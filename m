Date: Mon, 15 Jun 2020 21:43:49 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 5/5] fpga manager: xilinx-spi: check INIT_B pin during
 write_init
Message-ID: <20200616044347.GB46300@epycbox.lan>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
 <20200611211144.9421-5-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-5-luca@lucaceresoli.net>
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
List-ID: <linux-fpga@vger.kernel.org>

Hi Luca,

On Thu, Jun 11, 2020 at 11:11:44PM +0200, Luca Ceresoli wrote:
> The INIT_B reports the status during startup and after the end of the
> programming process. However the current driver completely ignores it.
> 
> Check the pin status during startup to make sure programming is never
> started too early and also to detect any hardware issues in the FPGA
> connection.
> 
> This is optional for backward compatibility. If INIT_B is not passed by
> device tree, just fallback to the old udelays.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/fpga/xilinx-spi.c | 54 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 799ae04301be..2710a15ed16b 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -23,6 +23,7 @@
>  struct xilinx_spi_conf {
>  	struct spi_device *spi;
>  	struct gpio_desc *prog_b;
> +	struct gpio_desc *init_b;
>  	struct gpio_desc *done;
>  };
>  
> @@ -36,11 +37,44 @@ static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> +/**
> + * wait_for_init_b - wait for the INIT_B pin to have a given state, or wait
> + * a given delay if the pin is unavailable
> + *
> + * @mgr        The FPGA manager object
> + * @value      Value INIT_B to wait for (1 = asserted = low)
> + * @act_udelay Delay to wait if the INIT_B pin is not available
> + *
> + * Returns 0 when the pin reached the given state or -ETIMEDOUT if too much
> + * time passed waiting for that. If there is no INIT_B, always return 0.
> + */
> +static int wait_for_init_b(struct fpga_manager *mgr, int value,
> +			   unsigned long backup_udelay)
> +{
> +	struct xilinx_spi_conf *conf = mgr->priv;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> +
> +	if (conf->init_b) {
> +		while (time_before(jiffies, timeout)) {
> +			/* dump_state(conf, "wait for init_d .."); */
> +			if (gpiod_get_value(conf->init_b) == value)
> +				return 0;
> +			usleep_range(100, 400);
> +		}
> +		return -ETIMEDOUT;
> +	}
> +
> +	udelay(backup_udelay);
> +
> +	return 0;
> +}
> +
>  static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  				 struct fpga_image_info *info,
>  				 const char *buf, size_t count)
>  {
>  	struct xilinx_spi_conf *conf = mgr->priv;
> +	int err;
>  
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
> @@ -49,10 +83,21 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  
>  	gpiod_set_value(conf->prog_b, 1);
>  
> -	udelay(1); /* min is 500 ns */
> +	err = wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
> +	if (err) {
> +		dev_err(&mgr->dev, "INIT_B pin did not go low\n");
> +		gpiod_set_value(conf->prog_b, 0);
> +		return err;
> +	}
>  
>  	gpiod_set_value(conf->prog_b, 0);
>  
> +	err = wait_for_init_b(mgr, 0, 0);
> +	if (err) {
> +		dev_err(&mgr->dev, "INIT_B pin did not go high\n");
> +		return err;
> +	}
> +
>  	if (gpiod_get_value(conf->done)) {
>  		dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
>  		return -EIO;
> @@ -154,6 +199,13 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  		return PTR_ERR(conf->prog_b);
>  	}
>  
> +	conf->init_b = devm_gpiod_get_optional(&spi->dev, "init_b", GPIOD_IN);
> +	if (IS_ERR(conf->init_b)) {
> +		dev_err(&spi->dev, "Failed to get INIT_B gpio: %ld\n",
> +			PTR_ERR(conf->init_b));
> +		return PTR_ERR(conf->init_b);
> +	}
> +
>  	conf->done = devm_gpiod_get(&spi->dev, "done", GPIOD_IN);
>  	if (IS_ERR(conf->done)) {
>  		dev_err(&spi->dev, "Failed to get DONE gpio: %ld\n",
> -- 
> 2.27.0
> 

Series looks good, will apply to for-next.

Thanks,
Moritz
