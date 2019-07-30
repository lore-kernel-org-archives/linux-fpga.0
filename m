Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2019 13:03:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/7] drivers: Introduce device lookup variants by
 of_node
Message-ID: <20190730110315.GA31631@kroah.com>
References: <20190723221838.12024-1-suzuki.poulose@arm.com>
 <20190723221838.12024-3-suzuki.poulose@arm.com>
 <20190725135402.GL23883@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725135402.GL23883@dell>
To: Lee Jones <lee.jones@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, linux-arm-kernel@lists.infradead.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Frank Rowand <frowand.list@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-i2c@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Peter Rosin <peda@axentia.se>, Mark Brown <broonie@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Thor Thayer <thor.thayer@linux.intel.com>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jul 25, 2019 at 02:54:02PM +0100, Lee Jones wrote:
> On Tue, 23 Jul 2019, Suzuki K Poulose wrote:
> 
> > Introduce wrappers for {bus/driver/class}_find_device() to
> > locate devices by its of_node.
> > 
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: devicetree@vger.kernel.org
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: linux-i2c@vger.kernel.org
> > Cc: linux-rockchip@lists.infradead.org
> > Cc: linux-spi@vger.kernel.org
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Alan Tull <atull@kernel.org>
> > Cc: Moritz Fischer <mdf@kernel.org>
> > Cc: linux-fpga@vger.kernel.org
> > Cc: Peter Rosin <peda@axentia.se>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: Heiner Kallweit <hkallweit1@gmail.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Thor Thayer <thor.thayer@linux.intel.com>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Peter Rosin <peda@axentia.se>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  - Dropped the reviewed-by tags from Thor, Mark, Andrew and Peter as the
> >    patches are mereged, though there are no functional changes.
> > ---
> >  drivers/amba/tegra-ahb.c              | 11 +-------
> >  drivers/fpga/fpga-bridge.c            |  8 +-----
> >  drivers/fpga/fpga-mgr.c               |  8 +-----
> >  drivers/gpu/drm/drm_mipi_dsi.c        |  7 +----
> >  drivers/i2c/i2c-core-of.c             |  7 +----
> >  drivers/mfd/altera-sysmgr.c           | 14 ++--------
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> What's the merge plan for this patch?
> 
> Is anyone prepared to create an immutable branch for us to pull from?
> I'm happy to do it if no one else steps up.

I'll take it, and create a branch for everyone to pull from.

thanks,

greg k-h
