Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com> <20190403142022.GB5752@archbook>
In-Reply-To: <20190403142022.GB5752@archbook>
From: Alan Tull <atull@kernel.org>
Date: Wed, 3 Apr 2019 11:29:39 -0500
Message-ID: <CANk1AXQAr-B8ShU4=Zs_aq3_iyQoZTfEhnLpnr9xiWHrKyZiow@mail.gmail.com>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Richard Gong <richard.gong@linux.intel.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Apr 3, 2019 at 9:20 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Richard,
>
> On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
> > From: Richard Gong <richard.gong@intel.com>
> >
> > Add a log for user to know FPGA configuration is successful
> >
> > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > ---
> >  drivers/fpga/fpga-mgr.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > index c386681..559e046 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
> >       }
> >       mgr->state = FPGA_MGR_STATE_OPERATING;
> >
> > +     dev_info(&mgr->dev, "Successfully programming FPGA\n");
>
> That info is available in FPGA manager's sysfs status entry, if at all
> I'd make this a dev_dbg().
>
> From my end I don't see how we need this really.

I'm ok with adding a message.  It's not adding lots of messages, just
one line for an event that will only happen for people who care about
the event (not too many FPGA users but if someone is using FPGA, they
will care about this.)

Alan


>
> Thanks,
> Moritz
