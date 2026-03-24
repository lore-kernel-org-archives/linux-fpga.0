Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D713FE642;
	Tue, 24 Mar 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360230; cv=none; b=Os15sSiAtlgy5FWe9qEScMY75wu6gs8peNrLH9xsRMC9NXGmcd2UGAD0Eg6/t23BXF6VKO0CXzUF92On1HGqBaAx1mGX1R5nQCYP6xpHRt5qvceSfzAhhT5PLG+ghGL9TNKe6a2v8kLpQ3MyaRIcO4eyHiiUOv7mYBcCVxXoPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360230; c=relaxed/simple;
	bh=AMs2xkHWpW+1i2TrCcqBgQmCQDfcYF+jyztI+Rm1Owg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH5A7IaC8N5/jGgL9LoVSxDMLWiPGGIpcq/PW+YERaWP/AHpSghkemqFpPDJCaH98I2cgCuGVO1xgkne+BK7juR9TkVC1CXKqE/box1U28Q/XKXrcpd0bBkwM0YbbWKtnemIID92c8AgqhqFJZo6q/F+tghy07m608QdEEFokEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZKzoudrL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZKzoudrL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8udT26h8eiURJoy49HOh8J1+Wsitw5BtoND+1sPb32Q=; b=ZKzoudrLGlLDpDbhGpajeL+IKO
	h76Ykl9fp2x8hZnqh7FNbmpYh6dfGwrfUi3e610nE34b7pY0O+S/kGKka24cRHw64wJcMES0xYUIu
	VaFG5tbOs6lQXx+3ljkV8cSPlakgpVcdaKTrqhafeP00GrpvLFxpO7suxaCkdVKJZmdo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w5291-00D6tO-K7; Tue, 24 Mar 2026 14:50:07 +0100
Date: Tue, 24 Mar 2026 14:50:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 04/10] regulator: of: switch to using
 class_find_device_by_fwnode()
Message-ID: <f8595a3a-fe9a-4294-8270-3364bc5c14e6@lunn.ch>
References: <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
 <acGFksyx3SA0kJ5b@google.com>
 <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>
 <cf92122d-6b15-458a-bf89-189a0a6874f7@lunn.ch>
 <193e194a-498f-464f-b22c-c283c16db6c1@sirena.org.uk>
 <acGzJV3vKhuty3nd@google.com>
 <09072374-65e7-4792-af7e-97d7df93f9bd@lunn.ch>
 <acG9BPkFr_De-ulu@google.com>
 <27f4ed63-08a2-4621-8943-c50261de31cd@lunn.ch>
 <acHCIA1d5-s2xkvz@google.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acHCIA1d5-s2xkvz@google.com>

On Mon, Mar 23, 2026 at 03:48:42PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 23, 2026 at 11:39:03PM +0100, Andrew Lunn wrote:
> > > If there is a deprecated property you can do:
> > > 
> > > 	error = device_property_read_u32(dev, "prop", &val);
> > > 	if (error == -ENOENT)
> > > 		error = device_property_read_u32(dev, "deprecated-prop", &val);
> > 
> > It is not as simple as that. There are a lot of optional
> > properties. Say "prop" is optional? And not present. So -ENOENT. We
> > then look for this deprecated property. That should not happen.
> 
> Why? That is exactly what you want: you favor new one if it is present
> and fall back to deprecated one if it is absent. And then you decide
> whether to continue or abort.

The old property is only valid in DT, where it is deprecated, but
still valid. It should never appear in any other newer firmware
bindings.

> If you only have of_property_read_u32() then it will not stand out. If
> you advocate of using device_property_read_u32() normally but
> of_property_read_u32() for deprecated only - that is a possibility, but
> I do not know if anyone does this.

For the subsystems i've dealt with, when somebody proposes a patch
adding an ACPI binding, and they do an of_ to device_ conversion
without engaging brain, i point out the issues, they should not be
adding deprecated properties to a brand new binding, and they go away
and never come back. And so the code remains OF only. Which is fine,
nobody does networking devices using ACPI.

       Andrew
