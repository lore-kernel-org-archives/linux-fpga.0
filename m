Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B32DA74A
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290823; cv=none; b=kNWJ/pDn08bFkcylSNgKFKyStOInBO/e9Ts96pAufKTbDozuT9v01RYYl1PslxJdrBLKZIfhZBN5A388Lf0T/+eCP2g+0CrmKBKuKaqRr2k66Fp84z3anrBjaz67JEBjB8Drf0E+rLP62WRlSX8HUK7XocDHlQe4zFbogEFl8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290823; c=relaxed/simple;
	bh=6I3TCajsnbPhvopolFVK3KO9pDXc1m1XrVrTJSIDMJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0cgJQvf4tHniACjE1NBr12Gan6asOQI4undIAaBhU3393ItA4ErALk9bmOXwBZxKHs1blF7lpVzWeGkxwf0mkHQXWWVH8HfABc9X7re+RIc5EpTYW4Tf6rhShO9x7v0sDeNh30qPyI1j97LqSNq8CTcgnJWmgpZxDSJ332L27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIw+qtLG; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIw+qtLG"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12a71ade78cso614438c88.0
        for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290821; x=1774895621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnYjc2faOHjkbaG+X0+KOSaQNDxXMdAftkLY6+CZb5k=;
        b=tIw+qtLG94A2vyctJ1nrIkpgQyY6GdyXSxudWeaEhia18nDKP7H2BlmAo+bzO1ezIi
         SZroA2JPns9tsiLeMtLDEP0iBAiDMhPuwY94Ch9vwu5Nb7kzxQKSjlDb4Uno3JOQoPva
         3p2OdOAudQkBOZaHWSaWAPNRZn/OsnD3dJKCN14jNHAD4DaXu3hF0f2dE6vn9ewGTpKy
         D711seWX5f00wu6/sVlnQL1F3p+/WbV/GJbZo+cZEXwy8JMK+t8PCfvRA9LLH51zU9st
         LzGjDoaxrG7NJQ86D9iUasPVzjiFa5zJR7vWcUGVKZIzLnsmNHxMwJgLz8UkPqUu8jAo
         9G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290821; x=1774895621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnYjc2faOHjkbaG+X0+KOSaQNDxXMdAftkLY6+CZb5k=;
        b=rwXC7/Sy7y/UXwGTZD98NJF1lIch+rTfKcG8RKg7q3PM5omXLGR7Qp8ddobPncl0Ti
         H+iyWVKWEMLUvim6Bon75ySaF/66ikNLJSwXXlHp9gcAykA4M8Jd864+WqLfQwv5ikyb
         +SXhA2/uF79ipNRLQ8L6VdEepFlAXaEicTo1itTb2gDrMJ5oQ0+BQThdaT1/WWyNXEB0
         XH6uxY0GQ5FcDeNWVkUN30kK+AA3dFXDXkxuWB6UI5wW7OWJT95mMpXXpEuWAHXJ8Xvn
         oprlzDX8bQJaP+bCfxQ1r4pp/z2fh3JijG7NzeV1mUSUtE8Wl1JimG/146pDMNOGGXDd
         iW0w==
X-Forwarded-Encrypted: i=1; AJvYcCUnDAbpckuWgev5W9mkAweyKH8X94Y57rqEI6vLQGfKMLSperCx7oZFvmIIWD3dZtYXgtcKoAiy2OF5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uRow7h/Kwupn+ocAbOxdVd+SeowwgpljMReGvHNDJzksmy3i
	6jGk/S8gClTd7FbjOlBiic8ffqL29fFldH2z7iIuNochH13wxxUoKbZR
X-Gm-Gg: ATEYQzxkSI8Ls1YRKK5pjyaN8smZyZomWtVxrubxDoO2E7RpQWhuou79WauzwZHrLXZ
	9q8fzSa67ruDuTdE6JHuzz1dMdRaXPeEGohpp9MlN4pPPHbfJLtekeKzPQmvwpPtrHByf3dopJw
	zBzZ4cs1QI9B4GNCZ6v+gwF/9R3iDBrsQLVcmJBRcRMmw7nZ1FgNlRSh9rNYFjwGaUrt+0xEVvE
	GgqTf4EGzAWHPH42hlFLQruv926A5WPrrxlWOZm4BJCh9++M6X2KkBMlp55O21JujVr3BXZ6j0b
	/LnBAUK8fM0kGAUCwEUd6zyyQVwVIQXNTPxsO+2mQwyPUKTlnu7MDikAmchxazI/B0LZGiHRC0I
	DtBeoj69IarsL6MktgWKKEkNn+YG34MzfaIkVX/z9JDzQvs8muWrkf4+qkT7nO/0q+9ZqAOVa+B
	224jdZhezE7xvcRpKo5aY5b2TyWK49/9vPiKJUQui+q+z36PdIsmgCyEbNhgvASTak
X-Received: by 2002:a05:7022:4199:b0:12a:6c7e:bef2 with SMTP id a92af1059eb24-12a72671ad6mr6133919c88.7.1774290821078;
        Mon, 23 Mar 2026 11:33:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733d199asm9391030c88.4.2026.03.23.11.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:33:40 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:33:36 -0700
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
Message-ID: <acGGWTmSMuc5h3Od@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
 <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>

On Mon, Mar 23, 2026 at 08:59:52AM +0000, Russell King (Oracle) wrote:
> On Sun, Mar 22, 2026 at 10:17:15PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 03:54:09AM +0100, Andrew Lunn wrote:
> > > > -	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
> > > > +	d = class_find_device_by_fwnode(&mdio_bus_class,
> > > > +					of_fwnode_handle(mdio_bus_np));
> > > 
> > > When you look at this, why is it better?
> > 
> > I think we should move as much as possible towards firmware-agnostic
> > APIs and use fwnode_handle instead of device_node or software_node or
> > ACPI companion. To discourage this I think we better remove
> > firmware-specific APIs where we have firmware-agnostic ones and
> > eventually clean up drivers that use OF- or ACPI-specific APIs.
> 
> Basically, no. This is wrong.
> 
> It may sound like a good goal, but there's an underlying issue. This
> goal assumes that the firmware description in OF and ACPI are
> indentical.

If they are different then drivers will make allowance for this, like
I2C core or SPI core does. But most of the modern drivers use
firmware-agnostic APIs (device_property_*()).

ACPI has allowance for device tree properties (via PRP0001 HID
entries), and drivers should work with them.

> 
> Sure, looking up devices by fwnode handle makes sense, but looking up
> anything that is described in firmware is not suitable for this kind
> of conversion, because in doing so, you effectively "port" the DT
> bindings to ACPI, and it may not be suitable for ACPI.
> 
> So, please don't make wholesale changes that transfer the DT bindings
> into ACPI.
> 

I am not "transferring" anything, but I want to make sure the code works
even if we augment OF with software nodes or if DT properties are used
in ACPI.

Thanks.

-- 
Dmitry
