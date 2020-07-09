Return-Path: <SRS0=/qFs=AU=redhat.com=trix@kernel.org>
Return-Path: <SRS0=/qFs=AU=redhat.com=trix@kernel.org>
Subject: Re: [RESEND PATCH 2/2] fpga: dfl: fix bug in port reset handshake
References: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
 <1594282337-32125-3-git-send-email-yilun.xu@intel.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <c6984a5b-ce56-2094-a30e-a019d8721420@redhat.com>
Date: Thu, 9 Jul 2020 06:20:42 -0700
MIME-Version: 1.0
In-Reply-To: <1594282337-32125-3-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lgoncalv@redhat.com, Matthew Gerlach <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>


On 7/9/20 1:12 AM, Xu Yilun wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> When putting the port in reset, driver must wait for the soft reset
> acknowledgment bit instead of the soft reset bit.
>
> Fixes: 47c1b19c160f (fpga: dfl: afu: add port ops support)
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 7c84fee..753cda4 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -83,7 +83,8 @@ int __afu_port_disable(struct platform_device *pdev)
>  	 * on this port and minimum soft reset pulse width has elapsed.
>  	 * Driver polls port_soft_reset_ack to determine if reset done by HW.
>  	 */
> -	if (readq_poll_timeout(base + PORT_HDR_CTRL, v, v & PORT_CTRL_SFTRST,
> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> +			       v & PORT_CTRL_SFTRST_ACK,
>  			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
>  		dev_err(&pdev->dev, "timeout, fail to reset device\n");
>  		return -ETIMEDOUT;

Looks ok to me.

Reviewed-by: Tom Rix <trix@redhat.com>
