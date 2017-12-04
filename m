Return-Path: <SRS0=SxHV=DA=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=SxHV=DA=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 4 Dec 2017 08:49:01 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA
 programming
Message-ID: <20171204164901.GA29779@tyrael.ni.corp.natinst.com>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
 <CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
 <20171204165835.33824aa8@windsurf.lan>
 <CANk1AXQJwnMzoOWkOwRh0YnEGXaE26zHdiRB_SsQHxFgd=+NxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <CANk1AXQJwnMzoOWkOwRh0YnEGXaE26zHdiRB_SsQHxFgd=+NxQ@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 10:25:47AM -0600, Alan Tull wrote:
> On Mon, Dec 4, 2017 at 9:58 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Hello,
> >
> > On Mon, 4 Dec 2017 09:50:14 -0600, Alan Tull wrote:
> >
> >> Hi Thomas,
> >>
> >> The problem I see with this is that it's allowing userspace to switch
> >> out what's on the FPGA without controlling bridges and without
> >> unloading drivers first.
> >
> > Correct. Do you have an idea on how to handle this? I'm not sure there's
> > an easy way to do that, but simply preventing people from programming
> > their FPGAs seems like a rather poor solution to the problem :-)
>=20
> Yes.  It's not an easy one to solve or we would have added something
> like this by now.  There is one large patchset that is currently under
> review.
> It's called "Intel FPGA Drivers"[1] but I don't see anything Intel
> specific in it.  It's dependent on the FPGA having a base image that
> contains structures for some enumeration.  When the PR regions are
> programmed, the FPGA based hardware in those regions also have similar
> structures.  The first iteration of this is PCIe based.

The difference here is, that in Thomas' case there's no base device to
bind to, i.e. there's no base image in the FPGA the first time around.

In the Intel FPGA case there's something that connects to the bus that
the FPGA manager driver can bind to.

> Others have suggested using device tree on platforms that aren't
> normally using device tree.  If I had time I'd be experimenting with
> that.
>=20

Moritz

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlolfHoACgkQUVwKRFcJ
cNj35Qf/c38PwWe1HHC8V7dPFkpusRWOWtQ6yFb9u69qoO3YABImw5VO+AmDM2MN
4Du0mjKsKmKW3dPNPun3AuwbRi17scTTZqf0kGXQ3aiWeyoudZQz6j/Ld2Hzpa99
lDXsjfau6oXPxvStY9jDh6zuOPOEvf1SQfWRUuBwkDcNu4jVQBhX1vwsDqyc2ZzO
NCVdxG6tHiKx5aURJt200LJt1Z17y6jtiJOBlCahUDClYz2Ks6WRJY0dUb1wI1bO
ZwbATR89N2ImQktfsdTzrMNJD126EUoTnuD7ZEi0rTn+yKzr8b36zXfn/G3YdZ9u
lUGl19ehVlSdQBY9hDOEhJr6u94Hog==
=lmfi
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
