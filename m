Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20190507194313.1618-1-mdf@kernel.org>
In-Reply-To: <20190507194313.1618-1-mdf@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Tue, 7 May 2019 15:09:57 -0500
Message-ID: <CANk1AXTgzAAH+c6oNe-ALZ5vHhUCcdhWYYAs9mbdYSB+bPabJQ@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: zynqmp-fpga: Correctly handle error pointer
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, May 7, 2019 at 2:43 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Fixes the following static checker errors:
>
> drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
> error: 'eemi_ops' dereferencing possible ERR_PTR()
>
> drivers/fpga/zynqmp-fpga.c:84 zynqmp_fpga_ops_state()
> error: 'eemi_ops' dereferencing possible ERR_PTR()
>
> Note: This does not handle the EPROBE_DEFER value in a
>       special manner.
>
> Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
> Xilinx zynqmp")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>

Thanks!
Alan

> ---
>
> Changes from v1:
> - Address Alan's feedback regarding handling both occurences.
>
> ---
>  drivers/fpga/zynqmp-fpga.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index f7cbaadf49ab..b8a88d21d038 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
>         char *kbuf;
>         int ret;
>
> -       if (!eemi_ops || !eemi_ops->fpga_load)
> +       if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
>                 return -ENXIO;
>
>         priv = mgr->priv;
> @@ -81,7 +81,7 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
>         const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>         u32 status;
>
> -       if (!eemi_ops || !eemi_ops->fpga_get_status)
> +       if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_get_status)
>                 return FPGA_MGR_STATE_UNKNOWN;
>
>         eemi_ops->fpga_get_status(&status);
> --
> 2.21.0
>
