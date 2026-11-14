Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794659758;
	b=TddMwWwCrOsOpipmckANPyFFT/ErNZy8tkXzyNN4XSheTuOZQwP54baS/2pOSXJKQ0Ad
	 y6UnA73ZUf2FewKs+O4uao1MrRiAlxFmhs0p/HgApghAeokYKMmXxDKpVUVuNPsrOFalO
	 09f+AVkQ4ej1Icwz9747iiMnQary9ar/8TKylT+nvLZOL69Q8KjfdngMO2d720Xe6fcNe
	 EMj8czRGrA7BPe1GDr+47SkgRYuV/hA/Fe0BKjNP/1VBKJA9WuaUXEu2gf+uMQsuoFVU4
	 R6OxMEf7CJDHb1Nxqcp1cF0zGTBHipzhwC3imOx60okz8Ckki8I3myE9tKK4YDFmIDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794659758;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kQ9PlLFanJO97/TILxd2Tgvdrkk2cvOpGFZUv4vINAg=;
	b=gos3HRYK721RS0OFg6aIK1lJaKS5EYzKKw3XyBERUkCoW2JK328yVYjJOrBBplIxiCMa
	 UWZOW/1ldyHyFkpBAo0FUqFeHKeUckAKWm6LGbruKlmuEc0FKyEg1OsZecjGq2KGITVVo
	 pe0ovRmSgaLYEIBZGkO5eAVvyqV1+SnhbSvGoFsFtzrTjgpyNFGwM91ELeSYTxElRmshR
	 Egx7Iv21DSl0xbXxocQjurRy54EV0Hagdzwvjn7WTCvSD+dsoT5AMsyRm5dEYRYYVIUgd
	 mqzUYfqAeJUib8xQ5vBCvyZhKN3VmuCAQVcXakOYz7Ps0MVaWksl/+QaD8kte1Dc/Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A0VbVAiX;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F94606A329;
	Sat, 14 Nov 2026 12:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F94606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A0VbVAiX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794659757; x=1826195757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vDRFfV23uhcbw8/Ilbo/MSNuNcIIWAFjYui4as218es=;
  b=A0VbVAiXkf0t8+erCvdYSZo57RK5e40q1pQZTsAA86oawfHQYA3l1KEd
   K246JXkphMIXwgbD25nqmkxx+Rju3RQCB82w4uNzGJrZZmvm+XBIM4/x7
   0NNBbZruyVArskk5MnZtlIMOmQ6w7CcxCDXwNjDKr8c0OdUaFjewKZQpg
   7WCn2R/eXM2MqOIM5fSdhp9ilfp8mTIh9HfiWwJ7NkOyafby6Kxo1lrmd
   eMTM96Q2K30hieGWUl2hMAfNLw1DbBHRRPov/xTFj9xQLaJnFTNDwKcL7
   E4Xiw7b6vvET57GOQkJItUHyzWmQUSzVEIdms0YDKAkPJe72AMXuBbBja
   g==;
X-CSE-ConnectionGUID: x/i/Q6YAQg2QjGWMaSiH1g==
X-CSE-MsgGUID: K6yFU9NvThWgzhOZ9tROzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3349402"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3349402"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 04:35:57 -0800
X-CSE-ConnectionGUID: /caIdS6PQ2G50gGjtxR2Vg==
X-CSE-MsgGUID: ElFoNmapTBupmIVLjZ+Z5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="9144398"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 14 Nov 2026 04:35:56 -0800
Date: Sat, 14 Nov 2026 20:27:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-hps2fpga: do not request reset by index
Message-ID: <avhTs52FZQt3JGAA@yilunxu-OptiPlex-7050>
References: <20261106-reset-deindex-fpga-v1-1-5672928ba5f6@pengutronix.de>
 <au8Szj1uhBsP++es@yilunxu-OptiPlex-7050>
 <a061bc4358465b5cf3b887249a48000fe07ae5ab.camel@pengutronix.de>
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a061bc4358465b5cf3b887249a48000fe07ae5ab.camel@pengutronix.de>

On Mon, Nov 09, 2026 at 08:54:59AM +0100, Philipp Zabel wrote:
> On Sa, 2026-11-07 at 20:00 +0800, Xu Yilun wrote:
> > On Fri, Nov 06, 2026 at 04:43:19PM +0100, Philipp Zabel wrote:
> > > There is no need to request a single reset by index.
> > > Use of_reset_control_get_exclusive() to request the first and only
> > > reset.
> > > 
> > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > ---
> > >  drivers/fpga/altera-hps2fpga.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
> > > index f2f1250689cb..9b7f5b8191b8 100644
> > > --- a/drivers/fpga/altera-hps2fpga.c
> > > +++ b/drivers/fpga/altera-hps2fpga.c
> > > @@ -134,8 +134,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
> > >  
> > >  	priv = (struct altera_hps2fpga_data *)device_get_match_data(dev);
> > >  
> > > -	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
> > > -								     0);
> > > +	priv->bridge_reset = of_reset_control_get_exclusive(dev->of_node, NULL);
> > 
> > Saved a 0 arg but add a NULL arg, Any benifit to justify the code churn?
> 
> I'd like to remove the _by_index() API once there are no users left.

Then you need to show your intent by having a series that includes both
the changes to the users and the removal of the API.

> For a while now, these functions are only ever called with index == 0.
> 
> regards
> Philipp
