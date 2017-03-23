Return-Path: <SRS0=kG60=3A=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=kG60=3A=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1489781732-31518-1-git-send-email-mdf@kernel.org>
References: <1489781732-31518-1-git-send-email-mdf@kernel.org>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Thu, 23 Mar 2017 13:29:14 -0500
Message-ID: <CANk1AXTn3znQ=L-sy3SKMezC9YtMMTGxb3Zc7t+gE4a0MPxNzg@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera_freeze_bridge: Constify ops
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 17, 2017 at 3:15 PM, Moritz Fischer <mdf@kernel.org> wrote:
> The ops are not changing, make them const.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>

> Cc: Alan Tull <atull@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org
> ---
>  drivers/fpga/altera-freeze-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
> index 8dcd9fb..8c1bc7e 100644
> --- a/drivers/fpga/altera-freeze-bridge.c
> +++ b/drivers/fpga/altera-freeze-bridge.c
> @@ -203,7 +203,7 @@ static int altera_freeze_br_enable_show(struct fpga_bridge *bridge)
>         return priv->enable;
>  }
>
> -static struct fpga_bridge_ops altera_freeze_br_br_ops = {
> +static const struct fpga_bridge_ops altera_freeze_br_br_ops = {
>         .enable_set = altera_freeze_br_enable_set,
>         .enable_show = altera_freeze_br_enable_show,
>  };
> --
> 2.7.4
>
