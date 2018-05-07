Return-Path: <SRS0=o3QM=H2=gmail.com=geert.uytterhoeven@kernel.org>
Return-Path: <SRS0=o3QM=H2=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180505094743.4d201ba0@vento.lan>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
 <1523987360-18760-13-git-send-email-geert@linux-m68k.org> <20180505094743.4d201ba0@vento.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 May 2018 09:21:47 +0200
Message-ID: <CAMuHMdXp8u9O7Yt3W+WxuOOadYOM+_28DLOMfktwgy_WqML_0A@mail.gmail.com>
Subject: Re: [PATCH v3 12/20] media: Remove depends on HAS_DMA in case of
 platform dependency
Content-Type: text/plain; charset="UTF-8"
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-ide@vger.kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, MTD Maling List <linux-mtd@lists.infradead.org>, netdev <netdev@vger.kernel.org>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Mauro,

On Sat, May 5, 2018 at 2:47 PM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> Em Tue, 17 Apr 2018 19:49:12 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
>
>> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
>> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
>
> Applying a patch like that is hard, as there are lots of churn at
> the code. That's against latest media upstream:

[...]

I can rebase. What's your preferred target? media-next?

>> In most cases this other symbol is an architecture or platform specific
>> symbol, or PCI.
>>
>> Generic symbols and drivers without platform dependencies keep their
>> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
>> cannot work anyway.
>
> Actually, depends on HAS_DMA was introduced on media because builds
> were failing otherwise. We started adding it before the addition
> of COMPILE_TEST.

Indeed. Before the 5 commits below, a missing dependency on HAS_DMA
would cause the build to fail for NO_DMA platforms.

    f29ab49b5388b2f8 dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
    ab642e952f80c66c dma-coherent: Add NO_DMA dummies for managed DMA API
    c1ce6c2beea38171 mm: Add NO_DMA dummies for DMA pool API
    bff739b6559e2fce scsi: Add NO_DMA dummies for SCSI DMA mapping API
    1f674e16f9ce6eb2 usb: gadget: Add NO_DMA dummies for DMA mapping API

> Can we just remove all HAS_DMA Kconfig dependencies as a hole from the
> entire media subsystem, with something like:
>
>         $ for i in $(find drivers/media -name Kconfig) $(find drivers/staging/media -name Kconfig); do sed '/depends on HAS_DMA/d;s/ && HAS_DMA//g' -i $i; done
>
> Or would it cause build issues?

It should not cause build issues, but it would enable lots of drivers that
need DMA platform support on platforms where they wouldn't work, making the
life of distro configurators harder.

That's why my series removes HAS_DMA only for symbols that have a platform
dependency.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
