Return-Path: <SRS0=eejo=GJ=linaro.org=ulf.hansson@kernel.org>
Return-Path: <SRS0=eejo=GJ=linaro.org=ulf.hansson@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1521208314-4783-14-git-send-email-geert@linux-m68k.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org> <1521208314-4783-14-git-send-email-geert@linux-m68k.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 Mar 2018 04:08:43 +0100
Message-ID: <CAPDyKFpPEQJLOv+i8yBEPkAiPG9QhjGGvyYSawPxRVShayznvw@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] mmc: Remove depends on HAS_DMA in case of
 platform dependency
Content-Type: text/plain; charset="UTF-8"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org, Linux USB List <linux-usb@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, alsa-devel@alsa-project.org, linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-block <linux-block@vger.kernel.org>, linux-media@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, driverdevel <devel@driverdev.osuosl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On 16 March 2018 at 14:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/mmc/host/Kconfig | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 620c2d90a646f387..f6d43348b4a3e5d4 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -358,7 +358,6 @@ config MMC_MESON_MX_SDIO
>         tristate "Amlogic Meson6/Meson8/Meson8b SD/MMC Host Controller support"
>         depends on ARCH_MESON || COMPILE_TEST
>         depends on COMMON_CLK
> -       depends on HAS_DMA
>         depends on OF
>         help
>           This selects support for the SD/MMC Host Controller on
> @@ -401,7 +400,6 @@ config MMC_OMAP
>
>  config MMC_OMAP_HS
>         tristate "TI OMAP High Speed Multimedia Card Interface support"
> -       depends on HAS_DMA
>         depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
>         help
>           This selects the TI OMAP High Speed Multimedia card Interface.
> @@ -511,7 +509,6 @@ config MMC_DAVINCI
>
>  config MMC_GOLDFISH
>         tristate "goldfish qemu Multimedia Card Interface support"
> -       depends on HAS_DMA
>         depends on GOLDFISH || COMPILE_TEST
>         help
>           This selects the Goldfish Multimedia card Interface emulation
> @@ -605,7 +602,7 @@ config MMC_SDHI
>
>  config MMC_SDHI_SYS_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
> -       depends on MMC_SDHI && HAS_DMA
> +       depends on MMC_SDHI
>         default MMC_SDHI if (SUPERH || ARM)
>         help
>           This provides DMA support for SDHI SD/SDIO controllers
> @@ -615,7 +612,7 @@ config MMC_SDHI_SYS_DMAC
>  config MMC_SDHI_INTERNAL_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
>         depends on ARM64 || COMPILE_TEST
> -       depends on MMC_SDHI && HAS_DMA
> +       depends on MMC_SDHI
>         default MMC_SDHI if ARM64
>         help
>           This provides DMA support for SDHI SD/SDIO controllers
> @@ -688,7 +685,6 @@ config MMC_CAVIUM_THUNDERX
>
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
> -       depends on HAS_DMA
>         depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
> @@ -758,7 +754,6 @@ config MMC_DW_ZX
>
>  config MMC_SH_MMCIF
>         tristate "SuperH Internal MMCIF support"
> -       depends on HAS_DMA
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>         help
>           This selects the MMC Host Interface controller (MMCIF) found in various
> @@ -878,7 +873,6 @@ config MMC_TOSHIBA_PCI
>  config MMC_BCM2835
>         tristate "Broadcom BCM2835 SDHOST MMC Controller support"
>         depends on ARCH_BCM2835 || COMPILE_TEST
> -       depends on HAS_DMA
>         help
>           This selects the BCM2835 SDHOST MMC controller. If you have
>           a BCM2835 platform with SD or MMC devices, say Y or M here.
> --
> 2.7.4
>
