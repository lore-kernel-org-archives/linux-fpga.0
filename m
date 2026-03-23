Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E63CF694
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290517; cv=none; b=oNQv+w7jJJKotkw/GdOTfnlSUU6taPl7zjM9Js8H8DQ6dQrOxyf09ZChCHr8X7ry36t7Rw/4WG3UD2TOihfxo0a3s/RDxFNINsvO0xKmrrfXiS6KXPt2cDKx+Y3BlCgiXrQtEwYhJFbm75PlIC4LJCxeVZvF9+VKSN+/CFeGvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290517; c=relaxed/simple;
	bh=t8uGoOmn69GTvslBxUEc5eTMB7ZiO+nrKn47M9Cp8FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVADsOtcr6gzl25FlhEsb7VEMXh+jxfYe6EBpxNdjEZhLUynN9QIsqk8iePwH0k/1CaaQu6GdqjGcACjMxoVVG0Rj32cPoqM5RNnvuVJBdo62vUxsE1sEUjf7hVlrCgEzSeokyITEh+L3pBBcicn1sb3olWAO8/AIOADU0M/nCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU4LxGOf; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU4LxGOf"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c0c955a481so3556204eec.1
        for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290512; x=1774895312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zDXVXDlTyWriMoHabs2g4jaDjhygWMksayJaNvHtSE8=;
        b=nU4LxGOfPs3QZ3q1BOHY3xW1BsasEVECfsn054gvduGccyJOdGSSriZyQel7ZZuODl
         ND8rPtQjMEovixdtNdNPwz4OydDcycp5pWW/3m1fgC5jMQKNUFPH7NGtKsQK1IfKfrh9
         Rqidd+o/bKJ8/7fAi7cuedl4la/kRsdBnWlhvXPhFzz0J2hgto+9uB1E+I8bK+rQylJi
         lSKxKrIbr7b/Jb/WJJy2Mj5pzoj2OD079F/dp9rrMqkSgsYnMnG4IjOOa44gvtMGJhqv
         B9oDuQ493ayNmc/UX1pJrrIqdmYW1NQWAO9Q0QIVybo3KKDYoESuZZMQdAQSGs8k+uO7
         teDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290512; x=1774895312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDXVXDlTyWriMoHabs2g4jaDjhygWMksayJaNvHtSE8=;
        b=YgF6ezCydDva+GDq/zjmnQHzYfQcF49TaegswLQes40kh9C3cVNlZ1c3ZkK7hMsDzM
         a1iBP+o1yFjt1Q7DbFWpT9Yvav/aXNsMBR0tafCdPpwX5iMm8fSaVD5kIkhJoapZl8Nt
         C+CH78LN52gXTeGtjcruSKLuP3BY2yJXOazBBDzNyahI8AjTWixv474iTVTzuqXATWVb
         PC+wAQZXvPfVxt307Yt4vY2xOIjuloBS6WSZW6hBrfZGW3R7/UhXKnl2NSD5Z4mXqzpo
         QaXwLJUX9/GxQL8ivpVaCiBLWlDYUBNOO8vwdGQ8eqh+XGIyNIly93bg9jrW+PIYgWCT
         5j2w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0OeuKf2dPdMH/4FgPcVjr8hRlDpgTTnunitPcrb4Xxr9xujcQ7U5YJZ8pywHfzoxbIhvsbeNbPwY@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWIU7fVQ3r5DN7+0eCcBacpAyIbLdkgyNSBEWZt+qI/83Z1Ek
	SdOGPDM/7GEoL/FK0rEVID/1DzihjwcpV/K67ILggz9pbU1x5QQz5SNP
X-Gm-Gg: ATEYQzx6v5AI0RCryZJc205hlpVSC7q6NT0ESRI+L8rzKvBY2CqNGIXHikH37MY+fdh
	0xvYWzEogfiJSgHTKe4nJ74m8UvEcnXuhvf+4E2rqxZW16lvMmXHoI3iH9ybATty8nfsu2AmEtC
	u5Ry2a24Svbxdy4uk/gty0KfiOfuB+PZHza4EG2r2dkKbRogTvH9GOrjqt6A41Ru9ZrIc5D9V6j
	BzX+wzs1lIeNtUKOBCHNzSStdTcYdtn/TAHh/lSzgih7Rfgek70QCO2j8PvxXocNxLuNxxHXkcI
	dkoRw6HkD2RDfVCZt7sn68Yq0A2oiG/1txxVumJv0Zdtcge4w0wFhApWTNZIVVEaWd28k/fv8c7
	R6QDScW/Hd0hrKjDViqDIcrNPCOz5I+ABFgN9G/CLUCaP3pEUvIMKgYfQDJ9C9Rbyu3goAESzhn
	IDc9uxQ6EXSaYXLINrSqYQaK1qrTXgyadz6crbkaWY+B7zEggRaRcch49H4DK0tF69
X-Received: by 2002:a05:693c:2b06:b0:2c0:ad52:e657 with SMTP id 5a478bee46e88-2c109712cedmr6434030eec.21.1774290511733;
        Mon, 23 Mar 2026 11:28:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b8f2sm17872306eec.9.2026.03.23.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:28:31 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:28:27 -0700
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
Message-ID: <acGFksyx3SA0kJ5b@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>

On Mon, Mar 23, 2026 at 02:00:43PM +0000, Mark Brown wrote:
> On Sun, Mar 22, 2026 at 06:54:22PM -0700, Dmitry Torokhov wrote:
> > In preparation to class_find_device_by_of_node() going away switch to
> > using class_find_device_by_fwnode().
> 
> >  	struct device *dev;
> >  
> > -	dev = class_find_device_by_of_node(&regulator_class, np);
> > +	dev = class_find_device_by_fwnode(&regulator_class, of_fwnode_handle(np));
> 
> The regulator API is very deliberately specifically using the OF APIs,
> not the ACPI APIs, since ACPI really doesn't want to model regulators.

For now? We also have software nodes and maybe we come up with something
else in the future...

I think we should use firmware-agnostic APIs as much as possible, and
only use OF- or ACPI-specific ones when there is no generic equivalent.
This makes the code most flexible.

Anyway, I am not proposing to change all of the regulator code, just
clean up driver core APIs.

Thanks.

-- 
Dmitry
