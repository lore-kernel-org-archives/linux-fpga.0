Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJOMII (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Oct 2019 08:08:08 -0400
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
 <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
 <20191015115439.GE32665@bombadil.infradead.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <f4157a18-6c2e-9854-40a2-dd78c9bde5ea@suse.de>
Date: Tue, 15 Oct 2019 14:08:04 +0200
MIME-Version: 1.0
In-Reply-To: <20191015115439.GE32665@bombadil.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xXjpgUbLDdBAUlDObA57HUQXDHzBsVHcH"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Tim.Bird@sony.com, jani.nikula@linux.intel.com, changbin.du@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, intel-gfx@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xXjpgUbLDdBAUlDObA57HUQXDHzBsVHcH
Content-Type: multipart/mixed; boundary="z434XuCeAEdMMPGCrDECpwMF4D7beqFx1";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Tim.Bird@sony.com, jani.nikula@linux.intel.com, changbin.du@gmail.com,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Message-ID: <f4157a18-6c2e-9854-40a2-dd78c9bde5ea@suse.de>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
 <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
 <20191015115439.GE32665@bombadil.infradead.org>
In-Reply-To: <20191015115439.GE32665@bombadil.infradead.org>

--z434XuCeAEdMMPGCrDECpwMF4D7beqFx1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 15.10.19 um 13:54 schrieb Matthew Wilcox:
> On Tue, Oct 15, 2019 at 11:25:53AM +0200, Thomas Zimmermann wrote:
>>> My preference would be to use 'symbols'.  I tried to come up with som=
ething
>>> but 'symbols' is better than anything I came up with.
>>
>> Maybe 'interfaces' or 'artifacts'. The term 'symbols' is just as
>> imprecise as 'functions'.
>=20
> I suggested 'identifier' because that's the term used in the C spec (6.=
2.1):
>=20
> : An identifier can denote an object; a function; a tag or a member
> : of a structure, union, or enumeration; a typedef name; a label name;
> : a macro name; or a macro parameter.
>=20
> We don't allow documenting all those things separately, but it does cov=
er
> all the things we do allow to be individually documented.
>=20

Yeah, makes sense.

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--z434XuCeAEdMMPGCrDECpwMF4D7beqFx1--

--xXjpgUbLDdBAUlDObA57HUQXDHzBsVHcH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl2ltqUACgkQaA3BHVML
eiO7bAf8DqpVa41x8h+LyR771/7XD6R9SM1oSqopIn1EaGndzepL2obOpvv7TM8J
xdFUMac1FMD7pBfjtTfs6Ax/+KSIBGMJQxiiiGhsZ2Z9RXIiNMJpVV0pFwkEBCic
Xwxmem2Hn+LhB98tlmtb1rUid5ZEWIqxJn0HEfOht/Y7iu+RZUfVre1GHP2W5OG+
KSJSTG5ZwTIBzXvMS++NOh0kJWyzTiKY7Gaxl0ck76UKp34bdsTqFNVlOqNgfdiW
tEmx0i6R/9ZZp3HGgsbN7waSqxjcYWI4M8sPApl7aPDDpTZC2ydWX1J5qzmp9/LF
uRn+WrOCEMHCMSPfYsv/311cYx9oLw==
=fbgk
-----END PGP SIGNATURE-----

--xXjpgUbLDdBAUlDObA57HUQXDHzBsVHcH--
