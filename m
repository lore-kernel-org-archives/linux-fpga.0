Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbfBLRHk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 Feb 2019 12:07:40 -0500
MIME-Version: 1.0
References: <20190211161754.23902-1-nava.manne@xilinx.com> <CAAtXAHfXaerVYzfdnA_09rK5AgLVJAiRcE2KEqosfrMZBuO3xQ@mail.gmail.com>
In-Reply-To: <CAAtXAHfXaerVYzfdnA_09rK5AgLVJAiRcE2KEqosfrMZBuO3xQ@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 12 Feb 2019 11:07:01 -0600
Message-ID: <CANk1AXTSE+JXn1rinhdxeuOHgFZKga6SvGvTcNwN1knSNxwjjQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Nava kishore Manne <nava.manne@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michal.simek@xilinx.com>, Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>, linux-fpga@vger.kernel.org, Devicetree List <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>

On Tue, Feb 12, 2019 at 5:06 AM Moritz Fischer <moritz.fischer@ettus.com> wrote:

Hi Nava,

> > +       mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> > +                             &zynqmp_fpga_ops, priv);

Please use the new devm_fpga_mgr_create()

> > +       if (!mgr)
> > +               return -ENOMEM;
> > +
> > +       platform_set_drvdata(pdev, mgr);
> > +
> > +       err = fpga_mgr_register(mgr);
> vs here.
> > +       if (err) {
> > +               dev_err(dev, "unable to register FPGA manager");
> > +               fpga_mgr_free(mgr);

With devm_fpga_mgr_create(), this fpga_mgr_free() can go away.

> > +               return err;
> > +       }
> > +
> > +       return 0;

Thanks,
Alan
