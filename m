Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B43DC4D7
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294542; cv=none; b=C2ZaBpDuLdFTsh118o7YBhpGXtO3jTkZraERxA0KssGWvbHe402Kj6NUs/ZKGoNzEIX2DvbhS4p6Auvx/RLm6d/23Dd39TZmaIDykOUlqPsB9hqSJqUXDaDLDyrnfGnvocjUvVEqwLNzE65PHaWsdks3wbI3tAHxHONP3eD+2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294542; c=relaxed/simple;
	bh=kvZQfR6Ka8WnuKuT7mVazzZOQdLKZWJfub3aSBzO8AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCfR0fxgiKfN13MOxQiBeW3qE9iGp6FoigO2blEM8vadFIdDpLvRD8UY/TNfAcAH8FQVYphfO+gB/CUKk7JVsdDslKtO/txsJF77tHjQaFgGEeQZFtun6I6AZ3WPpVls8MXaHDbsjh9Eu7/0J8u9G/XWA4oF4arN9zSiw1iaQ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gER+PnsK; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gER+PnsK"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4b77adso4712315c88.1
        for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774294535; x=1774899335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsALcZ16tevmJ3ng05DYY6tY5JjgfE8hJRfdYF/sgZQ=;
        b=gER+PnsKerawqjr5zJOkKJ7vn7s58hrCHWcIoAhdjFt27DESMOLN3wTgXJhso3fpuw
         1oIvt7jwneWdajfhCwQDqxinICvxzdiLJJ/5pAuM8lzo8lJojssSseVj/Z+yYJb5ihRg
         inRz9ss6IPHd9r3dxgf4WL074mJb4Lm88olwtJtapzoFF22VtIJyuyr7hwvnGOHdnONy
         tEjrM6FVCh8Dtwy/P/cERijF+kdULjB1cPZoMXGhxXfatDide14gpc/ZqCDTHyxuym8S
         Z8C9QKkA8aT4bmERGg+MrjyS3lFoEcRuZG3AcARhSroaURJIFk3Gp4VEaPbydmm9/Djo
         tYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294535; x=1774899335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsALcZ16tevmJ3ng05DYY6tY5JjgfE8hJRfdYF/sgZQ=;
        b=O7MGeRhFhmXcBJa06H0RNMt9vXKBK0tP4cmhDt0mId7skFMWn2W+YT3gluhUHlgSiV
         44QjMWpDuKwenh0u2QFJwAozdkKrGxRSTK1stEDFSO1obsSzmCN4xfMCV7HWzB/RkZsz
         sv5aM8BeGoD8kj+5lNzrJf9OeIUZw+fijWCNYlkbeHKmFWMRhqdDPIPmgHfXF9y84ODQ
         9M3N/Nm+1hrV3kHbTnoVk0A8o3exuEh9hl3fZhqLrfVomeI7pyTLUxoL30RpBGhGn3fo
         9M+Ts0Xa3COZjOq8traa7CuFSb6B/NqNLcK3W75R/r/wiUnvrYuPO0TbMuPg/AVQR0br
         tPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCjneU/pVWOXbzPx1R6MKNXOwa1F47zxGY5B7jJre+3nbfKSUUXNBYillRnYvFaelKDDmoyDj/yRXD@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/6E9HrcxeFLuPyMULEqiPa2hUEiYel3UW2IMEzDUXivzjp7O
	gb1uifzgIo50XZvjhfV2/SihgKbKNaLUbgKRsXexzoFQNLtN2oIik4uk
