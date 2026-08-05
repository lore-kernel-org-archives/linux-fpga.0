Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1E1A76BB;
	Wed,  5 Aug 2026 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909467; cv=none; b=K/DXqvcDzaNrXl4VjcSxS59BuJjXdB14xTR/vvGcTxM58Xg9ITQERP/lYGFkyRUKf77LlsH/v7cyJMJQ/sololfuQ2rFZqWoXGdQBlLa7MP44rQCzt09AsGQApbJtDBrnFvA18wnp9KQm8bwlumUajcVaZ1lvLul2ewCjt23cOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909467; c=relaxed/simple;
	bh=nYK8a4LyBB5NI/Vt1uqrUCMFs0PbitBowlHjnKY9NvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bg4DSSYB5C8l2iCcFdsWsrwzaZOTT/yJmRd0MuwEMSRHTIwRTHx+oa1uJq2OMRQmSW0F/1H4HdC9gzHx5WreOp0/71H5MUb4yHlVqxGhAryuvHqun8kQ2k5UNtVUawQIZuZhMhAr5rtHGP3+riFj1dTPnZmzeUvHRmJIw+ZRM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=IpoaRo8a; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="IpoaRo8a"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 333441197E5;
	Wed, 05 Aug 2026 07:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785909458;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xe8rDXjXZwjUoH4sZFgUHq56nL63HObRiCFz1CSPj84=;
	b=IpoaRo8aKoEzSGKghomcQ8x1jio62Q5Ddmnzov68nIfC/VbuvRjyHdnH1NP55juZcbQxx4
	uypSkNi+8KddJlw5NqCaLYh/VsAx3bS8qw5w/xqYv0ioDKVQKYfoXMrW5C+JA/g2RJHq6K
	twJUU3GwYHmMygxncYsih6HoNrmUC8nrySL6B119KBAxV6SK2IC9b8WJJptUDQZMfmb3hE
	DH2YO3PYPNxWR0gnfFRLq6VE5zNdCs0yIFNq2dXgp4nlkd4sv7P97y0YXV1/VM99vsut1O
	q+8ou5oNHy2NqMUVwvU1wZSoujbFSoPWtdmxcAcDjEQtEcR2+WF+VohuZZ8foA==
Message-ID: <fa06093a-50de-7b5b-daf7-bec288451efc@nabladev.com>
Date: Wed, 5 Aug 2026 07:56:54 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fpga@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Xu Yilun <yilun.xu@intel.com>, linux-gpio@vger.kernel.org
References: <20260727052218.4079979-1-hs@nabladev.com>
 <am9m0pGSUYKaRRDI@yilunxu-OptiPlex-7050>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <am9m0pGSUYKaRRDI@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Yilun,

On 02.08.26 17:48, Xu Yilun wrote:
> On Mon, Jul 27, 2026 at 07:22:10AM +0200, Heiko Schocher wrote:
>> The current driver requests the optional CSI_B and RDWR_B GPIOs but
>> only configures their initial output state and never changes them
>> afterwards. As a result, CSI_B and RDWR_B remain inactive throughout
>> the configuration process.
> 
> Then how the existing configuration process work if the control signals
> are always *INACTIVE*?

The sentence is simply wrong, as this depends on the setting in the DTS.
I rework this part of the  commit message

>> This may work on systems with a single FPGA where these signals do not
>> need to be controlled by software,
> 
> Is this always the case today? Then why does the existing driver bother
> doing the devm_gpiod_get_optional()?

The gpios are never used in mainline:

$ grep -lr csi-gpios arch
$

I change this sentence to

"""
This may work on systems with a single FPGA where these signals do not
need to be controlled by software, or where the signals are configured
to their active state. But this does not not support systems with
multiple FPGAs sharing a SelectMAP interface.
"""

Hope this makes it clearer.

>> but it does not support systems
>> with multiple FPGAs sharing a SelectMAP interface.
>>
>> On systems with multiple FPGAs sharing the same SelectMAP data bus,
>> the driver must actively control these signals during configuration.
>>
>> CSI_B (Chip Select, active low) selects the target FPGA. It is asserted
>> before configuration data is transferred and deasserted afterwards so
>> that only the intended device responds to bus transactions.
> 
> I still don't understand, only one Chip Select pin defined for each
> selectmap device, how could it select between multiple FPGAs?

I wrote in the commit message:
"""
On systems with multiple FPGAs sharing the same SelectMAP data bus
"""

So, each instance of the driver has its own CSI_B and RDWR_B signal,
but they share clock, data pins...

Current driver asserts the CSI_B signal for each instance in probe,
so if you have N FPGAs, N FPGAs have after probing an active CS signal.

As all FPGAs share the same databus and clock, and when driver starts
downloading to a specific FPGA the firmware, all FPGAs are active
and react to the firmware download.

This was not yet a problem as no driver in mainline used the gpios at
all (or it would work for single FPGAs with active CSI_B and RDWR_B
signals set)

