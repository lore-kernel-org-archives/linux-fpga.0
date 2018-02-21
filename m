Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45655 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbeBUMdW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Feb 2018 07:33:22 -0500
Received: by mail-wr0-f172.google.com with SMTP id p104so3983557wrc.12
        for <linux-fpga@vger.kernel.org>; Wed, 21 Feb 2018 04:33:22 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: Fpga manager help
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
Date: Wed, 21 Feb 2018 13:33:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="aJuYWXzZt6hY83VSAPMJxLIUbFntPZpj4"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@secretlab.ca>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aJuYWXzZt6hY83VSAPMJxLIUbFntPZpj4
Content-Type: multipart/mixed; boundary="qhzA6POgUUkfOh9gL1OFiEiy63zzWyWmN";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
 Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Grant Likely <grant.likely@secretlab.ca>
Message-ID: <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
Subject: Re: Fpga manager help
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
In-Reply-To: <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>

--qhzA6POgUUkfOh9gL1OFiEiy63zzWyWmN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi, +Grant and Pantelis,

On 21.2.2018 06:36, Shubhrajyoti Datta wrote:
> Hi Alan,
> Thanks for the help.
>=20
>=20
> On Tue, Feb 20, 2018 at 9:54 PM, Alan Tull <atull@kernel.org> wrote:
>> On Mon, Feb 19, 2018 at 1:09 AM, Shubhrajyoti Datta
>> <shubhrajyoti.datta@gmail.com> wrote:
>>
>> Hi Shubhrajyoti,
>>
>>> Hi ,
>>>
>>> Some of the FPGA has a  clock  rate that it needs to operate.
>>> Wanted some help in having suggestions as to  how should this be done=
=2E
>>>
>>>
>>> I tried the bridge approach.
>>> It worked however since having the possible rate have precompiled is =
difficult
>>> because of the wide range of possible frequency.
>>>
>>> So i have a first overlay that updates the rate and second overlay
>>> actually apply.
>>
>> IIUC, that sounds right to me.  The base overlay sets up bridges and
>> fpga regions.  The overlay after that does the programming.  That's
>> consistent with the fpga-region device tree binding documentation.
>=20
> My options were
> 1) a first overlay that updates the rate and second overlay
>  actually apply.
> 2) overlay has a pseudo clock driver that sets the rate and acts
> as a provider of clocks so that other drivers are EPROBE_DEFERED.
>=20
> Do you think I should prefer option 1)
I would prefer option too. If you want to use option 1 then still
devices in second overlay should reference clock setup in the first.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--qhzA6POgUUkfOh9gL1OFiEiy63zzWyWmN--

--aJuYWXzZt6hY83VSAPMJxLIUbFntPZpj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqNZwoACgkQykllyylKDCGG2gCfW5fTLDCMWwWIMnnxzvWI219X
2QMAn1sfYqZLWZDPzrnWyEZqirnCNkj4
=WS2e
-----END PGP SIGNATURE-----

--aJuYWXzZt6hY83VSAPMJxLIUbFntPZpj4--
