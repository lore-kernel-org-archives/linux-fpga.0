Return-Path: <SRS0=FdzR=2C=xilinx.com=michal.simek@kernel.org>
Return-Path: <SRS0=FdzR=2C=xilinx.com=michal.simek@kernel.org>
Subject: Re: [PATCH v2 2/3] fpga: zynq: Add support for encrypted bitstreams
References: <1487624123-13579-1-git-send-email-mdf@kernel.org>
 <1487624123-13579-2-git-send-email-mdf@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <29bc6189-479e-c063-ef35-4ba99c5a1d56@xilinx.com>
Date: Tue, 21 Feb 2017 14:55:18 +0100
MIME-Version: 1.0
In-Reply-To: <1487624123-13579-2-git-send-email-mdf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: mdf@kernel.org, linux-fpga@vger.kernel.org
Cc: Alan Tull <atull@kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 20.2.2017 21:55, mdf@kernel.org wrote:
> From: Moritz Fischer <mdf@kernel.org>
> 
> Add support for encrypted bitstreams. For this to work the system
> must be booted in secure mode.
> 
> In order for on-the-fly decryption to work, the PCAP clock rate
> needs to be lowered via the PCAP_RATE_EN bit.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org
> ---
> 
> Changes from v1:
> - Renamed flag from FPGA_MGR_DECRYPT_BITSTREAM->FPGA_MGR_ENCRYPTED_BITSTREAM
> 
> ---
>  drivers/fpga/zynq-fpga.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 34cb981..70b15b3 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -72,6 +72,10 @@
>  #define CTRL_PCAP_PR_MASK		BIT(27)
>  /* Enable PCAP */
>  #define CTRL_PCAP_MODE_MASK		BIT(26)
> +/* Lower rate to allow decrypt on the fly */
> +#define CTRL_PCAP_RATE_EN_MASK		BIT(25)
> +/* System booted in secure mode */
> +#define CTRL_SEC_EN_MASK		BIT(7)
>  
>  /* Miscellaneous Control Register bit definitions */
>  /* Internal PCAP loopback */
> @@ -266,6 +270,17 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  	if (err)
>  		return err;
>  
> +	/* check if bitstream is encrypted & and system's still secure */
> +	if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM) {
> +		ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
> +		if (!(ctrl & CTRL_SEC_EN_MASK)) {
> +			dev_err(&mgr->dev,
> +				"System not secure, can't use crypted bitstreams\n");
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +	}
> +
>  	/* don't globally reset PL if we're doing partial reconfig */
>  	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
>  		if (!zynq_fpga_has_sync(buf, count)) {
> @@ -337,12 +352,19 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  
>  	/* set configuration register with following options:
>  	 * - enable PCAP interface
> -	 * - set throughput for maximum speed
> +	 * - set throughput for maximum speed (if bistream not crypted)
>  	 * - set CPU in user mode
>  	 */
>  	ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
> -	zynq_fpga_write(priv, CTRL_OFFSET,
> -			(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl));
> +	if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM)
> +		zynq_fpga_write(priv, CTRL_OFFSET,
> +				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
> +				 | CTRL_PCAP_RATE_EN_MASK | ctrl));
> +	else
> +		zynq_fpga_write(priv, CTRL_OFFSET,
> +				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
> +				 | ctrl));
> +
>  
>  	/* We expect that the command queue is empty right now. */
>  	status = zynq_fpga_read(priv, STATUS_OFFSET);
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
