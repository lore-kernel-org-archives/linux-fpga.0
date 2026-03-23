Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662436164B;
	Mon, 23 Mar 2026 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251831; cv=none; b=AbYDSkE+blUFK+d7mgms6PZlEXezkHd3Jz6kNZIfdxZ24yghHEdVT5sxw80DbU9fIdNEhXp9GOSCGiSg30kHOvHmVAd9gYjrF8FT/H+Q2JM25MPout0AwQIyL4MpDMawXmvhUCrkc66Di5zNDwvH+maQ4rsRqhFdhzTsboBXm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251831; c=relaxed/simple;
	bh=lr5Fhmgun0YWB96hanC0s/lc635kRBaObUfJNlkomyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc5dNxGacj+z/0nhxClK7z4FydJMxlECGfhgdz/rzWpOOPgytcE6/NV0zDD5ZpiNMAh+lOyQqwddR2JfsYkpBOjc0FbzSXLYdZLvtJqdNmWUp2MMZldcx6mxlZCDm4lL5CefVnqSGu4GaaiR7khm5UKAv7hLYx6/zxy0PHyE3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RmEl+Fru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RmEl+Fru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC0C4CEF7;
	Mon, 23 Mar 2026 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774251830;
	bh=lr5Fhmgun0YWB96hanC0s/lc635kRBaObUfJNlkomyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmEl+FrurzTKfi+DrQDWO5WCLiGdO1TjB2N061ypBfroEMSGfEtJ7xKT2isDCZEFr
	 PD654e+uSKF5iqt1M8EEqEVxr7PW6DpUCsNgi07TUcpFnQ/GST+cWHFNU61ODUd28e
	 vZJjr3Q4LbqEkvaeQMg2O2dzOchzgGj9VmR1W80s=
Date: Mon, 23 Mar 2026 08:43:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 10/10] driver core: class: remove
 class_find_device_by_of_node()
Message-ID: <2026032321-freeing-outreach-be2e@gregkh>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-10-b72eb22a1215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322-remove-device-find-by-of-node-v1-10-b72eb22a1215@gmail.com>

On Sun, Mar 22, 2026 at 06:54:28PM -0700, Dmitry Torokhov wrote:
> All users of class_find_device_by_of_node() have been converted to
> using class_find_device_by_fwnode(). Remove the former.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  include/linux/device/class.h | 12 ------------
>  1 file changed, 12 deletions(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
