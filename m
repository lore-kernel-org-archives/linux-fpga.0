Return-Path: <SRS0=SzxG=GG=gmail.com=geert.uytterhoeven@kernel.org>
Return-Path: <SRS0=SzxG=GG=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180316151410.GA6527@gondor.apana.org.au>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org> <20180316151410.GA6527@gondor.apana.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Mar 2018 16:41:57 +0100
Message-ID: <CAMuHMdUKULvoB6-6EhsYpdbWEEEfjtn27GbzpXj7+Mz+=qeOnw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
Content-Type: text/plain; charset="UTF-8"
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-ide@vger.kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, MTD Maling List <linux-mtd@lists.infradead.org>, netdev <netdev@vger.kernel.org>, linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Herbert,

On Fri, Mar 16, 2018 at 4:14 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, Mar 16, 2018 at 02:51:33PM +0100, Geert Uytterhoeven wrote:
>> This patch series:
>>   - Removes dependencies on HAS_DMA for symbols that already have
>>     platform dependencies implying HAS_DMA.
>>
>> To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
>> this (drivers) series should be applied after the previous (core)
>> series (but not many people may notice/care ;-)
>>
>> Changes compared to v1:
>>   - Add Reviewed-by, Acked-by,
>>   - Drop dependency of SND_SOC_LPASS_IPQ806X on HAS_DMA,
>>   - Drop dependency of VIDEOBUF{,2}_DMA_{CONTIG,SG} on HAS_DMA,
>>   - Drop new dependencies of VIDEO_IPU3_CIO2, DVB_C8SECTPFE, and
>>     MTD_NAND_MARVELL on HAS_DMA,
>>   - Split in per-subsystem patches,
>>   - Split-off the core part in a separate series.
>>
>> This series is against v4.16-rc5. It can also be found at
>> https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=no-dma-compile-testing-v2
>>
>> It has been compile-tested with allmodconfig and allyesconfig for
>> m68k/sun3, and has received attention from the kbuild test robot.
>
> Do these patches have any dependencies? Can they be applied directly
> in a subsystem tree?

| To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
| this (drivers) series should be applied after the previous (core)
| series (but not many people may notice/care ;-)

Apart from introducing build failures in allmodconfig/allyesconfig builds on
(uncommon) NO_DMA=y platforms, they can be applied directly and individually.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
