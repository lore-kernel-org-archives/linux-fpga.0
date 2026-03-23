Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23114884C
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301981; cv=none; b=ckZRRek7/JGNEMqR+CyRT0R5hczj0I6xWjX2oO9IqNBZZpBLBXS9+OgDJshOFgXuOk3y2UZ/WcG1cuU5EQ9W5hiI0hfSvGnTXrwEyltyFjf2YbDctfA1j5trIkXg1pJlMCMiS7ELfIkGxVF+y6yB/V7at63rabjA93BRT4bU304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301981; c=relaxed/simple;
	bh=4+vcXD+1P3FXjL2Owm4YaNBB0CpFOHixgkjfmiDa1M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6qNIfPuRVyB8mAr+hy8MCqFU3rjF3SNQZN94IAosHLAy14OH2vB49IEev8uFRYWhONJRa47MN+wjIfeGZl4WzgqQQOrX+Fr9QBUPILoTue9AEycgIgzgXQ4DfodZ12J0txr58+Ygq7t4BIoBbE0fUcCM6YCpjh3wC/nIykEtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeNeGaUF; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeNeGaUF"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba895adfeaso730894eec.0
        for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774301979; x=1774906779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGHdDoGsiDtOdNrXq7SHzA/I1zh7boK5LF3ZF/OlV0U=;
        b=AeNeGaUFszrAZvUITkXt+7jwmEyvbJP7L5B0IEN/cIaMLG/q2bDeugKMm94lpxWzJU
         76V4lZmGn/sGj3IzxII/0CasDRfOtuEAhcRUrbWjtT3GoriS2yeejerlXaViFZmvDipR
         5KLUp5XGEvBEpdiNjU7v59yq9EPgYnByC5/FnpkmSNU3vnuk3iC1g26p/W+U1gLrmsh7
         hOlTuPsHhb4kW12/ibKRjgusWntF01dxbjmDE6RDAsB2z8K/rlHJdj4wvpM0K+BQtn5W
         VB9PMmm2b5K8dVBM78T/Lo9er9li/jc37aPPElbxi3KAGtX0dJTDyyM8cKjOoLC3SX9G
         I7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774301979; x=1774906779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGHdDoGsiDtOdNrXq7SHzA/I1zh7boK5LF3ZF/OlV0U=;
        b=assOByFmAdiBbOJSIwKQdFrubNAajRBOZ3PLFbaAKVIyRj569uX5M2QudJplK3mmzg
         DbRM824p5q735/ygVvkdEqf7opQos5CvOfcIahn8Ne+1yPlXoHePWPROqz0+3K52swSB
         Ra1SAObsA6bDEIyz+uQZP4uib8e/pn3XdNk2E5x4xGFjGNsge+EVch2OD0Hh9c3tLGyl
         SbvNzuXmf2jgIUkq/7SIEfF12rNl+TGOmsANtgJZwsqCymQZ+vIvDc34TKSY+fFTlZxH
         EPhECPRJvmz/1PYkO87f1oWm8vka5gS0sLW9AR5EPwxmo9K44hYSALivwSyPJ8kfDVUk
         spjw==
X-Forwarded-Encrypted: i=1; AJvYcCWLvIAcX95zhMR8isuHq9CymU44dL8VeQN/OQx/UVO1x2Cm76WxZCypvWQ3nFoYeWokW6SGo9t5x8jR@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3gWL2GOAXL4YLzrgOsZ6XcZruSA5DLr8+Wz00llravsuwHk3
	BhoPI2UYClq9C/qiNGGmRDFqzAVZDABd9GEFyrmU+LEGmw2ABnriYiiF
X-Gm-Gg: ATEYQzwoeNi+ntXRVgv3ZbwlTJ4T5al59EGxoHFMkSCMpIvzYQIZJyDNgKLeOWW4h5v
	1nx72ukqzv6w9KxUwjYSXqSrRfDEBG6Y1oYYnhCdFrZXUcj6bmmhSP0vpxtt4ZhPc0tqT284Lbw
	TAOzyBmLbYeQrdVGH/asvQEpZ+Cuk4JA9v1g1g5fsn4ijGBcGTyh8648TN0fsQjLmkClHZ9SZ/x
	vOZo/cXB0QyzjgXKw1GzGrEoilbmtoVsEOFkDg6XPSHRoYSAlHGeRHL0Gj+XlZ/Av8RSseINTV2
	cPoYJjxoT85LlagomAflkks7MKBM4w3yc1dCnIVdUWso37Zkh0GA34sGELsj6wGLz/XPYrgAUk9
	vX8IyCdODcqWis79griZgytCteH9fpF/O4YDzgDbPKuQd74SMhdGDj6uFfJcLnRAh5UCteNCFm2
	as49dfXsMdheUfumWn/xrH0tBGrjjcpST18hj3b42Fn9mSV8RCRe4IbxIUEbvNVcwJ
X-Received: by 2002:a05:7300:dc94:b0:2ba:6819:2e9b with SMTP id 5a478bee46e88-2c1095a5302mr6126697eec.3.1774301979400;
        Mon, 23 Mar 2026 14:39:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d01f7sm13145631eec.23.2026.03.23.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:39:38 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:39:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 04/10] regulator: of: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGxgkWiPLy8XePz@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
 <acGFksyx3SA0kJ5b@google.com>
 <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>
 <acGWJf1AGXT1xduM@google.com>
 <55abcc68-747a-468a-abdf-b6340d658c4f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55abcc68-747a-468a-abdf-b6340d658c4f@sirena.org.uk>

On Mon, Mar 23, 2026 at 07:58:14PM +0000, Mark Brown wrote:
> On Mon, Mar 23, 2026 at 12:41:59PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 07:05:13PM +0000, Mark Brown wrote:
> 
> > > I think this is a worrying idea for core code like this, we have
> > > specific firmware bindings for specific firmware interfaces with the
> > > different interfaces having very different ideas of how things should be
> > > modelled.  The chances that firmware agnostic code is going to do the
> > > right thing seem low, and encouraging the use of generic APIs that might
> > > happen to run OK raises the risk that we'll get firmware vendors relying
> > > on them and leaving us with a conceptual mishmash to sort through.
> 
> > Firmware vendors can introduce incompatible DT bindings and have them in
> > their devices too and we have to deal with that... 
> 
> The case that's worrying me is mixing the ACPI and DT design models in
> one system, and especially having that happen to actually work without
> modification purely by luck rather than by design.
> 
> > I think if this pushes closer ACPI and OF schemas for at least some
> > subsystems closer to each other it would not be a bad thing.
> 
> I think we shouldn't be encouraging people to just throw random stuff at
> the wall and see if it happens to run OK with whatever OS they tried
> booting.  The differences between ACPI and DT in areas like the
> regulator bindings are fundamental conceptual ones.  There's some areas
> where things are closer and it winds up being fine actually, especially
> for leaf devices, but there's others where that's less likely.

Maybe we should just have explicit checks with nice comments at the
beginning of the schema parsing stating that this schema is
intentionally restricted to OF (or ACPI) in cases where we ave distinct
schemas? This way it is explicit that it is a thought out decision and
not simply a legacy artefact.

I think we want to hanel software nodes because they do not
form their own schemas, they follow the existing ones (DT usually).

-- 
Dmitry
