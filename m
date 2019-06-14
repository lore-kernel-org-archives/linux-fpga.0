Return-Path: <SRS0=I96B=UN=arm.com=suzuki.poulose@kernel.org>
Return-Path: <SRS0=I96B=UN=arm.com=suzuki.poulose@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 00/28] drivers: Consolidate device lookup helpers
Date: Fri, 14 Jun 2019 18:53:55 +0100
Message-Id: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, suzuki.poulose@arm.com, Alan Tull <atull@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexander Aring <alex.aring@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Noever <andreas.noever@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Corey Minyard <minyard@acm.org>, Daniel Vetter <daniel@ffwll.ch>, Dan Murphy <dmurphy@ti.com>, David Airlie <airlied@linux.ie>, David Kershner <david.kershner@unisys.com>, "David S. Miller" <davem@davemloft.net>, Doug Ledford <dledford@redhat.com>, dri-devel@lists.freedesktop.org, Elie Morisse <syniurge@gmail.com>, Eric Anholt <eric@anholt.net>, Felipe Balbi <balbi@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Harald Freudenberger <freude@linux.ibm.com>, Hartmut Knaack <knaack.h@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Heiner Kallweit <hkallweit1@gmail.com>, Inki Dae <inki.dae@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Len Brown <lenb@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Mark Brown <broonie@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Michael Jamet <michael.jamet@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Moritz Fischer <mdf@kernel.org>, Nehal Shah <nehal-bakulchandra.shah@amd.com>, Oliver Neukum <oneukum@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Oberparleiter <oberpar@linux.ibm.com>, Peter Rosin <peda@axentia.se>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki " <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>, Sandy Huang <hjc@rock-chips.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sebastian Ott <sebott@linux.ibm.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Shyam Sundar S K <shyam-sundar.s-k@amd.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, Thor Thayer <thor.thayer@linux.intel.com>, Tomas Winkler <tomas.winkler@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Will Deacon <will.deacon@arm.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-leds@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

We have device iterators to find a particular device matching a criteria
for a given bus/class/driver. i.e, {bus,class,driver}_find_device() APIs.
The matching criteria is a function pointer for the APIs. Often the lookup
is based on a generic property of a device (e.g, name, fwnode, of node pointer
or device type) rather than a driver specific information. However, each driver
writes up its own "match" function, spilling the similar match functions all
over the driver subsystems.

Additionally the prototype for the "match" functions accepted by the above APIs
have a minute difference which prevents us otherwise sharing the match functions.
i.e,
	int (*match)(struct device *dev, void *data) for {bus/driver}_find_device()
	  vs
	int (*match)(struct device *dev, const void *) for class_find_device()

If we promote the former to accept a "const void*" parameter, we could share one
single match function for all the helpers. This series achieves the following:

 a) [Patches 03-05] Unify the prototype for "match" functions accepted by the
     device lookup APIs.
 b) [Patches 06-11] Introduce generic match functions to match devices by the
     generic attributes of a device (e.g, name, fwnode, of_node and devt).

 c) [Patches 12-27] Also, in order to prevent creation of such match functions
    in the future, we introduce wrapper functions for the look up APIs, which
    automatically uses the appropriate match functions.

    i.e,
	{bus/class/driver}_find_device_by_name
	{bus/class/driver}_find_device_by_of_node
	{bus/class/driver}_find_device_by_fwnode
	{bus/class/driver}_find_device_by_devt
	{bus/class/driver}_find_device_by_acpi_dev
	{bus/class/driver}_find_next_device

     and converts the existing users to switch to the new helpers.

 d) [Patch 28] Additionally, this series also adds wrapper for finding a
    device by matching a device driver for platform bus devices -

		 platform_find_device_by_driver()

    to avoid a few drivers hard coding the platform bus specific details.

Applies on v5.2-rc4, available at [0]

    [0] git://linux-arm.org/linux-skp.git driver-cleanup/v2
RFC [1] https://marc.info/?i=1559577023-558-1-git-send-email-suzuki.poulose@arm.com
V1  [2] https://marc.info/?i=1559747630-28065-1-git-send-email-suzuki.poulose@arm.com

