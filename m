Return-Path: <SRS0=+JAn=42=gmail.com=d.c.ddcc@kernel.org>
Return-Path: <SRS0=+JAn=42=gmail.com=d.c.ddcc@kernel.org>
Subject: Re: [PATCH v3] fpga: dfl: afu: support debug access to memory-mapped
 afu regions
References: <20200305033310.117030-1-d.c.ddcc@gmail.com>
 <20200309072810.GA852@hao-dev>
From: Dominic Chen <d.c.ddcc@gmail.com>
Message-ID: <dca2ed7b-ff6e-2886-238b-6a924553b9f1@gmail.com>
Date: Mon, 9 Mar 2020 14:53:05 -0400
MIME-Version: 1.0
In-Reply-To: <20200309072810.GA852@hao-dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Wu Hao <hao.wu@intel.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


On 3/9/2020 3:28 AM, Wu Hao wrote:
> On Wed, Mar 04, 2020 at 10:33:10PM -0500, Dominic Chen wrote:
>> +static const struct vm_operations_struct afu_vma_ops = {
>> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>> +	.access = generic_access_phys,
>> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
> To me, it's very clear for #ifdef - #end. So looks like this
> /* CONFIG_HAVE_IOREMAP_PROT */ comments is not needed.
>
> Could you please remove it? 
>
> Then
>
> Acked-by: Wu Hao <hao.wu@intel.com>
>
> Thanks
> Hao

Thanks, sent out v4.

Dominic
