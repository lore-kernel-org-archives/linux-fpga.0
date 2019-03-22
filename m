Return-Path: <SRS0=+8Fr=RZ=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=+8Fr=RZ=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <navam@xilinx.com>
Subject: RE: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Date: Fri, 22 Mar 2019 07:16:05 +0000
Message-ID: 
 <BYAPR02MB47104B7E954002CB4087FC71C2430@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20190314140122.23372-1-nava.manne@xilinx.com>
 <20190314140122.23372-7-nava.manne@xilinx.com>
In-Reply-To: <20190314140122.23372-7-nava.manne@xilinx.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Nava kishore Manne <navam@xilinx.com>, "atull@kernel.org" <atull@kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Ping!!

> -----Original Message-----
> From: Nava kishore Manne [mailto:nava.manne@xilinx.com]
> Sent: Thursday, March 14, 2019 7:31 PM
> To: atull@kernel.org; mdf@kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Nava kishore Manne
> <navam@xilinx.com>; linux-fpga@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> chinnikishore369@gmail.com
> Subject: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga d=
river
>=20
> Add documentation to describe Xilinx ZynqMP fpga driver bindings.
>=20
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v4:
> 		-Modified binding description as suggested by Moritz Fischer.
> Changes for v3:
>                 -Removed PCAP as a child node to the FW and Created
> 		 an independent node since PCAP driver is a consumer
> 		 not a provider.
>=20
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt           | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-
> pcap-fpga.txt
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga=
.txt
> b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..6d7f10775d9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,11 @@
> +Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
> +The ZynqMP SoC uses the PCAP (Processor configuration Port) to
> +configure the Programmable Logic (PL). The configuration uses  the firmw=
are
> interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	zynqmp_pcap: pcap {
> +		compatible =3D "xlnx,zynqmp-pcap-fpga";
> +	};
> --
> 2.18.0
