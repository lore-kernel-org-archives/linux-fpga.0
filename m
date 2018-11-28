Return-Path: <SRS0=gEQ3=OH=sirena.org.uk=broonie@kernel.org>
Return-Path: <SRS0=gEQ3=OH=sirena.org.uk=broonie@kernel.org>
Date: Wed, 28 Nov 2018 09:14:40 +0000
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: add FTDI MPSSE SPI controller driver
Message-ID: <20181128091439.GA6828@sirena.org.uk>
References: <20181120002821.12794-1-agust@denx.de>
 <20181120002821.12794-3-agust@denx.de>
 <20181121124237.GC8059@sirena.org.uk>
 <20181127012127.24e455b6@crub>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20181127012127.24e455b6@crub>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 01:21:27AM +0100, Anatolij Gustschin wrote:
> Mark Brown broonie@kernel.org wrote:

> >> +	if (max_cs > 12) {
> >> +		dev_err(dev, "Invalid max CS in platform data: %d\n", max_cs);
> >> +		return -EINVAL;
> >> +	}
> >> +	dev_dbg(dev, "CS count %d, max CS %d\n", num_cs, max_cs);
> >> +	max_cs +=3D 1; /* including CS0 */ =20

> >Why not just size the array based on the platform data?

> The driver must also support multiple SPI slaves with additional control
> pins (besides SPI chip-select gpios). There are devices with not adjacent
> chip-select gpios or devices with single chip-select gpio starting at
> some offset. The array size is not always the number of chip-selects
> or the max. chip-select, e.g.:

A few unused entries really won't matter.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+XH0ACgkQJNaLcl1U
h9BN6Qf8Cf8z9g7M2CSYTvbGRDLuKh4WWK/9Bj96Cg/lOX0H+++0glbKaXR9LZdW
C3Kq93XpWg+pjvDcHSP1OEOgeG4nXIiunOIgIUTALoTqhYVxDy+XnHF2cYgz5epK
y4BBtFVsUbA0WxN0YjEGoPRc8R2Mx/duLdpeRw2O1RvGLxZYaPYNAd5WZnoahP0c
zjoUB0uH+H12whUSCHQuky6IEOGC2/VkKNF6zZ4sMaFaAYV94VGp5ZWYvzHrjoJg
R8d+RKvq4vuobYgmvclOk+pKI5hr9PY2wkZ/539VoPtn6kMFDshiWeWXEQNr9AVf
mDfS4RQOzpO6S1CfGm7XQKcqzzNrkg==
=i8pS
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
