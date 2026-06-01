Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA6541C6A
	for <linux-fpga@vger.kernel.org>; Mon,  1 Jun 2026 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273263; cv=none; b=BrNu8Az5eAb3YSWmzt4UJxDbhY0jqEvije4/tCCNrmvN3KlAUukf9u5btxxbYx3HOM+Y4LvBkVEH41W1Jj6kb1mM2Pf9f+d3DjwsiDI+sd7BVmaoW339yxcgWxvTj+qsSB3cHo3xVFoTOgQ2HgNpB+8ezCgIiE3UBvmzTkQ4x5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273263; c=relaxed/simple;
	bh=y5x9VeqDKEmwkx8OrFdnevKo8r2xzK2tzc4l1QYQnSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXOUKoKkP2rk23uOgjkKga6VZEVLUrA9OG2yWK1nbzya1YMBocCcng7/aMhqOZSzHzF+qsQoXbVRKXA6bGndpRmuayf+QO9D9fByv7HC4HDkEVOs5R0gLazFWyDcWN91htud/vHIHDCrD0OqOQkyoM0yDK6cV8ZV/6Ew1Vz6tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0P12n3Z; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0P12n3Z"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7ded779a345so18172797b3.1
        for <linux-fpga@vger.kernel.org>; Sun, 31 May 2026 17:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780273261; x=1780878061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CM1q9ViEK2AU/qrAQZYqabaGPjGPWPy1MZYzvbR6QNs=;
        b=O0P12n3ZBVRRkXrRnz8YLYNNSxsPTZGzyUxGSaVk2qMgBQhHkNWq7QkvQ0LO6rSsZj
         0NmPKaKu36X5HdsL4MW8Hk4OKRoZahPa+WKMFtH3k0keaYIxsfderkwDZ3jcRf0Wn0KT
         njatsn6FWOD4ynP6MjwZMMYUa5gGBqzItpwhjCfr5Csx3241835NwNmD0UD3M5MiGC/S
         6PeK7dWzLLbBhFYCQbo/eMejyxvKMsPn8PCz80HL5UbXF8hJzWGnx0jgDuGdJSdkB9N9
         IuIAXlwRO1Jy3wvBzP3dEDubaHb7JP53uK+ItMAJpKWVjFBipq9D++RQvmsT8Wlb47Ej
         sqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780273261; x=1780878061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CM1q9ViEK2AU/qrAQZYqabaGPjGPWPy1MZYzvbR6QNs=;
        b=JfiohtCNu3v72q22wd1FD3B+uc3ByWlUDB5pjjKM2wMVHJhknaPv3vnL9a2PWhPd9Q
         fRSxXEzMjGA91G1IxKEzaQzWiMZEI7DWpqFIMXrvOcQKkwp3OchUnAxWbY7gvXyP+8Mm
         3j2OrsDMF9Lky8uWgX1iiXxSWU0PZ9XGtFYzWuXuMxXJJtiytBIQooYtoV/X2Nk4IibC
         M8zfnJB2oP0Of+uAdoCx2eA6PCSVV/uL/1yKT6MtUyXEvpAOX/R7NdWG4Tkvch+hEisd
         hb5fA3AQM09J5Z9Ulbc2zZRDNi5BvPRnG7KeXky1vU146z+QfwogflXFow/k9XrcKXh2
         Zj3A==
X-Forwarded-Encrypted: i=1; AFNElJ99LoWy2QO0jwr0gVvqfcaC16iVpG4sSNzhdzFf7AiHO9/0/wKfPC+I1xiOSodasX4mkYK4/f9UD6b5@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHLoRj1m4kXE8NYqfwQtcwM4dtYOkAu0Wm0+SRzMizvDr1We4
	3/EAEyt2gP7u5isxVg+FOJevDduBDQfVYDcAE8ppdivtMZl7343tOGODFj1JgfPm
X-Gm-Gg: Acq92OEM4P4AggRJ5lYTjsiQcBw5d2gAWNa5thr5k8s7ZFSQHyYNF26X8/TOTT6gQBn
	dJlL2ToAs0YS/dfWV4vjH4Zf48cWkXixTxytVyCuMvuoI5i1mzTlRBBGsbHopuh63PGOqV/OHbh
	Vkl50erDYIT/fwG0qEmu8aHTmFSUKmKGgtzd648lAwcSmxRebJYr3ldBi2jVUpeMiYAf0Y3YMiO
	p94EOphyGAH9nrvxMQ4eLfVOAmDuaGFKQh7lgG2L8zRJzpbFt8dhGXf5/X+SADVl0qxgaC16GcG
	kLaquI+sduoSA+BFUWqOpMRh+gKPyU49XVgE2qCO0BFimqIz4VJEvCFKTg2J+bBp8+edbJyTUPR
	Q/3VpiijkK/JYdiWxtpNKune7O93LXFzTgNDe10Hw+/9dHK+/O+OrlYQBdCYBn83rNg/TgEhqDc
	3m1KfZ96ufaFn32s8+j4YYp1oHsK83mtGOE+MplogLdI9pUxpbPLQB
X-Received: by 2002:a05:690c:6d86:b0:7bd:7e01:8d89 with SMTP id 00721157ae682-7e05c47bda8mr77291477b3.24.1780273261126;
        Sun, 31 May 2026 17:21:01 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e17bf00ff8sm30648267b3.37.2026.05.31.17.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:21:00 -0700 (PDT)
Date: Sun, 31 May 2026 17:20:54 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>,
	tglx@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	daniel.lezcano@kernel.org, sboyd@kernel.org,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
	imx@lists.linux.dev, linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
	mani@kernel.org, imran.shaik@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
 <20260407104802.34429-3-guwen@linux.alibaba.com>
 <20260412084704.743482ad@kernel.org>
 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
 <20260412095301.4fe1fe65@kernel.org>
 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
 <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>

On Thu, May 28, 2026 at 06:06:32PM +0100, David Woodhouse wrote:

> Apologies for the delay. I have set up
> 
> https://git.infradead.org/?p=linux-ptp.git
> git://git.infradead.org/linux-ptp.git
> 
> But I'm not keen on using it without Richard's explicit approval and a
> clear understanding of who owns what, *and* the taxonomy we use...

The name "linux-ptp" is very close to "linuxptp" which is the user
space PTP stack.  So it is a bit confusing.

Thanks,
Richard


