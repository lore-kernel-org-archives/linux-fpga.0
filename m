Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <201804030128.83Wu99al%fengguang.wu@intel.com>
References: <1522682026-11395-3-git-send-email-p.pisati@gmail.com> <201804030128.83Wu99al%fengguang.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 2 Apr 2018 13:25:31 -0500
Message-ID: <CANk1AXQ7hLLDoY0JLwsP1kQbkbd9diyDDcZtzYN4E8sFcQ=AKg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
Content-Type: text/plain; charset="UTF-8"
To: kbuild test robot <lkp@intel.com>
Cc: Paolo Pisati <p.pisati@gmail.com>, kbuild-all@01.org, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Apr 2, 2018 at 12:43 PM, kbuild test robot <lkp@intel.com> wrote:

This is complaining because Paolo's patch was rebased onto a branch
that had an API change.

Alan

> Hi Paolo,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16 next-20180329]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Paolo-Pisati/fpga-Lattice-MachXO2-Slave-SPI-FPGA-Manager-support/20180403-000300
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All error/warnings (new ones prefixed by >>):
>
>    drivers/fpga/machxo2-spi.c: In function 'machxo2_spi_probe':
>>> drivers/fpga/machxo2-spi.c:361:5: error: 'struct fpga_manager' has no member named 'parent'
>      mgr->parent = dev;
>         ^~
>>> drivers/fpga/machxo2-spi.c:367:27: error: passing argument 1 of 'fpga_mgr_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      return fpga_mgr_register(mgr);
>                               ^~~
>    In file included from drivers/fpga/machxo2-spi.c:12:0:
>    include/linux/fpga/fpga-mgr.h:173:5: note: expected 'struct device *' but argument is of type 'struct fpga_manager *'
>     int fpga_mgr_register(struct device *dev, const char *name,
>         ^~~~~~~~~~~~~~~~~
>>> drivers/fpga/machxo2-spi.c:367:9: error: too few arguments to function 'fpga_mgr_register'
>      return fpga_mgr_register(mgr);
>             ^~~~~~~~~~~~~~~~~
>    In file included from drivers/fpga/machxo2-spi.c:12:0:
>    include/linux/fpga/fpga-mgr.h:173:5: note: declared here
>     int fpga_mgr_register(struct device *dev, const char *name,
>         ^~~~~~~~~~~~~~~~~
>    drivers/fpga/machxo2-spi.c: In function 'machxo2_spi_remove':
>>> drivers/fpga/machxo2-spi.c:374:22: error: passing argument 1 of 'fpga_mgr_unregister' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      fpga_mgr_unregister(mgr);
>                          ^~~
>    In file included from drivers/fpga/machxo2-spi.c:12:0:
>    include/linux/fpga/fpga-mgr.h:176:6: note: expected 'struct device *' but argument is of type 'struct fpga_manager *'
>     void fpga_mgr_unregister(struct device *dev);
>          ^~~~~~~~~~~~~~~~~~~
>    drivers/fpga/machxo2-spi.c: In function 'machxo2_spi_probe':
>>> drivers/fpga/machxo2-spi.c:368:1: warning: control reaches end of non-void function [-Wreturn-type]
>     }
>     ^
>    cc1: some warnings being treated as errors
>
> vim +361 drivers/fpga/machxo2-spi.c
>
>    346
>    347  static int machxo2_spi_probe(struct spi_device *spi)
>    348  {
>    349          struct device *dev = &spi->dev;
>    350          struct fpga_manager *mgr;
>    351
>    352          if (spi->max_speed_hz > MACHXO2_MAX_SPEED) {
>    353                  dev_err(dev, "Speed is too high\n");
>    354                  return -EINVAL;
>    355          }
>    356
>    357          mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
>    358          if (!mgr)
>    359                  return -ENOMEM;
>    360
>  > 361          mgr->parent = dev;
>    362          mgr->name = "Lattice MachXO2 SPI FPGA Manager";
>    363          mgr->mops = &machxo2_ops;
>    364          mgr->priv = spi;
>    365          spi_set_drvdata(spi, mgr);
>    366
>  > 367          return fpga_mgr_register(mgr);
>  > 368  }
>    369
>    370  static int machxo2_spi_remove(struct spi_device *spi)
>    371  {
>    372          struct fpga_manager *mgr = spi_get_drvdata(spi);
>    373
>  > 374          fpga_mgr_unregister(mgr);
>    375
>    376          return 0;
>    377  }
>    378
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
