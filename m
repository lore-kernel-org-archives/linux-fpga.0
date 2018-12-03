Return-Path: <SRS0=5nsa=OM=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=5nsa=OM=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38543 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeLCRLH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 3 Dec 2018 12:11:07 -0500
Received: by mail-yw1-f65.google.com with SMTP id i20so5693276ywc.5
        for <linux-fpga@vger.kernel.org>; Mon, 03 Dec 2018 09:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20181203122145.1534-1-nsaenzjulienne@suse.de> <CANk1AXRxUai9SmSFt1uMXVRcoumh+ziKCi8WHb2tCG5Wx4Txow@mail.gmail.com>
In-Reply-To: <CANk1AXRxUai9SmSFt1uMXVRcoumh+ziKCi8WHb2tCG5Wx4Txow@mail.gmail.com>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Mon, 3 Dec 2018 09:01:47 -0800
Message-ID: <CAAtXAHdWrJ3zL7sHygTD9W+trvviTh_0zMSwaU4AtNpxSxLbgg@mail.gmail.com>
Subject: Re: [PATCH] fpga: stratix10-soc: fix wrong of_node_put() in init function
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: nsaenzjulienne@suse.de, linux-fpga@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Nicolas,

good catch.

On Mon, Dec 3, 2018 at 8:13 AM Alan Tull <atull@kernel.org> wrote:
>
> On Mon, Dec 3, 2018 at 6:22 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
>
> Hi Nicolas,
>
> Thanks for catching this!  I'll fix up one formatting thing (below).
>
> >
> > After finding a "firmware" dt node stratix10 tries to match it's
> > compatible string with it. To do so it's calling of_find_matching_node()
> > which already takes care of decreasing the refcount on the "firmware"
> > node. We are then incorrectly decreasing the refcount on that node
> > again.
> >
> > This patch removes the unwarranted call to of_node_put().
> >
> > Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
>
> > ---
> >  drivers/fpga/stratix10-soc.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > index a1a09e04fab8..e75dbe583152 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -509,13 +509,11 @@ static int __init s10_init(void)
> >
> >         np = of_find_matching_node(fw_np, s10_of_match);
> >         if (!np) {
> > -               of_node_put(fw_np);
> >                 return -ENODEV;
> >         }
>
> We don't need the brackets anymore around the return statement.  I'll fix it up.
>
> Thanks,
> Alan
>
> >
> >         of_node_put(np);
> >         ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
> > -       of_node_put(fw_np);
> >         if (ret)
> >                 return ret;
> >
> > --
> > 2.19.2
> >

Thanks,
Moritz
