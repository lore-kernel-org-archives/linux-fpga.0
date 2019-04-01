Return-Path: <moritz.fischer.private@gmail.com>
Date: Mon, 1 Apr 2019 15:05:55 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v5 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190401220555.GA2716@archbook>
References: <20190326143129.2608-1-nava.manne@xilinx.com>
 <20190326143129.2608-7-nava.manne@xilinx.com>
 <20190328170028.GA10815@bogus>
 <CANk1AXTcwb1oJL5Uq-H-Q41-n8SXtamObSedMHSa_smZ8Xr1fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXTcwb1oJL5Uq-H-Q41-n8SXtamObSedMHSa_smZ8Xr1fw@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Nava kishore Manne <nava.manne@xilinx.com>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michal.simek@xilinx.com>, Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Apr 01, 2019 at 03:50:08PM -0500, Alan Tull wrote:
> On Thu, Mar 28, 2019 at 12:00 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, 26 Mar 2019 20:01:29 +0530, Nava kishore Manne wrote:
> > > Add documentation to describe Xilinx ZynqMP fpga driver
> > > bindings.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > > Changes for v5:
> > >               -Moved pcap node as a child to firwmare
> > >                node as suggested by Rob.
> > > Changes for v4:
> > >               -Modified binding description as suggested by Moritz Fischer.
> > > Changes for v3:
> > >               -Removed PCAP as a child node to the FW and Created
> > >                an independent node since PCAP driver is a consumer
> > >                not a provider.
> > >
> > >  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 +++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
