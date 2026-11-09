Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794210904;
	b=krun6F0lMIP4qvOio86LO4Aw+a8NgDM1pK09SqlhRquWmcuayT/7TfRaL+aRcnc8wYLx
	 CuetZcWfpt+KxJ2LrEbKMC06mD+vm6KrBI94B5kaLnf1JFpxdMDT7F2/CMQzHHXrM1rxT
	 iZEBgXK6AbcUFPWsE7IksuLbfBqRuW4wuI+FpBRB5mplVSEhHsMXPNY6w0X/8QpKnIg/D
	 4dmO6t1r+P7s2pq3jP6noOG8RYFEcbcW2vfNgRD2Mw1BBTeYN4zUxeA+M/AJ2iJquD2nT
	 Ny6rmer3sYlGQML8BuuYyEdl02p/vPR1Tdgo1sWW+ar6H0V9EqLIHeQBGlbJnRNUSxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210904;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=lOYKkv6nLTrNG8umt/ZVvDbYEihQMMWiKsdpnVgQ1O0=;
	b=LM907OQwjFz3eFx2D+AZ/RWNS0b09pgBuK5Yd/p9uHhcP+L9MSi+3H1K1AK6DlMzAt/E
	 Rqck7L0HhFKYOl5Ekmr/EePJgDg5wx+0Dc4Qwcrl6BjAI1/A1ejR/Sdkf0MOvhnBje4g4
	 +jrvCpaxacoqp7YQb1Q+eR6QjnLfWTWVkA7LejMocpcNwXHJ5eVj54wP6HAEANeKdQvGM
	 siGNBiqwhs4vnMiO7Q2ScXzHfGMfXRvsm/svU3cfG1NzQIC4MgKuEt0/kQ56axsLVP88Z
	 FYY+MfyUoSs6eBh+Q6sVHDVWEbAjQnHSPivLRjSW/GZ6XJ8NitVHakz/jEyXkNvaqlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=g5cArzWj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E15606A31C;
	Mon,  9 Nov 2026 07:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E15606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=g5cArzWj
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7F5F6200B9E;
	Mon, 09 Nov 2026 08:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794210899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOYKkv6nLTrNG8umt/ZVvDbYEihQMMWiKsdpnVgQ1O0=;
	b=g5cArzWjTI2ZYtv5M885uXiJL6qXgfkEYX2tGQUMXxWO0UoSa9fPjdlEVmoj7HTn3pS7Ye
	T76P6GO0P7ZHaVfE1QAvURG1A9ds0jinTAeOTFar8ltvBgDY8rl2OwXmf1pcUOXdSQaXry
	VcsHxY6vavaw78VsFszT9LSNEaPlkP+s2jys1CjtSdF1Sgr++TVEkyK/5w+FRefMQzMIl5
	OLC12pn7DJSwASv+TEyC+6PkKhA7bvB9zuZK+//bV2DILCVaS3g4FlefqUykAwmV9fCe5G
	pkQtNYU/vRG8LCOvtjzhTvSF1FlNvCPsRbHL1QhYdkJszhMWcH+g9ejrVu9XVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794210899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOYKkv6nLTrNG8umt/ZVvDbYEihQMMWiKsdpnVgQ1O0=;
	b=fiyRhsZbh/BLU8C1gT/m3pjKSaLEfUxKDu+lSX5NLKDFz4aDYlvxo8zIoDN5qK+cf68xyT
	SpmPbn3/d7GVWZow0svMzgp1WYMR1z1TTaSlBPYz5405oa0n+vEtaDl1+v/odWDtheBE2j
	v2EG+cjpyGWXcsXhUwNf0QRXp5gmPPSHizavL4NsKsn8vciMuLWE44Zq6q34MhpGOHzDp9
	YTwSGUVrXm/wYd3eSVM9v8QszcewP7/FqP9wQtUF7+FBBLinvvNK74D9LMfG8PmiqsFa68
	DyfZRFJiM54aTSz7etPi4sZ5ehXus7H1YPr232ynG1OMf2dJF53IosnTIBmrFQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794210899; a=rsa-sha256;
	cv=none;
	b=cDWV4nRPSGD9VNJUpc45hVYHM7nWKaQhnS6d9E+9bXyjCT0c+xBq6AMp8cqEZB19qmFE5G
	m0BLa/AJKf1HCapkT1moIccDJF1Iuy6ZUZ02tgFpF+W8477ZFJcebFNbrdXTNBX1XSXf3b
	NYtdWlNIZohSQ8uJbztUsl/IosHhjZYgAL56ofMDw4Wmw7ra0JNBLJ9LiZWM6obfDLJ8d3
	qAY3NeBKq52BjPS5G95FWK9pWjRqk8R10o/w30vPPWI73xkBuBtFCLUGDpK0QKQSqMxZ8i
	5aEirQvpbsRwJvAH4n9UiBLvjcza8EgSxDyoByDzx3MjQOFgKviDmp7sQMx/6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <a061bc4358465b5cf3b887249a48000fe07ae5ab.camel@pengutronix.de>
Subject: Re: [PATCH] fpga: altera-hps2fpga: do not request reset by index
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix	
 <trix@redhat.com>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 08:54:59 +0100
In-Reply-To: <au8Szj1uhBsP++es@yilunxu-OptiPlex-7050>
References: <20261106-reset-deindex-fpga-v1-1-5672928ba5f6@pengutronix.de>
	 <au8Szj1uhBsP++es@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sa, 2026-11-07 at 20:00 +0800, Xu Yilun wrote:
> On Fri, Nov 06, 2026 at 04:43:19PM +0100, Philipp Zabel wrote:
> > There is no need to request a single reset by index.
> > Use of_reset_control_get_exclusive() to request the first and only
> > reset.
> >=20
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/fpga/altera-hps2fpga.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2f=
pga.c
> > index f2f1250689cb..9b7f5b8191b8 100644
> > --- a/drivers/fpga/altera-hps2fpga.c
> > +++ b/drivers/fpga/altera-hps2fpga.c
> > @@ -134,8 +134,7 @@ static int alt_fpga_bridge_probe(struct platform_de=
vice *pdev)
> > =20
> >  	priv =3D (struct altera_hps2fpga_data *)device_get_match_data(dev);
> > =20
> > -	priv->bridge_reset =3D of_reset_control_get_exclusive_by_index(dev->o=
f_node,
> > -								     0);
> > +	priv->bridge_reset =3D of_reset_control_get_exclusive(dev->of_node, N=
ULL);
>=20
> Saved a 0 arg but add a NULL arg, Any benifit to justify the code churn?

I'd like to remove the _by_index() API once there are no users left.
For a while now, these functions are only ever called with index =3D=3D 0.

regards
Philipp
