Return-Path: <SRS0=jT5i=7H=redhat.com=mtosatti@kernel.org>
Return-Path: <SRS0=jT5i=7H=redhat.com=mtosatti@kernel.org>
Date: Mon, 25 May 2020 16:35:50 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v5 7/7] Documentation: fpga: dfl: add descriptions for
 interrupt related interfaces.
Message-ID: <20200525193550.GG22266@fuller.cnet>
References: <1587370303-25568-1-git-send-email-yilun.xu@intel.com>
 <1587370303-25568-8-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587370303-25568-8-git-send-email-yilun.xu@intel.com>
To: Xu Yilun <yilun.xu@intel.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com, Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Apr 20, 2020 at 04:11:43PM +0800, Xu Yilun wrote:
> This patch adds introductions of interrupt related interfaces for FME
> error reporting, port error reporting and AFU user interrupts features.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ----
> v2: Update Documents cause change of irq ioctl interfaces.
> v3: No change
> v4: Update interrupt support part.
> v5: No change
> ---
>  Documentation/fpga/dfl.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 094fc8a..702bf62 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -89,6 +89,8 @@ The following functions are exposed through ioctls:
>  - Program bitstream (DFL_FPGA_FME_PORT_PR)
>  - Assign port to PF (DFL_FPGA_FME_PORT_ASSIGN)
>  - Release port from PF (DFL_FPGA_FME_PORT_RELEASE)
> +- Get number of irqs of FME global error (DFL_FPGA_FME_ERR_GET_IRQ_NUM)
> +- Set interrupt trigger for FME error (DFL_FPGA_FME_ERR_SET_IRQ)
>  
>  More functions are exposed through sysfs
>  (/sys/class/fpga_region/regionX/dfl-fme.n/):
> @@ -144,6 +146,10 @@ The following functions are exposed through ioctls:
>  - Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
>  - Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
>  - Reset AFU (DFL_FPGA_PORT_RESET)
> +- Get number of irqs of port error (DFL_FPGA_PORT_ERR_GET_IRQ_NUM)
> +- Set interrupt trigger for port error (DFL_FPGA_PORT_ERR_SET_IRQ)
> +- Get number of irqs of UINT (DFL_FPGA_PORT_UINT_GET_IRQ_NUM)
> +- Set interrupt trigger for UINT (DFL_FPGA_PORT_UINT_SET_IRQ)
>  
>  DFL_FPGA_PORT_RESET:
>    reset the FPGA Port and its AFU. Userspace can do Port
> @@ -378,6 +384,19 @@ The device nodes used for ioctl() or mmap() can be referenced through::
>  	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
>  
>  
> +Interrupt support
> +=================
> +Some FME and AFU private features are able to generate interrupts. As mentioned
> +above, users could call ioctl (DFL_FPGA_*_GET_IRQ_NUM) to know whether or how
> +many interrupts are supported for this private feature. Drivers also implement
> +an eventfd based interrupt handling mechanism for users to get notified when
> +interrupt happens. Users could set eventfds to driver via
> +ioctl (DFL_FPGA_*_SET_IRQ), and then poll/select on these eventfds waiting for
> +notification.
> +In Current DFL, 3 sub features (Port error, FME global error and AFU interrupt)
> +support interrupts.
> +
> +
>  Add new FIUs support
>  ====================
>  It's possible that developers made some new function blocks (FIUs) under this
> -- 
> 2.7.4


Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
