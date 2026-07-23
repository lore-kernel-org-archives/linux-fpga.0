Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C758360EF7;
	Thu, 23 Jul 2026 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782525; cv=none; b=lojPK24j+mm0zqZBqfCuE+b+9sV+6E6+O0+LohDGNA+dcFMl5aj21U6d22T2rlpILBKXU5Tr9/NN20iiOGk2L8hizkCNz16UDcUD29p2NnN6vW6U0GQ4wdsUmmwX5EA8hD9O4mn1g6GHEwd1TZ0CnL1go6QrWxLar31emMGFxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782525; c=relaxed/simple;
	bh=/W/KfgTwFK6olB39mtu6fyurtJOfyqyEV5RbFeZlIr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltsbRe2kVd2obT7IOUEpJcaeOy5ZqJwKMYo6hBZGAawkqIpHnVWXzoN5F77ONRJdO5A8l2ry3/2Id+QSDb58OxFWffQ7p6S14104Id1PKe+dr3+oN/co5DMqzw1ZeMOlpv2gVe3R3YQvc9WF332xMk5D1/+XFv1bsJJx5oFasnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9J0Hq1V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9J0Hq1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784782518; x=1816318518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/W/KfgTwFK6olB39mtu6fyurtJOfyqyEV5RbFeZlIr8=;
  b=J9J0Hq1VeBltXgW2wVSRHSENxxS7m1fO6BC13mCXOrIuPeuIBWeh3GFu
   uY2flGVTPPjU7bxLY7eraUqJOjMn+yynfkGWI01JqZqgX5NgljGNsZLyC
   WFlffzvp5zaX59rn6Pb9azK6xAYe8Zolm24BpbpbDgOc+KCBLufz0gQWw
   HFjbyRX5TWeJCr4K4lv44anXVU4EmtrdIhr0SNR38Yc4KMU0BDOyZYGcE
   x9QlrXmQmWxTC0dsF4c1uL8SOXek03tJrwFeV1pgRNFhiaHdxPstrUJCV
   OiEnG1J4LwCu/2TuDEYgb5nPH7tNjogMdSTJ6TWtWXMWUd7IacBXSQYcK
   w==;
X-CSE-ConnectionGUID: 2MaVJrjoQum2ZclfGSEWPA==
X-CSE-MsgGUID: oK1oYC+YQ6CdoOSRd2BfTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89251201"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="89251201"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 21:55:13 -0700
X-CSE-ConnectionGUID: 8mzZU7iPTvmxkvQVKVLogw==
X-CSE-MsgGUID: yKcaCWVjRt+mXUrU715LiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="261858269"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 22 Jul 2026 21:55:11 -0700
Date: Thu, 23 Jul 2026 12:55:10 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>, panchuang@vivo.com
Cc: Pan Chuang <panchuang@vivo.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: zynq-fpga: Remove redundant dev_err()
Message-ID: <amGerjZAOCySe2c2@yilunxu-OptiPlex-7050>
References: <20260713132237.370272-1-panchuang@vivo.com>
 <701a4078-721c-49a9-90ac-d59697fef82c@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701a4078-721c-49a9-90ac-d59697fef82c@amd.com>

On Mon, Jul 13, 2026 at 03:48:57PM +0200, Michal Simek wrote:
> 
> 
> On 7/13/26 15:22, Pan Chuang wrote:
> > Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> > devm_request_*_irq()"), devm_request_irq() automatically logs
> > detailed error messages on failure. Remove the now-redundant
> > driver-specific dev_err() calls.
> > 
> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
> > ---
> >   drivers/fpga/zynq-fpga.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> > index 9d1d599ef718..2f8ba32e4002 100644
> > --- a/drivers/fpga/zynq-fpga.c
> > +++ b/drivers/fpga/zynq-fpga.c
> > @@ -598,7 +598,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
> >   	err = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0, dev_name(dev),
> >   			       priv);
> >   	if (err) {
> > -		dev_err(dev, "unable to request IRQ\n");
> >   		clk_disable_unprepare(priv->clk);
> >   		return err;
> >   	}
> 
> Reviewed-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next. Thanks for the patch and the review!
