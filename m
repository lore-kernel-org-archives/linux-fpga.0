Return-Path: <SRS0=h2Xi=HG=gmail.com=geert.uytterhoeven@kernel.org>
Return-Path: <SRS0=h2Xi=HG=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAL_JsqJMppYaz31Gg8BH2OaAxs56dnjZ4y+nzBBp-Tt2odaqCw@mail.gmail.com>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org> <CAL_JsqJMppYaz31Gg8BH2OaAxs56dnjZ4y+nzBBp-Tt2odaqCw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Apr 2018 19:48:01 +0200
Message-ID: <CAMuHMdUrLW7gdsUfKQ5FHBHh1t5ecYBSy-6ZKxPSJoP6TQzXvw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
Content-Type: text/plain; charset="UTF-8"
To: Rob Herring <robherring2@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux USB List <linux-usb@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-ide@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, MTD Maling List <linux-mtd@lists.infradead.org>, netdev <netdev@vger.kernel.org>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Rob,

On Thu, Apr 5, 2018 at 2:32 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Mar 16, 2018 at 8:51 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> If NO_DMA=y, get_dma_ops() returns a reference to the non-existing
>> symbol bad_dma_ops, thus causing a link failure if it is ever used.
>>
>> The intention of this is twofold:
>>   1. To catch users of the DMA API on systems that do no support the DMA
>>      mapping API,
>>   2. To avoid building drivers that cannot work on such systems anyway.
>>
>> However, the disadvantage is that we have to keep on adding dependencies
>> on HAS_DMA all over the place.
>>
>> Thanks to the COMPILE_TEST symbol, lots of drivers now depend on one or
>> more platform dependencies (that imply HAS_DMA) || COMPILE_TEST, thus
>> already covering intention #2.  Having to add an explicit dependency on
>> HAS_DMA here is cumbersome, and hinders compile-testing.
>
> The same can be said for CONFIG_IOMEM and CONFIG_OF. Any plans to
> remove those too? CONFIG_IOMEM is mostly just a !CONFIG_UM option.

Perhaps, if time permits...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