Changes since v1:
 - Drop start parameter for *_find_device_by_devt().
 - Fix build warnings for s390
 - Add *_find_device_by_acpi_dev() wrappers.
 - Group wrappers and the consumers into single patch, reducing
   the total patches to 28 from 57. (Rafael).
 - Better description for acpi cleanup patch.
 - Added tags from v1.

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

Suzuki K Poulose (28):
  staging: most-core: Use bus_find_device_by_name
  mfd: Remove unused helper syscon_regmap_lookup_by_pdevname
  acpi: utils: Cleanup acpi_dev_match_cb
  bus_find_device: Unify the match callback with class_find_device
  driver_find_device: Unify the match function with class_find_device()
  drivers: Add generic helper to match by of_node
  drivers: Add generic helper to match by fwnode
  drivers: Add generic helper to match by device type
  drivers: Add generic match helper by ACPI_COMPANION device
  drivers: Add generic helper to match by name
  drivers: Add generic helper to match any device
  drivers: Introduce class_find_device_by_name() helper
  drivers: Introduce class_find_device_by_of_node() helper
  drivers: Introduce class_find_device_by_fwnode() helper
  drivers: Introduce class_find_device_by_devt() helper
  drivers: Introduce class_find_device_by_acpi_dev() helper
  drivers: Introduce bus_find_device_by_of_node() helper
  drivers: Introduce bus_find_device_by_fwnode() helper
  drivers: Introduce bus_find_device_by_devt() helper
  drivers: Introduce bus_find_next_device() helper
  drivers: Introduce bus_find_device_by_acpi_dev() helper
  drivers: Introduce driver_find_device_by_name() helper
  drivers: Introduce driver_find_device_by_of_node() helper
  drivers: Introduce driver_find_device_by_fwnode() helper
  drivers: Introduce driver_find_device_by_devt() helper
  drivers: Introduce driver_find_next_device() helper
  drivers: Introduce driver_find_device_by_acpi_dev() helper
  platform: Add platform_find_device_by_driver() helper

 arch/powerpc/platforms/pseries/ibmebus.c           |   4 +-
 drivers/acpi/acpi_lpss.c                           |   4 +-
 drivers/acpi/sleep.c                               |   2 +-
 drivers/acpi/utils.c                               |  11 +-
 drivers/amba/tegra-ahb.c                           |  11 +-
 drivers/base/bus.c                                 |  28 +--
 drivers/base/core.c                                |  45 +++-
 drivers/base/devcon.c                              |   8 +-
 drivers/base/driver.c                              |   4 +-
 drivers/base/platform.c                            |  14 ++
 drivers/char/ipmi/ipmi_msghandler.c                |   8 +-
 drivers/char/ipmi/ipmi_si_platform.c               |   2 +-
 drivers/firmware/efi/dev-path-parser.c             |   4 +-
 drivers/fpga/fpga-bridge.c                         |   8 +-
 drivers/fpga/fpga-mgr.c                            |   8 +-
 drivers/fpga/of-fpga-region.c                      |   7 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   7 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   9 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   3 +-
 drivers/gpu/drm/tegra/dc.c                         |   4 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |   3 +-
 drivers/hwtracing/coresight/coresight.c            |   6 +-
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
 drivers/mfd/syscon.c                               |  21 --
 drivers/misc/mei/main.c                            |   9 +-
 drivers/mux/core.c                                 |   7 +-
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
 drivers/s390/cio/ccwgroup.c                        |  18 +-
 drivers/s390/cio/chsc_sch.c                        |   2 +-
 drivers/s390/cio/css.c                             |   4 +-
 drivers/s390/cio/device.c                          |  21 +-
 drivers/s390/cio/scm.c                             |   4 +-
 drivers/s390/crypto/ap_bus.c                       |   8 +-
 drivers/s390/crypto/zcrypt_api.c                   |  22 +-
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
 include/linux/device.h                             | 247 ++++++++++++++++++++-
 include/linux/mfd/syscon.h                         |   6 -
 include/linux/platform_device.h                    |   3 +
 net/ieee802154/core.c                              |   7 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |   9 +-
 73 files changed, 407 insertions(+), 482 deletions(-)

-- 
2.7.4
