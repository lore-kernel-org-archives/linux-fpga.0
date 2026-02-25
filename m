Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E483D668E;
	Wed, 25 Feb 2026 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048480; cv=none; b=Bub5d5K2wEfUyFHkwL8wDoabys1Q9Ydx8A2cGnRGuI1Pa1rmLmkF1WAdlkX19hiYldXcqzFXLQjfav3hwq1lfFG8Sc9ImKygoUwtiUvoF4os/qKI5MXRhRzRaRQBj1QJcIlnDHex3bcTndUgvcMrBz7glvHkb5rwQqbFPudeok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048480; c=relaxed/simple;
	bh=Hxc8seEhSUYcCehdTOSE+1hqLezl98FQhwkLwturW9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gj1sprqynU5bdCylAbyI+kO/liT6UDvSHntH+sqK9WeZzxfog1KjIFmx/Em6SlcnvLZr++WH37My++N8kMcDbeW95oW9vua2X6xpl1SF1J1yGt0vrYF5ZPyUgNudGVumpPFvj/Q5ViAZaL0HnlM7UKzyGOmnhrNVtpqVOSRfCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9OAIHsk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9OAIHsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF24C116D0;
	Wed, 25 Feb 2026 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772048479;
	bh=Hxc8seEhSUYcCehdTOSE+1hqLezl98FQhwkLwturW9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z9OAIHsktw61SRN/xIqnrh8AUfNpmQZEuud0PVq/AOpZFE7hwENcyr/EREC9FM5N3
	 2xd2HoBCS/OLI1kJ0zZqLG9kCVEAbAAzMcA3IaDjuOtKBe/mOywVdcw+E/RQMEH5Ut
	 bk1D46HwbCsen0vH7oYZ75y09OIy0MywMs6JQ00k6MmgW1aI7tzfr3XxgtfAJlWaAP
	 dCbXeRZ4EB+O4YAT/JZJpfdQztWZTJltmiUvxy0Bi4dcq/XXMONhHxotbEZXk7dNHV
	 V9N5U8ho41HWufPZ5j6Q26DSxvHiDm20xRK/jrJD6weutEb0+WJQ164jLFAmjWSqVR
	 M40rgwGOg2xJw==
Message-ID: <6c64c903-0df0-4838-954f-4c82baf48971@kernel.org>
Date: Wed, 25 Feb 2026 13:36:29 -0600
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: stratix10-svc: support up to 4 buffer claims
 and extend timeout
Content-Language: en-US
To: adrianhoyin.ng@altera.com, mdf@kernel.org, yilun.xu@intel.com,
 trix@redhat.com, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ang Tien Sung <tiensung.ang@altera.com>
