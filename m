Return-Path: <SRS0=Lr74=NJ=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=Lr74=NJ=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 29 Oct 2018 09:59:45 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2] fpga: altera-cvp: Fix registration for CvP incapable
 devices
Message-ID: <20181029165945.GB2453@archbook>
References: <20181029072630.13339-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029072630.13339-1-agust@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Cc: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Puhm <puhm@oregano.at>
List-ID: <linux-fpga@vger.kernel.org>

Hi Anatolij, Andreas,

On Mon, Oct 29, 2018 at 08:26:30AM +0100, Anatolij Gustschin wrote:
> From: Andreas Puhm <puhm@oregano.at>
> 
> The probe function needs to verify the CvP enable bit in order to
> properly determine if FPGA Manager functionality can be safely
> enabled.
> 
> Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
> Signed-off-by: Andreas Puhm <puhm@oregano.at>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> Changes in v2:
>  - improve Fixes tag
>  - wrap lines in commit description
> 
>  drivers/fpga/altera-cvp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 3998d4f0e5e7..196d52558990 100644
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
> @@ -419,6 +420,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
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
> 2.17.1
> 

Thanks,
Moritz
