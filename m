Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl> <1540367583-5413-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1540367583-5413-1-git-send-email-mike.looijmans@topic.nl>
From: Alan Tull <atull@kernel.org>
Date: Thu, 1 Nov 2018 13:33:39 -0500
Message-ID: <CANk1AXRS=K65arg+JGmWsnpi1qoRm7ccQCsjo1C=d-85YGjeOQ@mail.gmail.com>
Subject: Re: [PATCH v2] zynq-fpga: Only route PR via PCAP when required
Content-Type: text/plain; charset="UTF-8"
To: mike.looijmans@topic.nl
Cc: linux-fpga@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, Moritz Fischer <mdf@kernel.org>, git@xilinx.com
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Oct 24, 2018 at 2:53 AM Mike Looijmans <mike.looijmans@topic.nl> wrote:

Hi Mike,

>
> The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
> it impossible to use the ICAP interface for partial reconfiguration.
>
> This patch changes the driver to only activate PR over PCAP while the
> device is actively being accessed by the driver for programming.
>
> This allows both PCAP and ICAP interfaces to be used for PR.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

Thanks for submitting!

Alan

> ---
> v2: Move the register setting in between the clock enable/disable
>
>  drivers/fpga/zynq-fpga.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 3110e00..ff3a427 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -501,6 +501,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
>         if (err)
>                 return err;
>
> +       /* Release 'PR' control back to the ICAP */
> +       zynq_fpga_write(priv, CTRL_OFFSET,
> +               zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
> +
>         err = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, intr_status,
>                                      intr_status & IXR_PCFG_DONE_MASK,
>                                      INIT_POLL_DELAY,
> --
> 1.9.1
>
