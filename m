Return-Path: <SRS0=ckN0=F7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ckN0=F7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:44781 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbeCIIMX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Mar 2018 03:12:23 -0500
Date: Fri, 9 Mar 2018 09:12:19 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: clk-fixed-rate clock driver usage with fpgas was: Re: Fpga
 manager help
Message-ID: <20180309081219.yzsy2ktq75af2tjv@flea.lan>
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
 <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
 <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>
 <295f64ae-a049-010a-fd68-3fcd46a5d8a1@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hmk5hivh7ulnlfya"
Content-Disposition: inline
In-Reply-To: <295f64ae-a049-010a-fd68-3fcd46a5d8a1@monstr.eu>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Alan Tull <atull@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@secretlab.ca>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>


--hmk5hivh7ulnlfya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry if I'm off-topic, I'm not sure I fully got the context

On Thu, Mar 08, 2018 at 03:04:50PM +0100, Michal Simek wrote:
>       pl1: clock {
> 		compatible =3D "fixed-factor-clock";
> 		clocks =3D <&clk 71>;
> 		#clock-cells =3D <0>;
> 		clock-frequency =3D <25000000>; /* missing property */
> 		clock-div =3D <1>;
> 		clock-mult =3D <1>;
> 		clock-output-names =3D "pl1"
>       };

In this case, I'm not sure why the clock-frequency property is needed
in the first place. If you have a divider and factor of 1, then your
rate should be the one from your parent clock.

The clock-frequency is redundant with what you already have.

>       /* The same as above but with different driver */
>       pl1-alt: clock {
> 		compatible =3D "fixed-clock";
> 		clocks =3D <&clk 71>; /* missing property */
> 		#clock-cells =3D <0>;
> 		clock-frequency =3D <25000000>;
> 		clock-output-names =3D "pl1";
>       };

And here, that would mean that whatever the rate of the parent clock
is, you have a fixed output? Is that really a thing?

Or are you trying to do something else?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--hmk5hivh7ulnlfya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqiQeIACgkQ0rTAlCFN
r3TiaQ/7B42HfhKo1yM0h2FJ+1hiYKjGNdDz1m53uWA16YtragF/C/HYc/7Ym5o7
EzUC/Zu1OJzPQByd22UZMOaB6D6aPE2r0PMhUzEFN/zLYraPCpq1npTFCgCgcCoF
7sVi/zpJ0daw5aZ0Z4CegYRKePRCPj6Zy2AF/LRaMr45KkPXhbGRaucufy2BHs3y
E8q1XT/rSDmbPWRL8JwOiZCOk2aK9NDacHmpqzC+gkadYOW5xYctYwkhd6uiSrtP
8d/86/mMXKi6YRkGFySlfnqBMVHuVKQGHWU8XhP/YfswUet+TSuqDqHZyWo0qWHl
zFx90RzwpVwgHEWP8WlldY68KJ7Sma1oCBIa6mPEtzObRuktJYPzlE/MHAqx91sj
msKvbO4UC90CkwdTwBMMPk9HjKgA/rJrV+fln+YPKtwj8ZEigJcaxu1dDaUmJLov
lPdVniFZCAtlyP12i/D10fT+UaXJXTXT1TRBXjpURW7PRp4QI3wYcuHZJaFMKMS4
jkquIIpuFnmRshFpNfT3pkgnvGj+oeew57OFB/4PaVi2UoSIEqih0bEO21AtrzzJ
kYs3QY7ugCJTJ4+Rt2FyIeKo4xld9rOj5iSHYMjZt1zMoypQRayVD3ZPF6ExSFv+
/vNAcz8+Lw7dCNc3jvJWrVkwc0AyPe5Ar92xEM32vO3SA0TV4PI=
=4ldn
-----END PGP SIGNATURE-----

--hmk5hivh7ulnlfya--
