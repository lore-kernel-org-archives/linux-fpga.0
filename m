Return-Path: <SRS0=eUR8=4V=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=eUR8=4V=intel.com=hao.wu@kernel.org>
Date: Wed, 4 Mar 2020 18:38:29 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [Resend] [PATCH] fpga: support debug access to memory-mapped afu
 regions
Message-ID: <20200304103829.GA14731@hao-dev>
References: <20200304061406.98865-1-d.c.ddcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304061406.98865-1-d.c.ddcc@gmail.com>
To: Dominic Chen <d.c.ddcc@gmail.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Dominic,

Thanks a lot for this patch. Please see my comments inline.

On Wed, Mar 04, 2020 at 01:14:06AM -0500, Dominic Chen wrote:
> Allow debug access to memory-mapped regions using e.g. gdb.

Do you mind improving the title to something like

   "fpga: dfl: afu: ...."

> 
> Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 02baa6a227c0..38983f9dde98 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	return -EINVAL;
>  }
>  
> +#ifdef CONFIG_HAVE_IOREMAP_PROT
> +const struct vm_operations_struct afu_vma_ops = {

let's add "static" for afu_vma_ops here.

> +	.access = generic_access_phys,
> +};
> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
> +

What about

  static const struct vm_operations_struct afu_vma_ops = {
  #ifdef CONFIG_HAVE_IOREMAP_PROT
  	.access = generic_access_phys,
  #endif
  };

Then we just need one line below.

  vma->vm_ops = &afu_vma_ops;


Thanks
Hao

>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	struct platform_device *pdev = filp->private_data;
> @@ -488,6 +494,11 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>  		return -EPERM;
>  
> +	// Support debug access to the mapping
> +#ifdef CONFIG_HAVE_IOREMAP_PROT
> +	vma->vm_ops = &afu_vma_ops;
> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
> +
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
>  	return remap_pfn_range(vma, vma->vm_start,
> -- 
> 2.17.1
