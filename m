Return-Path: <SRS0=uojY=2B=denx.de=agust@kernel.org>
Return-Path: <SRS0=uojY=2B=denx.de=agust@kernel.org>
Date: Mon, 20 Feb 2017 21:05:04 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 2/2] fpga manager: Add Xilinx slave serial SPI driver
Message-ID: <20170220210504.2473ce90@crub>
In-Reply-To: <CAAtXAHeO_+6ZXP51nxFgyLYR9cjqLrqmoYEniqXmZudF=3uhFA@mail.gmail.com>
References: <1487600724-17607-1-git-send-email-agust@denx.de>
	<1487600724-17607-3-git-send-email-agust@denx.de>
	<CAAtXAHeO_+6ZXP51nxFgyLYR9cjqLrqmoYEniqXmZudF=3uhFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, Devicetree List <devicetree@vger.kernel.org>, Alan Tull <atull@opensource.altera.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Moritz,

On Mon, 20 Feb 2017 09:27:35 -0800
Moritz Fischer mdf@kernel.org wrote:

>Anatolij,
>
>small nits inline.
...

>> +       gpiod_set_value(conf->prog_b, 1);
>> +
>> +       udelay(1); /* min is 500 ns */  
>
>Maybe make this a named constant.

Okay, I can add

  const size_t prog_pulse_us = 1;
  ...
  udelay(prog_pulse_us);

...
>> +       gpiod_set_value(conf->prog_b, 0);
>> +
>> +       if (gpiod_get_value(conf->done)) {
>> +               dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
>> +               return -EIO;
>> +       }
>> +
>> +       /* program latency */
>> +       usleep_range(1000, 1500);  
>
>Same here.

Okay, will change here as well.

Thanks for review! I'll wait some time for more comments and
will submit v3 then.

Anatolij