References: <b67ffe732654c7db86c4b5d987af92dcc12bf4f3.1770706895.git.adrianhoyin.ng@altera.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <b67ffe732654c7db86c4b5d987af92dcc12bf4f3.1770706895.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/10/26 01:16, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> The service layer previously only returned up to three buffer addresses
> per transaction. Extend the logic in svc_thread_cmd_data_claim() to
> collect up to four buffer claims. A new field `kaddr4` is added to
> struct stratix10_svc_cb_data, and the FPGA manager callback unlocks this
> fourth buffer accordingly.
> 
> Timeout values for reconfiguration and buffer transactions are also
> increased (from ~300–720ms to 5000ms), since real-world processing takes
> significantly longer (~600ms or more). The reconfiguration complete
> timeout is also replaced with S10_RECONFIG_TIMEOUT (>1s) to avoid
> premature aborts.
> 
> Additional changes:
> - Callbacks are updated to pass all claimed buffers to clients.
> - Debug logging is added to trace received status values.
> - Simplified buffer wait logic in s10_ops_write() by always using
>    wait_for_completion_timeout().
> 
> These changes improve robustness of FPGA configuration on SoCFPGA
> platforms by handling larger transactions and accommodating realistic
> timing.
> 
> Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>   drivers/firmware/stratix10-svc.c              | 36 +++++++++++++------
>   drivers/fpga/stratix10-soc.c                  | 18 +++++-----
>   .../firmware/intel/stratix10-svc-client.h     |  6 ++--
>   3 files changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index dbed404a71fc..58cf68d9a384 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -342,6 +342,8 @@ static void svc_thread_cmd_data_claim(struct stratix10_svc_controller *ctrl,
>   {
>   	struct arm_smccc_res res;
>   	unsigned long timeout;
> +	void *buf_claim_addr[4] = {NULL};
> +	int buf_claim_count = 0;
>   
>   	reinit_completion(&ctrl->complete_status);
>   	timeout = msecs_to_jiffies(FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS);
> @@ -353,20 +355,32 @@ static void svc_thread_cmd_data_claim(struct stratix10_svc_controller *ctrl,
>   
>   		if (res.a0 == INTEL_SIP_SMC_STATUS_OK) {
>   			if (!res.a1) {
> +				/* Transaction of 4 blocks are now done */

This comment is a bit misleading. How do you know you finish exactly 4 
blocks?

>   				complete(&ctrl->complete_status);
> +				cb_data->status = BIT(SVC_STATUS_BUFFER_DONE);
> +				cb_data->kaddr1 = buf_claim_addr[0];
> +				cb_data->kaddr2 = buf_claim_addr[1];
> +				cb_data->kaddr3 = buf_claim_addr[2];
> +				cb_data->kaddr4 = buf_claim_addr[3];
> +				p_data->chan->scl->receive_cb(p_data->chan->scl,
> +				cb_data);
>   				break;
>   			}
> -			cb_data->status = BIT(SVC_STATUS_BUFFER_DONE);
> -			cb_data->kaddr1 = svc_pa_to_va(res.a1);
> -			cb_data->kaddr2 = (res.a2) ?
> -					  svc_pa_to_va(res.a2) : NULL;
> -			cb_data->kaddr3 = (res.a3) ?
> -					  svc_pa_to_va(res.a3) : NULL;
> -			p_data->chan->scl->receive_cb(p_data->chan->scl,
> -						      cb_data);

The callback used to be only dependent on INTEL_SIP_SMC_STATUS_OK, but 
this change put the dependency on res.a1 == 0 as well. Please add 
comment or add to the commit message the reason for this change.

> -		} else {
> -			pr_debug("%s: secure world busy, polling again\n",
> -				 __func__);
> +
> +			if (buf_claim_count < 4) {
> +				buf_claim_addr[buf_claim_count] = svc_pa_to_va(res.a1);
> +				buf_claim_count++;
> +			}
> +
> +			if (res.a2 && buf_claim_count < 4) {
> +				buf_claim_addr[buf_claim_count] = svc_pa_to_va(res.a2);
> +				buf_claim_count++;
> +			}
> +			if (res.a3 && buf_claim_count < 4) {
> +				buf_claim_addr[buf_claim_count] = svc_pa_to_va(res.a3);
> +				buf_claim_count++;
> +			}

Could there be a case where buf_claim_count >= 4, if so you should add a 
WARN_ON.

> +
>   		}
>   	} while (res.a0 == INTEL_SIP_SMC_STATUS_OK ||
>   		 res.a0 == INTEL_SIP_SMC_STATUS_BUSY ||
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 0a295ccf1644..4fea9458f92b 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -147,6 +147,7 @@ static void s10_receive_callback(struct stratix10_svc_client *client,
>   	u32 status;
>   	int i;
>   
> +	pr_debug("%s data %x\n", __func__, data->status);

Use %#x would be more informative for a status bitmask.

>   	WARN_ONCE(!data, "%s: stratix10_svc_rc_data = NULL", __func__);
>   
>   	status = data->status;
> @@ -163,6 +164,7 @@ static void s10_receive_callback(struct stratix10_svc_client *client,
>   		s10_unlock_bufs(priv, data->kaddr1);
>   		s10_unlock_bufs(priv, data->kaddr2);
>   		s10_unlock_bufs(priv, data->kaddr3);
> +		s10_unlock_bufs(priv, data->kaddr4);
>   	}
>   
>   	complete(&priv->status_return_completion);
> @@ -309,15 +311,8 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>   				break;
>   		}
>   
> -		/*
> -		 * If callback hasn't already happened, wait for buffers to be
> -		 * returned from service layer
> -		 */
> -		wait_status = 1; /* not timed out */
> -		if (!priv->status)
> -			wait_status = wait_for_completion_timeout(
> -				&priv->status_return_completion,
> -				S10_BUFFER_TIMEOUT);
> +		wait_status = wait_for_completion_timeout(&priv->status_return_completion,
> +							  S10_BUFFER_TIMEOUT);

Can you add a comment why you remove the check for !priv->status to call 
wait_for_completion_timeout() ?

>   
>   		if (test_and_clear_bit(SVC_STATUS_BUFFER_DONE, &priv->status) ||
>   		    test_and_clear_bit(SVC_STATUS_BUFFER_SUBMITTED,
> @@ -353,7 +348,10 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>   	unsigned long timeout;
>   	int ret;
>   
> -	timeout = usecs_to_jiffies(info->config_complete_timeout_us);
> +	/* The time taken to process this is close to 600ms

nit: comment style is wrong

> +	 * This MUST be increased over 1 second
> +	 */
> +	timeout = S10_RECONFIG_TIMEOUT;
>   
>   	do {
>   		reinit_completion(&priv->status_return_completion);
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index d290060f4c73..abe04f4fad1d 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -68,8 +68,8 @@
>    * timeout value used in Stratix10 FPGA manager driver.
>    * timeout value used in RSU driver
>    */
> -#define SVC_RECONFIG_REQUEST_TIMEOUT_MS         300
> -#define SVC_RECONFIG_BUFFER_TIMEOUT_MS          720
> +#define SVC_RECONFIG_REQUEST_TIMEOUT_MS         5000
> +#define SVC_RECONFIG_BUFFER_TIMEOUT_MS          5000

These are huge jumps in timeout values. You may be masking real firmware 
hangs. Please document why such a large change.

Dinh

