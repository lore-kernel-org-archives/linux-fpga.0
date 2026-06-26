Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E4481B1;
	Fri, 26 Jun 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491999; cv=none; b=QgMaehB9UnQ0ql2sNOnWBRsjdcu9CdrOhx67HKMhIanDOwj6S0RvIsv9NVgn/emuWfvR7WLwASs8og9v83lJ7Tg7FLQi/NiqSlGDJJs+cb5I8M/xHgPkNvLmUb2IjH46s6LhVmBggfEUUcn7CgZkEfB2fFWMf3Jqg6cdfrIpJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491999; c=relaxed/simple;
	bh=qGGURGuTf5+usMGvxrvgjBsej1yWeXjfvcNixlYbsxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvYiBp4EAZHE4hUKRU8UH2y8d+sd2EungeLq1JAXBmrtkvbaCFoUIgVaTcTfcX45l3gxyVcv1B0klIYo85SKZoyLEwABnct/X4g4OnlE3Nd3Pj0KEKfZBRdonAvs5Tjk/jUHR4MAUa5Njp9mfbP6d/qCbfZoC7daKapU4mRyFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qr5ireLy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qr5ireLy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782491997; x=1814027997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qGGURGuTf5+usMGvxrvgjBsej1yWeXjfvcNixlYbsxA=;
  b=Qr5ireLyNh4dkAzQ3h1RCYwBN9HDXkYFTD/ZEI+qhvzqzRbgHA0pk6tk
   g1qe+WJTkG3CdmxHWVhuiJ8fvUCAhs83yd5H3fCe9hSvsECKKHy7sq2WA
   auBEn1WaX4MCCV4uC9l7shBMopc09+s3fGgIPVDkWwnpuUoP/WacWtM3h
   YcqzPjh6rI/YXm6oSB+tcRgLjibFy1aD3SvodEQB0lZyzgn7Joha5mJvT
   U6o2MMkxM1lH6IFmnkJfzfdaap9p6ah8aBjdYHjhsZ9pf1X4TofA0xu+K
   o06PoKUtcoCDF7S3FecXOzP2k9y35rjeg3gDRlJ3vbKZFDBKSI1CxEw7G
   w==;
X-CSE-ConnectionGUID: 9e6dc5+ERlWPXkz6Bfe29g==
X-CSE-MsgGUID: tb7LbyOSTjWsONCWN2dNDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="106079826"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="106079826"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 09:37:03 -0700
X-CSE-ConnectionGUID: Xdnjtz5HQOqDivlRT7dkug==
X-CSE-MsgGUID: bmBU+Ev3RN6JtTZZMzPElQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="255341201"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 26 Jun 2026 09:37:01 -0700
Date: Sat, 27 Jun 2026 00:37:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: mdf@kernel.org, yilun.xu@intel.com, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Add Agilex5 CVP credit register support
Message-ID: <aj6qrFag+NOvGrKr@yilunxu-OptiPlex-7050>
References: <20260619034327.26966-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619034327.26966-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Thu, Jun 18, 2026 at 08:43:27PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Extend the CvP driver to support Agilex5, which uses a different
> register layout than previous SoC FPGA variants for CVP bitstream
> transfer.
> 
> Agilex5 uses a different VSEC layout (VSEC length 0x60) and a
> dedicated CVP credit register at offset 0x5C with 12-bit width,
> compared to offset 0x49 with 8-bit width on other platforms.
> 
> Detect the device family at probe time by reading the VSEC specific
> header and checking the VSEC length field. Introduce
> device_family_type to distinguish V1, V2, and V2 Agilex5 variants.
> Use altera_read_config_dword() with a 0xFFF mask for Agilex5 credits
> and altera_read_config_byte() for all other devices.

> Fix the credit
> comparison by removing the incorrect u8 cast on sent_packets.

Is it a bug fix for existing cases? If yes, split it out to a separate
patch. Otherwise, don't say 'fix'.

> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  drivers/fpga/altera-cvp.c | 48 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 44badfd11e1b..58128de2a8c5 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -10,6 +10,7 @@
>   * Firmware must be in binary "rbf" format.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/fpga/fpga-mgr.h>
> @@ -22,6 +23,9 @@
>  #define TIMEOUT_US	2000	/* CVP STATUS timeout for USERMODE polling */
>  
>  /* Vendor Specific Extended Capability Registers */
> +#define VSE_PCIE_SPECIFIC_HEADER	0x4	/* VSEC ID, Revision, length */
> +#define VSEC_LENGTH			GENMASK(31, 20)

Are they PCIe standard registers?

