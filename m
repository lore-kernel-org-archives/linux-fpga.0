Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20190124204554.5438-1-atull@kernel.org> <20190124204554.5438-2-atull@kernel.org>
In-Reply-To: <20190124204554.5438-2-atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Sat, 26 Jan 2019 10:29:02 -0600
Message-ID: <CANk1AXQEkdPp0zB78LCOBWUnKRndB4Vv2aZ2AqU=M3jmJLSK+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] fpga: stratix10-soc: fix wrong of_node_put() in init function
Content-Type: text/plain; charset="UTF-8"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jan 24, 2019 at 2:46 PM Alan Tull <atull@kernel.org> wrote:
>
> From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
> Acked-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/stratix10-soc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index a1a09e0..e75dbe5 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -509,13 +509,11 @@ static int __init s10_init(void)
>
>         np = of_find_matching_node(fw_np, s10_of_match);
>         if (!np) {
> -               of_node_put(fw_np);
>                 return -ENODEV;
>         }

This leaves unnecessary braces around a single statement.  I had said
in the code review that I was going to clean that up.  Arg!  I'll
resubmit this patch.

Alan

>
>         of_node_put(np);
>         ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
> -       of_node_put(fw_np);
>         if (ret)
>                 return ret;
>
> --
> 2.7.4
>
