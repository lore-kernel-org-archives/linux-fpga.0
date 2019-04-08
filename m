Return-Path: <SRS0=jqPo=SK=denx.de=agust@kernel.org>
Return-Path: <SRS0=jqPo=SK=denx.de=agust@kernel.org>
Date: Mon, 8 Apr 2019 21:01:26 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 3/3] fpga: Add fpga manager driver for ARRI Altera
 FPP
Message-ID: <20190408210126.74920213@crub>
In-Reply-To: <20190408180151.GA5643@archbook>
References: <20190221202506.17744-1-agust@denx.de>
	<20190221202506.17744-4-agust@denx.de>
	<20190408180151.GA5643@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, broonie@kernel.org, atull@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Moritz,

On Mon, 8 Apr 2019 11:05:49 -0700
Moritz Fischer mdf@kernel.org wrote:

>Hi Anatolij,
>
>looks mostly good, a couple of nits inline.

Thanks for review.

...
>> +++ b/drivers/fpga/ftdi-fifo-fpp.c
>> @@ -0,0 +1,594 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Altera FPGA firmware upload via FPP using FT232H Bitbang/FT245-FIFO.
>> + *
>> + * Copyright (C) 2017 - 2018 DENX Software Engineering  
>Maybe bump that to 2019 ;-)

I'll update it in next version.

...
>> +	gpiod_set_raw_value_cansleep(priv->nconfig, 1);
>> +	gpiod_set_raw_value_cansleep(priv->conf_done, 0);
>> +	msleep(50);  
>
>You could use a constant here for the 50 ...

Do you mean something like below?

  const unsigned int wait_50ms = 50;
  ...
  msleep(wait_50ms);

...
>and here ...
>> +	gpiod_set_value_cansleep(priv->nconfig, 1);
>> +	msleep(50);  
>and here ...
>> +	gpiod_set_value_cansleep(priv->nconfig, 0);
>> +
>> +	/* Wait for CONF_DONE to get low */  
>Does the retry number come from datasheet?

No, it is an empirical value.

...
>> +	if (!retries) {
>> +		dev_warn(dev, "CONF_DONE wait timeout\n");  
>
>warn or err?

err fits better here, I'll update to dev_err().

...
>> +	struct fpp_fpga_mgr_priv *priv = mgr->priv;
>> +	struct device *dev = &priv->pdev->dev;
>> +	int retries = MAX_RETRIES;
>> +	int ret;
>> +	u8 mask, status;  
>
>Can you swap the two lines, reverse xmas-tree please.

Will do in v5.

Thanks,
Anatolij
