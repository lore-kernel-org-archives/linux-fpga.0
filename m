Return-Path: <SRS0=fPjK=GC=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=fPjK=GC=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35749 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbeCLNT2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 12 Mar 2018 09:19:28 -0400
Received: by mail-wm0-f53.google.com with SMTP id x7so16053539wmc.0
        for <linux-fpga@vger.kernel.org>; Mon, 12 Mar 2018 06:19:27 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: clk-fixed-rate clock driver usage with fpgas was: Re: Fpga
 manager help
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
 <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
 <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>
 <295f64ae-a049-010a-fd68-3fcd46a5d8a1@monstr.eu>
 <20180309081219.yzsy2ktq75af2tjv@flea.lan>
 <74d66882-662c-59c5-59c5-d59d8eb14280@monstr.eu>
 <20180309150754.aa3pqgnpjzkpxpgy@flea>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <bc813830-de0e-49fa-6c84-7c52024bcfbc@monstr.eu>
Date: Mon, 12 Mar 2018 14:19:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180309150754.aa3pqgnpjzkpxpgy@flea>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bSIjsUUso4l5rd84AxLTH1ULhRdvhbA83"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Alan Tull <atull@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@secretlab.ca>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bSIjsUUso4l5rd84AxLTH1ULhRdvhbA83
Content-Type: multipart/mixed; boundary="XYV7F8YoG8sTbgHsuLTAhneJEZsV7sw99";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Alan Tull <atull@kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
 linux-fpga@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Grant Likely <grant.likely@secretlab.ca>, linux-clk@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>
Message-ID: <bc813830-de0e-49fa-6c84-7c52024bcfbc@monstr.eu>
Subject: Re: clk-fixed-rate clock driver usage with fpgas was: Re: Fpga
 manager help
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
 <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
 <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>
 <295f64ae-a049-010a-fd68-3fcd46a5d8a1@monstr.eu>
 <20180309081219.yzsy2ktq75af2tjv@flea.lan>
 <74d66882-662c-59c5-59c5-d59d8eb14280@monstr.eu>
 <20180309150754.aa3pqgnpjzkpxpgy@flea>
In-Reply-To: <20180309150754.aa3pqgnpjzkpxpgy@flea>

--XYV7F8YoG8sTbgHsuLTAhneJEZsV7sw99
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On 9.3.2018 16:07, Maxime Ripard wrote:
> Hi Michal,
>=20
> On Fri, Mar 09, 2018 at 09:28:52AM +0100, Michal Simek wrote:
>> Hi Maxime,
>>
>>
>> On 9.3.2018 09:12, Maxime Ripard wrote:
>>> Hi,
>>>
>>> Sorry if I'm off-topic, I'm not sure I fully got the context
>>
>> let me explain below.
>>
>>>
>>> On Thu, Mar 08, 2018 at 03:04:50PM +0100, Michal Simek wrote:
>>>>       pl1: clock {
>>>> 		compatible =3D "fixed-factor-clock";
>>>> 		clocks =3D <&clk 71>;
>>>> 		#clock-cells =3D <0>;
>>>> 		clock-frequency =3D <25000000>; /* missing property */
>>>> 		clock-div =3D <1>;
>>>> 		clock-mult =3D <1>;
>>>> 		clock-output-names =3D "pl1"
>>>>       };
>>>
>>> In this case, I'm not sure why the clock-frequency property is needed=

>>> in the first place. If you have a divider and factor of 1, then your
>>> rate should be the one from your parent clock.
>>
>> Correct but this is DT overlay for FPGAs and every bitstream has
>> different need for setting up parent clock.
>>
>> Let me give you an example:
>> You have zynq board (arm32 in fixed part with bunch of hard IPs like
>> ethernet/usb/sd/qspi/nand) and you have fpga(programmable logic) next =
to
>> it. And depends on your need you can load bitstream to fpga to do some=

>> work for you. One design is synthesized for max clock 200MHz and anoth=
er
>> one on 10MHz because of whatever reason.
>> fpga manager/region and DT overlays are providing you and option to
>> change these two hw designs at run time based on your needs.
>> It means you need to describe input clock for both cases and you need =
to
>> ask for setting up different clock parent rate.
>>
>> That's why we need to describe this rate somewhere and example above i=
s
>> using clock-frequency properly with fixed-factor-clock in div=3D1/mult=
=3D1
>> setting.
>>
>>>
>>> The clock-frequency is redundant with what you already have.
>>
>> But this is DT overlay and every bitstream has different need as above=
=2E
>> It means different requirement for parent rate.
>=20
> Ah, I see, so you want to change the clk 71 (in this case) to 25MHz in
> the snippet above.
>=20
> Have you looked at the assigned-clock-rates property? It should cover
> it.

I have seen this but never looked at it. Definitely thanks for pointer.
We will look at it.

Thanks,
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--XYV7F8YoG8sTbgHsuLTAhneJEZsV7sw99--

--bSIjsUUso4l5rd84AxLTH1ULhRdvhbA83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqmflYACgkQykllyylKDCFXygCZAYRTkMjgBJJLrbTeor/4gHOv
1TEAni8Tw1LXLaZ2vvKLTCRoai0u5tQw
=WKw/
-----END PGP SIGNATURE-----

--bSIjsUUso4l5rd84AxLTH1ULhRdvhbA83--
