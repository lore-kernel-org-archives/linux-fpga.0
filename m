Return-Path: <SRS0=P7Jb=UC=arm.com=suzuki.poulose@kernel.org>
Return-Path: <SRS0=P7Jb=UC=arm.com=suzuki.poulose@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 00/57] drivers: Consolidate device lookup helpers
Date: Mon,  3 Jun 2019 16:49:26 +0100
Message-Id: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, suzuki.poulose@arm.com, Alan Tull <atull@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexander Aring <alex.aring@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Noever <andreas.noever@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Corey Minyard <minyard@acm.org>, Daniel Vetter <daniel@ffwll.ch>, Dan Murphy <dmurphy@ti.com>, David Airlie <airlied@linux.ie>, David Kershner <david.kershner@unisys.com>, "David S. Miller" <davem@davemloft.net>, Doug Ledford <dledford@redhat.com>, dri-devel@lists.freedesktop.org, Elie Morisse <syniurge@gmail.com>, Eric Anholt <eric@anholt.net>, Felipe Balbi <balbi@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Harald Freudenberger <freude@linux.ibm.com>, Hartmut Knaack <knaack.h@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Heiner Kallweit <hkallweit1@gmail.com>, Inki Dae <inki.dae@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Len Brown <lenb@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Mark Brown <broonie@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Michael Jamet <michael.jamet@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Moritz Fischer <mdf@kernel.org>, Nehal Shah <nehal-bakulchandra.shah@amd.com>, Oliver Neukum <oneukum@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Oberparleiter <oberpar@linux.ibm.com>, Peter Rosin <peda@axentia.se>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki " <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>, Sandy Huang <hjc@rock-chips.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sebastian Ott <sebott@linux.ibm.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Shyam Sundar S K <shyam-sundar.s-k@amd.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, Thor Thayer <thor.thayer@linux.intel.com>, Tomas Winkler <tomas.winkler@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Will Deacon <will.deacon@arm.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-leds@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

We have helper routines to lookup devices matching a criteria defined
by a "match" helper for bus/class/driver. Often the search is based on a
generic property of a device, such as of_node, fwnode, device type or
device name. In the absense of a common set of match functions, we have
drivers writing their own match functions, spilled all over the driver
subsystems. This series is an attempt to consolidate the and cleanup
the device match functions by providing generic match helpers by device
properties listed above. In this attempt, we unify the prototype for
the match functions for {bus/driver}_find_device() with that of the
class_find_device() and thus further reducing the duplicate functions.
The series also adds wrapper functions to lookup the devices by generic
attributes, so that people don't miss the generic match functions and
continue to write their own.

Also, there are a couple of instances where the drivers use "platform_bus_type"
directly reusing the "match" function of the bus. This is cleaned by providing
a new helper "platform_find_device_by_driver()" to abstract the details away
from the callers.

Applies on 5.2-rc3

Cc: Alan Tull <atull@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Corey Minyard <minyard@acm.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: David Airlie <airlied@linux.ie>
Cc: David Kershner <david.kershner@unisys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Doug Ledford <dledford@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Elie Morisse <syniurge@gmail.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Grant Likely <grant.likely@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Joe Perches <joe@perches.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Len Brown <lenb@kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sebastian Ott <sebott@linux.ibm.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-fpga@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-leds@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-wpan@vger.kernel.org

