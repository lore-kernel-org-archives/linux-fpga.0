Return-Path: <SRS0=r1hI=4J=xilinx.com=michals@kernel.org>
Return-Path: <SRS0=r1hI=4J=xilinx.com=michals@kernel.org>
Subject: Re: [PATCH] fpga: zynq: Remove clk_get error message for probe defer
References: <0060e55f0b8d3a57e129d7eb096267cc96eae846.1581517026.git.michal.simek@xilinx.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <fddb7796-c761-c6fa-13ff-632d01ffb55a@xilinx.com>
Date: Fri, 21 Feb 2020 11:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <0060e55f0b8d3a57e129d7eb096267cc96eae846.1581517026.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, Moritz Fischer <mdf@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 12. 02. 20 15:17, Michal Simek wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> In probe, the driver checks for devm_clk_get return and print error
> message in the failing case. However for -EPROBE_DEFER this message is
> confusing so avoid it.
> 
> The similar change was done also by commit 28910cee898c
> ("fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer")
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/fpga/zynq-fpga.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index ee7765049607..07fa8d9ec675 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -583,7 +583,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  
>  	priv->clk = devm_clk_get(dev, "ref_clk");
>  	if (IS_ERR(priv->clk)) {
> -		dev_err(dev, "input clock not found\n");
> +		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
> +			dev_err(dev, "input clock not found\n");
>  		return PTR_ERR(priv->clk);
>  	}
>  
> 

Moritz: Any comment on this one?

Thanks,
Michal
