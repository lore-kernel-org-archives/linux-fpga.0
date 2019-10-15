Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52530 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfJOJ0D (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Oct 2019 05:26:03 -0400
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
Date: Tue, 15 Oct 2019 11:25:53 +0200
MIME-Version: 1.0
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xhqojG6Suv0J68B6aAC9CpKobUD0Yg8Vm"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Tim.Bird@sony.com, jani.nikula@linux.intel.com, changbin.du@gmail.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, intel-gfx@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xhqojG6Suv0J68B6aAC9CpKobUD0Yg8Vm
Content-Type: multipart/mixed; boundary="e6U1SKLtu8YetFMprVb1L54zX2NmQYBjI";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tim.Bird@sony.com, jani.nikula@linux.intel.com, changbin.du@gmail.com,
 corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Message-ID: <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>

--e6U1SKLtu8YetFMprVb1L54zX2NmQYBjI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 14.10.19 um 22:48 schrieb Tim.Bird@sony.com:
>=20
>=20
>> -----Original Message-----
>> From: Jani Nikula on October 13, 2019 11:00 PM
>> On Sun, 13 Oct 2019, Changbin Du <changbin.du@gmail.com> wrote:
>>> The 'functions' directive is not only for functions, but also works f=
or
>>> structs/unions. So the name is misleading. This patch renames it to
>>> 'specific', so now we have export/internal/specific directives to lim=
it
>>> the functions/types to be included in documentation. Meanwhile we
>> improved
>>> the warning message.
>>
>> Agreed on "functions" being less than perfect. It directly exposes the=

>> idiosyncrasies of scripts/kernel-doc. I'm not sure "specific" is any
>> better, though.
>=20
> I strongly agree with this.  'specific' IMHO, has no semantic value and=

> I'd rather just leave the only-sometimes-wrong 'functions' than convert=

> to something that obscures the meaning always.
>=20
>>
>> Perhaps "symbols" would be more self-explanatory. Or, actually make
>> "functions" only work on functions, and add a separate keyword for oth=
er
>> stuff. *shrug*
> My preference would be to use 'symbols'.  I tried to come up with somet=
hing
> but 'symbols' is better than anything I came up with.

Maybe 'interfaces' or 'artifacts'. The term 'symbols' is just as
imprecise as 'functions'.

Best regards
Thomas

>>
>> Seems like the patch is way too big. I'd probably add "symbols" (or
>> whatever) as a synonym for "functions" for starters, and convert
>> documents piecemeal, and finally drop the old one.
>>
>> The scripts/kernel-doc change should be a patch of its own.
> Agreed on these two points as well.
>=20
> Just adding my 2 cents.
>  -- Tim
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--e6U1SKLtu8YetFMprVb1L54zX2NmQYBjI--

--xhqojG6Suv0J68B6aAC9CpKobUD0Yg8Vm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl2lkKUACgkQaA3BHVML
eiPfCAf/W0bkytCWyMq99ercABUIKnlOK53TBUZ9NR3Teor0EJtwx1giKdxBOLbe
qAjTTABU3EcEtmCxmmsKLUEyDrBEmK+/T4YDbASwYt9qSRZQ5rJXRY7RrTsiIfkF
TWYe27RbVMt7Vn4UC1f1FsShMPxv6fIrpyNoXtB8cCE/aFSLpdPafv0zNxvHFBe+
SnDdVv+dR767Yhm8etpDlgpFtAD03PTH4hN+ZD9dLD/qgJh7NQiI1zyirt2ns6kv
2RhyIDmEVltSEhgVDCMg+LOZG41UNmIqpjgNEUF1ReeJeYX3MecovgE4mdzYA4TD
7q4r9GeyLGeoqsEUu0A4mGRY+ZBZ8g==
=b8IK
-----END PGP SIGNATURE-----

--xhqojG6Suv0J68B6aAC9CpKobUD0Yg8Vm--
