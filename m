Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A640382289
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304459; cv=none; b=IrAqK+IvJjli3n2m7zVTrB0pSCeJxREpdIk9ZcW/mzGsup1PuJHOGHtuFgmQiNxHooDbEeQYbpSueoOyMF/Z/jHyPGXUd/UCmi6htvSdijj5ClqusJI75j6z0CnhH7dYzmcYmCo9F5LzzsB+xoCXCvqIv9Y8XCRqViHpkbiCo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304459; c=relaxed/simple;
	bh=qqUgVu3iIB9dI3QgPpQ/I+hkv8Lf18eczVPIEmNZ104=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlLjoAbW61eV1MVfY674q6KmmiZzqgy0fggoNNv3NrhFW7mi//PTV1mZc5++yv524kBiES8mMyU+YylatGSBYlIhVvXHSupPgCpB1+rzJbLfEXf3XbKfWPNCCHzB69Uy4326wBlZ7xZF3PxCNo7vQeSv1agIznMDl+eCnDL1P5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+SKwuKj; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+SKwuKj"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c0c955a481so4047463eec.1
        for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774304457; x=1774909257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kzF6SFWkNpwiVT7Tzq/JseNp5uopL7N2rNpwm2glC8=;
        b=G+SKwuKjoYWyLKf8QBIlUiunM/B9ly0uajRi5NpWg7loDqllf8SJ4LJ715Hhu4fpQj
         9pOTFA11serRiqEqRTFAJKW3yUed/hz0+ug/1BMf5gjEzTOT9XRtUywVQe9yEYFuKLrp
         fGY7t8I8clHj93m6jnZdSJxm8jviD2C+6z+gVqJ9VFZwGOUd5KPRAocXPM4bjvGuq/CA
         oaVukfDr5nWmw0YYLZwX01d1qL2DAjl7E6iAftQvBKhcqPREFhYZTDlSQVLGxkihs6Gj
         PUW0kEVTYB8kRHKOD9KCTjW9y+a1un5l/PygVk8Ek70i37H6PRlp50FBVTzI6yLiA9jf
         +cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304457; x=1774909257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kzF6SFWkNpwiVT7Tzq/JseNp5uopL7N2rNpwm2glC8=;
        b=bt+MG/bM28/XoR5k5OPYZ932TDG8UqhbRlh88XUDUWONdm7LK1jb44oTWa29oZgKyU
         RDs3oC6Y4GNXkj8BygINmf18Z3Z+nKWuApprSFUh+XAaUPMN4RyJ3kiHOLTSia1+lb1U
         CT3OSEAupGchreGxB86WX5Nwc3V2fGVq4djgJ9lJxLbj15J7Li211TsW/rXxRUORYIst
         Y7Qt+VaO0LNUEt1RbxZJ4Dd/cYFHgxGGgtG+eX3ls4YhOrkR+9QFiBguWDCo/WA+/Pbb
         gR1K20Dy/Cn5heIfkBwNOY7JcTCURtdq1Wb7yDclsxXjKlXC9Ql+v++zZsONAbwYhAil
         tYWA==
X-Forwarded-Encrypted: i=1; AJvYcCW3N9lLAPgI+EwMS/hXLiiY2o2ZdOhkEmwKtvdE2GnT6p5RIycfxd/cXENUoSobV3CmhW5YDf1K0M30@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+gv/gUILLZiRuXV6DmJsDz1LOJMCxXnsLQkfHyi33qt9m6qP
	wyrkWhMPXqBEYkr57I4F3Yk6FmTBC66TUm50+Jbtd7tMVKizUspNNfhM
X-Gm-Gg: ATEYQzwvr077LBWwQtc2VV4HpEVVxD8RwWL4p/THBO9cxuISS2GqgTLbXbhDzD+nVTf
	1Cl1ucjvwdhKeqF+osjV9e7lMvOmyZwRKy7yLblswbtkQc5saC8az2XTJ6G8h7tQC9JgzZR9DSp
	G+ZzjHjmYk+jq3eQyE2kX5jyBqPSsV8bz7hBt1fo3RvdFzayM9W6gNBj+GC5FU6TdduWKb8+lrN
	xGmdATcERZF6Kh8Uxv4NgbQeg89TNGgpCX3v6i6xuKxsPhX75FcA/DmXDkApgEn0HMe1QIomvEx
	BgZ+AQwWTkxOlGAxG17gENsbq+9lqBtvcCNmsL4eclpjnkxRAD+eWW2xaXlY5LLww0Y6uEb/7Rs
	wBfDUPPt4qhQRhzbnDBgI0mb50G5To3hXw7JkVw7NyTW+EKXn6Ra6cVusaFwPPccTD1hnKQCkCZ
	fYiKGV+5Kf0Hwr0M8nO39/peGzY9MVMppV4erkHlKx0bvmEqAr9jUYsBZYtN//fWD4
X-Received: by 2002:a05:693c:3b0b:b0:2be:ca4:e119 with SMTP id 5a478bee46e88-2c1097abc22mr6650334eec.30.1774304457110;
        Mon, 23 Mar 2026 15:20:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm16033079eec.24.2026.03.23.15.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:20:56 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:20:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
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
Message-ID: <acG4hY23zHHCRywx@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
 <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
 <acGGWTmSMuc5h3Od@google.com>
 <acGI4PI3MHML9Pce@shell.armlinux.org.uk>
 <f37684ff-57af-425a-bb18-bd5e8de3bba3@lunn.ch>
 <acG1JNGVBJ2Mf7jC@google.com>
 <f3c51f5d-e001-4a6d-a219-f2e0698f35f9@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c51f5d-e001-4a6d-a219-f2e0698f35f9@lunn.ch>

On Mon, Mar 23, 2026 at 11:00:05PM +0100, Andrew Lunn wrote:
> > BTW, why would not we want to push for the unified binding? They are the
> > same pieces of hardware...
> 
> I don't think the ACPI committee would be too happy if i ask them to
> throw away their standard and just use DT.

I meant if we are introducing a new to ACPI schema... Not throwing away
existing one.

> 
> ACPI and DT are different and we just have to accept it.
> 
> Nobody really cares about describing networking hardware in ACPI, so
> there is no need to support it. KISS and keep everything DT.

OK, but even for DT I think we should be using device_property_*() and
fwnode_handle.

If there is an ACPI support for mdio it is perfectly valid to use fwnode
handle on an ACPI system to locate an instance of mdio bus. And
hopefully the caller of this function does not really need to parse
properties itself but will use mdio APIs (mii_bus).

Thanks.

-- 
Dmitry
