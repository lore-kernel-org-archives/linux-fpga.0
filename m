Return-Path: <mchehab+samsung@kernel.org>
Return-Path: <mchehab+samsung@kernel.org>
Date: Sat, 5 May 2018 09:47:43 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v3 12/20] media: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180505094743.4d201ba0@vento.lan>
In-Reply-To: <1523987360-18760-13-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
	<1523987360-18760-13-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Geert,

Em Tue, 17 Apr 2018 19:49:12 +0200
Geert Uytterhoeven <geert@linux-m68k.org> escreveu:

> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".

Applying a patch like that is hard, as there are lots of churn at
the code. That's against latest media upstream:

checking file drivers/media/pci/intel/ipu3/Kconfig
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED
checking file drivers/media/pci/solo6x10/Kconfig
checking file drivers/media/pci/sta2x11/Kconfig
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED
checking file drivers/media/pci/tw5864/Kconfig
checking file drivers/media/pci/tw686x/Kconfig
checking file drivers/media/platform/Kconfig
Hunk #2 FAILED at 63.
Hunk #3 succeeded at 81 (offset 1 line).
Hunk #4 succeeded at 91 (offset 1 line).
Hunk #5 succeeded at 101 (offset 1 line).
Hunk #6 succeeded at 111 (offset 1 line).
Hunk #7 succeeded at 124 (offset 1 line).
Hunk #8 succeeded at 142 (offset 1 line).
Hunk #9 succeeded at 169 (offset 1 line).
Hunk #10 succeeded at 186 (offset 1 line).
Hunk #11 succeeded at 197 (offset 1 line).
Hunk #12 succeeded at 213 (offset 1 line).
Hunk #13 succeeded at 227 (offset 1 line).
Hunk #14 succeeded at 254 (offset 1 line).
Hunk #15 succeeded at 265 (offset 1 line).
Hunk #16 succeeded at 275 (offset 1 line).
Hunk #17 succeeded at 284 (offset 1 line).
Hunk #18 succeeded at 295 (offset 1 line).
Hunk #19 succeeded at 303 (offset 1 line).
Hunk #20 succeeded at 312 (offset 1 line).
Hunk #21 succeeded at 338 (offset 1 line).
Hunk #22 succeeded at 383 (offset 1 line).
Hunk #23 succeeded at 397 (offset 1 line).
Hunk #24 succeeded at 422 (offset 1 line).
Hunk #25 succeeded at 435 (offset 1 line).
Hunk #26 succeeded at 452 (offset 1 line).
Hunk #27 succeeded at 470 (offset 1 line).
Hunk #28 succeeded at 612 (offset 1 line).
1 out of 28 hunks FAILED

> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.

Actually, depends on HAS_DMA was introduced on media because builds
were failing otherwise. We started adding it before the addition 
of COMPILE_TEST.

Can we just remove all HAS_DMA Kconfig dependencies as a hole from the
entire media subsystem, with something like:

	$ for i in $(find drivers/media -name Kconfig) $(find drivers/staging/media -name Kconfig); do sed '/depends on HAS_DMA/d;s/ && HAS_DMA//g' -i $i; done

Or would it cause build issues?

Regards,
Mauro




Thanks,
Mauro
