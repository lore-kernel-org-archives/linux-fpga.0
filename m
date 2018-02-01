Return-Path: <SRS0=ujza=E3=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=ujza=E3=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 1 Feb 2018 16:11:08 +0100
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v3 15/21] fpga: dfl: add fpga bridge platform driver for
 FME
Message-ID: <20180201151108.dyxzcpjagfmxgjgb@insfl13.etec.uni-karlsruhe.de>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-16-git-send-email-hao.wu@intel.com>
 <CANk1AXS-ioW2svMS3QwrQCF5TiHp_nwaongC=d2Z2MfT8BEMMw@mail.gmail.com>
 <20180201051543.GC10273@hao-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aq7qqyqrth4x3dwg"
Content-Disposition: inline
In-Reply-To: <20180201051543.GC10273@hao-dev>
To: Wu Hao <hao.wu@intel.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>
List-ID: <linux-fpga@vger.kernel.org>


--aq7qqyqrth4x3dwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hao,

On Thu, Feb 01, 2018 at 01:15:43PM +0800, Wu Hao wrote:
> On Wed, Jan 31, 2018 at 09:16:58AM -0600, Alan Tull wrote:
> > On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> >=20
> > Hi Hao,
> >=20
> > One fix below.  Besides that, please add my ack.
> >=20
> > > This patch adds fpga bridge platform driver for FPGA Management Engin=
e.
> > > It implements the enable_set call back for fpga bridge.
> > >
> > > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> >=20
> > Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> >=20
> > > diff --git a/drivers/fpga/fpga-dfl-fme-br.c b/drivers/fpga/fpga-dfl-f=
me-br.c
> > > new file mode 100644
> > > index 0000000..db2603b
> > > --- /dev/null
> > > +++ b/drivers/fpga/fpga-dfl-fme-br.c
> > > @@ -0,0 +1,87 @@
> > > +/*
> > > + * FPGA Bridge Driver for FPGA Management Engine (FME)
> > > + *
> > > + * Copyright (C) 2017 Intel Corporation, Inc.
> > > + *
> > > + * Authors:
> > > + *   Wu Hao <hao.wu@intel.com>
> > > + *   Joseph Grecco <joe.grecco@intel.com>
> > > + *   Enno Luebbers <enno.luebbers@intel.com>
> > > + *   Tim Whisonant <tim.whisonant@intel.com>
> > > + *   Ananda Ravuri <ananda.ravuri@intel.com>
> > > + *   Henry Mitchel <henry.mitchel@intel.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL version 2.
> >=20
> > If we're using the SPDX, then please get rid of the above line.
> >=20
> > > + * SPDX-License-Identifier: GPL-2.0
> > > + */
> >=20
> > The SPDX line should be the first line of the file with a // (for .c
> > files), please see:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/Documentation/process/license-rules.rst
> >=20
> > Same thing for other files.
>=20
> Thanks for the review.
>=20
> Sure, will fix this for all driver files in the next version.
>=20
> Thanks
> Hao
>=20
> >=20
> > Alan

Looks good, feel free to add my Acked-by: with fixes Alan requested,

Moritz

--aq7qqyqrth4x3dwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlpzLgcACgkQUVwKRFcJ
cNjcmQf+OkmCQynZ0YYYDWjRGrfCVrI6Sa7ULCpgQnVNZoGaOfDRQQLZ8vguOgF0
UhX9SiH7bcykBPxJV8hefpdw29/iVP3+xCVO2TFlx/7N18TYmJZIjbWmBok20kLI
WJwU875j0gcJPkAuhPjWSlz50lxrsuH+o8Wp2l42EWaWbqHCIVvZks7zbb4ofZc9
TlHPvvgS7WLLAUrT9oVI2Uz17MOe+iGl4Xr9jDnS+xJ+Pbsn3Ob+ULDpn7lc6BLS
r4HuIzSWTAE2swMMUKt7/U1JhbAUKrwYrg8SNSZP/I75PBw1xMuO43Bxav/7+WJc
vVM4BWVM1TrB/2sfXi/9D11D+9r4Jw==
=ysIw
-----END PGP SIGNATURE-----

--aq7qqyqrth4x3dwg--
