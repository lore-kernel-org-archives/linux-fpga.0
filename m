Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU-0VOs6MYrCaCrtRfBqGgaQfox1AgbExNNcYxVC6Uh-Q@mail.gmail.com>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-7-git-send-email-geert@linux-m68k.org> <CANk1AXR3sv2=G-KsQh1p0rdcvy-3XZs6qVy5EMbcAMS6OSVzeQ@mail.gmail.com>
 <CAMuHMdU-0VOs6MYrCaCrtRfBqGgaQfox1AgbExNNcYxVC6Uh-Q@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 20 Mar 2018 13:20:11 -0500
Message-ID: <CANk1AXRve3asPTufFYe=C_YPfyGwDpXxOWYZbWDq2bAnVkj00A@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] fpga: Remove depends on HAS_DMA in case of
 platform dependency
Content-Type: text/plain; charset="UTF-8"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-ide@vger.kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>, linux-iio@vger.kernel.org, linux-block@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, MTD Maling List <linux-mtd@lists.infradead.org>, netdev <netdev@vger.kernel.org>, linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Mar 20, 2018 at 5:04 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

Hi Geert,

> Hi Alan,
>
> On Mon, Mar 19, 2018 at 5:06 PM, Alan Tull <atull@kernel.org> wrote:
>> On Fri, Mar 16, 2018 at 8:51 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> This essentially removes this commit
>>
>> commit 1c8cb409491403036919dd1c6b45013dc8835a44
>> Author: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>> Date:   Wed Aug 3 13:45:46 2016 -0700
>>
>>     drivers/fpga/Kconfig: fix build failure
>>
>>     While building m32r allmodconfig the build is failing with the error:
>>
>>       ERROR: "bad_dma_ops" [drivers/fpga/zynq-fpga.ko] undefined!
>>
>>     Xilinx Zynq FPGA is using DMA but there was no dependency while
>>     building.
>>
>>     Link: http://lkml.kernel.org/r/1464346526-13913-1-git-send-email-sudipm.mukherjee@gmail.com
>>     Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>>     Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
>>     Cc: Alan Tull <atull@opensource.altera.com>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> Yes it does. The major change is that the first (core) series introduces
> all needed dummies to do successful compile-testing on NO_DMA=y platforms.

OK yes, I looked at the first patch that does the fix.  Looks good.
Thanks for doing this.

>
>>> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
>>> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
>>> In most cases this other symbol is an architecture or platform specific
>>> symbol, or PCI.
>>>
>>> Generic symbols and drivers without platform dependencies keep their
>>> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
>>> cannot work anyway.
>>>
>>> This simplifies the dependencies, and allows to improve compile-testing.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Reviewed-by: Mark Brown <broonie@kernel.org>
>>> Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Alan Tull <atull@kernel.org>

Regards,
Alan

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
