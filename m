Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2019 05:23:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 00/28] drivers: Consolidate device lookup helpers
Message-ID: <20190624032348.GA28919@kroah.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, Alan Tull <atull@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexander Aring <alex.aring@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Noever <andreas.noever@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Corey Minyard <minyard@acm.org>, Daniel Vetter <daniel@ffwll.ch>, Dan Murphy <dmurphy@ti.com>, David Airlie <airlied@linux.ie>, David Kershner <david.kershner@unisys.com>, "David S. Miller" <davem@davemloft.net>, Doug Ledford <dledford@redhat.com>, dri-devel@lists.freedesktop.org, Elie Morisse <syniurge@gmail.com>, Eric Anholt <eric@anholt.net>, Felipe Balbi <balbi@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Harald Freudenberger <freude@linux.ibm.com>, Hartmut Knaack <knaack.h@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Heiner Kallweit <hkallweit1@gmail.com>, Inki Dae <inki.dae@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Len Brown <lenb@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Mark Brown <broonie@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Michael Jamet <michael.jamet@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Moritz Fischer <mdf@kernel.org>, Nehal Shah <nehal-bakulchandra.shah@amd.com>, Oliver Neukum <oneukum@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Oberparleiter <oberpar@linux.ibm.com>, Peter Rosin <peda@axentia.se>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki " <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>, Sandy Huang <hjc@rock-chips.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sebastian Ott <sebott@linux.ibm.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Shyam Sundar S K <shyam-sundar.s-k@amd.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, Thor Thayer <thor.thayer@linux.intel.com>, Tomas Winkler <tomas.winkler@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Will Deacon <will.deacon@arm.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org, linux-leds@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Jun 14, 2019 at 06:53:55PM +0100, Suzuki K Poulose wrote:
> We have device iterators to find a particular device matching a criteria
> for a given bus/class/driver. i.e, {bus,class,driver}_find_device() APIs.
> The matching criteria is a function pointer for the APIs. Often the lookup
> is based on a generic property of a device (e.g, name, fwnode, of node pointer
> or device type) rather than a driver specific information. However, each driver
> writes up its own "match" function, spilling the similar match functions all
> over the driver subsystems.
> 
> Additionally the prototype for the "match" functions accepted by the above APIs
> have a minute difference which prevents us otherwise sharing the match functions.
> i.e,
> 	int (*match)(struct device *dev, void *data) for {bus/driver}_find_device()
> 	  vs
> 	int (*match)(struct device *dev, const void *) for class_find_device()
> 
> If we promote the former to accept a "const void*" parameter, we could share one
> single match function for all the helpers. This series achieves the following:
> 
>  a) [Patches 03-05] Unify the prototype for "match" functions accepted by the
>      device lookup APIs.

I've applied the first 6 patches of this series to my tree now.  Let's
see how that goes, and this should give you a more solid base to redo
the rest of the series off of.

thanks,

greg k-h
