Return-Path: <SRS0=bQJH=GG=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=bQJH=GG=linuxfoundation.org=gregkh@kernel.org>
Date: Fri, 16 Mar 2018 15:34:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 20/21] staging: vc04_services: Remove depends on
 HAS_DMA in case of platform dependency
Message-ID: <20180316143439.GB29333@kroah.com>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-21-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521208314-4783-21-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org, linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 16, 2018 at 02:51:53PM +0100, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
