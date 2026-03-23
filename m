Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C77383C94
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306130; cv=none; b=cjGI4Lt27WRCOHT3TFdoaNdo19GZMRMRFkgwNe0QQD1lZ2NzOgwqi7iJrMJRAF7gPbc+mJR044H47A5OnJ865uKdTs9v8u5I+D3eKi714DnmPFRffPIg4T+mi88WwJZj83u123ArBGnn3MLyD/3HP05fURaG7aANETwAqOW+StQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306130; c=relaxed/simple;
	bh=RMwiUT2ca7SpehwMARA0+INqWPmeSfWclA5GGkGeRtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahSDvcRnQrxVr54WZFf765FMtRKJ0+JgE4AHZoqn/hcHNPACOIRAsRGN8CwcAfR0dIIwyM5dxxbn3G+vjDVn+icOWiZC4sN3XcSMb0TrCzTA+J0B8JgRAixfLEnmK+cKEYDk/erTrfTVl7CqXp96j9dAHJt5gAREeksMrufLOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSJqU6De; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSJqU6De"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c0ecaae7dfso7782612eec.1
        for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774306127; x=1774910927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGbAPMtb3fAC8y7bB7RIg3tLmv+zXAom99Sn+GnnvxY=;
        b=sSJqU6DegKv7IdQwHWHwBn6RLPAtdU3yFxud7ldnANkyYkukyvjOiHZd92mNeVkVHb
         qQvZ/+BhQsaC4E06XMg5JJqllbYc1ZSxTTwZB4FsBGCY7Fht0NX+bJGZKsNtHhohmSl2
         qyirqzYfhLMuUm2bKIJxYg+pnUKHNrzN4aRavXpgtxKgroaEUqks25YTCmSSCbPsNIQ8
         l3uRYfIVWD4e5xdMof9QZ1y4DtsVgmjOrRpMYePU2RsvQFlN5v3DXW7Rnos5EMaqvSBJ
         3O6vFYrgmbOxNe8jNyJCRG0g5wCK1zJIlN+BaKRzpbXNPC7n8sluOeE8rVgzkPzKXc8K
         M0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774306127; x=1774910927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGbAPMtb3fAC8y7bB7RIg3tLmv+zXAom99Sn+GnnvxY=;
        b=Dh6gfGKWL53S3fYEU2OCLHav28zgaoEbrzzJkoZRhxlPWNaHarYdsk62HxwcfbFel5
         fUaKq9FRNzUrUuYQyoydnWFk3F/2B57AauNoWL7CfIlJM1ZmnhKeRh5+NSr2XvGv1oay
         jfWbGCeZzG0RrxlXrnRjDv+PtB9jWvouYhQgRajdlCBXHJS9SQ6JXhUEpHw0+dE/4mk1
         8CXLK1hSKRRYMGL0onvRm+7okN8tqqUyuQT8SEFBxfcasPDqNfNzzwpDD8DL1Fw9e++O
         NbcydQmwK9EmXaG6mp4QHfimx5+AAAfnDeiYwCU+WjA4t1MlEUHDLmY8/2/sD1G+RlTi
         N1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAhFMJKqhNx0fL8e7iyCDtsFvGtuGt9i5X1RoX717QrepB4AZN/uMVoeJFdzhsL3X0nylCG7io+yA2@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBvVuN6ZcvParKghO13UtueqoMzd9HJ7hB4Mb1qTDe0286Azu
	WXrTvbDanS2O62b9+VvYV0VaptwnuxHZR2+OGxCsmpaDpV5qzWlHOG3x
X-Gm-Gg: ATEYQzztweq0Fa99LAb9dSreSajB/J4WFAydlGwW4/vrrXg5IuveBSgGi6JfbZndJGZ
	JiCdOQ/pxsm/d8CbgukFPgqg78O1XJEFNjZ610HQAkPToVm4SIkPSZ1VtpgswIkYA8xspvA6mdn
	TR3bKjNOjlV65QSEWPvspa9IIhdncuYMNhaNDMRXVAXDCL6DzPBX1Jl1fMPmEoNWodqv3jsq0uM
	Yu0Ze5KNOVwMnx9lEcVGWoPkwwFSu+lDvy2jAJ/WjlengJRv7zb6jokCN+91hULpA/j0tVxDy2i
	2mCZzXfjtxPDyRmtnC0V93fE730tHCLy003JGtyaAuqEGqsy6IJqF7Vt6zQ6YFnxVkqGKXXIvSj
	cwwBoZ558JUBi30BVb8HImmoaO1ZeMfFMayCT7LaQI+pPxz3cKDUeoVFkqFrtltpDk851D4VCzI
	ePADs9CH00hB+sjPBQNRPxyzdR4klbXWc5dAcJWiiLr/qJ+rPOO76lEkhmhQ1CGC4i
X-Received: by 2002:a05:7301:9f0c:b0:2b8:4c95:365d with SMTP id 5a478bee46e88-2c1095f54afmr6740228eec.10.1774306126689;
        Mon, 23 Mar 2026 15:48:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c1313bf5fdsm5080230eec.14.2026.03.23.15.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:48:46 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:48:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
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
Message-ID: <acHCIA1d5-s2xkvz@google.com>
References: <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
 <acGFksyx3SA0kJ5b@google.com>
 <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>
 <cf92122d-6b15-458a-bf89-189a0a6874f7@lunn.ch>
 <193e194a-498f-464f-b22c-c283c16db6c1@sirena.org.uk>
 <acGzJV3vKhuty3nd@google.com>
 <09072374-65e7-4792-af7e-97d7df93f9bd@lunn.ch>
 <acG9BPkFr_De-ulu@google.com>
 <27f4ed63-08a2-4621-8943-c50261de31cd@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27f4ed63-08a2-4621-8943-c50261de31cd@lunn.ch>

On Mon, Mar 23, 2026 at 11:39:03PM +0100, Andrew Lunn wrote:
> > If there is a deprecated property you can do:
> > 
> > 	error = device_property_read_u32(dev, "prop", &val);
> > 	if (error == -ENOENT)
> > 		error = device_property_read_u32(dev, "deprecated-prop", &val);
> 
> It is not as simple as that. There are a lot of optional
> properties. Say "prop" is optional? And not present. So -ENOENT. We
> then look for this deprecated property. That should not happen.

Why? That is exactly what you want: you favor new one if it is present
and fall back to deprecated one if it is absent. And then you decide
whether to continue or abort.

Or you are saying that new property is optional but old one was
mandatory? Not sure...

> 
> Using of_property_read_u32(np, "deprecated-prop", &val) actually makes
> it stand out, it is special somehow, which is good, because it is
> special.

If you only have of_property_read_u32() then it will not stand out. If
you advocate of using device_property_read_u32() normally but
of_property_read_u32() for deprecated only - that is a possibility, but
I do not know if anyone does this.

Thanks.

-- 
Dmitry
