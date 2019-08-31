Date: Sat, 31 Aug 2019 13:55:32 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v6 14/57] fpga: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190831205530.GA24385@archbox>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-15-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-15-swboyd@chromium.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jul 30, 2019 at 11:15:14AM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/fpga/zynq-fpga.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 31ef38e38537..ee7765049607 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -578,10 +578,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  	init_completion(&priv->dma_done);
>  
>  	priv->irq = platform_get_irq(pdev, 0);
> -	if (priv->irq < 0) {
> -		dev_err(dev, "No IRQ available\n");
> +	if (priv->irq < 0)
>  		return priv->irq;
> -	}
>  
>  	priv->clk = devm_clk_get(dev, "ref_clk");
>  	if (IS_ERR(priv->clk)) {
> -- 
> Sent by a computer through tubes
> 
Applied to for-next. If all goes well I'll queue it for next PR.
