Date: Tue, 12 May 2020 08:35:17 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv1] fpga: stratix10-soc: remove the pre-set
 reconfiguration condition
Message-ID: <20200512153514.GA125665@epycbox.lan>
References: <1589290051-30246-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589290051-30246-1-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, dinguyen@kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Richard,

On Tue, May 12, 2020 at 08:27:31AM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> The reconfiguration mode is pre-set by driver as the full reconfiguration.
> As a result, user have to change code and recompile the drivers if he or
> she wants to perform a partial reconfiguration. Removing the pre-set
> reconfiguration condition so that user can select full or partial
> reconfiguration via overlay device tree without recompiling the drivers.
> 
> Also add an error message if the configuration request is failure.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/stratix10-soc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 44b7c56..2da8a40 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -182,12 +182,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	uint i;
>  	int ret;
>  
> -	ctype.flags = 0;
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_dbg(dev, "Requesting partial reconfiguration.\n");
> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> +		ctype.flags = 1;
Have you considered:

ctype.flags = BIT(COMMAND_RECONFIG_FLAG_PARTIAL);

instead (assuming 1, lines up with BIT(COMMAND_RECONFIG_FLAG_PARTIAL)?

If not: Can you define a constant?
>  	} else {
>  		dev_dbg(dev, "Requesting full reconfiguration.\n");
> +		ctype.flags = 0;
>  	}
>  
>  	reinit_completion(&priv->status_return_completion);
> @@ -210,6 +210,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  
>  	ret = 0;
>  	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> +		dev_err(dev, "RECONFIG_REQUEST failed\n");
>  		ret = -ETIMEDOUT;
>  		goto init_done;
>  	}
> -- 
> 2.7.4
> 

Cheers,
Moritz
