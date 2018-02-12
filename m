Return-Path: <SRS0=lXn+=FG=denx.de=agust@kernel.org>
Return-Path: <SRS0=lXn+=FG=denx.de=agust@kernel.org>
Date: Mon, 12 Feb 2018 17:49:02 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: enable usage on non-dt
 platforms
Message-ID: <20180212174902.2ecb2eed@crub>
In-Reply-To: <CANk1AXQ7-caSN=7Xtqokpq80Rh77XTZhP7d7P4L7d9V6mgoq4w@mail.gmail.com>
References: <20180201223115.16420-1-agust@denx.de>
	<CANk1AXQ7-caSN=7Xtqokpq80Rh77XTZhP7d7P4L7d9V6mgoq4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Joshua Clayton <stillcompiling@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Mon, 12 Feb 2018 10:19:06 -0600
Alan Tull atull@kernel.org wrote:
...
>> +       if (spi->dev.of_node) {
>> +               of_id = of_match_device(of_ef_match, &spi->dev);
>> +               if (!of_id)
>> +                       return -ENODEV;
>> +
>> +               conf->data = of_id->data;
>> +       } else {
>> +               id = spi_get_device_id(spi);
>> +               if (!id)
>> +                       return -ENODEV;  
>
>Is it actually possible for !id at this point?  Seems like if we are
>in this probe function and we get this far, this would always succeed.

Yes, !id should be always false here. I'll drop this check then.

Thanks,

Anatolij
