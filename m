Return-Path: <SRS0=XHVm=F6=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=XHVm=F6=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39449 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754837AbeCHOFA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Mar 2018 09:05:00 -0500
Received: by mail-wr0-f180.google.com with SMTP id w77so5800734wrc.6
        for <linux-fpga@vger.kernel.org>; Thu, 08 Mar 2018 06:04:59 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: clk-fixed-rate clock driver usage with fpgas was: Re: Fpga manager
 help
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
 <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
 <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <295f64ae-a049-010a-fd68-3fcd46a5d8a1@monstr.eu>
Date: Thu, 8 Mar 2018 15:04:50 +0100
MIME-Version: 1.0
In-Reply-To: <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="C0kJsjzclDrTrWEm35iZPKWbgrK97652p"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@secretlab.ca>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Maxime Ripard <maxime.ripard@bootlin.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C0kJsjzclDrTrWEm35iZPKWbgrK97652p
Content-Type: multipart/mixed; boundary="MF07sNqwjhPuuP86OW1rpz9TelnNmWuKp";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Alan Tull <atull@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
 linux-fpga@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Grant Likely <grant.likely@secretlab.ca>, linux-clk@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Message-ID: <295f64ae-a049-010a-fd68-3fcd46a5d8a1@monstr.eu>
Subject: clk-fixed-rate clock driver usage with fpgas was: Re: Fpga manager
 help
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
 <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
 <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>
In-Reply-To: <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>

--MF07sNqwjhPuuP86OW1rpz9TelnNmWuKp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi, +linux-clk

On 21.2.2018 20:25, Alan Tull wrote:
> On Wed, Feb 21, 2018 at 6:33 AM, Michal Simek <monstr@monstr.eu> wrote:=

>> Hi, +Grant and Pantelis,
>=20
> Hi Shubhrajyoti,
>=20
> I want to make sure I understand your situation here.  So I'll ask
> some questions, please let me know if I'm misunderstanding.
>=20
>>
>> On 21.2.2018 06:36, Shubhrajyoti Datta wrote:
>>> Hi Alan,
>>> Thanks for the help.
>>>
>>>
>>> On Tue, Feb 20, 2018 at 9:54 PM, Alan Tull <atull@kernel.org> wrote:
>>>> On Mon, Feb 19, 2018 at 1:09 AM, Shubhrajyoti Datta
>>>> <shubhrajyoti.datta@gmail.com> wrote:
>>>>
>>>> Hi Shubhrajyoti,
>>>>
>>>>> Hi ,
>>>>>
>>>>> Some of the FPGA has a  clock  rate that it needs to operate.
>=20
> The FPGA device needs a clock, right?  This isn't dependent on what
> FPGA image is loaded; this is the clock that makes the FPGA device
> happy, right?

There are several scenarios how to use these clocks but let me describe
HW. Xilinx fpgas have some clock lines coming from fixed part(PS) to
programmable logic(PL). Clock rate is setup by initial device
programming (bootloader) but that's just fixed for the whole live cycle.

To be more flexible there is a need to have an option to change clock
rate depending on bitstream you want to program (It doesn't matter if
this is full bitstream or partial bitstream).
For example: That means one set of bitstreams with dt overlay where one
require 25MHz on clock line and another 50MHz.


> If that is the case, this is platform specific setup, which can be
> done by adding an overlay or it could have been in the base device
> tree, right?  The second overlay can do the FPGA programming.

I don't think that make sense to have more overlays and mess up things
just because of setting up proper clock rate for specific PL.

Anyway concept which I am talking about looks like this in DT description=
=2E

/dts-v1/;
/plugin/;

