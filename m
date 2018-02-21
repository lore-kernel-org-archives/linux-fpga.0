Return-Path: <SRS0=VoxH=FP=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=VoxH=FP=ettus.com=moritz.fischer@kernel.org>
Date: Wed, 21 Feb 2018 09:44:40 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 1/2] doc: fpga: Add reset bridge support
Message-ID: <20180221174440.GA17947@tyrael.ni.corp.natinst.com>
References: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com>
To: shubhrajyoti.datta@gmail.com
Cc: linux-fpga@vger.kernel.org, atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com, devicetree@vger.kernel.org, nofooter@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:23:45AM +0530, shubhrajyoti.datta@gmail.com wrot=
e:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>=20
> Add reset bridge support. Once this bridge is enabled.
> The reset line(s) will be toggled. Generally it will be
> called after the bitstream load to reset the PL.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../devicetree/bindings/fpga/xlnx,rst-bridge.txt   | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,rst-bridg=
e.txt
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt b=
/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
> new file mode 100644
> index 0000000..6f1bfc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
> @@ -0,0 +1,22 @@
> +Xilinx fpga reset bridge
> +
> +The Xilinx reset bridge toggles the reset line to the PL
> +in Zynqmp Ultrascale plus.

Out of curiosity do you have a reference in the TRM where this is
explained?
> +
> +
> +Required properties:
> +- compatible	: Should contain "xlnx,rst-bridge"
> +- reset		: reset phandles
> +
> +Optional properties:
> +- bridge-enable		: 0 if driver should disable bridge at startup
> +			  1 if driver should enable bridge at startup
> +			  Default is to leave bridge in current state.
> +
> +See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic b=
indings.

Since this would be the 5th? time of replicating this I sent out a patch
[1] to consolidate this paragraph into a single file.

Feel free to add this to your series and replace the above with

See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bind=
ings.

Thanks

Moritz

[1] https://lkml.org/lkml/2018/2/21/1099

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlqNsAEACgkQUVwKRFcJ
cNiVcwf6A9CtlcSSU9vSF/yUnR6b7Tyu2770BYrGWrHk8/dTkK43SvrnPMDYQhV3
JIyMBmSkKvtYDQIGueyQ2FuNbQPMJgOzX9pbFgiXuQmdF/Tg9+cF5xjpLzE509v1
eSCYHzcRAs9A6oArmso2getnOA0pKpAejQ4Lr6fWKVpDQJBptrTD+Kcrp/GAyS/a
40Ljja8sKuWeffoZtVOrBzZRj66+m6PFF7SkbsmTZdhAgnhgHfPYwBYLHQtEUDtW
Mv6oIIyP1Qg08ApEOKX4CTx+TiWvFt7CSPyTcKfcPwvo6QjHbZnJpHT1n8cEwrDz
VFRwmhkWYrZkmABjC20IyDgnGdimgw==
=09x4
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
