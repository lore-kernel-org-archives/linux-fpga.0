Return-Path: <SRS0=VmpS=FQ=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=VmpS=FQ=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 22 Feb 2018 09:30:08 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] dt-bindings: fpga: Consolidate bridge properties
Message-ID: <20180222173008.GA12391@tyrael.ni.corp.natinst.com>
References: <20180221173306.17265-1-mdf@kernel.org>
 <8751fd85-fc84-f422-94e7-dd5689cb6922@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <8751fd85-fc84-f422-94e7-dd5689cb6922@xilinx.com>
To: Michal Simek <michal.simek@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, atull@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 08:12:19AM +0100, Michal Simek wrote:
> On 21.2.2018 18:33, Moritz Fischer wrote:
> > Consolidate bridge properties in a single file, instead of duplicating
> > the same optional property over and over again.
> >=20
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > Cc: Alan Tull <atull@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > ---
> >  .../devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt |  5 +----
> >  .../devicetree/bindings/fpga/altera-freeze-bridge.txt     |  5 +----
> >  .../devicetree/bindings/fpga/altera-hps2fpga-bridge.txt   |  5 +----
> >  Documentation/devicetree/bindings/fpga/fpga-bridge.txt    | 15 +++++++=
++++++++
> >  .../devicetree/bindings/fpga/xilinx-pr-decoupler.txt      |  8 ++------
> >  5 files changed, 20 insertions(+), 18 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.=
txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-b=
ridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge=
=2Etxt
> > index 817a8d4bf903..5dd0ff0f7b4e 100644
> > --- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.t=
xt
> > +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.t=
xt
> > @@ -3,10 +3,7 @@ Altera FPGA To SDRAM Bridge Driver
> >  Required properties:
> >  - compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
> > =20
> > -Optional properties:
> > -- bridge-enable		: 0 if driver should disable bridge at startup
> > -			  1 if driver should enable bridge at startup
> > -			  Default is to leave bridge in current state.
> > +See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic=
 bindings.
> > =20
> >  Example:
> >  	fpga_bridge3: fpga-bridge@ffc25080 {
> > diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridg=
e.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> > index f8e288c71b2d..8b26fbcff3c6 100644
> > --- a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> > +++ b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> > @@ -10,10 +10,7 @@ Required properties:
> >  - compatible		: Should contain "altr,freeze-bridge-controller"
> >  - regs			: base address and size for freeze bridge module
> > =20
> > -Optional properties:
> > -- bridge-enable		: 0 if driver should disable bridge at startup
> > -			  1 if driver should enable bridge at startup
> > -			  Default is to leave bridge in current state.
> > +See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic=
 bindings.
> > =20
> >  Example:
> >  	freeze-controller@100000450 {
> > diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bri=
dge.txt b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> > index 6406f9337eeb..68cce3945b10 100644
> > --- a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> > +++ b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> > @@ -9,10 +9,7 @@ Required properties:
> >  - resets	: Phandle and reset specifier for this bridge's reset
> >  - clocks	: Clocks used by this module.
> > =20
> > -Optional properties:
> > -- bridge-enable	: 0 if driver should disable bridge at startup.
> > -		  1 if driver should enable bridge at startup.
> > -		  Default is to leave bridge in its current state.
> > +See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic=
 bindings.
> > =20
> >  Example:
> >  	fpga_bridge0: fpga-bridge@ff400000 {
> > diff --git a/Documentation/devicetree/bindings/fpga/fpga-bridge.txt b/D=
ocumentation/devicetree/bindings/fpga/fpga-bridge.txt
> > new file mode 100644
> > index 000000000000..82607b23a287
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/fpga-bridge.txt
> > @@ -0,0 +1,15 @@
> > +FPGA Bridge Device Tree Binding
> > +
> > +Moritz Fischer 2018 (Consolidated from previous bindings)
>=20
> nit: I would remove your name and year - it is visible from git log.

Yeah can get rid of that, I copied from fpga-region.txt :)

>=20
> > +
> > +Optional properties:
> > +- bridge-enable		: 0 if driver should disable bridge at startup
> > +			  1 if driver should enable bridge at startup
> > +			  Default is to leave bridge in current state.
> > +
> > +Example:
> > +	fpga_bridge3: fpga-bridge@ffc25080 {
> > +		compatible =3D "altr,socfpga-fpga2sdram-bridge";
> > +		reg =3D <0xffc25080 0x4>;
> > +		bridge-enable =3D <0>;
> > +	};
> > diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler=
=2Etxt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> > index 8dcfba926bc7..4284d293fa61 100644
> > --- a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> > +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> > @@ -18,12 +18,8 @@ Required properties:
> >  - clocks		: input clock to IP
> >  - clock-names		: should contain "aclk"
> > =20
> > -Optional properties:
> > -- bridge-enable		: 0 if driver should disable bridge at startup
> > -			  1 if driver should enable bridge at startup
> > -			  Default is to leave bridge in current state.
> > -
> > -See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic=
 bindings.
> > +See Documentation/devicetree/bindings/fpga/fpga-region.txt and
> > +Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bin=
dings.
> > =20
> >  Example:
> >  	fpga-bridge@100000450 {
> >=20
>=20
> Acked-by: Michal Simek <michal.simek@xilinx.com>
>=20
> Thanks,
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

- Moritz

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlqO/hsACgkQUVwKRFcJ
cNhkVAf/eA8Nx34LxVVOUN/c+M/4FfBPP6Dj2cWCTsr+ixzMXEKyvP5nP79h2f+l
rFNGAJbLs6vfvdVfvwMR6nAFr3DAp3d1upTSWMQ5bi6TwSiJpOmW/VsOa5WMf154
hyTUsCPkdEfQUMo0j2r5rtVpuRvAanU9OM+4V4TEIyeNNe15DBh4niyQbtVL+2lb
UaT+F3PNwA1MNxeyS5jLGBfBdoN0SpWdSP9EHm8XNwZNvWBbWh0b357W1fBsCT6Q
C2UOhev5+klr0AQofOjdi3yanJg6SNGih7KCqtRNLhBCg7CldT8yEu8yWO7HKvHD
ngpTOd+69E2SgNmtJSBzRuJ+1oCY3w==
=fR1e
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
