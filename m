Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA083803E7
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302070; cv=none; b=dSSY5pH5qZt/T2a/iBrtb4H5vs8nRx8bh8gNcVZv7ecTdWP70lJWdLnYc6iQTUzwrLOqrcnwehe41VenW2MlE50oUrsTkS1EVYUPfF/+wNIGgmvzVQ3R6JyLMFrAgZTbe0rM0PoFQXi83TyuXMCUiD0CFQLRFzh46mPqNlNoqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302070; c=relaxed/simple;
	bh=Ia2wOeaNxrGGSqm94OjQXh1deCH4whLtBppic3PUk3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKQWXUacUvKQkp3GHUIXHcM7ya4dQ4aAJ/l+jNYr2KQa2Va0wjtdgDnrYlyd6lL/yYPixyS7JAHMliIrCwAZQu4gv/ud4tteykn968rxclO+0NAMHfHc9STvgC5w4Ll7dZ3lNBi712vgNa70k41AfLwdhxWXcw/1Qpd3u8J4mDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvOMxUP3; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvOMxUP3"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12a747e7b2fso1117848c88.0
        for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774302068; x=1774906868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7HCZ5YthEu6Sto4GADNi5rznGP/hi6UoU7AjdQU+RY=;
        b=bvOMxUP3ynayoZoyQiQubkhgSB8gwVBqoVcFi/egyb7w2owvUhwCU9zc4g2v3ctqCD
         B9O8oZmoaNmgoTpSUMugSavwhcQw/Mk62VoF8VU3NhecFu88XPN8zcD+HbSLj0oXUxyC
         Uak67PuSuJwMSOBapnvPrhpdLqV1WnYkFhMp0VHFSaRHSdPftLaCsO+8090CSi/ZEuUY
         H4EOf4cAnGEcPNfQutrSMyl++XsVQ7+a2ez+143H+ogac1wgD6++YgqtDxYVnCbtV/JL
         8MD7fp/sk3fLbgxnYX3lRnrh+ZSq7NEE7mMTUXvIWVLVci3z7Cao4NWPVIreNe+fwAv6
         4UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302068; x=1774906868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7HCZ5YthEu6Sto4GADNi5rznGP/hi6UoU7AjdQU+RY=;
        b=KgmaoCX6mxPf7dE6nRWnXx/qfaZl5FRJAK2VzTtZSQbPwjp6Ce1ydZxyMZZSeZvYCk
         1Ko6HLJwBdxXJocdtDIDRBuG3iLWy4azq4D3hmaD1xuqG7zr6R9eRZ1dnfFA5vosDavl
         tY1sYa6LmCeMdFs9ST9uteLIbo5Vr/QA2kQiJoEafHz+wu0s/Bn5jHQoYSRuyKKiaHiB
         Xdcy0Azq7Kh8SOcAOCBg9XeuEKoz33nx1bFrXdSfWQhcQZNBv7q4N+F+nVNq8kQ6io67
         mCimdFCABJ9AorCZBZ0XTlBzuW2r5PstVTUaWBcb4xDFdT3utYIvOmyhjzQ2mD42Z3Jd
         hifw==
X-Forwarded-Encrypted: i=1; AJvYcCWEFV6qZmVzBJP8um8sUEtgQQCjO7qTPv04amlXUH9D0ysetQAlShTI4yLY4/Zsa3AVY3E7l2V78oIi@vger.kernel.org
X-Gm-Message-State: AOJu0YzSemnhRHesm882cKBOTeRfmQdDCVTf3e+c+oFdl8qamo0Yl34W
	Xdl4ukQoCUR9y2jMs5fY2hd1g3s/Sv5o4ep2z9l+7YNbS2L0CEpXdE8H
X-Gm-Gg: ATEYQzyV7QSousNm7mqIx2534c3CbCaDOdHfWCHJriE20BM8+iTl1duNBOdbLz2Vglu
	4PiKxoReeaN6/+NFPWYuMip6Rj2ibmQ/D9JQQ5QALPyhHJsWoTb2jfUGDglfTYEwlE/zaQB3prC
	CBZP/TCiUDEhIe57Nn3GjEKnu9SUPuthDarHTdziW3hYTjFgNVp2VnYSh9H9kc2vlR+JdXsYmQn
	LrwncrjnZGzr9YDlwWYcqV7x7lmzksXl1G1kWFlJ1zvGhKwx95rLXbl+2PvZ+TV8JnnWLj9vs9m
	xtMx87QVY1qn6FbHUg5lij+j1BAVH1NmyV3imbi8F7+NPcZrrSBI8ybSmug9EJ+xwiNlnR3Z2t8
	asPQoZ1yIO+VaHajKwfvpdnOAhnXBqLw4NtlVFU08WjJmGkgNLlN/pYXidsvvrZDJkxuCwU7msb
	dmjG/A79F4kJN4MBvWX0CbEsP8pK0DrUmAs1dLpn+MoUj1Dn3fTQA81RZvqrk1DjwC
X-Received: by 2002:a05:7022:31a:b0:128:d24a:a5ba with SMTP id a92af1059eb24-12a726cafe2mr5295048c88.20.1774302067990;
        Mon, 23 Mar 2026 14:41:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733d199asm9682893c88.4.2026.03.23.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:41:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:41:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 04/10] regulator: of: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGzJV3vKhuty3nd@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
 <acGFksyx3SA0kJ5b@google.com>
 <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>
 <cf92122d-6b15-458a-bf89-189a0a6874f7@lunn.ch>
 <193e194a-498f-464f-b22c-c283c16db6c1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193e194a-498f-464f-b22c-c283c16db6c1@sirena.org.uk>

On Mon, Mar 23, 2026 at 09:36:07PM +0000, Mark Brown wrote:
> On Mon, Mar 23, 2026 at 09:01:47PM +0100, Andrew Lunn wrote:
> 
> > How do you handle deprecated OF properties? This is a problem i've run
> > into before. A developer needs an ACPI binding, so they blindly
> > convert from of_ to device_ without engaging brain. As a result, they
> > bring all the deprecated OF properties we want to die into the brand
> > new ACPI bindings.
> 
> Honestly that one hasn't really come up much for me - not too many
> deprecated properties.

Given that we position properties as an ABI even if they are deprecated
we supposed to handle them forever. Newer properties usually offer
benefits over old ones and that is how users get moved over.

Thanks.

-- 
Dmitry
