Date: Sat, 21 Mar 2020 13:15:38 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v3] fpga: dfl: afu: support debug access to memory-mapped
 afu regions
Message-ID: <20200321201536.GA7275@epycbox.lan>
References: <20200305033310.117030-1-d.c.ddcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305033310.117030-1-d.c.ddcc@gmail.com>
To: Dominic Chen <d.c.ddcc@gmail.com>
Cc: hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Mar 04, 2020 at 10:33:10PM -0500, Dominic Chen wrote:
> Allow debug access to memory-mapped regions using e.g. gdb.
> 
> Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 02baa6a227c0..8fa1666b5b20 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	return -EINVAL;
>  }
>  
> +static const struct vm_operations_struct afu_vma_ops = {
> +#ifdef CONFIG_HAVE_IOREMAP_PROT
> +	.access = generic_access_phys,
> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
> +};
> +
>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	struct platform_device *pdev = filp->private_data;
> @@ -488,6 +494,9 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>  		return -EPERM;
>  
> +	/* Support debug access to the mapping */
> +	vma->vm_ops = &afu_vma_ops;
> +
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
>  	return remap_pfn_range(vma, vma->vm_start,
> -- 
> 2.17.1
> 

Applied to for-next.

Thanks
