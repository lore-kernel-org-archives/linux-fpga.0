Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACF2D3A7B
	for <linux-fpga@vger.kernel.org>; Wed, 18 Mar 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853568; cv=pass; b=s9mv5oNKdl5eZgxfZD/9Wa61kid+SddFfiS0NGeq7FHT7kc6TNRc4uA0Nnms5lL+v/a6M7RQmpY97oTmKrSMhuXovZ2yaJ2PRr9gBdsTYD43Xe3/0KkfQMBEcaC77MPJkNArESyLc4yeYdCleQuu3wpXGsD/LpzbIA+kuPUXhGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853568; c=relaxed/simple;
	bh=Hz8E05LdBGmu2bfAFeryryBDZivcDYI8jWINoREv7ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6tRMfd30kHBR9q+ePt2n/iffqE4Mut4s6tygGNQs/x1eTaNAVM6sqxDiMU/SAt7Wzn5F/m08DQ47Ioj+jSpD1+JgW88aoNXeb9ymGvee/+U0vry7s7jpn3HkfKqnEX+Xtw7Va+Ux5JZnXidIdY3xAcLPlHj/T+R6A1ReKlssxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBogQ2Ow; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBogQ2Ow"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9793fa5371so4550766b.2
        for <linux-fpga@vger.kernel.org>; Wed, 18 Mar 2026 10:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773853565; cv=none;
        d=google.com; s=arc-20240605;
        b=Yj2xke6qp5FtqKZwSJMHx1MXzNdNbPY9eVjUVypfHt+YE+kCgjLtvlc3ClfX0sIy1Y
         NAn/hTKzfoSOE7ZF0GEBYhm5zm+ke8hHFK1u0QBZP/N+SD0sYT+lCjdN/ZGcEfRXVedN
         cwqmXdROVSol8DWIhv1s5bkMIq8t4bseldpIQEwdhvVEpYzk7qRF45bGAVCcRY8YfYDt
         xhIwKDZDm96MxbtLB0PyHxQZUOFoVy39b0KHrek+L4X4Ezgvk6f6m3r88DS+iFHUpyaf
         H+DM6g8ZTMO6n4J30tNSj+1QNPjoAyJYyrt7NL1UPif4sKNR9g8rxBTjATgz7f8K9V1+
         /ZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kATEDVmGF0/O9M3x0zcBp1yfg6DAeXFmwwnXfMoTIKM=;
        fh=rIGHf3OK4HdMcWp+LOBS7xw0QuH7f0VrPDoOHPfWeJE=;
        b=dPvMSG/He+sFKdl2oRl3+h78qGYKQLRAs+EzLWC5EJY/OvSDOYwfoYH1ANThFt/Ygi
         gPeLDA/qIOJ9OisxadDOPulyaiULdBzriMpnGrQdU6NbjD7PVOZeHAGgliVk5VAMWWr2
         94xWA12Hm1qZh0GPY1S8eTD/vm44QzsCVOghhwAXSoqNWsLkfNxWiertyC1bPbq/EVtG
         88HnrBRSFwISSuFBaT52gebl6dgmNvf8cyCnblqCWiYMwNzJIAqAwOOOBQDPhyD7SSSV
         xW91Gau4JufVWat9kY4qSY8lbHL9RrvA2ByhhLvvS2UmXCRnVPRoxa/yP3tsnxlLJmXf
         3vAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773853565; x=1774458365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kATEDVmGF0/O9M3x0zcBp1yfg6DAeXFmwwnXfMoTIKM=;
        b=SBogQ2OwU2DRgi5gY+jzSDEtDWk+k1aN43X3WBa7UW0G8we+O1SRWXBH3FyhQT4P6I
         V7hVwvSfsjMpbYRKw2MCp9E4/18/JvQ6HHHqOobD3EMQLGE68RAL5kXpKIkwB4bXyjB6
         UnKg5HLQJgfRNS2n8kPkSqoL/4JwR+/LJIxrjCiyFm58cML43jbKdAS1JEpLstV05RMF
         XR6bUkBdwYNtj8W++Vor1dCJkKb86teC5+ESF9Lmq+SbFGR0CQ4dXcdGS4sV3XmgIKC5
         XuhEI/AF8ii7b5PtvxF5HxsSzYGr7KKfTBRYlW5NSpsMXw2P9b8oYqJj2UbI3x/hyB8/
         2RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773853565; x=1774458365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kATEDVmGF0/O9M3x0zcBp1yfg6DAeXFmwwnXfMoTIKM=;
        b=ssFm4XUcFS5lJTNzI9JHnnR++DA/63B+zEZCJobvNhil548GQPO8MCEo2h2dyMKJkD
         tyZQExZjPlL5guAveuLluWGET7N5FjKg9yDS+EkXNtTb/5WfpCuR/z883O+3YqCgd1j1
         Tqgywhd2NiojKtY0TvUgSWFvG0T3P5qcoS0gJeuyh3BAePIgycK7eKyfzKHD70DRHlom
         7CDEEx+q7F8X3AwmX34MXLW/lSp8sH8m+LPMzmBBzBnCp0EPeB11I9+a+PmXRu/sEhzb
         1kVfmtFzurfIZdo0AfHSRKczMZNfgwVmlc4QFXnVB4657XA/UvYOE6sth+O5it+bD6+j
         bssg==
