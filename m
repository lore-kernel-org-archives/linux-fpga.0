Return-Path: <SRS0=klg8=NU=sirena.org.uk=broonie@kernel.org>
Return-Path: <SRS0=klg8=NU=sirena.org.uk=broonie@kernel.org>
Date: Fri, 9 Nov 2018 15:30:26 +0000
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: add FTDI MPSSE SPI controller driver
Message-ID: <20181109153026.GA7734@sirena.org.uk>
References: <20181105161913.27538-3-agust@denx.de>
 <20181109075356.19229-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20181109075356.19229-1-agust@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09, 2018 at 08:53:56AM +0100, Anatolij Gustschin wrote:
> Add SPI bus controller driver for FTDI MPSSE mode. This driver
> is supposed to be used together with the FT232H interface driver
> for FPGA configuration in drivers/usb/misc/ft232h-intf.c which
> adds an mpsse spi platform device describing USB SPI bus with
> attached SPI slave devices.

I don't have the rest of this series or a cover letter - what's the
story with dependencies?

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvlp/QACgkQJNaLcl1U
h9Axigf/VervD3QHtFsC4pz9OgPlvUInPERqVb2RS0cOEybaSM5bQz1flT6qqt0+
JWbCOKqW1CrO8XJ4mNzFuJfQ/ThXudIU53ORZDDY3dSzy57Sd2UY1I+CD5rPs/I0
C8ylLu1GMfBGvm/JnThGQie+jvcjnnFxxyw5IqH9IYPLBI6CskJqfwaf3nwtBpLF
8JgntJ/YQEhNCRWURoiI5cNiAECvBuX5asKDz4KBFwUAhNgdNGJ3yZ7V87kqD9Zt
gatV0NZuEat7gwU0dpt4+/2IjuA9KvB6H766cZuS2dILtnr8l9H0StalrXPrvC7z
Thu4Rx+CZPaLw3gSI4HZVsw6vGjUOw==
=Gvom
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
