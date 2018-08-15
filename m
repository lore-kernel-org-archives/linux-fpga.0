Return-Path: <SRS0=qv6O=K6=infradead.org=rdunlap@kernel.org>
Return-Path: <SRS0=qv6O=K6=infradead.org=rdunlap@kernel.org>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
References: <20180815220958.3606-1-atull@kernel.org>
 <20180815220958.3606-2-atull@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9043a69f-47d8-0ffe-ca15-77c9c73c085f@infradead.org>
Date: Wed, 15 Aug 2018 15:34:10 -0700
MIME-Version: 1.0
In-Reply-To: <20180815220958.3606-2-atull@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Dinh Nguyen <dinguyen@kernel.org>
Cc: Appana Durga Kedareswara Rao <appanad@xilinx.com>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@opensource.altera.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On 08/15/2018 03:09 PM, Alan Tull wrote:
> From: Alan Tull <atull@opensource.altera.com>
> 
> Implement DebugFS for the FPGA Manager Framework for
> debugging and developmental use.
> 
> Enabled by CONFIG_FPGA_MGR_DEBUG_FS

Hi Alan,

for your v2 changes:

> Each FPGA gets its own directory such as
>  <debugfs>/fpga_manager/fpga0 and three files:

s/three/four/

> 
>  * [RW] flags          = flags as defined in fpga-mgr.h
>  * [RW] firmware_name  = write/read back name of FPGA image
>                          firmware file to program
>  * [WO] image          = write-only file for directly writing
>                          fpga image w/o firmware layer
>  * [RW] config_complete_timeout_us = maximum for the FPGA to
>                          go to the operating state after
> 			 programming
> 
> The debugfs is implemented in a separate fpga_mgr_debugfs.c

      debugfs interface is

> file, but the FPGA manager core is still built as one
> module.  Note the name change from fpga-mgr.ko to fpga_mgr.ko.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/Kconfig            |   7 ++
>  drivers/fpga/Makefile           |   4 +-
>  drivers/fpga/fpga-mgr-debugfs.c | 221 ++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/fpga-mgr-debugfs.h |  22 ++++
>  drivers/fpga/fpga-mgr.c         |   8 ++
>  include/linux/fpga/fpga-mgr.h   |   3 +
>  6 files changed, 264 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.c
>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.h
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 1ebcef4..600924d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -9,6 +9,13 @@ menuconfig FPGA
>  	  kernel.  The FPGA framework adds a FPGA manager class and FPGA
>  	  manager drivers.
>  
> +config FPGA_MGR_DEBUG_FS
> +       bool "FPGA Manager DebugFS"
> +       depends on FPGA && DEBUG_FS
> +       help
> +         Say Y here if you want to expose a DebugFS interface for the
> +	 FPGA Manager Framework.

Use tab indentation for bool, depends, and help lines.

Use tab +2 spaces for help text.

> +
>  if FPGA
>  
>  config FPGA_MGR_SOCFPGA

thanks,
-- 
~Randy
