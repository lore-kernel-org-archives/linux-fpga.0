Return-Path: <SRS0=fLkF=ND=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=fLkF=ND=ettus.com=moritz.fischer@kernel.org>
Date: Tue, 23 Oct 2018 10:01:19 +0100
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] zynq-fpga: Only route PR via PCAP when required
Message-ID: <20181023090119.GA2205@archbook>
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, mdf@kernel.org, atull@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Mike,

seems like a good usecase (though uncommon), question below

On Tue, Oct 23, 2018 at 08:31:19AM +0200, Mike Looijmans wrote:
> The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
> it impossible to use the ICAP interface for partial reconfiguration.
> 
> This patch changes the driver to only activate PR over PCAP while the
> device is actively being accessed by the driver for programming.
> 
> This allows both PCAP and ICAP interfaces to be used for PR.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/fpga/zynq-fpga.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 3110e00..f6c205a 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -497,6 +497,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
>  	int err;
>  	u32 intr_status;
>  
> +	/* Release 'PR' control back to the ICAP */
> +	zynq_fpga_write(priv, CTRL_OFFSET,
> +		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
> +

Shouldn't that be after the below stanza that enables the clock?

>  	err = clk_enable(priv->clk);
>  	if (err)
>  		return err;
> -- 
> 1.9.1
> 

Cheers,

Moritz