Suzuki K Poulose (57):
  drivers: s390/cio: Use driver_for_each_device
  drivers: ipmi: Drop device reference
  drivers: coresight: Drop device references found via bus_find_device
  drivers: Add generic match helper to match the device of_node
  drm: mipi_dsi: Use bus_find_device_by_of_node() helper
  drivers: i2c: i2c-core: Use bus_find_device_by_of_node helper
  drivers: nvmem: Use bus_find_device_by_of_node helper
  drivers: spi: Use bus_find_device_by_of_node helper
  drivers: sound: rockchip: rk3399: Use bus_find_device_by_of_node
    helper
  drivers: coresight: Use bus_find_device_by_of_node helper
  of: mdio: Use bus_find_device_by_of_node helper
  of: platform: Use bus_find_device_by_of_node helper
  drivers: Add generic helper for matching device by fwnode
  drivers: devcon: Use bus_find_device_by_fwnode helper
  net: hisilicon: hnfs:Use bus_find_device_by_fwnode helper
  net: hns_roce: Use bus_find_device_by_fwnode helper
  drivers: Add generic match by device type helper
  drivers: intel_th: Use bus_find_device_by_devt helper
  drivers: usb: core: Use bus_find_device_by_devt helper
  platform: Add a helper to find device by driver
  drivers: Add generic match helper by ACPI_COMPANION device
  drivers: i2c: Use generic helper to match device by acpi_dev
  drivers: spi: Use bus_find_device_by_acpi_dev match helper
  drivers: staging: most-core: Use bus_find_device_by_name
  drivers: Add generic match by name helper
  drivers: acpi: Clean up acpi_dev_match_cb
  drivers: Unify the match prototype for bus_find_device with
    class_find_device
  drivers: class: Add variants of class_find_device()
  drivers: stm: Use class_find_device_by_name() helper
  drivers: leds: Use class_find_device_by_name() helper
  drivers: rtc: Use class_find_device_by_name() helper
  drivers: s390-crypto: Use class_device_find_by_name() helper
  drivers: usb: Use class_find_device_by_name() helper
  drivers: ieee802154: Use class_find_device_by_name() helper
  drivers: core: Reuse generic match by device type helper
  drivers: mei: Use class_find_device_by_devt match helper
  drivers: s390: zcrypt: Use class_find_device_by_devt helper
  drivers: fpga: Use generic helpers to match by of_node
  drivers: mux: Use class_find_device_by_of_node helper
  drivers: spi: Use class_find_device_by_of_node helper
  drivers: net: phy: Use class_find_device_by_of_node helper
  drivers: regulator: Use class_find_device_by_of_node helper
  drivers: tty : Use class_find_device_by_of_node helper
  drivers: usb : Use class_find_device_by_fwnode() helper
  drivers: driver_find_device: Unify the match function
  driver: Add variants of driver_find_device()
  drivers: mfd: Use driver_find_device_by_name helper
  drivers: s390: cio: Use driver_find_by_name() helper
  drivers: mfd: altera: Use driver_find_device_by_of_node() helper
  drivers: iommu: arm-smmu: Use driver_find_device_by_fwnode() helper
  drivers: Add generic helper to match all devices
  drivers: tegra: Use driver_find_device_by_of_node() helper
  drivers: Introduce bus_find_next_device() helper
  drivers: pci: Use bus_find_next_device() helper
  drivers: scsi: Use bus_find_next_device() helper
  drivers: Introduce driver_find_next_device() helper
  drivers: i2c-amd: Use driver_find_next_device() helper

 arch/powerpc/platforms/pseries/ibmebus.c           |   4 +-
 drivers/acpi/acpi_lpss.c                           |   4 +-
 drivers/acpi/sleep.c                               |   2 +-
 drivers/acpi/utils.c                               |  11 +-
 drivers/amba/tegra-ahb.c                           |  11 +-
 drivers/base/bus.c                                 |  26 +--
 drivers/base/core.c                                |  45 ++++-
 drivers/base/devcon.c                              |   8 +-
 drivers/base/driver.c                              |   2 +-
 drivers/base/platform.c                            |  14 ++
 drivers/char/ipmi/ipmi_msghandler.c                |   8 +-
 drivers/char/ipmi/ipmi_si_platform.c               |   3 +-
 drivers/firmware/efi/dev-path-parser.c             |   4 +-
 drivers/fpga/fpga-bridge.c                         |   8 +-
 drivers/fpga/fpga-mgr.c                            |   8 +-
 drivers/fpga/of-fpga-region.c                      |   7 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   7 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   9 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   3 +-
 drivers/gpu/drm/tegra/dc.c                         |   4 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |   3 +-
 drivers/hwtracing/coresight/coresight.c            |  10 +-
 drivers/hwtracing/coresight/of_coresight.c         |  11 +-
 drivers/hwtracing/intel_th/core.c                  |  11 +-
 drivers/hwtracing/stm/core.c                       |   9 +-
 drivers/i2c/busses/i2c-amd-mp2-pci.c               |   8 +-
 drivers/i2c/i2c-core-acpi.c                        |  10 +-
 drivers/i2c/i2c-core-of.c                          |   9 +-
 drivers/iio/inkern.c                               |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   8 +-
 drivers/iommu/arm-smmu-v3.c                        |   9 +-
 drivers/iommu/arm-smmu.c                           |   9 +-
 drivers/leds/led-class.c                           |   9 +-
 drivers/mfd/altera-sysmgr.c                        |  14 +-
 drivers/mfd/syscon.c                               |   8 +-
 drivers/misc/mei/main.c                            |   9 +-
 drivers/mux/core.c                                 |   8 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |   8 +-
 drivers/net/ethernet/ti/cpsw-phy-sel.c             |   4 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   2 +-
 drivers/net/ethernet/toshiba/tc35815.c             |   4 +-
 drivers/net/phy/mdio_bus.c                         |   9 +-
 drivers/nvmem/core.c                               |   7 +-
 drivers/of/of_mdio.c                               |   8 +-
 drivers/of/platform.c                              |   7 +-
 drivers/pci/probe.c                                |   7 +-
 drivers/pci/search.c                               |   4 +-
 drivers/regulator/of_regulator.c                   |   7 +-
 drivers/rtc/interface.c                            |  11 +-
 drivers/s390/cio/ccwgroup.c                        |  28 +--
 drivers/s390/cio/chsc_sch.c                        |   2 +-
 drivers/s390/cio/css.c                             |   4 +-
 drivers/s390/cio/device.c                          |  21 +--
 drivers/s390/crypto/ap_bus.c                       |   4 +-
 drivers/s390/crypto/zcrypt_api.c                   |  23 +--
 drivers/scsi/scsi_proc.c                           |   9 +-
 drivers/spi/spi.c                                  |  28 +--
 drivers/staging/most/core.c                        |   9 +-
 drivers/thunderbolt/switch.c                       |   4 +-
 drivers/tty/tty_io.c                               |   8 +-
 drivers/usb/core/devio.c                           |   8 +-
 drivers/usb/core/usb.c                             |   4 +-
 drivers/usb/phy/phy-am335x-control.c               |   4 +-
 drivers/usb/phy/phy-isp1301.c                      |   4 +-
 drivers/usb/roles/class.c                          |  16 +-
 drivers/usb/typec/class.c                          |  16 +-
 drivers/visorbus/visorbus_main.c                   |   4 +-
 include/linux/device.h                             | 191 ++++++++++++++++++++-
 include/linux/platform_device.h                    |   3 +
 net/ieee802154/core.c                              |   7 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |   9 +-
 71 files changed, 359 insertions(+), 460 deletions(-)

-- 
2.7.4
