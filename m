Date: Tue, 11 Apr 2017 07:57:56 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga altera-hps2fpga: disable/unprepare clock on error
 in alt_fpga_bridge_probe()
Message-ID: <20170411145756.GA1656@tyrael.amer.corp.natinst.com>
References: <20170411092254.19712-1-tklauser@distanz.ch>
 <CANk1AXQOH+6sZ-JHuwXviPw6--Qpa4C8xkHg3wu5-1e4ABgRHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXQOH+6sZ-JHuwXviPw6--Qpa4C8xkHg3wu5-1e4ABgRHg@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Tobias Klauser <tklauser@distanz.ch>, Moritz Fischer <moritz.fischer@ettus.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Apr 11, 2017 at 09:53:38AM -0500, Alan Tull wrote:
> On Tue, Apr 11, 2017 at 4:22 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
> 
> Hi Tobias,
> 
> Thanks!
> 
> > If either _alt_hps2fpga_enable_set() or fpga_bridge_register() fail in
> > alt_fpga_bridge_probe(), the clock remains enabled and prepared. Also,
> > in the error path for _alt_hps2fpga_enable_set() a call to
> > fpga_bridge_unregister() is made even though the bridge was not
> > registered yet.
> >
> > Remove the unnecessary call to fpga_bridge_unregister() and call
> > clk_disable_unprepare() in both error paths in order to make sure the
> > clock gets properly disabled and unprepared.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
Acked-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Alan Tull <atull@kernel.org>
> 
> > ---
> >  drivers/fpga/altera-hps2fpga.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
> > index 4b354c79be31..3066b805f2d0 100644
> > --- a/drivers/fpga/altera-hps2fpga.c
> > +++ b/drivers/fpga/altera-hps2fpga.c
> > @@ -181,15 +181,18 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
> >                                  (enable ? "enabling" : "disabling"));
> >
> >                         ret = _alt_hps2fpga_enable_set(priv, enable);
> > -                       if (ret) {
> > -                               fpga_bridge_unregister(&pdev->dev);
> > -                               return ret;
> > -                       }
> > +                       if (ret)
> > +                               goto err;
> >                 }
> >         }
> >
> > -       return fpga_bridge_register(dev, priv->name, &altera_hps2fpga_br_ops,
> > -                                   priv);
> > +       ret = fpga_bridge_register(dev, priv->name, &altera_hps2fpga_br_ops,
> > +                                  priv);
> > +err:
> > +       if (ret)
> > +               clk_disable_unprepare(priv->clk);
> > +
> > +       return ret;
> >  }
> >
> >  static int alt_fpga_bridge_remove(struct platform_device *pdev)
> > --
> > 2.12.2
> >
> >
