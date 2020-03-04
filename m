Return-Path: <SRS0=yryN=4V=gmail.com=d.c.ddcc@kernel.org>
Return-Path: <SRS0=yryN=4V=gmail.com=d.c.ddcc@kernel.org>
Subject: Re: [Resend] [PATCH] fpga: support debug access to memory-mapped afu
 regions
References: <20200304061406.98865-1-d.c.ddcc@gmail.com>
 <20200304103829.GA14731@hao-dev>
From: Dominic Chen <d.c.ddcc@gmail.com>
Message-ID: <cf46872f-e8dd-ed6b-7637-b23163bdde95@gmail.com>
Date: Wed, 4 Mar 2020 08:38:27 -0500
MIME-Version: 1.0
In-Reply-To: <20200304103829.GA14731@hao-dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Wu Hao <hao.wu@intel.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Sure, I will send out a v2.

Thanks,

Dominic

On 3/4/2020 5:38 AM, Wu Hao wrote:
> Hi Dominic,
>
> Thanks a lot for this patch. Please see my comments inline.
>
> On Wed, Mar 04, 2020 at 01:14:06AM -0500, Dominic Chen wrote:
>> Allow debug access to memory-mapped regions using e.g. gdb.
> Do you mind improving the title to something like
>
>    "fpga: dfl: afu: ...."
>
>> Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
>> ---
>>  drivers/fpga/dfl-afu-main.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
>> index 02baa6a227c0..38983f9dde98 100644
>> --- a/drivers/fpga/dfl-afu-main.c
>> +++ b/drivers/fpga/dfl-afu-main.c
>> @@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>  	return -EINVAL;
>>  }
>>  
>> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>> +const struct vm_operations_struct afu_vma_ops = {
> let's add "static" for afu_vma_ops here.
>
>> +	.access = generic_access_phys,
>> +};
>> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
>> +
> What about
>
>   static const struct vm_operations_struct afu_vma_ops = {
>   #ifdef CONFIG_HAVE_IOREMAP_PROT
>   	.access = generic_access_phys,
>   #endif
>   };
>
> Then we just need one line below.
>
>   vma->vm_ops = &afu_vma_ops;
>
>
> Thanks
> Hao
>
>>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>>  {
>>  	struct platform_device *pdev = filp->private_data;
>> @@ -488,6 +494,11 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>>  		return -EPERM;
>>  
>> +	// Support debug access to the mapping
>> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>> +	vma->vm_ops = &afu_vma_ops;
>> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
>> +
>>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>  
>>  	return remap_pfn_range(vma, vma->vm_start,
>> -- 
>> 2.17.1
