Return-Path: <SRS0=SxHV=DA=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=SxHV=DA=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 4 Dec 2017 11:18:49 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 0/2] of: dynamic: restrict overlay by targets
Message-ID: <20171204191849.GA17574@tyrael.ni.corp.natinst.com>
References: <20171204191357.3211-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20171204191357.3211-1-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 01:13:55PM -0600, Alan Tull wrote:
> Restrict which nodes are valid targets for a DT overlay.
>=20
> Add a flag bit to struct device_node allowing nodes to be marked as
> valid target for overlays.
>=20
> A driver that is always intended to handle DT overlays can
> enable overlays by calling a function for its DT node.
>=20
> For individual nodes that need to be opened up for a specific use,
> adding the property "overlay-allowed" enables overlays targeting
> that node.  I'll need to document the DT property, not sure where
> specifically.  New file bindings/overlay.txt?
>=20
> This patchset differs from the RFC:
> * Added a flag bit and got rid of the whitelist
> * Renamed the functions that enable a node
> * Added a DT property
>=20
> Alan Tull (2):
>   of: overlay: add flag enabling overlays and enable fpga-region
>     overlays
>   of: dynamic: add overlay-allowed DT property

I think [1/2] and [2/2] are backwards order. If applied like this,
it won't work. [1/2] uses stuff that gets added in [2/2]

>=20
>  drivers/fpga/of-fpga-region.c |  4 ++++
>  drivers/of/base.c             |  4 ++--
>  drivers/of/dynamic.c          |  3 +++
>  drivers/of/fdt.c              |  3 +++
>  drivers/of/of_private.h       |  2 ++
>  drivers/of/overlay.c          | 26 ++++++++++++++++++++++++++
>  include/linux/of.h            | 19 +++++++++++++++++++
>  7 files changed, 59 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.7.4
>=20

Moritz

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAloln5YACgkQUVwKRFcJ
cNhZFQgApOJSjoRXVPUsxpjoFUDqW/LgAOh7xdE/8RIzQJCqWkGDiqx4YlUZg5H1
1bapRjr5NKZ9KiyPkgQaTxZB/GNN2D6/AiE/CjbrMUc2+ntKwsfIwwjT8dp8+RVZ
Y/Qb5OMqG1wX7QKKcU1ibXncD0Y+U5QbGFGkyh9bz+i46ZZh91VLudHj2jr699mp
aobv18yBZe3qd8+cyH8MxEfWRjEADpc2xP0Ch4OKnusv+BW32LpouQD2mEjLvQ3t
SnQvCGRz7VTrF/TAI8Vi7Jc5Paj7nK7QHfd0cLBVGubxJq9T3gvbQ9C9qgW+6VfJ
bWlG+uI1wz11cXisp+eEtVd5vf6bhQ==
=+3I5
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
