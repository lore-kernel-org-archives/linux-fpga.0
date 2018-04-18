Return-Path: <SRS0=9nAk=HH=the-dreams.de=wsa@kernel.org>
Return-Path: <SRS0=9nAk=HH=the-dreams.de=wsa@kernel.org>
Date: Wed, 18 Apr 2018 09:01:54 +0200
From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 07/20] i2c: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180418070154.mgvdb2ne7tdqyyra@ninjato>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
 <1523987360-18760-8-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="65i3mhai7gxgnaf3"
Content-Disposition: inline
In-Reply-To: <1523987360-18760-8-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--65i3mhai7gxgnaf3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 07:49:07PM +0200, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
>=20
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
>=20
> This simplifies the dependencies, and allows to improve compile-testing.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Applied to for-current, thanks!


--65i3mhai7gxgnaf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrW7V4ACgkQFA3kzBSg
KbbXkQ/6A+My2+u0mIuo0vlx8PQNM4nXpuGAjtIwhvCDZDUsVnYi3wAnpwGSSbUe
dFFkEoD6fo2xikBdF1xjwU36oCMO3VV4zdSPXKmBLQgLd+EDY1WS1sX54kYzNb2T
aqxIL8J8Uf7SNNVxg1iaPLQbakS96xLocim26fWdV+H+ggLJxthEQlZrR2LKV/m2
UHE+8NLy13Zq0+WAd9l/aX+7Lo5WZUBFAZIorLEI8v2nfWtUf3oBVBU97FxbjDwc
gEmi2qqcggS3CtaGQmHUJc6FiirvHbNGfLAI/3SzAZ2qkrcn+kJbls3LJ6wEpfvp
OHkQyujvT2QokgW/xddLqyMTl16EDiPKT2YWjP/fsgpfAZEubDCVyDt4VJ8sNMLH
Zvm5A1jU/9k3LE0dxG8fEiwW3RkD7qtsUDayY1T4BZvafjXVww+VRJZyxRVCGOqd
ohBossb6pK0difN2MbnaSeE1ykkn9sGbEot/AyQ5xfw9Mjjkm8VfBuIT/GqgIr3r
vegJZcPwC8rdJTz5qg/6lj3JuIL51OxBfuFaIpYQR6klrer9y9VSbKKuFJyAW0Y1
E4+f1d2cxaJPcuUbvfINWpyBLBHTFARdWYcE9tFxxOHBXLxgRnRKKljZZYq5yc6b
LR03w8WxaMKC4cT6mPgBHSck/LY70C5pA4k/VlOj2+MNa4cPA30=
=opRi
-----END PGP SIGNATURE-----

--65i3mhai7gxgnaf3--