X-Forwarded-Encrypted: i=1; AJvYcCU7PX7wBuhN2fF2wLnU94ltUs4nQSgl6RgY2UcyeVagzOb24DuwQO3zi+DmPxwEASeZNt3z5XVOdB7y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Dzr7EXoUVmVD8KMuYou5YcvyJfxeXk7Q2+7c6iS9jI8YW1B6
	CADhfGuVc8gj6o2mMsrIDTnD5w2/1yPSdQpyp+euGr4v2lsnU1Ch1A+2Bobg7ChHZOsXUpNmdcq
	j79C7X9iYhUIY34QsuHpYMm2woYeGg4xRGwuvLWQ=
X-Gm-Gg: ATEYQzwZbjpY6fCSCNS7tULmzznHGQYEootm1PZ6thzDAdxU7n5Q6ahL9SzRARUeUnh
	ELvDXQ+kSOGWUQhcbUFNzIXNHFl6XOT6gSqOzHMWDjXV6lnJ7vK+Bjq+9FTsp09bxOoGz1jC5a6
	BWVthkgCfTjpsv18fu2eB01cocOmO3w5g9/qnV+jDfLHZN8zVjaEcE55fWYNIjGN2LnQiq2azzR
	7LpFcB019voQpVf1/QwckxrqIyETt7Jl957nPeKvWAyU7JDbwoW1uUOTIkVlLApEAgi1Lj0Mpll
	sMLSQnMuOX2X2bzfgP+YEj7nUa7wkGKc9v0=
X-Received: by 2002:a17:907:9946:b0:b73:4d06:bc8 with SMTP id
 a640c23a62f3a-b97f4b60eefmr194003266b.53.1773853564611; Wed, 18 Mar 2026
 10:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
In-Reply-To: <20260318073330.115808-1-guwen@linux.alibaba.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 18 Mar 2026 10:05:52 -0700
X-Gm-Features: AaiRm51pAIUhiIslZYeLgnI5zv3XevZ8aLuUPYbmBN9fBas0fAu2t7Z9AQkAyFw
Message-ID: <CANDhNCoFxsXdP7d6nbLTFLOrB_4GnDvhF4O6ZGyvGEVoqV4U2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] ptp: split non-NIC PHC drivers into the
 clock/timekeeping maintenance domain
To: Wen Gu <guwen@linux.alibaba.com>
Cc: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, anna-maria@linutronix.de, frederic@kernel.org, 
	daniel.lezcano@kernel.org, sboyd@kernel.org, vladimir.oltean@nxp.com, 
	wei.fang@nxp.com, xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, 
	vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com, 
	dwmw2@infradead.org, nick.shi@broadcom.com, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	linux-fpga@vger.kernel.org, imx@lists.linux.dev, linux-s390@vger.kernel.org, 
	dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mani@kernel.org, 
	imran.shaik@oss.qualcomm.com, taniya.das@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 12:33=E2=80=AFAM Wen Gu <guwen@linux.alibaba.com> w=
rote:
> - Following the model used by NTP related code, this series lists tip.git
>   (timers/core) as the integration tree for emulated PTP clocks in the
>   MAINTAINERS entry. Guidance from clock/timekeeping maintainers
>   (Thomas Gleixner, John Stultz, Anna-Maria Behnsen, Frederic Weisbecker,
>   Daniel Lezcano, Stephen Boyd) on whether this is the appropriate workfl=
ow
>   for this class of drivers would be appreciated.

While I'm sure it would be good to continue to CC folks, I'm not sure
if the timekeeping maintainers would be the right folks for these
driver/ptp/ changes to flow through.
Thomas has been doing the heavy lifting for a long while and I'd not
want to put more on his shoulders.

Richard is listed as the maintainer for drivers/ptp/, is there any
reason for it not to go through him?

thanks
-john
