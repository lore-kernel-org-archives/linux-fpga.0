Return-Path: <SRS0=lrpB=R5=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=lrpB=R5=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <navam@xilinx.com>
Subject: RE: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Date: Tue, 26 Mar 2019 14:06:15 +0000
Message-ID: 
 <SN6PR02MB47194C1EEA9BDD8F3FE61B75C25F0@SN6PR02MB4719.namprd02.prod.outlook.com>
References: <20190314140122.23372-1-nava.manne@xilinx.com>
 <20190314140122.23372-7-nava.manne@xilinx.com> <20190315235422.GA29658@bogus>
In-Reply-To: <20190315235422.GA29658@bogus>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>
Cc: "atull@kernel.org" <atull@kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Rob,

	Thanks for the response.
Please find my response inline.

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, March 26, 2019 12:49 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: atull@kernel.org; mdf@kernel.org; mark.rutland@arm.com; Michal Simek
> <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; linux-fpga@vger.kernel.org; devicetree@vger.kernel.o=
rg;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> chinnikishore369@gmail.com
> Subject: Re: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fp=
ga
> driver
>=20
> On Thu, Mar 14, 2019 at 07:31:22PM +0530, Nava kishore Manne wrote:
> > Add documentation to describe Xilinx ZynqMP fpga driver bindings.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v4:
> > 		-Modified binding description as suggested by Moritz Fischer.
> > Changes for v3:
> >                 -Removed PCAP as a child node to the FW and Created
> > 		 an independent node since PCAP driver is a consumer
> > 		 not a provider.
>=20
> Huh?
>=20
> It was the fpga-regions that I suggested should perhaps be at the top-lev=
el. As
> long as pcap is a function exposed by the firmware it should be a child o=
f it.
>=20
Thanks for providing the clarification. Will address the above comments in =
the next version.

Regards,
Navakishore.
