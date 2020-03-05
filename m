Return-Path: <SRS0=/+0c=4W=gmail.com=d.c.ddcc@kernel.org>
Return-Path: <SRS0=/+0c=4W=gmail.com=d.c.ddcc@kernel.org>
Subject: Re: [PATCH v2] fpga: dfl: afu: support debug access to memory-mapped
 afu regions
References: <20200304133847.103881-1-d.c.ddcc@gmail.com>
 <20200305030926.GA4253@epycbox.lan>
From: Dominic Chen <d.c.ddcc@gmail.com>
Message-ID: <11d8fce0-f859-becc-f190-a151d4562e1c@gmail.com>
Date: Wed, 4 Mar 2020 22:32:16 -0500
MIME-Version: 1.0
In-Reply-To: <20200305030926.GA4253@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
To: Moritz Fischer <mdf@kernel.org>
Cc: hao.wu@intel.com, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 3/4/2020 10:09 PM, Moritz Fischer wrote:
>> +static const struct vm_operations_struct afu_vma_ops =3D {
>> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>> +	.access =3D generic_access_phys,
>> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
> I remember there were issues in the past with modules and this, are
> those resolved?

Are you referring to the `generic_access_phys` symbol not being
exported? It looks like it became available to GPL modules starting with
kernel v3.12.

>>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>>  {
>>  	struct platform_device *pdev =3D filp->private_data;
>> @@ -488,6 +494,9 @@ static int afu_mmap(struct file *filp, struct vm_a=
rea_struct *vma)
>>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>>  		return -EPERM;
>> =20
>> +	// Support debug access to the mapping
> Please use kernel style comments /* */ checkpatch.pl should catch this.=

Hmm, I did run checkpatch.pl, though it contains `$allow_c99_comments =3D=

1`.=C2=A0 I'll send out v3 to fix this.

Thanks,

Dominic
