Return-Path: <SRS0=ckN0=F7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ckN0=F7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:46683 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeCII3C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Mar 2018 03:29:02 -0500
Received: by mail-wr0-f169.google.com with SMTP id m12so8147602wrm.13
        for <linux-fpga@vger.kernel.org>; Fri, 09 Mar 2018 00:29:01 -0800 (PST)
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
From: Michal Simek <monstr@monstr.eu>
Message-ID: <74d66882-662c-59c5-59c5-d59d8eb14280@monstr.eu>
Date: Fri, 9 Mar 2018 09:28:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180309081219.yzsy2ktq75af2tjv@flea.lan>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="joztmFiaKHbtXXEB2PyPd4L7SGD16ImJT"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Alan Tull <atull@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@secretlab.ca>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--joztmFiaKHbtXXEB2PyPd4L7SGD16ImJT
Content-Type: multipart/mixed; boundary="CSckQ1ESrpTq0oMRe6R0zFU1aFfw43cmp";
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
Message-ID: <74d66882-662c-59c5-59c5-d59d8eb14280@monstr.eu>
Subject: Re: clk-fixed-rate clock driver usage with fpgas was: Re: Fpga
 manager help
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
 <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
 <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>
 <295f64ae-a049-010a-fd68-3fcd46a5d8a1@monstr.eu>
 <20180309081219.yzsy2ktq75af2tjv@flea.lan>
In-Reply-To: <20180309081219.yzsy2ktq75af2tjv@flea.lan>

--CSckQ1ESrpTq0oMRe6R0zFU1aFfw43cmp
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Maxime,


On 9.3.2018 09:12, Maxime Ripard wrote:
> Hi,
>=20
> Sorry if I'm off-topic, I'm not sure I fully got the context

let me explain below.

>=20
> On Thu, Mar 08, 2018 at 03:04:50PM +0100, Michal Simek wrote:
>>       pl1: clock {
>> 		compatible =3D "fixed-factor-clock";
>> 		clocks =3D <&clk 71>;
>> 		#clock-cells =3D <0>;
>> 		clock-frequency =3D <25000000>; /* missing property */
>> 		clock-div =3D <1>;
>> 		clock-mult =3D <1>;
>> 		clock-output-names =3D "pl1"
>>       };
>=20
> In this case, I'm not sure why the clock-frequency property is needed
> in the first place. If you have a divider and factor of 1, then your
> rate should be the one from your parent clock.

Correct but this is DT overlay for FPGAs and every bitstream has
different need for setting up parent clock.

Let me give you an example:
You have zynq board (arm32 in fixed part with bunch of hard IPs like
ethernet/usb/sd/qspi/nand) and you have fpga(programmable logic) next to
it. And depends on your need you can load bitstream to fpga to do some
work for you. One design is synthesized for max clock 200MHz and another
one on 10MHz because of whatever reason.
fpga manager/region and DT overlays are providing you and option to
change these two hw designs at run time based on your needs.
It means you need to describe input clock for both cases and you need to
ask for setting up different clock parent rate.

That's why we need to describe this rate somewhere and example above is
using clock-frequency properly with fixed-factor-clock in div=3D1/mult=3D=
1
setting.


>=20
> The clock-frequency is redundant with what you already have.

But this is DT overlay and every bitstream has different need as above.
It means different requirement for parent rate.


>=20
>>       /* The same as above but with different driver */
>>       pl1-alt: clock {
>> 		compatible =3D "fixed-clock";
>> 		clocks =3D <&clk 71>; /* missing property */
>> 		#clock-cells =3D <0>;
>> 		clock-frequency =3D <25000000>;
>> 		clock-output-names =3D "pl1";
>>       };
>=20
> And here, that would mean that whatever the rate of the parent clock
> is, you have a fixed output? Is that really a thing?

The fixed-clock driver will be asking clock parent for delivering this
clock rate on output and that's exactly what I want to reach to get a
exact clock rate which bitstream was synthesized to.

>=20
> Or are you trying to do something else?

I want to get a fixed clock by changing parent clock rate which is what
at least our clock driver is capable to do.
(I expect that if you ask for rate which parent is not capable to
deliver that this will be handled via error path).

Definitely feel free to ask more question to make it clear.

Thanks,
Michal
--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--CSckQ1ESrpTq0oMRe6R0zFU1aFfw43cmp--

--joztmFiaKHbtXXEB2PyPd4L7SGD16ImJT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqiRcQACgkQykllyylKDCERagCgg/ThKSkTP5239oZL21C2dnJb
OwkAn0Gmi1AkFhW7OhaRXTYUu+VkBOzU
=Mzef
-----END PGP SIGNATURE-----

--joztmFiaKHbtXXEB2PyPd4L7SGD16ImJT--
