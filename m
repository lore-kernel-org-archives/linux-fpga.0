Return-Path: <moritz.fischer.private@gmail.com>
Date: Fri, 24 Mar 2017 08:23:18 -0700
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Subject: Re: [PATCH v3 1/2] doc: Add bindings document for Xilinx LogiCore PR
 Decoupler
Message-ID: <20170324152318.GA13089@tyrael.amer.corp.natinst.com>
References: <1489781473-30772-1-git-send-email-mdf@kernel.org>
 <20170324145908.aiijqixf5xcnkksa@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170324145908.aiijqixf5xcnkksa@rob-hp-laptop>
To: Rob Herring <robh@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, Michal Simek <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 24, 2017 at 09:59:08AM -0500, Rob Herring wrote:
> On Fri, Mar 17, 2017 at 01:11:12PM -0700, Moritz Fischer wrote:
> > This adds the binding documentation for the Xilinx LogiCORE PR
> > Decoupler soft core.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: S�ren Brinkmann <soren.brinkmann@xilinx.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > ---
> > 
> > Changes from v2:
> > - Added refence to generic fpga-region bindings
> > - Fixed up reg property in example
> > - Added fallback to "xlnx,pr-decoupler" without version
> > 
> > Changes from v1:
> > - Added clock names & clock to example
> > - Merged some of the description from Michal's version
> > 
> > ---
> >  .../bindings/fpga/xilinx-pr-decoupler.txt          | 35 ++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> > new file mode 100644
> > index 0000000..16141bd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> > @@ -0,0 +1,35 @@
> > +Xilinx LogiCORE Partial Reconfig Decoupler Softcore
> > +
> > +The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
> > +decouplers / fpga bridges.
> > +The controller can decouple/disable the bridges which prevents signal
> > +changes from passing through the bridge.  The controller can also
> > +couple / enable the bridges which allows traffic to pass through the
> > +bridge normally.
> > +
> > +The Driver supports only MMIO handling. A PR region can have multiple
> > +PR Decouples which can bhe handled independently or chaines via decouple/
> 
> s/chaines/chains/

Fixed in v4.

> > +decouple_status signals.
> > +
> > +Required properties:
> > +- compatible		: Should contain "xlnx,pr-decoupler-1.00"
> > +- regs			: base address and size for decoupler module
> > +- clocks		: input clock to IP
> > +- clock-names		: should contain "aclk"
> > +
> > +Optional properties:
> > +- bridge-enable		: 0 if driver should disable bridge at startup
> > +			  1 if driver should enable bridge at startup
> > +			  Default is to leave bridge in current state.
> 
> This is common and should move into a common doc. Maybe fpga-region.txt 
> works?

Ok will add patch for that to v5 series.

Thanks for your feedback,

Moritz
