Return-Path: <SRS0=6DJo=GL=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=6DJo=GL=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:49137 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752188AbeCUSKT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 21 Mar 2018 14:10:19 -0400
Message-ID: <1521655492.7999.13.camel@perches.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
From: Joe Perches <joe@perches.com>
Date: Wed, 21 Mar 2018 11:04:52 -0700
In-Reply-To: <1521653726-24625-3-git-send-email-p.pisati@gmail.com>
References: <1521653726-24625-1-git-send-email-p.pisati@gmail.com>
         <1521653726-24625-3-git-send-email-p.pisati@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 18:35 +0100, Paolo Pisati wrote:
> This patch adds support to the FPGA manager for programming
> MachXO2 device’s internal flash memory, via slave SPI.

style trivia:

> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
[]
> +static int get_status(struct spi_device *spi, unsigned long *status)
> +{
> +	struct spi_message msg;
> +	struct spi_transfer rx, tx;
> +	u8 cmd[] = LSC_READ_STATUS;

static const u8 cmd[]
here and everywhere else as all the tx_buf assignments 
of cmd are to const void *

> +	int ret;
> +
> +	memset(&rx, 0, sizeof(rx));
> +	memset(&tx, 0, sizeof(tx));
> +	tx.tx_buf = cmd;

[]

> +#ifdef DEBUG
> +static void dump_status_reg(unsigned long *status)
> +{

Instead of multiple declarations of dump_status_reg
it's frequently nicer to use a style like

static void debug_func(args...)
{
#ifdef DEBUG
	[code...]
#endif
}

so if function arguments ever need to be changed
it's only required to be changed in one spot and
not multiply compilation tested with and without
the DEBUG definition

> +	char *ferr;
> +
> +	switch (get_err(status)) {
> +	case ENOERR:
> +		ferr = "No Error";
> +		break;
> +	case EID:
> +		ferr = "ID ERR";
> +		break;
> +	case ECMD:
> +		ferr = "CMD ERR";
> +		break;
> +	case ECRC:
> +		ferr = "CRC ERR";
> +		break;
> +	case EPREAM:
> +		ferr = "Preamble ERR";
> +		break;
> +	case EABRT:
> +		ferr = "Abort ERR";
> +		break;
> +	case EOVERFL:
> +		ferr = "Overflow ERR";
> +		break;
> +	case ESDMEOF:
> +		ferr = "SDM EOF";
> +		break;
> +	default:
> +		ferr = "Default switch case";
> +	}

It's frequently nicer to use a static function
for these enum -> string conversions like:

static const char *get_err_string(unsigned long err)
{
	switch (err) {
	case ENOERR:	return "No Error";
	case EID:	return "ID ERR";
	case ECMD:	return "CMD ERR";
	[...]
	}
	return "default switch case";
}

> +	pr_debug("machxo2 status: 0x%08lX - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
> +	       *status, test_bit(DONE, status), test_bit(ENAB, status),
> +	       test_bit(BUSY, status), test_bit(FAIL, status),
> +		   test_bit(DVER, status), ferr);

So instead of ferr, this could use
	get_err_string(*status)

And please try to keep a consistent alignment for
indentation of multiple line statements

> +}
> +#else
> +static void dump_status_reg(unsigned long *status) {}
> +#endif
> +
> +static int wait_until_not_busy(struct spi_device *spi)
> +{
> +	unsigned long status;
> +	int ret, loop = 0;
> +
> +	do {
> +		ret = get_status(spi, &status);
> +		if (ret)
> +			break;
> +		if (++loop >= MACHXO2_MAX_BUSY_LOOP) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +	} while (test_bit(BUSY, &status));
> +
> +	return ret;
> +}

Direct returns are OK and would shorten the function
line count.

