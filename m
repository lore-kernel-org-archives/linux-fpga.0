Return-Path: <SRS0=Ciit=ND=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ciit=ND=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35836 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeJWRtR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Oct 2018 13:49:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id w186-v6so1001564wmf.0
        for <linux-fpga@vger.kernel.org>; Tue, 23 Oct 2018 02:26:42 -0700 (PDT)
Date: Tue, 23 Oct 2018 10:26:39 +0100
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: altera-cvp: Fix registration for CvP incapable
 devices
Message-ID: <20181023092639.GA4682@archbook>
References: <9b53d15391054a598ec3a32cee540798@SRV177.busymouse24.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b53d15391054a598ec3a32cee540798@SRV177.busymouse24.de>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Andreas Puhm <puhm@oregano.at>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "atull@kernel.org" <atull@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Andreas,

we're getting there :) It seems your mail setup is still a bit
funky though. Did you use git send-email / git format-patch?

On Tue, Oct 23, 2018 at 09:01:39AM +0000, Andreas Puhm wrote:
> From bfc602900b016f65bc2f183aa93702101a1fdc17 Mon Sep 17 00:00:00 2001
> From: Andreas Puhm <puhm@oregano.at>
> Date: Tue, 23 Oct 2018 10:24:10 +0200
> Subject: [PATCH] fpga: altera-cvp: Fix registration for CvP incapable devices
> 
> The probe function needs to verify the CvP enable bit in order to properly determine if FPGA Manager functionality can be safely enabled.
> 
> Fixes 34d1dc17ce978ae76e676d401b48fe9d004aa948 ("fpga manager: Add Altera CvP driver")

According to [1] this should be the first 12 characters of the SHA-1.
> 
> Signed-off-by: Andreas Puhm <puhm@oregano.at>
> ---
>  drivers/fpga/altera-cvp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 7fa793672a7a..ece344a56075 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	struct altera_cvp_conf *conf;
>  	struct fpga_manager *mgr;
>  	u16 cmd, val;
> +	u32 regval;
>  	int ret;
>  
>  	/*
> @@ -416,6 +417,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  		return -ENODEV;
>  	}
>  
> +	pci_read_config_dword(pdev, VSE_CVP_STATUS, &regval);
> +	if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
> +		dev_err(&pdev->dev,
> +			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
> +			regval);
> +		return -ENODEV;
> +	}
> +
>  	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
>  	if (!conf)
>  		return -ENOMEM;
> -- 
> 2.18.0.windows.1
> 

It looks like you used Windows / Outlook or something. Please don't send 
patches as attachment.

There's tutorials out there to set up git send-email with GMail for
example, if your current provider makes using git send-email hard.

[1] https://www.kernel.org/doc/html/v4.19/process/submitting-patches.html

Thanks,
Moritz
