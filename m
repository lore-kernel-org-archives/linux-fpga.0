Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275F191;
	Mon, 23 Mar 2026 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291223; cv=none; b=WpGoG/K+8WptuvX/1VxZUrbRODQ3PReCC/nyGq6irt8hJDKEkn481AQkIrrkj1WQeTV4C8h4qc/cHZogzLIk3uu9ppWE/XZ3eVSvCY75D70GWvv2wKdmqjhEelI2rA88fXezUV0kps+s+ieS6nYBV95dRnPap085Q4MFyTY33a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291223; c=relaxed/simple;
	bh=5wgyNxGVcLa5x3o0SkwFyGDVZQZedbCoLnwtrBNG/6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4aVg9Y9WN7kQYBlv4WcRmWSSwdEiK04LibUEAaIce2oPojlGHgUZT2pbjPqMGB08oxVStpOFHNMYtSkkOa7NiCpqw8ianL8/ESut3RmviRclkA6M7CmGFa7FQhM3lg9MF721rx5gYTihOjCK33UFQFF0mWPrZD8huhUUa5HmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FN3SACl3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FN3SACl3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5bAnUpk4I5KuTFj8AGK69+RpszMB18SfsdhQE/fiuhQ=; b=FN3SACl30X141swDnDlBG3rFc5
	p8yiMw1NN0kVVU3WmULf53sxfUT3xL7XFNbIzsC+bcHlURm2o3wmy/om57nvrP7yljlC5M/KcAUtr
	boFAm1VYfgoGlUzK7S7NPGDfredUqpUpdzPRmmLhMbvgRKETyWH2RkAzJ5+HJvRjxNvx5317X7JEX
	8EYBG/jIZXk7hbLOZd724shWZDyA8bzLU7L4F0IllL3rkm5NspIZ5cTkZcnxhOba9gIDUQIJ5uMAE
	gBPVL+jCmDhLVPFFrCPMaV0RATkjAq0qgOEyNuAxSmg1bcdQ38OzZjbv/QoAVYUM2p8VYbenp6eyw
	1WU5eMRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47290)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4kC4-000000000pl-05ok;
	Mon, 23 Mar 2026 18:40:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4kBV-000000004Je-0Qmx;
	Mon, 23 Mar 2026 18:39:29 +0000
Date: Mon, 23 Mar 2026 18:39:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 07/10] net: phy: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGI4PI3MHML9Pce@shell.armlinux.org.uk>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
 <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
 <acGGWTmSMuc5h3Od@google.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acGGWTmSMuc5h3Od@google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 23, 2026 at 11:33:36AM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 23, 2026 at 08:59:52AM +0000, Russell King (Oracle) wrote:
> > On Sun, Mar 22, 2026 at 10:17:15PM -0700, Dmitry Torokhov wrote:
> > > On Mon, Mar 23, 2026 at 03:54:09AM +0100, Andrew Lunn wrote:
> > > > > -	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
> > > > > +	d = class_find_device_by_fwnode(&mdio_bus_class,
> > > > > +					of_fwnode_handle(mdio_bus_np));
> > > > 
> > > > When you look at this, why is it better?
> > > 
> > > I think we should move as much as possible towards firmware-agnostic
> > > APIs and use fwnode_handle instead of device_node or software_node or
> > > ACPI companion. To discourage this I think we better remove
> > > firmware-specific APIs where we have firmware-agnostic ones and
> > > eventually clean up drivers that use OF- or ACPI-specific APIs.
> > 
> > Basically, no. This is wrong.
> > 
> > It may sound like a good goal, but there's an underlying issue. This
> > goal assumes that the firmware description in OF and ACPI are
> > indentical.
> 
> If they are different then drivers will make allowance for this, like
> I2C core or SPI core does. But most of the modern drivers use
> firmware-agnostic APIs (device_property_*()).

What is appropriate is up to the standards bodies responsible for
the firmware. ACPI has a separate body, and we can't just dump
the structure we use for networking into ACPI. So no, you can't
just switch to firmware-agnostic APIs for networking.

For infrastructure where we lookup stuff by some kind of firmware
node, I have no problem with converting that to fwnode APIs,
because that doesn't transfer the DT description into other
firmwares without prior agreement of the appropriate firmware
standards bodies.

This is not "foreign territory" - ACPI in general doesn't want to
describe e.g. the individual components of a network card, unlike
DT.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
