Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBB38552F;
	Mon, 23 Mar 2026 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256433; cv=none; b=q/PcRNs0pHoT3fmppIEe5RsDkkswe7U3JjwiLPtkfXcx5j/60aRqE4XwY6yBYnv832SRwYR4KHuH3xtd+DF61nxLhcMK6YUSImSSizOcQ6KuYuZrPNZt8GSUXw1BKsB005sfdzDWdFB27jX6IWxK24a06uriOvZRfgUOdECKea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256433; c=relaxed/simple;
	bh=/biRsCEdq/ddELaA4pVbIjzNAeUEcCO8JGY8MM8mv/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSMomPZkvjiZjiSkiAd6M9CyKQKcr+PNA90HZEW+BA0AHieggF3sZTUyO/tmdxsrhKRzKxprIPZlhv2IlhOZk52XIxl6RKcvC5snpqXYfSX8AH6hw1S5OJwHZ7p8XL9CxXcJCMS2zfIrMb9C5+idWaV5VCkeZ3qVWSJF0tWLWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PSwEOmg+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PSwEOmg+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yMWdX5rPU/LnYnaKYFuAJpacSJjdsYtQkCNE/5cAkNw=; b=PSwEOmg+s3OczIMqw7GtGr0Fdf
	HA30SHMempCUFsF4P+/wB4O9mxAJuHBvKfp+WopGLmcVaWKey4NeTTNgrCfcludwaigtBAvL9AKy9
	8aKNh6qwqzU15V1EkY49I1k0ExipPVcIuFfZKT40j53SnOJOki341VbB9gviwD+1G1WYuTn+6djf4
	Co73IutMNyyt7iaIhJWnbAdqd7wVO0CVjDKF4+CH1H2AwCYPaoHJHA4qtXmx+URFIrsxOmLraeEOx
	uC0UiZMh9oYmRKRMHBboKtS4j73+15+KcBX3gfsOkW5zdkl6cy5Mm0u9h378R3sO1FFB3I8BtvfAa
	4gisQ0dA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53602)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4b8f-0000000009l-0dMz;
	Mon, 23 Mar 2026 08:59:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4b8a-000000003tW-2pe0;
	Mon, 23 Mar 2026 08:59:52 +0000
Date: Mon, 23 Mar 2026 08:59:52 +0000
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
Message-ID: <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acDLzK8vpptTUMf1@google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 22, 2026 at 10:17:15PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 23, 2026 at 03:54:09AM +0100, Andrew Lunn wrote:
> > > -	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
> > > +	d = class_find_device_by_fwnode(&mdio_bus_class,
> > > +					of_fwnode_handle(mdio_bus_np));
> > 
> > When you look at this, why is it better?
> 
> I think we should move as much as possible towards firmware-agnostic
> APIs and use fwnode_handle instead of device_node or software_node or
> ACPI companion. To discourage this I think we better remove
> firmware-specific APIs where we have firmware-agnostic ones and
> eventually clean up drivers that use OF- or ACPI-specific APIs.

Basically, no. This is wrong.

It may sound like a good goal, but there's an underlying issue. This
goal assumes that the firmware description in OF and ACPI are
indentical.

Sure, looking up devices by fwnode handle makes sense, but looking up
anything that is described in firmware is not suitable for this kind
of conversion, because in doing so, you effectively "port" the DT
bindings to ACPI, and it may not be suitable for ACPI.

So, please don't make wholesale changes that transfer the DT bindings
into ACPI.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
