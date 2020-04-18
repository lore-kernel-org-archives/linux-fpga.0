Return-Path: <SRS0=ClbJ=6C=infradead.org=rdunlap@kernel.org>
Return-Path: <SRS0=ClbJ=6C=infradead.org=rdunlap@kernel.org>
Subject: Re: [PATCH v9 1/2] Documentation: fpga: dfl: add description for
 performance reporting support
References: <1587102000-18262-1-git-send-email-hao.wu@intel.com>
 <1587102000-18262-2-git-send-email-hao.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8aa60f7e-68d4-ca41-403f-37f430ce05c1@infradead.org>
Date: Fri, 17 Apr 2020 17:07:41 -0700
MIME-Version: 1.0
In-Reply-To: <1587102000-18262-2-git-send-email-hao.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Wu Hao <hao.wu@intel.com>, will@kernel.org, mdf@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com, trix@redhat.com, bhu@redhat.com
List-ID: <linux-fpga@vger.kernel.org>

Hi--

Here are a few comments for you:

On 4/16/20 10:39 PM, Wu Hao wrote:
> From: Xu Yilun <yilun.xu@intel.com>
> 
> This patch adds description for performance reporting support for
> Device Feature List (DFL) based FPGA.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  Documentation/fpga/dfl.rst | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 094fc8a..6ccaf77 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst

> @@ -378,6 +383,85 @@ The device nodes used for ioctl() or mmap() can be referenced through::
>  	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
>  
>  
> +Performance Counters
> +====================
> +Performance reporting is one private feature implemented in FME. It could
> +supports several independent, system-wide, device counter sets in hardware to
> +monitor and count for performance events, including "basic", "cache", "fabric",
> +"vtd" and "vtd_sip" counters. Users could use standard perf tool to monitor
> +FPGA cache hit/miss rate, transaction number, interface clock counter of AFU
> +and other FPGA performance events.
> +
> +Different FPGA devices may have different counter sets, it depends on hardware

                                                     sets, depending on hardware

> +implementation. e.g. some discrete FPGA cards don't have any cache. User could

                   E.g., some

> +use "perf list" to check which perf events are supported by target hardware.
> +
> +In order to allow user to use standard perf API to access these performance
> +counters, driver creates a perf PMU, and related sysfs interfaces in
> +/sys/bus/event_source/devices/dfl_fme* to describe available perf events and
> +configuration options.
> +
> +The "format" directory describes the format of the config field of struct
> +perf_event_attr. There are 3 bitfields for config, "evtype" defines which type

                                              config: "evtype"

> +the perf event belongs to. "event" is the identity of the event within its

                  belongs to; "event" is

> +category. "portid" is introduced to decide counters set to monitor on FPGA

   category; "portid" is

> +overall data or a specific port.
> +
> +The "events" directory describes the configuration templates for all available
> +events which can be used with perf tool directly. For example, fab_mmio_read
> +has the configuration "event=0x06,evtype=0x02,portid=0xff", which shows this
> +event belongs to fabric type (0x02), the local event id is 0x06 and it is for
> +overall monitoring (portid=0xff).
> +
> +Example usage of perf::
> +
> +  $# perf list |grep dfl_fme
> +
> +  dfl_fme0/fab_mmio_read/                              [Kernel PMU event]
> +  <...>
> +  dfl_fme0/fab_port_mmio_read,portid=?/                [Kernel PMU event]
> +  <...>
> +
> +  $# perf stat -a -e dfl_fme0/fab_mmio_read/ <command>
> +  or
> +  $# perf stat -a -e dfl_fme0/event=0x06,evtype=0x02,portid=0xff/ <command>
> +  or
> +  $# perf stat -a -e dfl_fme0/config=0xff2006/ <command>
> +
> +Another example, fab_port_mmio_read monitors mmio read of a specific port. So
> +its configuration template is "event=0x06,evtype=0x01,portid=?". The portid
> +should be explicitly set.
> +
> +Its usage of perf::
> +
> +  $# perf stat -a -e dfl_fme0/fab_port_mmio_read,portid=0x0/ <command>
> +  or
> +  $# perf stat -a -e dfl_fme0/event=0x06,evtype=0x02,portid=0x0/ <command>
> +  or
> +  $# perf stat -a -e dfl_fme0/config=0x2006/ <command>
> +
> +Please note for fabric counters, overall perf events (fab_*) and port perf
> +events (fab_port_*) actually share one set of counters in hardware, so it can't
> +monitor both at the same time. If this set of counters is configured to monitor
> +overall data, then per port perf data is not supported. See below example::
> +
> +  $# perf stat -e dfl_fme0/fab_mmio_read/,dfl_fme0/fab_port_mmio_write,\
> +                                                    portid=0/ sleep 1
> +
> +  Performance counter stats for 'system wide':
> +
> +                 3      dfl_fme0/fab_mmio_read/
> +   <not supported>      dfl_fme0/fab_port_mmio_write,portid=0x0/
> +
> +       1.001750904 seconds time elapsed
> +
> +The driver also provides a "cpumask" sysfs attribute, which contains only one
> +cpu id used to access these perf events. Counting on multiple CPUs is not
   CPU

> +allowed since they are system-wide counters on FPGA device.
> +
> +The current driver does not support sampling. So "perf record" is unsupported.
> +
> +
>  Add new FIUs support
>  ====================
>  It's possible that developers made some new function blocks (FIUs) under this
> 

thanks.
-- 
~Randy
