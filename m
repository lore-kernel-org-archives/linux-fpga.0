Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170927164300.3487-1-uvv.mail@gmail.com>
References: <20170927164300.3487-1-uvv.mail@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 27 Sep 2017 13:48:32 -0500
Message-ID: <CANk1AXTttoOs3aCYOgMZTTBeuSOaW_w7tUZzDpMUM3XFcKTz0A@mail.gmail.com>
Subject: Re: [PATCH 1/1] fpga: region: release bridges in successful path
Content-Type: text/plain; charset="UTF-8"
To: "Vyacheslav V. Yurkov" <uvv.mail@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Sep 27, 2017 at 11:43 AM, Vyacheslav V. Yurkov
<uvv.mail@gmail.com> wrote:

Hi Vyacheslav,

Thanks for the patch, but actually this is on purpose to prevent
someone disabling the bridges when a region has hardware running in
it.  The fpga_bridges_put happens when the device tree overlay is
removed in fpga_region_notify_post_remove().  When an overlay programs
a region, the region gets exclusive control of the bridges and
disables them before programming.  After programming, the region
re-enables the bridges and keeps exclusive control of them.  Some
drivers are loaded by device tree and are expecting those bridges to
stay enabled.  Later when the overlay is removed, the drivers are
unloaded first, the bridges are disable and put.

Alan

> From: Vyacheslav Yurkov <uvv.mail@gmail.com>
>
> In case of successful FPGA reconfiguration bridges mutexes are not
> unlocked properly.
>
> Signed-off-by: Vyacheslav Yurkov <uvv.mail@gmail.com>
> ---
>  drivers/fpga/fpga-region.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index d9ab7c7..ed858e3 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -274,6 +274,7 @@ static int fpga_region_program_fpga(struct fpga_region *region,
>         }
>
>         fpga_mgr_put(mgr);
> +       fpga_bridges_put(&region->bridge_list);
>         fpga_region_put(region);
>
>         return 0;
> --
> 2.7.4
>
