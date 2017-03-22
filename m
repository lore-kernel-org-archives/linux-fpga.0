Return-Path: <moritz.fischer.private@gmail.com>
Date: Wed, 22 Mar 2017 14:17:07 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [RFC] Add a parser in fpga_region to decode the tlv meta data
 suggested by Sundar
Message-ID: <20170322211707.GA30167@tyrael.amer.corp.natinst.com>
References: <20170320225514.GA22059@obsidianresearch.com>
 <CAAtXAHcFCXzOXMTyAkQQCAdTnoJXOsF1nDectdC10o1KSXtscQ@mail.gmail.com>
 <CANk1AXSJ_ije8cebi88ULkonRhtGi+75=x1DxwCbMcLZZcdLww@mail.gmail.com>
 <CAAtXAHe8paePE+kkOPv-pWWQzUTVeihQSMzdECUWi1FN6XGytw@mail.gmail.com>
 <CANk1AXQHeyM74DiY3Dz4ex0rB6BBUgRFLdPmxrKh_=GTSL+xkg@mail.gmail.com>
 <CANk1AXQC_F4dSSBO1Prkui=e7zRONtyDaUx6_8CQ3-C7cgWESA@mail.gmail.com>
 <CANk1AXR_Q9dFRAPn_+EuxFT8m8+Q1jsezYpvMeLBEc-g33betw@mail.gmail.com>
 <CANk1AXSo8fbtbSWVhnneZcGML9+Sus76_SVMSDMmeL+EHAhppA@mail.gmail.com>
 <CAAtXAHcwfUiQseLgt287vBvtuKnbCnTOJxWd_ZwJ7vmN1KP17A@mail.gmail.com>
 <CANk1AXRMGTrk5JUU_tKuZFVBiMbn4-1kQ0SajMYuPFYnjvMWVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <CANk1AXRMGTrk5JUU_tKuZFVBiMbn4-1kQ0SajMYuPFYnjvMWVA@mail.gmail.com>
To: Alan Tull <delicious.quinoa@gmail.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, "Li, Yi" <yi1.li@linux.intel.com>, "Nadathur, Sundar" <sundar.nadathur@intel.com>, linux-fpga@vger.kernel.org, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
List-ID: <linux-fpga@vger.kernel.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 03:13:39PM -0500, Alan Tull wrote:
> On Wed, Mar 22, 2017 at 1:33 AM, Moritz Fischer
> <moritz.fischer@ettus.com> wrote:

> > It doesn't have to be exactly FIT, but it serves a very similar purpose,
> > so I'll definitely spend some more time on studying how that works.
> > What you describe above seems to 'fit' (pun intended) very well with
> > what the U-Boot guys do with FIT already (multiple images, configuratio=
ns
> > etc) there's definitely code there that we can reuse.
>=20
> Bringing all of FIT to the kernel would be a large project (and
> wouldn't belong in drivers/fpga).  But as your  experimentation
> demonstrated, parsing our own thing with existing support in the
> kernel or libfdt would be pretty easy.

Possibly, yeah.

> > The one thing that would be interesting for our use case might be the
> > non-contiguous header case which I assume 1. and 2. are meant to deal w=
ith?
>=20
> Yes non-contiguous cases and streaming cases.
>=20
> 1. is the file magic (4 bytes) 2. is header size (4 bytes).  The
> parser code will check the magic, get the header size, then gather
> enough additional non-contiguous/streaming header into a buffer to
> parse it.  Having parsed it, it will have offsets to the bitfiles and
> other header info.

I think again fdt got us covered ([1]) there :-) There's a magic and a
totalsize member:

<snip>
struct fdt_header {
        fdt32_t magic;                   /* magic word FDT_MAGIC */
        fdt32_t totalsize;               /* total size of DT block
</snip>

Cheers,

Moritz

[1] http://lxr.free-electrons.com/source/scripts/dtc/libfdt/fdt.h#L57

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0unQAAoJEL5CEHepFqovcR8IAJm6OLN6rV8TtYIjoclGPVZc
xXjyfIe8G91dZbpgj3+XaDiCurkxXdws+0MfspkVshg263rWCta1AMEbtDo+3Pvs
kZpqqsA2ooJMHnjiHcKKo5HL5Ewlu5qQ9WAXOUo7hCHiEVSvI4C5Zk3QJcXFPheP
bXXKfcJUTZYC/VYdWVyRo+fjFwfFYRiXWhI2ktv6pPikmDkyb7A7IlR+lxeboOA7
XlSOYfGafDeJrJrdt7sIitofedE3yFnjDTEC67T/DXmWbLhJDaNWGTYCX5R/7R1S
zZHGGtoHYvnucaBJgi5sfxQ+nj5N3K1igz9X2FcKDM8zaf5+Ep6ERGCoSP4892w=
=lRgg
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
