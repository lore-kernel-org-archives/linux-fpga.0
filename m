Return-Path: <SRS0=AlN3=42=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=AlN3=42=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37955 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIHtW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 9 Mar 2020 03:49:22 -0400
Date: Mon, 9 Mar 2020 15:28:10 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v3] fpga: dfl: afu: support debug access to memory-mapped
 afu regions
Message-ID: <20200309072810.GA852@hao-dev>
References: <20200305033310.117030-1-d.c.ddcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305033310.117030-1-d.c.ddcc@gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Dominic Chen <d.c.ddcc@gmail.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org

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

To me, it's very clear for #ifdef - #end. So looks like this
/* CONFIG_HAVE_IOREMAP_PROT */ comments is not needed.

Could you please remove it? 

Then

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

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
