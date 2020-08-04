Return-Path: <moritz.fischer.private@gmail.com>
Date: Tue, 4 Aug 2020 09:43:58 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [RESEND PATCHv1] fpga: stratix10-soc: make FPGA task
 un-interruptible
Message-ID: <20200804164358.GB1499313@epycbox.lan>
References: <1595607009-2065-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595607009-2065-1-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com, dinguyen@kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Jul 24, 2020 at 11:10:09AM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
> reconfiguration process stops and the user can't perform a new FPGA
> reconfiguration properly.
> 
> Set FPGA task to be not interruptible so that the user can properly
> perform FPGA reconfiguration after CTRL+C event.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/stratix10-soc.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 44b7c56..657a70c 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -196,17 +196,13 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	if (ret < 0)
>  		goto init_done;
>  
> -	ret = wait_for_completion_interruptible_timeout(
> +	ret = wait_for_completion_timeout(
>  		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>  	if (!ret) {
>  		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>  		ret = -ETIMEDOUT;
>  		goto init_done;
>  	}
> -	if (ret < 0) {
> -		dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
> -		goto init_done;
> -	}
>  
>  	ret = 0;
>  	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> @@ -318,7 +314,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  		 */
>  		wait_status = 1; /* not timed out */
>  		if (!priv->status)
> -			wait_status = wait_for_completion_interruptible_timeout(
> +			wait_status = wait_for_completion_timeout(
>  				&priv->status_return_completion,
>  				S10_BUFFER_TIMEOUT);
>  
> @@ -340,13 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  			ret = -ETIMEDOUT;
>  			break;
>  		}
> -		if (wait_status < 0) {
> -			ret = wait_status;
> -			dev_err(dev,
> -				"error (%d) waiting for svc layer buffers\n",
> -				ret);
> -			break;
> -		}
>  	}
>  
>  	if (!s10_free_buffers(mgr))
> @@ -372,7 +361,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>  		if (ret < 0)
>  			break;
>  
> -		ret = wait_for_completion_interruptible_timeout(
> +		ret = wait_for_completion_timeout(
>  			&priv->status_return_completion, timeout);
>  		if (!ret) {
>  			dev_err(dev,
> @@ -380,12 +369,6 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>  			ret = -ETIMEDOUT;
>  			break;
>  		}
> -		if (ret < 0) {
> -			dev_err(dev,
> -				"error (%d) waiting for RECONFIG_COMPLETED\n",
> -				ret);
> -			break;
> -		}
>  		/* Not error or timeout, so ret is # of jiffies until timeout */
>  		timeout = ret;
>  		ret = 0;
> -- 
> 2.7.4
> 

Sorry that one slipped through the cracks, will apply to for-next.

Thanks!