X-Gm-Gg: ATEYQzwgjQJYrYLd1qaIlU7pgUYY3LVuOOxfcF4eplNKutV3rKt7XZ0i1u0SL5ZkLaC
	Xp9RzzrDbzMgp19nMRS+qcNbGnxnEmVx0ml3ZpqF2WkLuhI5vLFJUsO+MAQhEG8VNXJx9lPinOP
	1JHbPXzigVWtwjAV8F0Hghwdg/ScXNXIIEU29RVqTOGSzmzD6JE9o9WgPTzwO64MWJnuWWf2WmO
	e05fmE2HFt+mM7xRyYki3qX+PhjcnFonJz8pROjOaUKcaBa3h2Uv6mlrUfbXhV0u59ODVLUY1fO
	JOZHYe4AIAP4mlK5vpHb0W1na4gjUaQDbAQtlR0X2t+hpdubh4OMdy8sO8PJ2IoNsEMHlcgLTvu
	f/2j2h41EDf71iUpVc+oW7JK6LWKuIDW+DNmUXe6djv4Cw8Lw5hjS0olwB7Yt/6j7rKghqtXYs/
	MvOtJTiiRO1iS4Xh+Yz37eZUorOaTCkG1vEIY74GbxqOEfAWPHLRZVfmMudZQnfj71
X-Received: by 2002:a05:7022:6981:b0:12a:6ab7:3f9e with SMTP id a92af1059eb24-12a72671127mr5823640c88.10.1774294535335;
        Mon, 23 Mar 2026 12:35:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17d1ddsm12967046eec.11.2026.03.23.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:35:34 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:35:30 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Rosin <peda@axentia.se>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 07/10] net: phy: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGTaZcF6GwkmC03@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
 <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
 <acGGWTmSMuc5h3Od@google.com>
 <acGI4PI3MHML9Pce@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acGI4PI3MHML9Pce@shell.armlinux.org.uk>

On Mon, Mar 23, 2026 at 06:39:28PM +0000, Russell King (Oracle) wrote:
> On Mon, Mar 23, 2026 at 11:33:36AM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 08:59:52AM +0000, Russell King (Oracle) wrote:
> > > On Sun, Mar 22, 2026 at 10:17:15PM -0700, Dmitry Torokhov wrote:
> > > > On Mon, Mar 23, 2026 at 03:54:09AM +0100, Andrew Lunn wrote:
> > > > > > -	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
> > > > > > +	d = class_find_device_by_fwnode(&mdio_bus_class,
> > > > > > +					of_fwnode_handle(mdio_bus_np));
> > > > > 
> > > > > When you look at this, why is it better?
> > > > 
> > > > I think we should move as much as possible towards firmware-agnostic
> > > > APIs and use fwnode_handle instead of device_node or software_node or
> > > > ACPI companion. To discourage this I think we better remove
> > > > firmware-specific APIs where we have firmware-agnostic ones and
> > > > eventually clean up drivers that use OF- or ACPI-specific APIs.
> > > 
> > > Basically, no. This is wrong.
> > > 
> > > It may sound like a good goal, but there's an underlying issue. This
> > > goal assumes that the firmware description in OF and ACPI are
> > > indentical.
> > 
> > If they are different then drivers will make allowance for this, like
> > I2C core or SPI core does. But most of the modern drivers use
> > firmware-agnostic APIs (device_property_*()).
> 
> What is appropriate is up to the standards bodies responsible for
> the firmware. ACPI has a separate body, and we can't just dump
> the structure we use for networking into ACPI. So no, you can't
> just switch to firmware-agnostic APIs for networking.

So I believe there is a difference between deciding:

1. What schema is being used on a particular system - it may be
OF-compatible, or ACPI compatible one, and ACPI may support
OF-compatible schemes for certain subsystems or individual devices, and

2. What is the API to access the properties.

There is no harm to use device_property_read_*() universally as well as 
not having OF-specific APIs at the driver core level. What matters is
schema matches the system type.

> 
> For infrastructure where we lookup stuff by some kind of firmware
> node, I have no problem with converting that to fwnode APIs,
> because that doesn't transfer the DT description into other
> firmwares without prior agreement of the appropriate firmware
> standards bodies.
> 
> This is not "foreign territory" - ACPI in general doesn't want to
> describe e.g. the individual components of a network card, unlike
> DT.

I think we actually broadly agree? What you are arguing against is
saying that OF schema is guaranteed to work on ACPI systems and vice
versa, but I am not saying that (although for some things it may). But
still most OF schema can be handled by generic APIs (either
device_property_read_*() or fwnode ones).

Thanks.

-- 
Dmitry
