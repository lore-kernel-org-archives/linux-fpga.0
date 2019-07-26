Return-Path: <SRS0=8dFd=VX=sirena.org.uk=broonie@kernel.org>
Return-Path: <SRS0=8dFd=VX=sirena.org.uk=broonie@kernel.org>
Date: Fri, 26 Jul 2019 18:18:02 +0100
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/7] drivers: Introduce device lookup variants by
 of_node
Message-ID: <20190726171802.GD55803@sirena.org.uk>
References: <20190723221838.12024-1-suzuki.poulose@arm.com>
 <20190723221838.12024-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <20190723221838.12024-3-suzuki.poulose@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, linux-arm-kernel@lists.infradead.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Frank Rowand <frowand.list@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-i2c@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Peter Rosin <peda@axentia.se>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee.jones@linaro.org>, Thor Thayer <thor.thayer@linux.intel.com>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-fpga@vger.kernel.org>


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2019 at 11:18:33PM +0100, Suzuki K Poulose wrote:
> Introduce wrappers for {bus/driver/class}_find_device() to
> locate devices by its of_node.

Acked-by: Mark Brown <broonie@kernel.org>

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl07NckACgkQJNaLcl1U
h9A0GAf/Qv4GC1ywijdMO9/GL0PzTuBBqL46oM94b0OCt9PYllKoQ2MkrwSN+eAS
DGfHngyqVnoUtqjC/RksDFvWLJ7/Hg6BRJf0zkPspIu7s/DC2tW4x7C8CTIvfbF3
LbDl5DdTKcj/+2cS7yypDLGUkmUVs0pmfQJ5e9gk0l8qX8UUIoycnIQCKtctvUlr
LZgOv6gh5nuo2Vh8vuJIMi9rUHfe8zeSvMhnDhM/cU4ufM81bxjTeRw/9wdv1KOO
WLCRZm1nIAYCZajxTVgQdYhI/c7w6Dl9ZSc9/dJmzVp5RZyoV7KYT6IcjRwPVnRt
UZpTwC9oSD2mXZB30cpoNy7JmGFAKw==
=+DYp
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
