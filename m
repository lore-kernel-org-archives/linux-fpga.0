Return-Path: <SRS0=ztfD=GK=gmail.com=geert.uytterhoeven@kernel.org>
Return-Path: <SRS0=ztfD=GK=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180316212317.7d5rri3p25hpmx44@ninjato>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org> <20180316212317.7d5rri3p25hpmx44@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Mar 2018 10:57:28 +0100
Message-ID: <CAMuHMdUUKMngcyajm_s==KbhL3ZjMNHVxhNNGkPWkpnePE2rMw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
Content-Type: text/plain; charset="UTF-8"
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-ide@vger.kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, MTD Maling List <linux-mtd@lists.infradead.org>, netdev <netdev@vger.kernel.org>, linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Wolfram,

On Fri, Mar 16, 2018 at 10:23 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
>> this (drivers) series should be applied after the previous (core)
>> series (but not many people may notice/care ;-)
>
> I still don't get if there is a dependency on the core patches. I.e.
> shall I apply the subsystem patch now by myself or do you want to push
> the series after the core patch and need my ack here?

Yes, there is a dependency. Without the core patches, enabling COMPILE_TEST,
and compile-testing drivers irrelevant on obscure NO_DMA=y platforms will
cause build failures.

To play it safe, you want to postpone the subsystem patches until the core
part has landed upstream. I will rebase and resubmit after v4.17-rc1.

Thanks, and sorry for being unclear.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