>> RDWR_B (Read/Write, active low) controls the transfer direction on the
>> SelectMAP interface. A low level selects write cycles, while a high
>> level selects read cycles. During FPGA configuration the driver drives
>> RDWR_B low before transferring the bitstream and restores it to its
>> reading (high state) afterwards.
>>
>> Store the optional GPIO descriptors and toggle both signals around the
>> configuration data transfer, allowing multiple FPGAs to safely share a
>> single SelectMAP interface.
>>
>> Tested on an AM625 based board with two Xilinx FPGAs connected to the
>> GPMC bus.
> 
> What is GPMC bus, anything to do with "SelectMAP data bus"?

No, I remove this line from the commit message.

> 
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>> ---
>>
>> Changes in v3:
>> - use 0 (deasserted state) and 1 (asserted state) in gpio_set_value()
>>    as commented from Micahl
>> - rewrite commit message as requested from Xu Yilun
>>    - describe what rdwr_b and csi_b do, and why this change is needed
>>      for more than one FPGA.
>> - add comment before asserting the signals, why they are asserted
>>    in this order.
>>
>> Changes in v2:
>> - add comments from Michal
>>    - skip check if gpio descriptor variables csi_b/rdwr_b are valid,
>>      as validate_desc() checks this in gpiod_set_value() call.
>>    - initialize the gpio variables csi_b/rdwr_b immediately with
>>      the return value from devm_gpiod_get_optional(), so we can
>>      drop local gpio variable at all
>>
>>   drivers/fpga/xilinx-selectmap.c | 32 +++++++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
>> index d0cbb5fdfe3a..35078206a3a3 100644
>> --- a/drivers/fpga/xilinx-selectmap.c
>> +++ b/drivers/fpga/xilinx-selectmap.c
>> @@ -19,6 +19,8 @@
>>   struct xilinx_selectmap_conf {
>>   	struct xilinx_fpga_core core;
>>   	void __iomem *base;
>> +	struct gpio_desc *csi_b;
>> +	struct gpio_desc *rdwr_b;
>>   };
>>   
>>   #define to_xilinx_selectmap_conf(obj) \
>> @@ -30,16 +32,30 @@ static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
>>   	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>>   	size_t i;
>>   
>> +	/*
>> +	 * Assert CSI_B and select write mode.
>> +	 *
>> +	 * UG570 states in note 4 in Figure "Continuous x8 SelectMAP Data
>> +	 * Loading", RDWR_B should be asserted before CSI_B to avoid
>> +	 * causing an ABORT on the next CCLK.
>> +	 *
>> +	 * To be sure, set first RDWR_B pin before activate CSI_B
>> +	 */
>> +	gpiod_set_value(conf->rdwr_b, 1);
>> +	gpiod_set_value(conf->csi_b, 1);
>> +
>>   	for (i = 0; i < count; ++i)
>>   		writeb(buf[i], conf->base);
>>   
>> +	gpiod_set_raw_value(conf->csi_b, 0);
>> +	gpiod_set_raw_value(conf->rdwr_b, 0);
> 
> I don't see why you do gpiod_set_raw_value() here, they seems change nothing.

Oh, I am sorry, mistake from me, of course it must be gpiod_set_value()

I will change this in v4.

> 
>    Function (example)                 line property          physical line
>    gpiod_set_raw_value(desc, 0);      don't care             low
>    ...
>    gpiod_set_value(desc, 1);          active low             low
> 
>> +
>>   	return 0;
>>   }
>>   
>>   static int xilinx_selectmap_probe(struct platform_device *pdev)
>>   {
>>   	struct xilinx_selectmap_conf *conf;
>> -	struct gpio_desc *gpio;
>>   	void __iomem *base;
>>   
>>   	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
>> @@ -56,15 +72,17 @@ static int xilinx_selectmap_probe(struct platform_device *pdev)
>>   	conf->base = base;
>>   
>>   	/* CSI_B is active low */
>> -	gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
>> -	if (IS_ERR(gpio))
>> -		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
>> +	conf->csi_b = devm_gpiod_get_optional(&pdev->dev, "csi",
>> +					      GPIOD_OUT_HIGH);
> 
> You've changed this from v2, why? Why keep the initial state active?

Seems the same typo, as above with gpio_set_raw_value.

I will change in v4 back and add comment

I have to wait until next week, before I can test the new version.

Many thanks for your time, patience and review.

bye,
Heiko
> 
>> +	if (IS_ERR(conf->csi_b))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
>>   				     "Failed to get CSI_B gpio\n");
>>   
>>   	/* RDWR_B is active low */
>> -	gpio = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
>> -	if (IS_ERR(gpio))
>> -		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
>> +	conf->rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr",
>> +					       GPIOD_OUT_HIGH);
>> +	if (IS_ERR(conf->rdwr_b))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
>>   				     "Failed to get RDWR_B gpio\n");
>>   
>>   	return xilinx_core_probe(&conf->core);
>> ---
>> base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
>>
>> -- 
>> 2.55.0
>>
>>

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
