Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from ozlabs.org ([103.22.144.67]:50553 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbdJSCAf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Oct 2017 22:00:35 -0400
Date: Thu, 19 Oct 2017 12:57:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc issue with overlays starting in next-20171009
Message-ID: <20171019015755.GV2776@umbus.fritz.box>
References: <CANk1AXQaXKud2Mic_879JiS39hJB4y0uTS2w1uxXje-0mO68Vw@mail.gmail.com>
 <59E7ACA0.7030809@gmail.com>
 <CAL_Jsq+f4Y1DDB4ZkXAEKUZ_P9YdMUKMhr2E=VKtbHWMZFaO0w@mail.gmail.com>
 <59E7D6E0.5030109@gmail.com>
 <CAL_Jsq+svHThmkqDYRLsQdSeKjvnAfvgbqkhDmk-kVB6D8ocvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pM5zeTSooDOHDhuH"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+svHThmkqDYRLsQdSeKjvnAfvgbqkhDmk-kVB6D8ocvQ@mail.gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Alan Tull <atull@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Devicetree Compiler <devicetree-compiler@vger.kernel.org>


--pM5zeTSooDOHDhuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 07:17:04PM -0500, Rob Herring wrote:
> On Wed, Oct 18, 2017 at 5:34 PM, Frank Rowand <frowand.list@gmail.com> wr=
ote:
> > On 10/18/17 13:16, Rob Herring wrote:
> >> Use devicetree-compiler list for dtc issues please.
> >>
> >> On Wed, Oct 18, 2017 at 2:33 PM, Frank Rowand <frowand.list@gmail.com>=
 wrote:
> >>> Hi Rob, Alan,
> >>>
> >>> On 10/18/17 08:58, Alan Tull wrote:
> >>>> Hi Rob,
> >>>>
> >>>> I've noticed a problem compiling DT overlays and traced it back to
> >>>> beginning in next-20171009
> >>>>
> >>>> That tag adds the following in scripts/dtc
> >>>>
> >>>> e9480c1 2017-10-09 16:17:32 +0100 : Mark Brown : Merge remote-tracki=
ng
> >>>> branch 'devicetree/for-next'
> >>>> 4201d05 2017-10-03 15:03:47 -0500 : Rob Herring : scripts/dtc: Update
> >>>> to upstream version v1.4.5-3-gb1a60033c110
> >>>> 4322323 2017-10-03 15:03:46 -0500 : Rob Herring : scripts/dtc: add
> >>>> fdt_overlay.c and fdt_addresses.c to sync script
> >>>>
> >>>> The error is:
> >>>>
> >>>> dtc: /home/atull/repos/linux-socfpga/scripts/dtc/livetree.c:543:
> >>>> get_node_by_phandle: Assertion `(phandle !=3D 0) && (phandle !=3D -1=
)'
> >>>> failed.
> >>>> arch/arm/boot/dts/socfpga_overlay.dtb: Warning (clocks_property):
> >>>> Could not get phandle node for
> >>>> /fragment@0/__overlay__/gpio@10040:clocks(cell 0)
> >>>> Aborted (core dumped)
> >>>> scripts/Makefile.lib:316: recipe for target
> >>>> 'arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb'
> >>>> failed
> >>>> make[2]: *** [arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc_ghrd_ovl=
_ext_cfg.dtb]
> >>>> Error 134
> >>>> arch/arm/Makefile:346: recipe for target 'dtbs' failed
> >>>>
> >>>> Here's a simplified overlay that gets this error.  Taking out the li=
ne
> >>>> "interrupt-parent =3D <&intc>;" fixes the build.
> >>>>
> >>>> /dts-v1/;
> >>>> /plugin/;
> >>>> / {
> >>>>         fragment@0 {
> >>>>                 target-path =3D "/soc/base_fpga_region";
> >>>>                 #address-cells =3D <1>;
> >>>>                 #size-cells =3D <1>;
> >>>>
> >>>>                 __overlay__ {
> >>>>                         ranges =3D <0x00000000 0x00000000 0xc0000000=
 0x00040000>,
> >>>>                                  <0x00000001 0x00000000 0xff200000 0=
x00001000>;
> >>>>
> >>>>                         external-fpga-config;
> >>>>
> >>>>                         #address-cells =3D <2>;
> >>>>                         #size-cells =3D <1>;
> >>>>
> >>>>                         fpga_pr_region0 {
> >>>>                                 compatible =3D "fpga-region";
> >>>>                                 fpga-bridges =3D <&freeze_controller=
_0>;
> >>>>                                 ranges;
> >>>>                         };
> >>>>
> >>>>                         freeze_controller_0: freeze_controller@0x100=
000450 {
> >>>>                                 compatible =3D "altr,freeze-bridge-c=
ontroller";
> >>>>                                 reg =3D <0x00000001 0x00000450 0x000=
00010>;
> >>>>                                 interrupt-parent =3D <&intc>;  /* <--
> >>>> remove to fix build */
> >>>>                                 interrupts =3D <0 21 4>;
> >>>>                         };
> >>>>                 };
> >>>>         };
> >>>> };
> >>>>
> >>>> Alan
> >>>
> >>> Phandle references in overlays are assigned the value of -1 (0xffffff=
ff) in
> >>> the dtb, to be fixed up when loaded.  A new check sees this value and
> >>> triggers the assert.
> >>>
> >>> It is this commit in the upstream dtc tools tree:
> >>>
> >>>    commit ee3d26f6960bb5922d9a35fe266d9eac74a78ec0
> >>>    checks: add interrupts property check
> >>>
> >>> There are a bunch of other new checks that call get_node_by_phandle(),
> >>> and thus could trigger the assertion.
> >>>
> >>> I'm guessing that those checks would also trigger the assert if an
> >>> overlay contained something that would lead to one of the other checks
> >>> being processed.
> >>
> >> You won't get an assert because I check for 0 or -1 and skip the check
> >> in those cases. The interrupts check missed that condition.
> >
> > Awesome, thank for confirming that.  That means the temporary work arou=
nd
> > is quite easy.
> >
> >>
> >> However, as shown above, you will get an erroneous warning because it
> >> just skips 1 cell and goes to the next to handle the case where the
> >> phandle is optional and you want a fixed number of elements.
> >
> > Just for those reading along at home, with the one warning disabled, the
> > messages become:
> >
> >    $  dtc -Wno-interrupts_property socfpga_arria10_socdk_sdmmc_ghrd_ovl=
_ext_cfg.dts >junk.dtb
> >    <stdout>: Warning (unit_address_vs_reg): Node /fragment@0 has a unit=
 name, but no reg property
> >    <stdout>: Warning (unit_address_vs_reg): Node /fragment@0/__overlay_=
_ has a reg or ranges property, but no unit name
>=20
> Look like errors to me.
>=20
> >> I guess we can't validate overlays which is unfortunate. I don't think
> >> that's a solvable problem unless you have the base DT.
> >
> > Yes, maybe.  But there are still some useful warnings for overlays, may=
be.  I'm
> > not sure what the implications of the "range_format" warning that I wil=
l show
> > below are (I'd actually have to spend a few minutes thinking about rang=
es, and
> > I don't have the cycles right now).
>=20
> Well, yes all the simple localized checks should work, but as we add
> more complex checks with either dtc or the schema we'll have after
> ELCE next week there's a lot we can't validate. Perhaps we have to
> place some restrictions on overlays so we can validate them better.

Reworking overlay handling in dtc will help at least insofar as making
it easier to work out which checks can be applied to overlay fragments
and which only make sense on a fully assembled tree.  There will still
be plenty of things that can't be checked on overlays, since they
absolitely require information from the base tree.

This is a reason I really prefer the (alas, stalled) connector
proposal, since it makes it much more explicit what the external
dependencies of the fragments are.

> I do wonder if we could add tags to phandles to make them
> identifiable. Perhaps making them all 0xFF?????? instead of starting
> at 1. 2^24 phandles should be enough for anyone(TM).

True, in a sense.  However this is a problem for systems generating
FDTs from a real OF.  On real OF, the phandles are usually pointers
inside OF, and if it happens to allocate it's memory at the top of the
address space, phandles in the 0xff?????? range are entirely
plausible.

0 and -1 are the only values explicitly disallowed by IEEE1275, so
they're the only safe values to use as markers.

> That would not
> completely solve this problem, but then we could at least find the
> phandles in a property.

No, it wouldn't do that reliably, because a 0xff?????? value could
just as well appear as another integer value in a property.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pM5zeTSooDOHDhuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnoBqMACgkQbDjKyiDZ
s5KEiBAAiC9BJe12masdYaRBWN327K1WHbghETTt6rwfvr7H4+YoCOf8wkjluAad
XXE5Gdz5slPyTVUUiMHYM+zNdi5p34ikdRu6IKJUetMYI6IMFODPzu4YlWTl/ohN
RayUjBrl4zP66s/UgYhwjZklxIVeqArpyV+w7mqh49196UaaRK7nVAJqceZRo+3l
7cQU+xZaBezRjXgIBI+VUJwigePpKpuHvPruS77neGl3lR/Uirk+RXPQFyR/fOMl
qwlxGArII01ucgFR7P8Mt9SgQfD8eHAYb4fN11mEt/a/nqzSM7lzDhXLa/joso2X
x+HmYgwHUIW6ogmeQkvKS651f+pYUel6o8FJU/shiHdaQxbhcc3RENMLK8r8OTsD
jNJBy3bf2eTebcm7bHBE2xEB4280SErJMdwnvgqF6pMrXDaRoLoE7BDdahd6t/aj
4Hs3hNyriYEOm4Vm1/Ltv7/CoXfiN1Gy3EHMZJFHjT1ufLpUesJresPHmIcLP32z
FC2ZTjJRiJozVqEhQFhO5fYkiiM7OOdz7xeF7xyIAG7H4sFk0dYPdhFsYYY/7ntA
3UnGCkbNLBoG0dnZuNfMDGMAmDAGz6uyJ3tI/yp1bJB8sXx6e5EVAN/m2Cju7WfG
/3sGF3yQS0s+rXD4j+puQT+dg2Adg6GmwXdRhMROU9Di0Jy4QPI=
=G6k0
-----END PGP SIGNATURE-----

--pM5zeTSooDOHDhuH--
