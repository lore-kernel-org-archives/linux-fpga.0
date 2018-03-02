Return-Path: <SRS0=oPSy=FY=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=oPSy=FY=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 1 Mar 2018 21:00:33 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 2/2] fpga: reset bridge: Add the reset bridge
Message-ID: <20180302050033.v6dvlppskpzht7tf@derp-derp.lan>
References: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <1519188826-2047-2-git-send-email-shubhrajyoti.datta@gmail.com>
 <CANk1AXQ1R4dbgDJrUC4pgKtmoCaJhryTnD=bxwwWbEJn0BQcaA@mail.gmail.com>
 <20180227002832.GA24387@tyrael.ni.corp.natinst.com>
 <CAKfKVtGPhb6Mg4UcX58iknEHAvRhp7NzisEONz8Cj+k9OYcu7A@mail.gmail.com>
 <CANk1AXR6aSwyQTW=NeYrRUQo2Oe8BysyOzf6VHvBuXaxKwNp-g@mail.gmail.com>
 <CAKfKVtE5u7z_ASmw_f6t6MAybAnoPm+rKm5LQZ_MaYmUEYuOhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfKVtE5u7z_ASmw_f6t6MAybAnoPm+rKm5LQZ_MaYmUEYuOhg@mail.gmail.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, nofooter@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Shubhrajyoti,

On Thu, Mar 01, 2018 at 04:19:48PM +0530, Shubhrajyoti Datta wrote:
> On Tue, Feb 27, 2018 at 10:30 PM, Alan Tull <atull@kernel.org> wrote:
> > On Mon, Feb 26, 2018 at 10:46 PM, Shubhrajyoti Datta
> > <shubhrajyoti.datta@gmail.com> wrote:
> >> Hi  Moritz,
> >>
> >> On Tue, Feb 27, 2018 at 5:58 AM, Moritz Fischer <mdf@kernel.org> wrote:
> >>> Hi Shubhrajyoti, Alan
> >>>
> >>> On Mon, Feb 26, 2018 at 04:53:59PM -0600, Alan Tull wrote:
> >>>> On Tue, Feb 20, 2018 at 10:53 PM,  <shubhrajyoti.datta@gmail.com> wrote:
> >>>> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >>>> >
> >>>> > Adds the reset bridge. After the bitstream load the reset
> >>>> > bridge helps in reseting the programable logic. The
> >>>> > reset lines depends on the design.
> >>>>
> >>>> Hi Shubhrajyoti,
> >>>>
> >>>> OK so adding this 'bridge' will get a reset line to be toggled after
> >>>> programming is done.  It looks like it might be generally usable.
> >>>> This doesn't look very xilinx specific (i.e. no specific device
> >>>> registers, just using a reset), so maybe it is just a 'rst-brige'.
> >>>> How is it used?  To hit a reset line on a whole FPGA?
> >>>
> >>> In zynq-fpga we have the fpga-mgr hit on the reset, which to some
> >>> extend I suppose makes sense, since after reload you wanna reset the
> >>> entire FPGA space (unless you do PR, where you don't hit on the resets).
> >>>
> >>> Shubhrajyoti's solution seems more modular I guess, however I don't
> >>> really see a good usecase for only hitting a single reset.
> >>>
> >>> IP that's in the FPGA and needs reset should have their dedicated resets
> >>> via normal reset API bindings imho and not rely on bridges to do the
> >>> right thing.
> >>>
> >>> The ZynqMP is fairly complex and I might be missing something here,
> >>> so maybe you (Shubhrajyoti) can elaborate a bit more. The paragraph in
> >>> the TRM seemed fairly short, and didn't enlighten me as to why it is
> >>> required.
> >>
> >> The FPGA supports both the PR case and independent execution
> >> Like  a design can have 2 parts that can have independent execution.
> >
> > I want to understand you better here.  What do you mean by
> > 'independent execution'?  Like 2 partial reconfiguration regions that
> > each have a single reset to reset the hardware in their region?  Or
> > something else?
> Yes.
> 
> >
> >> In that case they have to have independent resets.
> >>
> >> There are 4 PS-PL lines that could be used by designs.
> >> So in that case we should have  multiple resets.
> >
> > Normally, as Moritz is saying, the reset would be handled by the
> > driver for the fabric-based hardware.
> I didnt understand you mean the  platform-fpga.c ?

I don't understand this sentence ;-) I'll try to re-explain:

Say you have an AXI DMA engine in there that needs a reset to be toggled
after programming the FPGA then you are in either one of these cases:

a) You're doing a full reprogram of the entire fabric, at which point
you can reset everything by asserting them in the driver like in
drivers/fpga/zynq-fpga.c

b) You're doing a partial reconfiguration in which case the regions that
are being reconfigured contain some peripherals you want to selectively
reset. If you need a software reset, the driver for this peripheral can
request a reset through the normal reset API.

Am I missing somehting here? Why do you need the bridge to do the reset?

- Moritz
