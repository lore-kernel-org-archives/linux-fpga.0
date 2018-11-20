Return-Path: <SRS0=E6IX=N7=denx.de=agust@kernel.org>
Return-Path: <SRS0=E6IX=N7=denx.de=agust@kernel.org>
Date: Tue, 20 Nov 2018 15:49:47 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 1/3] usb: misc: add driver for FT232H based FPGA
 configuration devices
Message-ID: <20181120154947.4dbc90d6@crub>
In-Reply-To: <1542675372.30311.573.camel@impinj.com>
References: <20181120002821.12794-1-agust@denx.de>
	<20181120002821.12794-2-agust@denx.de>
	<1542675372.30311.573.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Trent Piepho <tpiepho@impinj.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "broonie@kernel.org" <broonie@kernel.org>, "atull@kernel.org" <atull@kernel.org>, "mdf@kernel.org" <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, 20 Nov 2018 00:56:13 +0000
Trent Piepho tpiepho@impinj.com wrote:

>On Tue, 2018-11-20 at 01:28 +0100, Anatolij Gustschin wrote:
>> Add USB interface driver for ARRI FPGA configuration devices based on
>> FTDI FT232H chip. Depending on USB PID the driver registers different
>> platform devices describing an FPGA configuration interface.  
>
>Is ARRI different than Arria?

yes, ARRI is a company name.

>> +/* Use baudrate calculation borrowed from libftdi */
>> +static int ftdi_to_clkbits(int baudrate, unsigned int clk, int clk_div,  
>
>Linux uses unsigned values for clocks.  Does it make any sense to mix
>the unsigned clk with signed values?  Seems like baudrate and clk_div
>should also be unsigned.

okay, will fix to unsigned.

>> +			   unsigned long *encoded_divisor)  
>
>unsigned long is an odd choice here.  Is there any to reason to use an
>unsigned long to store the result of right shifting a signed int
>(best_div)?  It can't be longer than a int, but it can be negative.

okay, I'll change that to unsigned int.

>> +{
>> +	static const char frac_code[8] = { 0, 3, 2, 4, 1, 5, 6, 7 };
>> +	int best_baud = 0;
>> +	int div, best_div;
>> +
>> +	if (baudrate >= clk / clk_div) {
>> +		*encoded_divisor = 0;
>> +		best_baud = clk / clk_div;
>> +	} else if (baudrate >= clk / (clk_div + clk_div / 2)) {
>> +		*encoded_divisor = 1;
>> +		best_baud = clk / (clk_div + clk_div / 2);
>> +	} else if (baudrate >= clk / (2 * clk_div)) {
>> +		*encoded_divisor = 2;
>> +		best_baud = clk / (2 * clk_div);
>> +	} else {
>> +		/*
>> +		 * Divide by 16 to have 3 fractional bits and
>> +		 * one bit for rounding
>> +		 */
>> +		div = clk * 16 / clk_div / baudrate;
>> 
>> +		if (div & 1)	/* Decide if to round up or down */
>> +			best_div = div / 2 + 1;
>> +		else
>> +			best_div = div / 2;  
>
>In Linux we would write:
>
>best_div = DIV_ROUND_UP(div, 2);
>
>Though I think you can combine that with the above to get:
>
>best_div = DIV_ROUND_CLOSEST(clk * 8 / clk_div, baudrate);
>
>That what the above is trying to accomplish in a round about way

will rework this, too. Thanks for suggestions.

>> +		if (best_div > 0x20000)
>> +			best_div = 0x1ffff;

>Looks like the above was probably supposed to be >=

I'll check it.

>> +		best_baud = clk * 16 / clk_div / best_div;
>> +		if (best_baud & 1)	/* Decide if to round up or down */
>> +			best_baud = best_baud / 2 + 1;
>> +		else
>> +			best_baud = best_baud / 2;  
>
>Again, looks like a complicated way to round to the nearest.

will change this, too.

Thanks,
Anatolij