/ {
  fragment {
    target =3D <&fpga_full>;
    __overlay__ {
      #address-cells =3D <1>;
      #size-cells =3D <1>;
      firmware-name =3D "download.bin"; /* bitstream */
      fpga-bridges =3D <&... &...>; /* some bridges */

      pl1: clock {
	compatible =3D "fixed-factor-clock";
	clocks =3D <&clk 71>;
	#clock-cells =3D <0>;
	clock-frequency =3D <25000000>; /* missing property */
	clock-div =3D <1>;
	clock-mult =3D <1>;
	clock-output-names =3D "pl1"
      };

      /* The same as above but with different driver */
      pl1-alt: clock {
	compatible =3D "fixed-clock";
	clocks =3D <&clk 71>; /* missing property */
	#clock-cells =3D <0>;
	clock-frequency =3D <25000000>;
	clock-output-names =3D "pl1";
      };
      /* or completely new driver based on above two. */

      gpio_on: gpio@XXX {
	compatible =3D "xlnx,xps-gpio-1.00.a";
	gpio-controller ;
	clocks =3D <&pl1>; /* or pl1-alt or new driver */
      };
    };
  };
};

It means download.bit is loaded and overlay applied. clock driver is
probed and gpio driver is waiting for it (-EDEFER if not ready).

This concept should ensure that no driver is probed without setting up
proper clock rate which bitstream was built for.

As you see above I have added pl1 or pl1-alt nodes which are using
current drivers but we are missing functionality there.

1) In fixed-factor-clock we are missing option to setup clock rate
directly. That the driver will ask parent for setting up rate. Driver
contain support added with "allwinner,sun4i-a10-pll3-2x-clk"
(e6cbf9984ee73) by Maxime Ripard which enables changing rate from childs
but that's different functionality than we need.

2) in fixed-clock driver we are missing connection with parent to ask
for setting up described clock.

There is also an option to write new driver. Based on my look the driver
would be almost the same as above with just small difference. That's why
I think that will be the best to add this functionality to current
driver instead of creating similar one.

fixed-factor-clk seems to be better because there is already patch from
Maxime for passing setting up rate from childs but I would like hear
your opinion.
The patch would like just like this

clock-frequency - DT optional parameter.

And in driver:

of_property_read_u32(node, "clock-frequency", &rate);
if (rate)
	clk_set_rate(..., rate);

Please let me what you think.

Thanks,
Michal

>=20
>>>>> Wanted some help in having suggestions as to  how should this be do=
ne.
>>>>>
>>>>>
>>>>> I tried the bridge approach.
>>>>> It worked however since having the possible rate have precompiled i=
s difficult
>>>>> because of the wide range of possible frequency.
>>>>>
>>>>> So i have a first overlay that updates the rate and second overlay
>>>>> actually apply.
>>>>
>>>> IIUC, that sounds right to me.  The base overlay sets up bridges and=

>>>> fpga regions.  The overlay after that does the programming.  That's
>>>> consistent with the fpga-region device tree binding documentation.
>>>
>>> My options were
>>> 1) a first overlay that updates the rate and second overlay
>>>  actually apply.
>=20
> So that's what I'm saying above, IIUC
>=20
>>> 2) overlay has a pseudo clock driver that sets the rate and acts
>>> as a provider of clocks so that other drivers are EPROBE_DEFERED.
>>>
>>> Do you think I should prefer option 1)
>> I would prefer option too.
>=20
> Option two?
>=20
> What does option 2 give us that option 1 doesn't?  Seems like more
> work, unless there's something in this setup I don't know about, which
> seems pretty likely right now.
>=20
>> If you want to use option 1 then still
>> devices in second overlay should reference clock setup in the first.
>=20
> Now that makes it sound like we're talking about clocks for the
> hardware that is in FPGA fabric?
>=20
>>
>> Thanks,
>> Michal
>>
>>
>> --
>> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
>> w: www.monstr.eu p: +42-0-721842854
>> Maintainer of Linux kernel - Xilinx Microblaze
>> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
>> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs
>>
>>


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--MF07sNqwjhPuuP86OW1rpz9TelnNmWuKp--

--C0kJsjzclDrTrWEm35iZPKWbgrK97652p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqhQwIACgkQykllyylKDCFXLwCgizl/zLMuR0R62e1roD/mA2gH
0KsAn2MaJfL/9xp5rwxGoG5BnplYPTVe
=q9IP
-----END PGP SIGNATURE-----

--C0kJsjzclDrTrWEm35iZPKWbgrK97652p--
