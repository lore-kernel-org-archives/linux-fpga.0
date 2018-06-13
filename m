Return-Path: <SRS0=ymNJ=I7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ymNJ=I7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43509 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754484AbeFMMmG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 13 Jun 2018 08:42:06 -0400
Received: by mail-lf0-f65.google.com with SMTP id n15-v6so3698262lfn.10
        for <linux-fpga@vger.kernel.org>; Wed, 13 Jun 2018 05:42:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611172049.26630-1-christophe.jaillet@wanadoo.fr>
References: <20180611172049.26630-1-christophe.jaillet@wanadoo.fr>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Wed, 13 Jun 2018 07:42:03 -0500
Message-ID: <CAAtXAHdF_AEcohGW=yoUgoe1OWcxLeCYgp2u3pjsmUn=-z-_bg@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera-cvp: Fix an error handling path in 'altera_cvp_probe()'
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

Hi Christophe,

good catch!

On Mon, Jun 11, 2018 at 12:20 PM, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> If 'fpga_mgr_create()' fails, we should release some resources, as done
> in the other error handling path of the function.
>
> Fixes: 7085e2a94f7d ("fpga: manager: change api, don't use drvdata")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-cvp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index dd4edd8f22ce..7fa793672a7a 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -455,8 +455,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>
>         mgr = fpga_mgr_create(&pdev->dev, conf->mgr_name,
>                               &altera_cvp_ops, conf);
> -       if (!mgr)
> -               return -ENOMEM;
> +       if (!mgr) {
> +               ret = -ENOMEM;
> +               goto err_unmap;
> +       }
>
>         pci_set_drvdata(pdev, mgr);
>
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,

Moritz
