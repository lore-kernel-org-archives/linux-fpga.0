Return-Path: <SRS0=ckN0=F7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ckN0=F7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:58816 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbeCIPIO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Mar 2018 10:08:14 -0500
Date: Fri, 9 Mar 2018 16:07:54 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: clk-fixed-rate clock driver usage with fpgas was: Re: Fpga
 manager help
Message-ID: <20180309150754.aa3pqgnpjzkpxpgy@flea>
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
 <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
 <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>
 <295f64ae-a049-010a-fd68-3fcd46a5d8a1@monstr.eu>
 <20180309081219.yzsy2ktq75af2tjv@flea.lan>
 <74d66882-662c-59c5-59c5-d59d8eb14280@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y7nmixcsn6b3acny"
Content-Disposition: inline
In-Reply-To: <74d66882-662c-59c5-59c5-d59d8eb14280@monstr.eu>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Alan Tull <atull@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@secretlab.ca>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>


--y7nmixcsn6b3acny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Fri, Mar 09, 2018 at 09:28:52AM +0100, Michal Simek wrote:
> Hi Maxime,
>=20
>=20
> On 9.3.2018 09:12, Maxime Ripard wrote:
> > Hi,
> >=20
> > Sorry if I'm off-topic, I'm not sure I fully got the context
>=20
> let me explain below.
>=20
> >=20
> > On Thu, Mar 08, 2018 at 03:04:50PM +0100, Michal Simek wrote:
> >>       pl1: clock {
> >> 		compatible =3D "fixed-factor-clock";
> >> 		clocks =3D <&clk 71>;
> >> 		#clock-cells =3D <0>;
> >> 		clock-frequency =3D <25000000>; /* missing property */
> >> 		clock-div =3D <1>;
> >> 		clock-mult =3D <1>;
> >> 		clock-output-names =3D "pl1"
> >>       };
> >=20
> > In this case, I'm not sure why the clock-frequency property is needed
> > in the first place. If you have a divider and factor of 1, then your
> > rate should be the one from your parent clock.
>=20
> Correct but this is DT overlay for FPGAs and every bitstream has
> different need for setting up parent clock.
>=20
> Let me give you an example:
> You have zynq board (arm32 in fixed part with bunch of hard IPs like
> ethernet/usb/sd/qspi/nand) and you have fpga(programmable logic) next to
> it. And depends on your need you can load bitstream to fpga to do some
> work for you. One design is synthesized for max clock 200MHz and another
> one on 10MHz because of whatever reason.
> fpga manager/region and DT overlays are providing you and option to
> change these two hw designs at run time based on your needs.
> It means you need to describe input clock for both cases and you need to
> ask for setting up different clock parent rate.
>=20
> That's why we need to describe this rate somewhere and example above is
> using clock-frequency properly with fixed-factor-clock in div=3D1/mult=3D1
> setting.
>=20
> >=20
> > The clock-frequency is redundant with what you already have.
>=20
> But this is DT overlay and every bitstream has different need as above.
> It means different requirement for parent rate.

Ah, I see, so you want to change the clk 71 (in this case) to 25MHz in
the snippet above.

Have you looked at the assigned-clock-rates property? It should cover
it.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--y7nmixcsn6b3acny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqio0oACgkQ0rTAlCFN
r3SmHA/+MFv5PKSSJZPJufbA8WRip5MRhc3UHAqkAQfMtXPDGyLL3BtM9dVSFwNq
klEPSoaCfKZVY7xdKxQHTfUChO9bQ/DtrJlSrLIQqPkfnzK2hGlYLTWFYr+NUJSE
F3iAOABEWoMxOc8DbPH9oIqchRO7k7+85ZpLyhQEOwwnyq95RzceVCptXtJMOdie
oyOCiSE2hlWWSO7QpZkUWY4nnouveU/FLg4xnN9sTQZGVcCcpuv/ljzHKpUw6wwe
dqXhb/9vx10neEr2tBk6UuoAwr8qvUt8XrqFHXI3PYmHQieMWb8q0YHSTIf5L5ly
MYCT353i0lRSYm8jwaRx+gB/rjYh53BDD81/Is9+jyRAeEkCS62NxGcsaCwHX6dM
V9M6MUFCeysRLVL6bhi3+Nawa3wqaosVm61n+rV5rVmN2Yr8fQGVcCpKmBj14fPV
dts2stkk8sdCXnBZAUEbqvnwYAINA6iTNLVDVjJg5wHsFkyvP3N4Gdxgmqpn8Ks4
ZX+KxwYZ0VkqxiLgX9nT91SyDUnZ5fc/41E7YrWqxec4ByvzTOvjZ/JkT1LiFsxE
fjGd4WVssQarOJg3tYqdYYxjif7MoyVAJzd7Ekwuf/IXeLtClT4+ekBofz9RtFVl
ZHDSIJ/BRm27tUuqq+VfVutVLu5XofnHf8DYxE2p9EoOKZ5Q/SI=
=6o6W
-----END PGP SIGNATURE-----

--y7nmixcsn6b3acny--
