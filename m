Return-Path: <SRS0=C0zL=3G=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=C0zL=3G=intel.com=hao.wu@kernel.org>
Date: Fri, 17 Jan 2020 11:39:34 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [RESEND Patch v6 0/2] add performance reporting support to FPGA
 DFL drivers
Message-ID: <20200117033934.GA23536@hao-dev>
References: <1579230628-22243-1-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579230628-22243-1-git-send-email-hao.wu@intel.com>
To: will@kernel.org
Cc: mdf@kernel.org, mark.rutland@arm.com, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, atull@kernel.org, gregkh@linuxfoundation.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Will

I resend this patch per suggestion from Greg.

Actually this is one important feature for users, but was blocked by
code review for quite a long time (no comments since last November).

We really need your help on code review from perf, please help us..

Many Thanks!

Hao

On Fri, Jan 17, 2020 at 11:10:26AM +0800, Wu Hao wrote:
> Hi all,
> 
> This patchset adds performance reporting support for FPGA DFL drivers. It
> introduces one pmu to expose userspace interfaces via standard perf API.
> User could use standard perf tool to access perf events exposed via pmu.
> 
> This patchset is generated based on latest fpga/for-next branch.
> 
> Main changes from v5:
>  - use dev_ext_attribute instead of fme_perf_event_attr.
>  - use is_visible function to decide which events to expose per
>    hardware capability, and add event_init checking for all events.
> 
> Main changes from v4:
>  - rebase and clean up.
>  - update Kconfig for PERF_EVENTS dependency.
> 
> Main changes from v3:
>  - add more descriptions in doc, including how to use perf tool for these
>    hardware counters. (patch #1)
>  - use standard perf API instead of sysfs entries. (patch #2)
> 
> Wu Hao (1):
>   fpga: dfl: fme: add performance reporting support
> 
> Xu Yilun (1):
>   Documentation: fpga: dfl: add description for performance reporting
>     support
> 
>  Documentation/fpga/dfl.rst  |  83 ++++
>  drivers/fpga/Makefile       |   1 +
>  drivers/fpga/dfl-fme-main.c |   4 +
>  drivers/fpga/dfl-fme-perf.c | 943 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl-fme.h      |   2 +
>  drivers/fpga/dfl.h          |   2 +
>  6 files changed, 1035 insertions(+)
>  create mode 100644 drivers/fpga/dfl-fme-perf.c
> 
> -- 
> 1.8.3.1
