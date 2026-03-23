Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F7299AAB
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243042; cv=none; b=RE7CtjQMpskxdykj+sCuZKi7KBnJ+l6oFxHQq625lG6d+heXyCrBw5ga2AAsBzv+ms8aR9Duoh0HRnEWJyyNFG/JI+Zw4BCbwemupdUS5Ta9Py+LYKKQwDy9acaKqmow+DqxC2eAMltqhJRsC7G07eymFOoOzpQ8NzyNUzWUSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243042; c=relaxed/simple;
	bh=pfWTJZqaVhDCbFG2fAE5ptgG+qJ6NN4y7N0S/smJD24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUK59TTG4noOKCKGpGr+3LB0jM0jLdMypWE3e21cTN9nTbzjmmDvfajcTrgj7llDuZlgnDjC7BvpkusxBrOpfQ+m5aG/0ynPelA04pr99JTEun1RZrsy49IBceMWk6B0iZL1VjkjCjhe8VRlDEahz8kQvQnAX778HxM1C9vzm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHV+rjR4; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHV+rjR4"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3665603eec.1
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774243040; x=1774847840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jpqkfz7hZUs+vzaN1OQd+jtBYhuxG1ZULSLXTe38VI=;
        b=EHV+rjR4uLE2ZpVupR6/bntiSBDG/Xjb5SHch7GJZGBpnXq0cb0REaAR7geSu29UrM
         5f7t+R/0xF+JpLTTxsRPkKNtbN5eM8qEbd4VFKyaleEqyJikeXu6Jo0Prtqc8vp7xc/+
         JZjpYHmWQ7uVLX5Uy69gei695XxH3x3uxRYV4PI1+Hws9GTFcZEpcbxO1OQ+0VWXOSJI
         QvyMOrDYlCOKfEIk0027i5KQzPvZdtfnNYZ/+sUgcToiU//PpSTneYASnyag4K2jlN0w
         dg5tUScdeD8qJJP9nS3Hgo41ImVOdp1BcNJh+4vCwLNwQU7ByFppk+DuOcGxk/LHItOp
         eSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774243040; x=1774847840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Jpqkfz7hZUs+vzaN1OQd+jtBYhuxG1ZULSLXTe38VI=;
        b=KZ4wr8AdZsK+dKVz98CuqALbgoh+H/CwpnVEoC4R/8ePB50tn2HPZfiEuC2w+tx4ds
         mXhcU4lP3IiAgpprdvB0bCPBCX4B+U1aoHdsT/mSmNW/VyIkzpBWRAP49Mm+istdbNbc
         LD/utsq89u9eu+WkzrxoFXD2sDhvUj1u2OEo/TEUUBEWEMB93SOLbqan0Hjx0EI13bx2
         4l6ptQIUcJD0sqgOV5KaBv3wNZq3QBFJJQrSZaXKV8Peu2oljoIYrbIs3qtTxRQnCVXx
         3XektMNTeluBTBdwX0SEGX2YzXLGmksWe7X8oBG+WGuM823KKmKIwTINOWXUNzYvPmCl
         shrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTAwIQ2B7Uv1UDKAqu1ycsC18aQVVYvZfOl0zVn1KAhJfy4TSkOmOf2YyY/0NiO9Kuzfqx8+45j+6L@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXyAGiMqCe+yM/Hm1rnUWdD21tzTVHruPO8juDNq12PdDPp2p
	PJ0K0DoEQY6rXBGi7QBeF69mYxb8R4k5+1K6/lZPl4VzmNHCXVJzHXaM
X-Gm-Gg: ATEYQzyHbG4NnIXf6TY7+AnQc5wt4GfLAqEFhUkFo4z0CyaIs8CUpEMj8rCjsGrfdm2
	KlOBZF0QxS0ajURM8C52ABL5D7TLmbdsXicrJJjpwpHvBpQjolXrMKsGYWP1690Ggar56YabB2l
	xdi78SDDD4Zh+orUWl+UzazN5qQoxP7VvEIrHNEF9XXSPwv9CChSktqsguLPt2YB1TtEgza+FjU
	aZGVyAkpUFGfxhBVPpLe8+4mD8iRtb5l9cGZt7amqEFBweFQ6QYh7gXNQw5COC1bkW9GH8cUyeG
	p1N/ZVh8k+ftbbFTuplTVtNk3Xt3n7Q4SAVNFnXT/l7T3hifK6myyz9wOl3/YDLZ1rP8uTK21M+
	UchhY7L+Seo/84XuXzAT4GCR2+JcCc0A1GonJ7lU0y84nddbBRe+6EupzNnt7iMrRgxC5EJ6UXs
	udEZV1iCF32JTBrsY5U8Cj57H0BC/89myfQCjzE9ogf/Isxv3sUz+nS+OKus9dWhQE
X-Received: by 2002:a05:7301:4198:b0:2c0:c775:a46b with SMTP id 5a478bee46e88-2c10961ef1bmr5539127eec.8.1774243040114;
        Sun, 22 Mar 2026 22:17:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm13470084eec.24.2026.03.22.22.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 22:17:18 -0700 (PDT)
Date: Sun, 22 Mar 2026 22:17:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Rosin <peda@axentia.se>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Tom Rix <trix@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 07/10] net: phy: switch to using
 class_find_device_by_fwnode()
Message-ID: <acDLzK8vpptTUMf1@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>

On Mon, Mar 23, 2026 at 03:54:09AM +0100, Andrew Lunn wrote:
> > -	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
> > +	d = class_find_device_by_fwnode(&mdio_bus_class,
> > +					of_fwnode_handle(mdio_bus_np));
> 
> When you look at this, why is it better?

I think we should move as much as possible towards firmware-agnostic
APIs and use fwnode_handle instead of device_node or software_node or
ACPI companion. To discourage this I think we better remove
firmware-specific APIs where we have firmware-agnostic ones and
eventually clean up drivers that use OF- or ACPI-specific APIs.

Thanks.

-- 
Dmitry