> +#define AGILEX5_VSEC_LENGTH		0x60	/* Agilex5 only */
>  #define VSE_CVP_STATUS			0x1c	/* 32bit */
>  #define VSE_CVP_STATUS_CFG_RDY		BIT(18)	/* CVP_CONFIG_READY */
>  #define VSE_CVP_STATUS_CFG_ERR		BIT(19)	/* CVP_CONFIG_ERROR */
> @@ -48,6 +52,7 @@
>  #define V1_VSEC_OFFSET			0x200	/* Vendor Specific Offset V1 */
>  /* V2 Defines */
>  #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
> +#define VSE_CVP_AG5_TX_CREDITS		0x5C	/* 12bit credits for Agilex5 */
>  
>  #define V2_CREDIT_TIMEOUT_US		40000
>  #define V2_CHECK_CREDIT_US		10
> @@ -58,6 +63,9 @@
>  
>  #define DRV_NAME		"altera-cvp"
>  #define ALTERA_CVP_MGR_NAME	"Altera CvP FPGA Manager"
> +#define SOCFPGA_CVP_V1_OTHERS	0x1
> +#define SOCFPGA_CVP_V2_OTHERS	0x2

I didn't see they are used anywhere.

> +#define SOCFPGA_CVP_V2_AGILEX5	0x3
>  
>  /* Write block sizes */
>  #define ALTERA_CVP_V1_SIZE	4
> @@ -78,6 +86,7 @@ struct altera_cvp_conf {
>  	u32			sent_packets;
>  	u32			vsec_offset;
>  	const struct cvp_priv	*priv;
> +	u32			device_family_type;
>  };
>  
>  struct cvp_priv {
> @@ -228,18 +237,32 @@ static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
>  	u32 timeout = V2_CREDIT_TIMEOUT_US / V2_CHECK_CREDIT_US;
>  	struct altera_cvp_conf *conf = mgr->priv;
>  	int ret;
> -	u8 val;
> +	u32 val;
> +	u32 credit_mask = GENMASK(7, 0);
> +	u32 vse_cvp_tx_credits_offset = VSE_CVP_TX_CREDITS;

I'm not strict on reverse xmas tree, but don't make a complete mess.

> +
> +	if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5) {
> +		vse_cvp_tx_credits_offset = VSE_CVP_AG5_TX_CREDITS;
> +		credit_mask = GENMASK(11, 0);
> +	}
>  
>  	do {
> -		ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
> +		/* READ DWORD is required for Agilex5 but READ BYTE is required for non-Agilex5 */
> +		if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5)
> +			ret = altera_read_config_dword(conf, vse_cvp_tx_credits_offset, &val);
> +		else
> +			ret = altera_read_config_byte(conf, vse_cvp_tx_credits_offset, (u8 *)&val);
> +
>  		if (ret) {
>  			dev_err(&conf->pci_dev->dev,
>  				"Error reading CVP Credit Register\n");
>  			return ret;
>  		}
>  
> +		val = val & credit_mask;

Don't you have struct cvp_priv to describe HW differences? Why not use
it? Why Bifurcating code like this?

> +
>  		/* Return if there is space in FIFO */
> -		if (val - (u8)conf->sent_packets)
> +		if (val - conf->sent_packets)
>  			return 0;
>  
>  		ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
> @@ -507,6 +530,8 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>  				     conf->priv->user_time_us);
>  	if (ret)
>  		dev_err(&mgr->dev, "PLD_CLK_IN_USE|USERMODE timeout\n");
> +	else
> +		dev_notice(&mgr->dev, "CVP write completed successfully.\n");

Why adding this print, anything to do with "support Agilex5"?

>  
>  	return ret;
>  }
> @@ -627,10 +652,23 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	conf->pci_dev = pdev;
>  	conf->write_data = altera_cvp_write_data_iomem;
>  
> -	if (conf->vsec_offset == V1_VSEC_OFFSET)
> +	/* To differentiate the target SOCFPGA */
> +	if (conf->vsec_offset == V1_VSEC_OFFSET) {
>  		conf->priv = &cvp_priv_v1;
> -	else
> +		conf->device_family_type = SOCFPGA_CVP_V1_OTHERS;

Why add another board type indicator, conf->priv won't work?

> +		dev_notice(&pdev->dev, "V1 target SOCFPGA detected.\n");

No news is good news, a good driver keeps quiet.

> +	} else {
> +		/* Agilex7, Stratix10, Agilex5*/
>  		conf->priv = &cvp_priv_v2;
> +		pci_read_config_dword(pdev, offset + VSE_PCIE_SPECIFIC_HEADER, &regval);
> +		if (FIELD_GET(VSEC_LENGTH, regval) == AGILEX5_VSEC_LENGTH) {
> +			conf->device_family_type = SOCFPGA_CVP_V2_AGILEX5;
> +			dev_notice(&pdev->dev, "V2 target SOCFPGA Agilex5 detected.\n");
> +		} else {
> +			conf->device_family_type = SOCFPGA_CVP_V2_OTHERS;
> +			dev_notice(&pdev->dev, "V2 target SOCFPGA detected.\n");
> +		}
> +	}

BTW: I really suggest you don't send multiple threads at a time. Getting the
first patch right, then I'll have confidence to move to the next.

>  
>  	conf->map = pci_iomap(pdev, CVP_BAR, 0);
>  	if (!conf->map) {
> -- 
> 2.43.7
> 
> 
