Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B43CC9F8
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290317; cv=none; b=JS4fnrpP9PwX+O9MthPtUJIC1JzEy5NzrDZtkRe3SRXa7mZteTHugSnvXwpJ3wVn/C6+jjgs1uaQX6rpSR7spavxvWWDeJ21xTCX4ZOW7Jpyha+ELbSCRHeeK/Y97hK38e6SPFGWFUwDIuURzRkRugWyS3fEOy4Y2Y33cfZ02Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290317; c=relaxed/simple;
	bh=n2Px9KvrBSca+8wbbFZSgIYdPNKBUj7GDb8kCwrntFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5Un0e3px9/UFarDWgnAwASNgSMuf8UTtD2fo6SE2K498OUhIlVscUL52LeYo4BMT/HpFKE8WKe9yESD5r99gIgd1vXusj7UCMV3lGNvAvDphlQqtASBAqx2EaS2fUTdi3nn4bZxMePtUb3Bjk3pvj1ghJCXXymuAx0wnXYSfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6BhqKuv; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6BhqKuv"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1271195d2a7so870710c88.0
        for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290311; x=1774895111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+l2i6CJ0UesVmQ48tC67wDfEsqc0p6X8zxC51ds3A4=;
        b=C6BhqKuvTpMhqlgVXLg6kGG0gezlJsDbJftPaxV/tEZBZA6D9EC2wRDTvqtCMVxwz4
         /8ZOvMrwAa3W5fYzMgFaX3I6Ptx0VKBRK4Lgpt8ILJokWwtxMfTBzc3/PzPXg70Oj4np
         jpl5Jmo0t7/5kzqB3fsutAMjgJ1YqE19eixjvR7p/ri4XkpXb+LFuk8M8KLyDG6+2rqI
         tb8Hveoxujn0S2XUx8RQ18UNQBRNT7oS0go8XLXN5G5pAoMBFsg952vDwr6+W4olLNAq
         zg9N/rTnW/muM4oDXZA9ksnKerCiBQ8d0Y181a4ort6rAdjU48nIksLnZXq4bqI32XqA
         3OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290311; x=1774895111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+l2i6CJ0UesVmQ48tC67wDfEsqc0p6X8zxC51ds3A4=;
        b=sLh34IpSIys2MNK/LRiib6aTKgQZ/86qNBcYXcrTe2F2RgAmGBkNI+bjFqzfTTOJWc
         zLh+DnLfnBJrtbwOH0plagL0b6hIRxsDQ9k8aLn7iy4StwPFRNtVHk3EbX3LaHAeFaCG
         pTKr4YQF4/U0oNtWfFtH2N3b+TGeqlWHAUkvzqNA9B1XkDOJOHiNcZ5dbdh+GOPkMI7Q
         gTju5VrgtB2fTmQStNL9CJlbXLfGNYkOBUyN2qoDGaj1QyGWR2TNGt+WvZWypS4Nn+UJ
         xBo0fWxTXh0fD/pX6VMnmsysWTlE1DBKZTRd3JKR4G8ZkM0jpxbVw4fdGe2rU4gmyW33
         EoOA==
X-Forwarded-Encrypted: i=1; AJvYcCWB32+Gn4gXhfKjcLB5aCVuLqcRUVpITztDX66iN+22gHK4r3YBfTr+62ZCi39zeDaP83uSh4L6bXfb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgp9yDbIwVJijyZjzULETEe+yHP3rWNJGGdkQIiE5z2lx6N0Y9
	LgjFUcl3cm6skcHxthYVWbNNRoXq1dw/cHfkbx0tdbVSDuyq2mATMAsH
X-Gm-Gg: ATEYQzw849CebPk2eCGo7P7C89W7orH2nCUJEQ8ht84OZth9A+Rd2pImzcSHIulUrTI
	/TZhqsUDIvMjz/XUfwchdbc2HfpHz8FnnoRkjy2VL6GzJitKM3ZBWRnJ2cXAHH7wQhnfUSQXkqr
	OoeAk1XWClnirDKhO4Vyhkj5qKjJ2udygomrO66b5Z7cDFHmhViBqyC8iSMMnLvnI8o/TED8AQK
	2JchIPn83yAe3RASkv/ekzgDEFZXxebBFPyXIAhh8WmJINE2uMzcOdZUBCCwpNt6Hr9v1cx0j+P
	9T2E8eftKo8WGt7EQu/64mWRmKHSqcDQFh3XNCVrS4Fv3b15JeNGob5ZGsL5+7hdh7JkkvratJE
	6hmLE8zY5YoBsznlXQOqOiUYgUSUv1zlAf1KL7OOUBDwnNjFAiA9CLQTy9PyO2w3dcZhHBvzYid
	ob0ZS228G8ZrSJPplJK2rFf6UmlGB1/4X8dfkl7VPFKHO/j0o5if1AwtHCMXQ2+v9hUnUxZUh1K
	uI=
X-Received: by 2002:a05:7023:b14:b0:128:e2a9:d97b with SMTP id a92af1059eb24-12a726dd9b5mr6179340c88.42.1774290310889;
        Mon, 23 Mar 2026 11:25:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31bef1sm16253302eec.26.2026.03.23.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:25:10 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:25:06 -0700
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
Subject: Re: [PATCH 03/10] spi: switch to using class_find_device_by_fwnode()
Message-ID: <acGEk-63oVK_fBeh@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
 <098e1856-feee-4f4b-8059-85a53967f6b3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098e1856-feee-4f4b-8059-85a53967f6b3@sirena.org.uk>

On Mon, Mar 23, 2026 at 05:16:04PM +0000, Mark Brown wrote:
> On Sun, Mar 22, 2026 at 06:54:21PM -0700, Dmitry Torokhov wrote:
> > In preparation to class_find_device_by_of_node() going away switch to
> > using class_find_device_by_fwnode().
> 
> >  struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
> >  {
> > +	struct fwnode_handle *fwnode = of_fwnode_handle(node);
> >  	struct device *dev;
> >  
> > -	dev = class_find_device_by_of_node(&spi_controller_class, node);
> > +	dev = class_find_device_by_fwnode(&spi_controller_class, fwnode);
> >  	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
> > -		dev = class_find_device_by_of_node(&spi_target_class, node);
> > +		dev = class_find_device_by_fwnode(&spi_target_class, fwnode);
> >  	if (!dev)
> >  		return NULL;
> 
> Actually, no - this just looks weird.  We're in the middle of an OF
> specific function but we're having to jump up to fwnode for no apparent
> reason.  If we actually decide to get rid of the OF specific function
> then I guess but I'm really not convinced this is an improvement in
> isolation.

Yes, I want to remove OF-specific APIs from the driver core. I also have
drafts for bus_find_device_by_fwnode and others.

I can make a followup series introducing spi_find_controller_by_fwnode()
and removing this OF-specific variant.

Thanks.

-- 
Dmitry
