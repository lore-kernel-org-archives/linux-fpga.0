Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181029072630.13339-1-agust@denx.de> <20181029165945.GB2453@archbook>
In-Reply-To: <20181029165945.GB2453@archbook>
From: Alan Tull <atull@kernel.org>
Date: Thu, 1 Nov 2018 13:39:20 -0500
Message-ID: <CANk1AXRc7Erwb-stmZ6+zp9EKAb3f0XjPd3uiWYLPzgapkozbw@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: altera-cvp: Fix registration for CvP incapable devices
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Anatolij Gustschin <agust@denx.de>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, puhm@oregano.at
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Oct 29, 2018 at 11:59 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Anatolij, Andreas,
>
> On Mon, Oct 29, 2018 at 08:26:30AM +0100, Anatolij Gustschin wrote:
> > From: Andreas Puhm <puhm@oregano.at>
> >
> > The probe function needs to verify the CvP enable bit in order to
> > properly determine if FPGA Manager functionality can be safely
> > enabled.
> >
> > Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
> > Signed-off-by: Andreas Puhm <puhm@oregano.at>
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

Thanks!

Alan

> > ---
> > Changes in v2:
> >  - improve Fixes tag
> >  - wrap lines in commit description
> >
> >  drivers/fpga/altera-cvp.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > index 3998d4f0e5e7..196d52558990 100644
> > --- a/drivers/fpga/altera-cvp.c
> > +++ b/drivers/fpga/altera-cvp.c
> > @@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >       struct altera_cvp_conf *conf;
> >       struct fpga_manager *mgr;
> >       u16 cmd, val;
> > +     u32 regval;
> >       int ret;
> >
> >       /*
> > @@ -419,6 +420,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >               return -ENODEV;
> >       }
> >
> > +     pci_read_config_dword(pdev, VSE_CVP_STATUS, &regval);
> > +     if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
> > +             dev_err(&pdev->dev,
> > +                     "CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
> > +                     regval);
> > +             return -ENODEV;
> > +     }
> > +
> >       conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
> >       if (!conf)
> >               return -ENOMEM;
> > --
> > 2.17.1
> >
>
> Thanks,
> Moritz
