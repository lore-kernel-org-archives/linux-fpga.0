Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from ozlabs.org ([103.22.144.67]:41131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751458AbdJSCAf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Oct 2017 22:00:35 -0400
Date: Thu, 19 Oct 2017 12:52:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc issue with overlays starting in next-20171009
Message-ID: <20171019015214.GU2776@umbus.fritz.box>
References: <CANk1AXQaXKud2Mic_879JiS39hJB4y0uTS2w1uxXje-0mO68Vw@mail.gmail.com>
 <59E7ACA0.7030809@gmail.com>
 <CAL_Jsq+f4Y1DDB4ZkXAEKUZ_P9YdMUKMhr2E=VKtbHWMZFaO0w@mail.gmail.com>
 <59E7D6E0.5030109@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dQ+ozEaLk2y6HH72"
Content-Disposition: inline
In-Reply-To: <59E7D6E0.5030109@gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Devicetree Compiler <devicetree-compiler@vger.kernel.org>


--dQ+ozEaLk2y6HH72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 03:34:08PM -0700, Frank Rowand wrote:
> On 10/18/17 13:16, Rob Herring wrote:
> > Use devicetree-compiler list for dtc issues please.
> >=20
> > On Wed, Oct 18, 2017 at 2:33 PM, Frank Rowand <frowand.list@gmail.com> =
wrote:
> >> Hi Rob, Alan,
> >>
> >> On 10/18/17 08:58, Alan Tull wrote:
> >>> Hi Rob,
> >>>
> >>> I've noticed a problem compiling DT overlays and traced it back to
> >>> beginning in next-20171009
> >>>
> >>> That tag adds the following in scripts/dtc
> >>>
> >>> e9480c1 2017-10-09 16:17:32 +0100 : Mark Brown : Merge remote-tracking
> >>> branch 'devicetree/for-next'
> >>> 4201d05 2017-10-03 15:03:47 -0500 : Rob Herring : scripts/dtc: Update
> >>> to upstream version v1.4.5-3-gb1a60033c110
> >>> 4322323 2017-10-03 15:03:46 -0500 : Rob Herring : scripts/dtc: add
> >>> fdt_overlay.c and fdt_addresses.c to sync script
> >>>
> >>> The error is:
> >>>
> >>> dtc: /home/atull/repos/linux-socfpga/scripts/dtc/livetree.c:543:
> >>> get_node_by_phandle: Assertion `(phandle !=3D 0) && (phandle !=3D -1)'
> >>> failed.
> >>> arch/arm/boot/dts/socfpga_overlay.dtb: Warning (clocks_property):
> >>> Could not get phandle node for
> >>> /fragment@0/__overlay__/gpio@10040:clocks(cell 0)
> >>> Aborted (core dumped)
> >>> scripts/Makefile.lib:316: recipe for target
> >>> 'arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb'
> >>> failed
> >>> make[2]: *** [arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc_ghrd_ovl_=
ext_cfg.dtb]
> >>> Error 134
> >>> arch/arm/Makefile:346: recipe for target 'dtbs' failed
> >>>
> >>> Here's a simplified overlay that gets this error.  Taking out the line
> >>> "interrupt-parent =3D <&intc>;" fixes the build.
> >>>
> >>> /dts-v1/;
> >>> /plugin/;
> >>> / {
> >>>         fragment@0 {
> >>>                 target-path =3D "/soc/base_fpga_region";
> >>>                 #address-cells =3D <1>;
> >>>                 #size-cells =3D <1>;
> >>>
> >>>                 __overlay__ {
> >>>                         ranges =3D <0x00000000 0x00000000 0xc0000000 =
0x00040000>,
> >>>                                  <0x00000001 0x00000000 0xff200000 0x=
00001000>;
> >>>
> >>>                         external-fpga-config;
> >>>
> >>>                         #address-cells =3D <2>;
> >>>                         #size-cells =3D <1>;
> >>>
> >>>                         fpga_pr_region0 {
> >>>                                 compatible =3D "fpga-region";
> >>>                                 fpga-bridges =3D <&freeze_controller_=
0>;
> >>>                                 ranges;
> >>>                         };
> >>>
> >>>                         freeze_controller_0: freeze_controller@0x1000=
00450 {
> >>>                                 compatible =3D "altr,freeze-bridge-co=
ntroller";
> >>>                                 reg =3D <0x00000001 0x00000450 0x0000=
0010>;
> >>>                                 interrupt-parent =3D <&intc>;  /* <--
> >>> remove to fix build */
> >>>                                 interrupts =3D <0 21 4>;
> >>>                         };
> >>>                 };
> >>>         };
> >>> };
> >>>
> >>> Alan
> >>
> >> Phandle references in overlays are assigned the value of -1 (0xfffffff=
f) in
> >> the dtb, to be fixed up when loaded.  A new check sees this value and
> >> triggers the assert.
> >>
> >> It is this commit in the upstream dtc tools tree:
> >>
> >>    commit ee3d26f6960bb5922d9a35fe266d9eac74a78ec0
> >>    checks: add interrupts property check
> >>
> >> There are a bunch of other new checks that call get_node_by_phandle(),
> >> and thus could trigger the assertion.
> >>
> >> I'm guessing that those checks would also trigger the assert if an
> >> overlay contained something that would lead to one of the other checks
> >> being processed.
> >=20
> > You won't get an assert because I check for 0 or -1 and skip the check
> > in those cases. The interrupts check missed that condition.
>=20
> Awesome, thank for confirming that.  That means the temporary work around
> is quite easy.
>=20
> >=20
> > However, as shown above, you will get an erroneous warning because it
> > just skips 1 cell and goes to the next to handle the case where the
> > phandle is optional and you want a fixed number of elements.
>=20
> Just for those reading along at home, with the one warning disabled, the
> messages become:
>=20
>    $  dtc -Wno-interrupts_property socfpga_arria10_socdk_sdmmc_ghrd_ovl_e=
xt_cfg.dts >junk.dtb
>    <stdout>: Warning (unit_address_vs_reg): Node /fragment@0 has a unit n=
ame, but no reg property
>    <stdout>: Warning (unit_address_vs_reg): Node /fragment@0/__overlay__ =
has a reg or ranges property, but no unit name

Ah.. yeah.. we should put in explicit handling of this.  The top level
nodes in an overlay don't really obey the normal DT rules, so we
shouldn't apply the checks to them in the same way.

This, incidentally was a major part of why I want to change overlay
construction so it's done as a separate pass, rather than during the
parse: that way we can apply the checks separately to each fragment
before we assemble them, which I think will work better in most
cases.  (well, actually, the plan was to have two groups of checks -
some that run before overlay assembly, some after).  I made a start on
this in the 'overlay' branch, but I never got a chance to finish it.

> > I guess we can't validate overlays which is unfortunate. I don't think
> > that's a solvable problem unless you have the base DT.
>=20
> Yes, maybe.  But there are still some useful warnings for overlays, maybe=
=2E  I'm
> not sure what the implications of the "range_format" warning that I will =
show
> below are (I'd actually have to spend a few minutes thinking about ranges=
, and
> I don't have the cycles right now).
>=20
>=20
> >=20
> >> You can avoid the problem in your example dts with "-Wno-interrupts_pr=
operty"
> >>
> >>   dtc -Wno-interrupts_property fpga_01_a.dts
> >>
> >> The larger set of other checks that might trigger the assert is too la=
rge
> >> for me to want to add "-Wno-" flags for all of them to the command line
> >> (as temporary workarounds).
> >=20
> > David thought more switches were better.
>=20
> Yep.  Not a complaint, just an observation about a _temporary_ workaround.
>=20
>=20
> >=20
> > Rob
> >=20
>=20
>=20
> Here is the "range_format" warning I mentioned above.  The dts file that
> started this thread hand crafts what is internal overlay data, which
> should be generated by the dtc compiler instead of being hand coded in
> the dts.  If I remove the hand coded stuff and let dtc generate the
> internal overlay data, the dtc messages become (use a wide window to
> avoid line wrapping):
>=20
> $ dtc -Wno-interrupts_property fpga_01_a.dts >junk.dtb
> <stdout>: Warning (ranges_format): "ranges" property in /fragment@0/__ove=
rlay__ has invalid length (32 bytes) (parent #address-cells =3D=3D 2, child=
 #address-cells =3D=3D 2, #size-cells =3D=3D 1)

This is a false positive.  Correctly parsing the ranges property
requires knowing the parent node's #address-cells and #size-cells.  In
the case of an overlay, we don't know the real parent until it's
applied, so we can't check this.

So this probably needs another change to skip this test on the top
node of any overlay fragment.  Again, this would be easier if overlay
juggling was in a separate pass.

> <stdout>: Warning (unit_address_vs_reg): Node /fragment@0 has a unit name=
, but no reg property
> <stdout>: Warning (unit_address_vs_reg): Node /fragment@0/__overlay__ has=
 a reg or ranges property, but no unit name
> <stdout>: Warning (avoid_default_addr_size): Relying on default #address-=
cells value for /fragment@0/__overlay__
> <stdout>: Warning (avoid_default_addr_size): Relying on default #size-cel=
ls value for /fragment@0/__overlay__
>=20
>=20
> The second through last warning are about the format of the internal
> data structure, and hopefully could just be suppressed.  I don't
> know how easy or hard that would be to implement - I am very much
> not a dtc internals expert.

Right, we shouldn't be applying these checks to nodes that are part of
the overlay metadata rather than "real" nodes.

> The first warning says something about what the overlay source dts
> contains.  Here is what the original dts source looks like when
> transformed to not contain the hand crafted internal overlay data:
>=20
> $ cat fpga_01_a.dts=20
> /dts-v1/;
> /plugin/;
>=20
> // This assumes an existing label in the base dts
> // whose location is "/soc/base_fpga_region"
> &fpga_region {
>=20
> 			ranges =3D <0x00000000 0x00000000 0xc0000000 0x00040000>,
> 				 <0x00000001 0x00000000 0xff200000 0x00001000>;
>=20
> 			external-fpga-config;
>=20
> 			#address-cells =3D <2>;
> 			#size-cells =3D <1>;
>=20
> 			fpga_pr_region0 {
> 				compatible =3D "fpga-region";
> 				fpga-bridges =3D <&freeze_controller_0>;
> 				ranges;
> 			};
>=20
> 			freeze_controller_0: freeze_controller@100000450 {
> 				compatible =3D "altr,freeze-bridge-controller";
> 				reg =3D <0x00000001 0x00000450 0x00000010>;
> 				interrupt-parent =3D <&intc>;  /* <-- remove to fix build */
> 				interrupts =3D <0 21 4>;
> 			};
> };
>=20
> Of course, if this was a real transformation, I would remove all the
> extra tabbing.  But the current form makes it easier to see that all
> of the stuff that is highly indented is unchanged from the original
> dts file.
>=20
> $ diff -u socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dts fpga_01_a.dts
> --- socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dts	2017-10-18 15:18:43.=
123137508 -0700
> +++ fpga_01_a.dts	2017-10-18 15:18:11.587136897 -0700
> @@ -1,12 +1,10 @@
>  /dts-v1/;
>  /plugin/;
> -/ {
> -	fragment@0 {
> -		target-path =3D "/soc/base_fpga_region";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> =20
> -		__overlay__ {
> +// This assumes an existing label in the base dts
> +// whose location is "/soc/base_fpga_region"
> +&fpga_region {
> +
>  			ranges =3D <0x00000000 0x00000000 0xc0000000 0x00040000>,
>  				 <0x00000001 0x00000000 0xff200000 0x00001000>;
> =20
> @@ -27,6 +25,4 @@
>  				interrupt-parent =3D <&intc>;  /* <-- remove to fix build */
>  				interrupts =3D <0 21 4>;
>  			};
> -		};
> -	};
>  };
>=20
>=20
> -Frank

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dQ+ozEaLk2y6HH72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnoBU4ACgkQbDjKyiDZ
s5LhYw/+JQNBtL6xKkku69jg2moPa9/fnE+x5pVO7afzfesl+7qPSiya5MVPiy/p
/aBDe0mCZ7UtJbwHbF08oktGDV6FLe96g6rE8JnTOlVSZalOLe4HSpO7spoUtr8F
dhJT3z8IuxOUW61tAILCf18X6Phq8HpYdow9Fhp/W1HuAYWy26Ktyi554hk+TRWl
doUDwA0Dhse4d7Qun21c+wHbFMwWNWoRNzusjXPgWW9sOQxXLMVtMge5H7ONpKKG
ghQCWg5IixWSvGufc+9cFOb+4JC9CMXW2jMKRQwzfb0C2gCkkwEPjpYfyGzXm0ZP
byw2oVCn+xm6iVUDUF5CknaBr4jCi6BuywIAhaFJ8Dl5cXeCblLAe5ZHIfvU9OdV
83D8VAA/6mEo0hu7igd+UuvHkrnX4Be0rnp+M/Q4+ZOXCAXVGzn9SChwOpHLgdMf
VXAZjO78edNYg4SRQ2KK1guElTOGt85IkM6lAYQiQcndDPm962BqQSByi0YASflx
vGc0H1KOrvSmSWSP3PRp57i1ouTSAZc+qaSnrYoGInJP8bT8tj+DsRyiSal4eCc3
O4tW9LE/sflO+IOQIPp4qcVEfO92CeCI0Iet7CSuk/zlXsZX+jQeinfvUk1lCgUc
AlY2QclJgU/61ursVtt8hkuwK7eJZJA2V/oU7JUrD4Fcvd15+CE=
=mqJP
-----END PGP SIGNATURE-----

--dQ+ozEaLk2y6HH72--
