Return-Path: <SRS0=1sRv=GT=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=1sRv=GT=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 29 Mar 2018 19:04:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/6] fpga: bridge: don't use drvdata in common fpga code
Message-ID: <20180329170420.GD8501@kroah.com>
References: <20180329153658.11614-1-mdf@kernel.org>
 <20180329153658.11614-4-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329153658.11614-4-mdf@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: atull@kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Mar 29, 2018 at 08:36:55AM -0700, Moritz Fischer wrote:
> From: Alan Tull <atull@kernel.org>
> 
> Change fpga_bridge_register to not set drvdata.
> 
> Change the register/unregister functions parameters to take the
> bridge struct:
> * int fpga_bridge_register(struct fpga_bridge *bridge);
> * void fpga_bridge_unregister(struct fpga_bridge *bridge);
> 
> Change the drivers that call fpga_bridge_register to alloc the struct
> fpga_bridge (using devm_kzalloc) and partly fill it, adding name,
> ops, parent device, and priv.
> 
> The rationale is that setting drvdata is fine for DT based devices
> that will have one manager, bridge, or region per platform device.
> However PCIe based devices may have multiple FPGA mgr/bridge/regions
> under one pcie device.  Without these changes, the PCIe solution has
> to create an extra device for each child mgr/bridge/region to hold
> drvdata.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-fpga2sdram.c    | 20 +++++++++++++----
>  drivers/fpga/altera-freeze-bridge.c | 18 +++++++++++++---
>  drivers/fpga/altera-hps2fpga.c      | 16 +++++++++++---
>  drivers/fpga/fpga-bridge.c          | 43 ++++++++++++++-----------------------
>  drivers/fpga/xilinx-pr-decoupler.c  | 15 ++++++++++---
>  include/linux/fpga/fpga-bridge.h    |  7 +++---
>  6 files changed, 76 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
> index d4eeb74388da..a4593c0f5e42 100644
> --- a/drivers/fpga/altera-fpga2sdram.c
> +++ b/drivers/fpga/altera-fpga2sdram.c
> @@ -106,10 +106,15 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct alt_fpga2sdram_data *priv;
> +	struct fpga_bridge *br;
>  	u32 enable;
>  	struct regmap *sysmgr;
>  	int ret = 0;
>  
> +	br = devm_kzalloc(dev, sizeof(*br), GFP_KERNEL);
> +	if (!br)
> +		return -ENOMEM;
> +
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> @@ -131,8 +136,13 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>  	/* Get f2s bridge configuration saved in handoff register */
>  	regmap_read(sysmgr, SYSMGR_ISWGRP_HANDOFF3, &priv->mask);
>  
> -	ret = fpga_bridge_register(dev, F2S_BRIDGE_NAME,
> -				   &altera_fpga2sdram_br_ops, priv);
> +	br->parent = dev;
> +	br->name = F2S_BRIDGE_NAME;
> +	br->br_ops = &altera_fpga2sdram_br_ops;
> +	br->priv = priv;
> +	platform_set_drvdata(pdev, br);

Same question here, why not fpga_bridge_create(...)?

thanks,

greg k-h
