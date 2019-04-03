Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
 <20190403142022.GB5752@archbook> <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
 <20190403164742.GC5752@archbook>
In-Reply-To: <20190403164742.GC5752@archbook>
From: Alan Tull <atull@kernel.org>
Date: Wed, 3 Apr 2019 13:05:25 -0500
Message-ID: <CANk1AXSoF3bhiO=t-XJRLhBH20emWYaZ+2LCPtqJsKyh4b+9KQ@mail.gmail.com>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Richard Gong <richard.gong@linux.intel.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Apr 3, 2019 at 11:47 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Richard,
>
> On Wed, Apr 03, 2019 at 11:43:26AM -0500, Richard Gong wrote:
> > Hi Moritz,
> >
> >
> > On 4/3/19 9:20 AM, Moritz Fischer wrote:
> > > Hi Richard,
> > >
> > > On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
> > > > From: Richard Gong <richard.gong@intel.com>
> > > >
> > > > Add a log for user to know FPGA configuration is successful
> > > >
> > > > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > > > ---
> > > >   drivers/fpga/fpga-mgr.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > > > index c386681..559e046 100644
> > > > --- a/drivers/fpga/fpga-mgr.c
> > > > +++ b/drivers/fpga/fpga-mgr.c
> > > > @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
> > > >           }
> > > >           mgr->state = FPGA_MGR_STATE_OPERATING;
> > > > + dev_info(&mgr->dev, "Successfully programming FPGA\n");
> > >
> > > That info is available in FPGA manager's sysfs status entry, if at all
> > > I'd make this a dev_dbg().
> > >
> > >  From my end I don't see how we need this really.
> >
> > We got requests from the field and they want to see a log to get know if
> > FPGA configuration is successfully completed. They don't want use any
> > additional command to get status.
> >
> > This log is useful for the user who performs FPGA configuration.
> >
> > I think we need use dev_info, since dev_dbg is not enabled by fault for most
> > build.
>
> Well basically it boils down to:
>
> $ dmesg | grep "Sucessfully"
>
> vs
>
> $ cat /sys/class/fpga.../status

it's state, not status for most fpga manager drivers.  It should
return 'operating' if everything went well.

It seems like there's a possible scenario where the FPGA starts up
with the FPGA in 'operating' mode and the user messes up early enough
that the state doesn't change.

>
> Personally not in favor of extra messages, but if we do it we should
> change the message to "Sucessfully programmed FPGA".
>
> I think making it a dbg message is a good trade-off ...
>
> Moritz
