Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF2355F49;
	Wed, 22 Jul 2026 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731555; cv=none; b=OSSomQc+FBtscqvL4WWaD+pyGjKzs4xTqEsVCMVjuaC4oGRXw3XpyI8fD68NchhO76FMvzq7wOCLec4m4JvdlKHEwaLhYIuB7FYpEgKUf8lTH8r7MvD77w+vhsqDVglEhlzRJuGubtXdKsr+Of6bD3w31XpT/Y4Qw5xWiMFQB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731555; c=relaxed/simple;
	bh=RY3KsCcrzpweil3EPJQTAdvYkTYFJfFDogJ1KAmaug0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/t7ZfI//r6C78oeUkGsoKFhkWsfowGZGiMxJYXi2MUQFYyNKZGZ6q5c4uCcNE1yh06kPVSkg8uHEHUeO4gub8Nvn/1krn6F/VU2xKibGS4EJuMDacceb/Qo9MqH/fjION/dDRCRGwtati55U7JWpRyP/EtT/TSC+oVtMlR/iHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=C2izVZph; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="C2izVZph"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 786B711AE51;
	Wed, 22 Jul 2026 16:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784731544;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RuTN5NwqlLDJZEVsZBh6ckJC4co05P9l82YrCxQa3Ak=;
	b=C2izVZphIHqNPQJQGjpRt7TDWjO/l9yYvw5GxSQbnrzsSkFBnv5w73Sr+Ya6jUD/plKgPK
	7e3MQQIAxN378Oa9C2zluK/r0EetyjX4ZpVJlYJD4tSVq5HWfjHbxUHtpeIfXX1rl4DI8k
	ebhpRz57SxHPsv+gY63hb0MLQJW+Xm+sfE51inizy8AhSTDOC/77nK9ZEpzMP4yQrJGFqp
	CvJLfzSY0FUUU8LTFUeCudFUF+aN42lsvTckWe2OgOMBQSBiZS1m8yh4Tl4TVvcUvwbw0Y
	TbI1jShlZv+tlEODeElkWR7Itfz1GFzigP91FxOkE/jHOYJxOUXVYkbnVLDLVQ==
Message-ID: <855f458a-60d7-931f-9ef9-5dba2b2d916d@nabladev.com>
Date: Wed, 22 Jul 2026 16:45:12 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20260721114258.3324794-1-hs@nabladev.com>
 <2758c5dc-91fa-44a0-986e-1258afc3dbd5@amd.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <2758c5dc-91fa-44a0-986e-1258afc3dbd5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Michal,

On 22.07.26 08:55, Michal Simek wrote:
> 
> 
> On 7/21/26 13:42, Heiko Schocher wrote:
>> Add csi_b and rdwr pin support for the xilinx,selectmap driver.
>>
>> In current driver the pins are configured from DTS and set to
>> GPIOD_OUT_HIGH. This works in case you have one FPGA.
>>
>> Extend this to really implement csi_b and rdwr pin function in
>> driver, so it works with more than one FPGA.
>>
>> Tested on AM625 based board with 2 FPGAs connected to GPMC.
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>> ---
>>
>> Changes in v2:
>> - add comments from Michal
>>    - skip check if gpio descriptor variables csi_b/rdwr_b are valid,
>>      as validate_desc() checks this in gpiod_set_value() call.
>>    - initialize the gpio variables csi_b/rdwr_b immediately with
>>      the return value from devm_gpiod_get_optional(), so we can
>>      drop local gpio variable at all
>>
>>   drivers/fpga/xilinx-selectmap.c | 23 ++++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
>> index d0cbb5fdfe3a..d5175f9430e4 100644
>> --- a/drivers/fpga/xilinx-selectmap.c
>> +++ b/drivers/fpga/xilinx-selectmap.c
>> @@ -19,6 +19,8 @@
>>   struct xilinx_selectmap_conf {
>>       struct xilinx_fpga_core core;
>>       void __iomem *base;
>> +    struct gpio_desc *csi_b;
>> +    struct gpio_desc *rdwr_b;
>>   };
>>   #define to_xilinx_selectmap_conf(obj) \
>> @@ -30,16 +32,21 @@ static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
>>       struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>>       size_t i;
>> +    gpiod_set_value(conf->csi_b, GPIOD_OUT_HIGH);
>> +    gpiod_set_value(conf->rdwr_b, GPIOD_OUT_HIGH);
> 
> I think GPIOD_OUT_HIGH/LOW is wrong in this context.
> If you do "git grep gpiod_set_value" you will see that values are 0/1
I will change it!

Hmm.. while thinking about it... CSI_B and RDWR_B signals
are defined as active low...

Doesn't it make more sense to use here

gpiod_set_raw_value()

instead, which sets the physical levels?

Thanks!

bye,
Heiko
> 
> Thanks,
> Michal

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
