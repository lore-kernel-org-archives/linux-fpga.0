Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1516771642-14551-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1516771642-14551-1-git-send-email-shubhrajyoti.datta@xilinx.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 24 Jan 2018 10:34:06 -0600
Message-ID: <CANk1AXQTDc+8ho=HtADAHd4BEPz3h4WOYgdxcBXDg_EWzB8FrA@mail.gmail.com>
Subject: Re: [PATCH] fpga: region: Release the bridge reference
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, shubhrajyoti.datta@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jan 23, 2018 at 11:27 PM, Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:

> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index d9ab7c7..58789b9 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -273,6 +273,7 @@ static int fpga_region_program_fpga(struct fpga_regio=
n *region,
>                 goto err_put_br;
>         }
>
> +       fpga_bridges_put(&region->bridge_list);

Hi Shubhrajyoti,

Please do not write to the Linux mailing lists with a
confidential/proprietary footer in your email.

Thanks for your submission, but the code is already correct as-is.  We
want fpga_region_program_fpga to hold the reference to the bridges if
programming succeeds.  The idea is that the reference for the bridge
is exclusive, so if some module programs an FPGA region, that module
owns the region.  Nobody else can come and program it.  The function
header should make this clear and it doesn't, so that's the real
problem here.

For example, in of-fpga-region.c, of_fpga_region_notify_post_remove
calls fpga_bridges_put when an overlay is removed.  But if someone
tries to program the region again (by applying another overlay without
first removing the first overlay), it will fail to get the bridges,
which is what we want.

Alan

>         fpga_mgr_put(mgr);
>         fpga_region_put(region);
>
> --
> 2.1.1
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
