Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180911123732.32579-1-colin.king@canonical.com>
In-Reply-To: <20180911123732.32579-1-colin.king@canonical.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 13 Sep 2018 15:21:30 -0500
Message-ID: <CANk1AXTxBtMEJo0NTW9g0GeMX8-RTcD_PJ2eyqkYyCtw-u_9Mw@mail.gmail.com>
Subject: Re: [PATCH] fpga: region: fix spelling mistake "partion" -> "partition"
Content-Type: text/plain; charset="UTF-8"
To: Colin King <colin.king@canonical.com>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, kernel-janitors@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Sep 11, 2018 at 7:37 AM Colin King <colin.king@canonical.com> wrote:

Hi Colin,

>
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in the documentation

I took a look, there's other misspellings in this doc.  I'd like to
get them all in one patch if possible.  If I have time I'll add them
to this patch or if you have time, you can.

Alan

>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index 6db8aeda461a..71beb85b56f1 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -484,7 +484,7 @@ It is beyond the scope of this document to fully describe all the FPGA design
>  constraints required to make partial reconfiguration work[1] [2] [3], but a few
>  deserve quick mention.
>
> -A persona must have boundary connections that line up with those of the partion
> +A persona must have boundary connections that line up with those of the partition
>  or region it is designed to go into.
>
>  During programming, transactions through those connections must be stopped and
> --
> 2.17.1
>
