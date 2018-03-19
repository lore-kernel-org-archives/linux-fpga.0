Return-Path: <SRS0=Nsqs=GJ=sirena.org.uk=broonie@kernel.org>
Return-Path: <SRS0=Nsqs=GJ=sirena.org.uk=broonie@kernel.org>
Date: Sun, 18 Mar 2018 17:54:11 -0700
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/21] ASoC: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180319005411.GY2186@sirena.org.uk>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-2-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oWEYV0WmY9Kcrzh0"
Content-Disposition: inline
In-Reply-To: <1521208314-4783-2-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org, linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--oWEYV0WmY9Kcrzh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2018 at 02:51:34PM +0100, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.

Acked-by: Mark Brown <broonie@kernel.org>

Thanks again for doing this work, it's really good to see!

--oWEYV0WmY9Kcrzh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqvCjIACgkQJNaLcl1U
h9CLbQf/Tg+dhuRMVvi1udWCp1BJUGB8Vd88otJVfjSSf1BIoBvw4XV7xrP7HUJH
V98MDQfrlLGW8qtZFHhsjmz4+NsOu9t5y7+2UjwDXtoq/dZT9TmgxeJc7lwl3zZS
qaIe8HYUK8KmKWhwDW/YJbYX7oUSO+G6SZvUOVVq7UFU03iCATTKU8/N4+Ckixxb
QzTdPkgsvrz2xVe5SjvUWJPTZ0Jl4b8WsLE3+i65FYqhlyiWQqTxyEtNRlbfUtKq
tcPXSUwsstpVqf3fsRI4n50J0xynVIeoIT9urJ0ZXjlgjg0r5jFkxYuXByUax8xw
XbixoPLIKcJ26u2e3uGs+EZnaQ0iCw==
=p8oA
-----END PGP SIGNATURE-----

--oWEYV0WmY9Kcrzh0--
