Return-Path: <SRS0=PnVv=77=xilinx.com=michal.simek@kernel.org>
Return-Path: <SRS0=PnVv=77=xilinx.com=michal.simek@kernel.org>
Subject: Re: [PATCH] fpga: make xlnx_pr_decoupler_br_ops const
References: <1503941531-17977-1-git-send-email-bhumirks@gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <78e2ed1d-ea20-eb68-b6b4-d993a98984a6@xilinx.com>
Date: Tue, 29 Aug 2017 08:00:20 +0200
MIME-Version: 1.0
In-Reply-To: <1503941531-17977-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, atull@kernel.org, mdf@kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 28.8.2017 19:32, Bhumika Goyal wrote:
> Make this const as it is only passed to a const argument of the function
> fpga_bridge_register.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/fpga/xilinx-pr-decoupler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index e359930..0d77430 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -79,7 +79,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
>  	return !status;
>  }
>  
> -static struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
> +static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
>  	.enable_set = xlnx_pr_decoupler_enable_set,
>  	.enable_show = xlnx_pr_decoupler_enable_show,
>  };
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
