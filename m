Return-Path: <SRS0=dM/I=GG=the-dreams.de=wsa@kernel.org>
Return-Path: <SRS0=dM/I=GG=the-dreams.de=wsa@kernel.org>
Date: Fri, 16 Mar 2018 22:23:17 +0100
From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
Message-ID: <20180316212317.7d5rri3p25hpmx44@ninjato>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jn72qj2wgis6yzej"
Content-Disposition: inline
In-Reply-To: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org, linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--jn72qj2wgis6yzej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
> this (drivers) series should be applied after the previous (core)
> series (but not many people may notice/care ;-)

I still don't get if there is a dependency on the core patches. I.e.
shall I apply the subsystem patch now by myself or do you want to push
the series after the core patch and need my ack here?


--jn72qj2wgis6yzej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqsNcAACgkQFA3kzBSg
KbZoeA/+NmqFAw+9cAaOVzf/+nl/mZIFlENg9U18xEPNRmtBUBLBVqxRPuFqBhxm
XA8XO+eUOvtG3pBePwHGQbaFDdSgsvkDateYYp7yUUvssQaROgG8OT+cOyZvSLUw
x6f1R2+fPNGVC2r8ilpYr9xubYlAsT1Uc9IFJ8gKJK3xceYDxMxvlAQGYaXL8GbT
tglbckIXElRlToMLTZnS5HEau7PuQUnJkPZ4LmKND8b0JQT5Q40x7PPVo7fnwD5r
xzDhzfniBrs4XJuIaQsYwcGL7v2bnLLL7X8w2Y7mQeoVi2hRSau8KDMi56fyQq7Y
SCd4kmBCyn1R7WUzb2p4feuv4W1FJkZIFS9dJq188EhrHR07Tq18N7YLRNufyVmu
zf4q7vC/KEeUOG0agyU/DJvr4Mymef8ieC+NBq9fejxl/7Y2sIeJOC8O6MDusfH8
it0UgQpUmALewJxPfiEtMjNk4K5c+Cn2syy7gESZN8vBt0oV+7F2UvKNCzot3pMO
+TEiMPiOb4ILXKZMXpnwr3YPAwYqTuoqz5xVxvuCYICEww7Q1nHL83PTGJYGHDgm
tP5tEHSTvmviNdwk3DCIvG4vQCZiolzb8nsrxHKIheXZQiCgfVjUTK3nV/l4/0nx
q6LaetLOaZIc8CRlKpGx6WnvD0N6i+oeWeyaBIdunKLFLi/oCwY=
=65ZV
-----END PGP SIGNATURE-----

--jn72qj2wgis6yzej--
