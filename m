Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2019 13:56:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/7] drivers: Add generic device lookup helpers
Message-ID: <20190730115643.GA21672@kroah.com>
References: <20190723221838.12024-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723221838.12024-1-suzuki.poulose@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, linux-arm-kernel@lists.infradead.org, Alan Tull <atull@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexander Aring <alex.aring@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Vetter <daniel@ffwll.ch>, Dan Murphy <dmurphy@ti.com>, David Airlie <airlied@linux.ie>, "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, Doug Ledford <dledford@redhat.com>, dri-devel@lists.freedesktop.org, Elie Morisse <syniurge@gmail.com>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Frank Rowand <frowand.list@gmail.com>, Harald Freudenberger <freude@linux.ibm.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Heiner Kallweit <hkallweit1@gmail.com>, Inki Dae <inki.dae@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>, Joerg Roedel <joro@8bytes.org>, Lee Jones <lee.jones@linaro.org>, Len Brown <lenb@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-leds@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Mark Brown <broonie@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Moritz Fischer <mdf@kernel.org>, Nehal Shah <nehal-bakulchandra.shah@amd.com>, Oliver Neukum <oneukum@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Oberparleiter <oberpar@linux.ibm.com>, Peter Rosin <peda@axentia.se>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sandy Huang <hjc@rock-chips.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Seung-Woo Kim <sw0312.kim@samsung.com>, Shyam Sundar S K <shyam-sundar.s-k@amd.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Takashi Iwai <tiwai@suse.com>, Thor Thayer <thor.thayer@linux.intel.com>, Tomas Winkler <tomas.winkler@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Will Deacon <will.deacon@arm.com>, Wolfram Sang <wsa@the-dreams.de>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jul 23, 2019 at 11:18:31PM +0100, Suzuki K Poulose wrote:
> We have device iterators to find a particular device matching a criteria
> for a given bus/class/driver. i.e, {bus,class,driver}_find_device()
> APIs. The matching criteria is a function pointer for the APIs. Often the
> lookup is based on a generic property of a device (e.g, name, fwnode, of node
> pointer or device type) rather than a driver specific information. However, each
> driver writes up its own "match" function, spilling the similar match functions
> all over the driver subsystems.
> 
> This series adds device match helpers by generic device properties of a device.
> Using these generic match functions, introduce wrappers to the existing
>  *_find_device() helpers and converts the existing users to use the new wrappers.
>  i.e,
> 	{bus/class/driver}_find_device_by_name()
> 	{bus/class/driver}_find_device_by_fwnode()
> 	{bus/class/driver}_find_device_by_devt()
> 	{bus/class/driver}_find_device_by_acpi_dev()
> 
> Also adds a wrapper for finding a platform device by driver, to avoid
> spilling the platform_bus internals in the individual drivers. Applies
> on 5.3-rc1.
> 
>    [0] git://linux-arm.org/linux-skp.git driver-cleanup/v3
> RFC[1] https://marc.info/?i=1559577023-558-1-git-send-email-suzuki.poulose@arm.com
> V1 [2] https://marc.info/?i=1559747630-28065-1-git-send-email-suzuki.poulose@arm.com
> V2 [3] https://marc.info/?i=1560534863-15115-1-git-send-email-suzuki.poulose@arm.com

There is now a persistent tag/branch in my driver-core tree for any
subsystem that wants to pull this tree in to make it easier for merges:


The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/generic_lookup_helpers

for you to fetch changes up to 36f3313d6bff91ab2a9e47698c27d15363640a4e:

  platform: Add platform_find_device_by_driver() helper (2019-07-30 13:07:42 +0200)

----------------------------------------------------------------
Generic Device Lookup Helpers

Persistent tag for others to pull this branch from

Based on patch series from Suzuki K Poulose <suzuki.poulose@arm.com>
with Subject: [PATCH v3 0/7] drivers: Add generic device lookup helpers

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Suzuki K Poulose (7):
      drivers: Introduce device lookup variants by name
      drivers: Introduce device lookup variants by of_node
      drivers: Introduce device lookup variants by fwnode
      drivers: Introduce device lookup variants by device type
      drivers: Introduce device lookup variants by ACPI_COMPANION device
      drivers: Add generic helper to match any device
      platform: Add platform_find_device_by_driver() helper

 drivers/amba/tegra-ahb.c                           |  11 +-
 drivers/base/bus.c                                 |  24 ---
 drivers/base/core.c                                |  39 +++-
 drivers/base/devcon.c                              |   8 +-
 drivers/base/platform.c                            |  14 ++
 drivers/fpga/fpga-bridge.c                         |   8 +-
 drivers/fpga/fpga-mgr.c                            |   8 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   7 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   9 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |   3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   3 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |   3 +-
 drivers/hwtracing/coresight/coresight-platform.c   |  11 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   2 -
 drivers/hwtracing/coresight/coresight.c            |   4 +-
 drivers/hwtracing/intel_th/core.c                  |  10 +-
 drivers/hwtracing/stm/core.c                       |   9 +-
 drivers/i2c/busses/i2c-amd-mp2-pci.c               |   8 +-
 drivers/i2c/i2c-core-acpi.c                        |  11 +-
 drivers/i2c/i2c-core-of.c                          |   7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   8 +-
 drivers/iommu/arm-smmu-v3.c                        |   9 +-
 drivers/iommu/arm-smmu.c                           |   9 +-
 drivers/leds/led-class.c                           |   9 +-
 drivers/mfd/altera-sysmgr.c                        |  14 +-
 drivers/misc/mei/main.c                            |   9 +-
 drivers/mux/core.c                                 |   7 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |   8 +-
 drivers/net/phy/mdio_bus.c                         |   9 +-
 drivers/nvmem/core.c                               |   7 +-
 drivers/of/of_mdio.c                               |   8 +-
 drivers/of/platform.c                              |   7 +-
 drivers/pci/probe.c                                |   7 +-
 drivers/regulator/of_regulator.c                   |   7 +-
 drivers/rtc/interface.c                            |  11 +-
 drivers/s390/cio/ccwgroup.c                        |  18 +-
 drivers/s390/cio/device.c                          |  15 +-
 drivers/s390/crypto/zcrypt_api.c                   |  22 +-
 drivers/scsi/scsi_proc.c                           |   9 +-
 drivers/spi/spi.c                                  |  28 +--
 drivers/tty/tty_io.c                               |   8 +-
 drivers/usb/core/devio.c                           |   8 +-
 drivers/usb/roles/class.c                          |  16 +-
 drivers/usb/typec/class.c                          |  16 +-
 include/linux/device.h                             | 237 ++++++++++++++++++++-
 include/linux/platform_device.h                    |   3 +
 net/ieee802154/core.c                              |   7 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |   9 +-
 48 files changed, 341 insertions(+), 383 deletions(-)
