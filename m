Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2019 16:10:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/7] drivers: Add generic device lookup helpers
Message-ID: <20190725141036.GA14950@kroah.com>
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
> 
> Changes since v2:
>  - Merge the device match helper introduction patch with the variants
>    of the helpers, for better review.
>  - Use platform_find_device_by_driver for mcde drm driver.

This looks good to me at first glance, thanks for doing this work.

I'll wait a few days to collect acks from various subsystem maintainers
before taking the series in my tree.

thanks,

greg k-h
