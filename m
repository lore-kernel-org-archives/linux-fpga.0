Return-Path: <SRS0=zkQp=VW=linaro.org=lee.jones@kernel.org>
Return-Path: <SRS0=zkQp=VW=linaro.org=lee.jones@kernel.org>
Date: Thu, 25 Jul 2019 14:54:02 +0100
From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 2/7] drivers: Introduce device lookup variants by
 of_node
Message-ID: <20190725135402.GL23883@dell>
References: <20190723221838.12024-1-suzuki.poulose@arm.com>
 <20190723221838.12024-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190723221838.12024-3-suzuki.poulose@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, linux-arm-kernel@lists.infradead.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Frank Rowand <frowand.list@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-i2c@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Peter Rosin <peda@axentia.se>, Mark Brown <broonie@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Thor Thayer <thor.thayer@linux.intel.com>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, 23 Jul 2019, Suzuki K Poulose wrote:

> Introduce wrappers for {bus/driver/class}_find_device() to
> locate devices by its of_node.
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: devicetree@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-spi@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  - Dropped the reviewed-by tags from Thor, Mark, Andrew and Peter as the
>    patches are mereged, though there are no functional changes.
> ---
>  drivers/amba/tegra-ahb.c              | 11 +-------
>  drivers/fpga/fpga-bridge.c            |  8 +-----
>  drivers/fpga/fpga-mgr.c               |  8 +-----
>  drivers/gpu/drm/drm_mipi_dsi.c        |  7 +----
>  drivers/i2c/i2c-core-of.c             |  7 +----
>  drivers/mfd/altera-sysmgr.c           | 14 ++--------

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

What's the merge plan for this patch?

Is anyone prepared to create an immutable branch for us to pull from?
I'm happy to do it if no one else steps up.

>  drivers/mux/core.c                    |  7 +----
>  drivers/net/phy/mdio_bus.c            |  9 +------
>  drivers/nvmem/core.c                  |  7 +----
>  drivers/of/of_mdio.c                  |  8 +-----
>  drivers/of/platform.c                 |  7 +----
>  drivers/regulator/of_regulator.c      |  7 +----
>  drivers/spi/spi.c                     | 20 +++------------
>  include/linux/device.h                | 37 +++++++++++++++++++++++++++
>  sound/soc/rockchip/rk3399_gru_sound.c |  9 ++-----
>  15 files changed, 56 insertions(+), 110 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
