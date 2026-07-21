Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187462D0C94;
	Tue, 21 Jul 2026 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784609323; cv=none; b=TFZc9TvcWzz3kZwKG3IKNX6BXmttkvTrAn5ScTeE4GLXHN7L3vu3MWQAuxcdZ4vuDgzCxUv8j7XEwA4wvPQvYE/q1n+D+jfVC0m5zrW1EL9X+kHCj7wYx2O6qUkNOr3BFn0Lq9r1kByidrdIZH5xhS5xlmu1zE86knd+mO2d5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784609323; c=relaxed/simple;
	bh=cb7OzSCmNC/CDkE9XGsfvobN43lPCK1NfN2ckHxYOyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gosPllvRmAEA9Ny9Vhu92Ibz9PU1PJ8RS5vMp6HzMT7cvo7yOzeg3iLg3mDSVYkEhZ0uzVOoWK4IAmscaSK5N6CfnP9ynvE8brNAjsJ8pbGFhYfGoLMQjpgZqgTp9Cx4XJ9cGURFGqgEDfnmuBh2wlpgENuEeyfyJP8t1K7rey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=G1NI3wBb; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="G1NI3wBb"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0266111A6DB;
	Tue, 21 Jul 2026 06:48:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784609318;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KAwLmuYdWrUlYAh7whQjAX/qWjCdiDKUmzfyN31Aaio=;
	b=G1NI3wBb6DHP3qj4bXWA8NeV3UGJAVRRyKjhkiVE3u4s6xxaXIDZ5mtri+aXg7LPeAIepM
	F1f7GU3EiBOXVbGxWWLM2O0qv8qHZdl5tVf2hZDaZriUlJxU4WmQW/RHAIdcyvKnlvCteo
	gEI1FjmfaBPMElZJaJp1GelIAEDxqu0Ftl24vhtnx1d+L9eN52h+o0NhT+ehCDqGwuNSxv
	Nyjhuk9haskb33o/Bp4l/9KoIBDN23rjEwCyIpYXxl8u1v0UWgupnzZ4s4K9Ccq7TJFmHx
	JQyq6OCJYFtnQznXjWhGFRp9/HAq40xBf2gPshqRwCQDkcddRWBfWn4ZQqiClA==
Message-ID: <658ce5d3-df8b-e443-7886-1b393657a135@nabladev.com>
Date: Tue, 21 Jul 2026 06:48:06 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20260716070020.4113618-1-hs@nabladev.com>
 <dad54c5f-34d1-4aab-bf7c-590ed5f638e6@amd.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <dad54c5f-34d1-4aab-bf7c-590ed5f638e6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Michal,

On 20.07.26 14:40, Michal Simek wrote:
> 
> 
> On 7/16/26 09:00, Heiko Schocher wrote:
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
>>   drivers/fpga/xilinx-selectmap.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
>> index d0cbb5fdfe3a..b5fbdedf8aec 100644
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
>> @@ -30,9 +32,21 @@ static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
>>       struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>>       size_t i;
>> +    if (conf->csi_b)
> 
> Is this really needed?
> 
> 4023 int gpiod_set_value(struct gpio_desc *desc, int value)
> 4024 {
> 4025         VALIDATE_DESC(desc);
> 4026         /* Should be using gpiod_set_value_cansleep() */
> 4027         WARN_ON(desc->gdev->can_sleep);
> 4028         return gpiod_set_value_nocheck(desc, value);
> 4029 }
> 4030 EXPORT_SYMBOL_GPL(gpiod_set_value);
> 
>   398 #define VALIDATE_DESC(desc) do { \
>   399         int __valid = validate_desc(desc, __func__); \
>   400         if (__valid <= 0) \
>   401                 return __valid; \
>   402         } while (0)
> 
>   385 static int validate_desc(const struct gpio_desc *desc, const char *func)
>   386 {
>   387         if (!desc)
>   388                 return 0;
>   389
>   390         if (IS_ERR(desc)) {
>   391                 pr_warn("%s: invalid GPIO (errorpointer: %pe)\n", func, desc);
>   392                 return PTR_ERR(desc);
>   393         }
>   394
>   395         return 1;
>   396 }
>   397
> 
> You should be able to just skip it because validate_desc is checking it for you.

It seems this is possible yes, so I drop it!

>> +        gpiod_set_value(conf->csi_b, GPIOD_OUT_HIGH);
>> +
>> +    if (conf->rdwr_b)
>> +        gpiod_set_value(conf->rdwr_b, GPIOD_OUT_HIGH);
>> +
>>       for (i = 0; i < count; ++i)
>>           writeb(buf[i], conf->base);
>> +    if (conf->rdwr_b)
>> +        gpiod_set_value(conf->rdwr_b, GPIOD_OUT_LOW);
>> +
>> +    if (conf->csi_b)
>> +        gpiod_set_value(conf->csi_b, GPIOD_OUT_LOW);
>> +
>>       return 0;
>>   }
>> @@ -56,16 +70,18 @@ static int xilinx_selectmap_probe(struct platform_device *pdev)
>>       conf->base = base;
>>       /* CSI_B is active low */
>> -    gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
>> +    gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_LOW);
>>       if (IS_ERR(gpio))
>>           return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
>>                        "Failed to get CSI_B gpio\n");
>> +    conf->csi_b = gpio;
> 
> Isn't it easier to simply call to avoid it?
> 
> conf->csi_b = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_LOW);

Of course, will send a v2 and drop the local gpio variable as not
longer needed.

Thanks for the review!

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
