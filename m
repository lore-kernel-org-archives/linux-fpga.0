Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181203122145.1534-1-nsaenzjulienne@suse.de>
In-Reply-To: <20181203122145.1534-1-nsaenzjulienne@suse.de>
From: Alan Tull <atull@kernel.org>
Date: Mon, 3 Dec 2018 10:12:39 -0600
Message-ID: <CANk1AXRxUai9SmSFt1uMXVRcoumh+ziKCi8WHb2tCG5Wx4Txow@mail.gmail.com>
Subject: Re: [PATCH] fpga: stratix10-soc: fix wrong of_node_put() in init function
Content-Type: text/plain; charset="UTF-8"
To: nsaenzjulienne@suse.de
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 3, 2018 at 6:22 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:

Hi Nicolas,

Thanks for catching this!  I'll fix up one formatting thing (below).

>
> After finding a "firmware" dt node stratix10 tries to match it's
> compatible string with it. To do so it's calling of_find_matching_node()
> which already takes care of decreasing the refcount on the "firmware"
> node. We are then incorrectly decreasing the refcount on that node
> again.
>
> This patch removes the unwarranted call to of_node_put().
>
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Alan Tull <atull@kernel.org>

> ---
>  drivers/fpga/stratix10-soc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index a1a09e04fab8..e75dbe583152 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -509,13 +509,11 @@ static int __init s10_init(void)
>
>         np = of_find_matching_node(fw_np, s10_of_match);
>         if (!np) {
> -               of_node_put(fw_np);
>                 return -ENODEV;
>         }

We don't need the brackets anymore around the return statement.  I'll fix it up.

Thanks,
Alan

>
>         of_node_put(np);
>         ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
> -       of_node_put(fw_np);
>         if (ret)
>                 return ret;
>
> --
> 2.19.2
>
