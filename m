Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from ozlabs.org ([103.22.144.67]:43361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbdJSCAf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Oct 2017 22:00:35 -0400
Date: Thu, 19 Oct 2017 12:42:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc issue with overlays starting in next-20171009
Message-ID: <20171019014215.GT2776@umbus.fritz.box>
References: <CANk1AXQaXKud2Mic_879JiS39hJB4y0uTS2w1uxXje-0mO68Vw@mail.gmail.com>
 <59E7ACA0.7030809@gmail.com>
 <CAL_Jsq+f4Y1DDB4ZkXAEKUZ_P9YdMUKMhr2E=VKtbHWMZFaO0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j2Klb18PAKd8hQ5U"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+f4Y1DDB4ZkXAEKUZ_P9YdMUKMhr2E=VKtbHWMZFaO0w@mail.gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Alan Tull <atull@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Devicetree Compiler <devicetree-compiler@vger.kernel.org>


--j2Klb18PAKd8hQ5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 03:16:34PM -0500, Rob Herring wrote:
> Use devicetree-compiler list for dtc issues please.
>=20
> On Wed, Oct 18, 2017 at 2:33 PM, Frank Rowand <frowand.list@gmail.com> wr=
ote:
> > Hi Rob, Alan,
> >
> > On 10/18/17 08:58, Alan Tull wrote:
> >> Hi Rob,
> >>
> >> I've noticed a problem compiling DT overlays and traced it back to
> >> beginning in next-20171009
> >>
> >> That tag adds the following in scripts/dtc
> >>
> >> e9480c1 2017-10-09 16:17:32 +0100 : Mark Brown : Merge remote-tracking
> >> branch 'devicetree/for-next'
> >> 4201d05 2017-10-03 15:03:47 -0500 : Rob Herring : scripts/dtc: Update
> >> to upstream version v1.4.5-3-gb1a60033c110
> >> 4322323 2017-10-03 15:03:46 -0500 : Rob Herring : scripts/dtc: add
> >> fdt_overlay.c and fdt_addresses.c to sync script
> >>
> >> The error is:
> >>
> >> dtc: /home/atull/repos/linux-socfpga/scripts/dtc/livetree.c:543:
> >> get_node_by_phandle: Assertion `(phandle !=3D 0) && (phandle !=3D -1)'
> >> failed.
> >> arch/arm/boot/dts/socfpga_overlay.dtb: Warning (clocks_property):
> >> Could not get phandle node for
> >> /fragment@0/__overlay__/gpio@10040:clocks(cell 0)
> >> Aborted (core dumped)
> >> scripts/Makefile.lib:316: recipe for target
> >> 'arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb'
> >> failed
> >> make[2]: *** [arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc_ghrd_ovl_e=
xt_cfg.dtb]
> >> Error 134
> >> arch/arm/Makefile:346: recipe for target 'dtbs' failed
> >>
> >> Here's a simplified overlay that gets this error.  Taking out the line
> >> "interrupt-parent =3D <&intc>;" fixes the build.
> >>
> >> /dts-v1/;
> >> /plugin/;
> >> / {
> >>         fragment@0 {
> >>                 target-path =3D "/soc/base_fpga_region";
> >>                 #address-cells =3D <1>;
> >>                 #size-cells =3D <1>;
> >>
> >>                 __overlay__ {
> >>                         ranges =3D <0x00000000 0x00000000 0xc0000000 0=
x00040000>,
> >>                                  <0x00000001 0x00000000 0xff200000 0x0=
0001000>;
> >>
> >>                         external-fpga-config;
> >>
> >>                         #address-cells =3D <2>;
> >>                         #size-cells =3D <1>;
> >>
> >>                         fpga_pr_region0 {
> >>                                 compatible =3D "fpga-region";
> >>                                 fpga-bridges =3D <&freeze_controller_0=
>;
> >>                                 ranges;
> >>                         };
> >>
> >>                         freeze_controller_0: freeze_controller@0x10000=
0450 {
> >>                                 compatible =3D "altr,freeze-bridge-con=
troller";
> >>                                 reg =3D <0x00000001 0x00000450 0x00000=
010>;
> >>                                 interrupt-parent =3D <&intc>;  /* <--
> >> remove to fix build */
> >>                                 interrupts =3D <0 21 4>;
> >>                         };
> >>                 };
> >>         };
> >> };
> >>
> >> Alan
> >
> > Phandle references in overlays are assigned the value of -1 (0xffffffff=
) in
> > the dtb, to be fixed up when loaded.  A new check sees this value and
> > triggers the assert.
> >
> > It is this commit in the upstream dtc tools tree:
> >
> >    commit ee3d26f6960bb5922d9a35fe266d9eac74a78ec0
> >    checks: add interrupts property check
> >
> > There are a bunch of other new checks that call get_node_by_phandle(),
> > and thus could trigger the assertion.
> >
> > I'm guessing that those checks would also trigger the assert if an
> > overlay contained something that would lead to one of the other checks
> > being processed.
>=20
> You won't get an assert because I check for 0 or -1 and skip the check
> in those cases. The interrupts check missed that condition.
>=20
> However, as shown above, you will get an erroneous warning because it
> just skips 1 cell and goes to the next to handle the case where the
> phandle is optional and you want a fixed number of elements.
>=20
> I guess we can't validate overlays which is unfortunate. I don't think
> that's a solvable problem unless you have the base DT.

Right.  You can check some things in overlays, but when parsing
something requires information from the base tree, there is indeed not
much that can be done.

> > You can avoid the problem in your example dts with "-Wno-interrupts_pro=
perty"
> >
> >   dtc -Wno-interrupts_property fpga_01_a.dts
> >
> > The larger set of other checks that might trigger the assert is too lar=
ge
> > for me to want to add "-Wno-" flags for all of them to the command line
> > (as temporary workarounds).
>=20
> David thought more switches were better.

Right, as a rule, I like fine configurability of the checks.

But.. there's a trick to make things easier to configure in batches:
when you enable a warning, you automatically enable all warnings that
warning has as prerequisites.  And when you disable a warning, every
other warning that has it as a prerequisite is also disabled.

So by adding some dummy checks with the right depencies, you can allow
enabling and disabling of groups of related checks with a single
command line option.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--j2Klb18PAKd8hQ5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnoAvcACgkQbDjKyiDZ
s5IoNA//X+AFWbdXLP6x9wLx5bDb9AF0GOo6JsVQcQgmVbSVIG6+lEw1ExpyDuLJ
4iTqQWouOVcnBBZEKSVaMM8o5+oRWxdp6OctV12gKdHXmvJ4Gj/Y/TQjTAq5gkzO
V0L2NGDnWC5og6OXvKIt8/n0hjiK9mvREIWRQdXsTvG+iy+ywJp71EmU6EUnOptN
3XXeIfPwVMEH4+QTKKfAn6h9zgHnGmamwltqVfPQoEQjTnkSc78tZ/uVz1JKwAYC
IMMXhPKNbvZ9R9fLg5b5NsC2LOi/HpwjEC96I/9rmALgC9ddKcMxEu2b1ECr75tR
BrzlZYa2/OEcpI9cKU/hQJOtCGlCrfNrzOlET/5PlJGmk6oNSaf2kzJyCdJ3umf5
ZWrkp/lx8DaY09c9ZVt00K3ngO3dslnetNTSov//XHz6LgXvNJVg/PmNRxUbHogB
V87085yxJkcYRK3mq2hzZd3e6j2IFjlaVU8EDMAUxrmyqG1GRgteciM7CxeYOc//
XYkbSq4tpnOiEpCdvrZZDQXns9MqBVN+L7RsaB/6zlNbA3o+atNd7JKIxTZsa4Ej
9e5VX/IrWlQViFOfZOu8iZRS+uJX7y9tCCFV3zePYEgVaWdO+obL7RP0fYfAKo/a
IuaTeUM5znabtPY6kgNSyibP/vkx+sB+11Pws8to+fbSDgqBLI4=
=9akC
-----END PGP SIGNATURE-----

--j2Klb18PAKd8hQ5U--
