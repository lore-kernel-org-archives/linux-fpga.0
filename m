Return-Path: <SRS0=McIN=A7=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=McIN=A7=linux.intel.com=richard.gong@kernel.org>
Subject: Re: [PATCH] fpga: stratix10-soc: make FPGA task un-interruptible
References: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
From: Richard Gong <richard.gong@linux.intel.com>
Message-ID: <d678df9e-7f1d-8f50-e2c9-a734b60e6c9a@linux.intel.com>
Date: Mon, 20 Jul 2020 14:00:22 -0500
MIME-Version: 1.0
In-Reply-To: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, dinguyen@kernel.org, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>


Hi Moritz,

Sorry for asking.

When you get chance, can you review this FPGA patch?

Regards,
Richard


On 7/7/20 11:14 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
> reconfiguration process stops and the user can't perform a new FPGA
> reconfiguration properly.
> 
> Set FPGA complete task to be not interruptible so that the user can
> properly perform FPGA reconfiguration after CTRL+C event.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>   drivers/fpga/stratix10-soc.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 44b7c56..657a70c 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -196,17 +196,13 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>   	if (ret < 0)
>   		goto init_done;
>   
> -	ret = wait_for_completion_interruptible_timeout(
> +	ret = wait_for_completion_timeout(
>   		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>   	if (!ret) {
>   		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>   		ret = -ETIMEDOUT;
>   		goto init_done;
>   	}
> -	if (ret < 0) {
> -		dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
> -		goto init_done;
> -	}
>   
>   	ret = 0;
>   	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> @@ -318,7 +314,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>   		 */
>   		wait_status = 1; /* not timed out */
>   		if (!priv->status)
> -			wait_status = wait_for_completion_interruptible_timeout(
> +			wait_status = wait_for_completion_timeout(
>   				&priv->status_return_completion,
>   				S10_BUFFER_TIMEOUT);
>   
> @@ -340,13 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>   			ret = -ETIMEDOUT;
>   			break;
>   		}
> -		if (wait_status < 0) {
> -			ret = wait_status;
> -			dev_err(dev,
> -				"error (%d) waiting for svc layer buffers\n",
> -				ret);
> -			break;
> -		}
>   	}
>   
>   	if (!s10_free_buffers(mgr))
> @@ -372,7 +361,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>   		if (ret < 0)
>   			break;
>   
> -		ret = wait_for_completion_interruptible_timeout(
> +		ret = wait_for_completion_timeout(
>   			&priv->status_return_completion, timeout);
>   		if (!ret) {
>   			dev_err(dev,
> @@ -380,12 +369,6 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>   			ret = -ETIMEDOUT;
>   			break;
>   		}
> -		if (ret < 0) {
> -			dev_err(dev,
> -				"error (%d) waiting for RECONFIG_COMPLETED\n",
> -				ret);
> -			break;
> -		}
>   		/* Not error or timeout, so ret is # of jiffies until timeout */
>   		timeout = ret;
>   		ret = 0;
> 
