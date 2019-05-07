Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20190507170257.25451-1-mdf@kernel.org>
In-Reply-To: <20190507170257.25451-1-mdf@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Tue, 7 May 2019 14:11:06 -0500
Message-ID: <CANk1AXS2m+v2uMoE0gLhKqYhn_NcbV8gZq+ogMsC_Zp81ZHAow@mail.gmail.com>
Subject: Re: [PATCH] fpga: zynqmp-fpga: Correctly handle error pointer
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, May 7, 2019 at 12:03 PM Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

>
> Fixes the following static checker error:
>
> drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
> error: 'eemi_ops' dereferencing possible ERR_PTR()
>
> Note: This does not handle the EPROBE_DEFER value in a
>       special manner.
>
> Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
> Xilinx zynqmp")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/zynqmp-fpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index f7cbaadf49ab..abcb0b2e75bf 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
>         char *kbuf;
>         int ret;
>
> -       if (!eemi_ops || !eemi_ops->fpga_load)
> +       if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)

This if statement also happens in fpga_mgr_states
zynqmp_fpga_ops_state(), so we'll need this fix there also.

>                 return -ENXIO;
>
>         priv = mgr->priv;
> --
> 2.21.0
>

Alan
