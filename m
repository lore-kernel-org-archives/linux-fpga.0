Date: Sun, 1 Mar 2020 08:26:04 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv1 3/7] fpga: stratix10-soc: add compatible property value
 for intel agilex
Message-ID: <20200301162602.GG7593@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-4-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-4-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Feb 14, 2020 at 10:00:48AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add compatible property value so we can reuse FPGA manager driver on
> Intel Agilex SoC platform.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/stratix10-soc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 215d337..bac93d0 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -482,7 +482,8 @@ static int s10_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id s10_of_match[] = {
> -	{ .compatible = "intel,stratix10-soc-fpga-mgr", },
> +	{.compatible = "intel,stratix10-soc-fpga-mgr"},
> +	{.compatible = "intel,agilex-soc-fpga-mgr"},
>  	{},
>  };
>  
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks
