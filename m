Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21954265623;
	Mon, 18 May 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116961; cv=none; b=TjSWYYl486wogo3SP+8Eo4+JJ6N24YqsQsH62/jmP+COddcMlNq7GZ8aZHwdycs5FYoRvrLmaP5PIf5zJP5njoCk2yBS9UT14JicfA2sCOn4wOCi8KEhGX9tYy07z/Dqc9NBE5Nzbur+w9O8CfWaEnow6ecR3BWSxy6dWxyCMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116961; c=relaxed/simple;
	bh=/GkfcAtvqqBwqMMHMvqjGmVzxFyvyyQGGHfpLp/MIlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4Kga4DeL7zjC/V8LzgznmHe/MzS6biVmyjjlNmF7NFk0C1URQYTm/dLIn8cwaSlfaGgGyCL5whXgXEbyXsI9jgbHNZ687gCcznrf4TXrS01znMaox8mv5vEiBnle04IQfLIQ6rWpdax8eg97A8/CkpzIjNj1I1Hnp5vfuuY48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=as8ACKfq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="as8ACKfq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779116960; x=1810652960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/GkfcAtvqqBwqMMHMvqjGmVzxFyvyyQGGHfpLp/MIlA=;
  b=as8ACKfqHedryH0+s4pbFxabDlMzQWEDRzHyAZw8fYDVoCrsRba/EC8K
   W3s+j7hL5LOZTqPW1N2G/9i4xJJHlZtpoVLNMJtekqMqJN2sODutCaIu7
   7/t7qBpgGJb+hnvo4R9u7zDT/DUCG7YIXJC6XWHypn1yRCRXphPaoy/hW
   ozasS0BUMbVS6GfSXc2b1YkjCD3fW4THqB9AJ0WI+PcLjHAXdRXP+59fv
   GhYSLFwb+GZdXNpRQz/A7lLawqg0J+9rhDzvV5cu5TYVJlqi3GYt4Skbo
   PUgHbNFUpiYYAB0T9/QUJCKNXxS2TsoTQOnWvKy9k8d2ZXq8AaT+0qh3v
   g==;
X-CSE-ConnectionGUID: s6sQoD50Qrun2EXchh/pHw==
X-CSE-MsgGUID: gMtYITz7Tdeb4NV3R88z2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79936740"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="79936740"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 08:09:20 -0700
X-CSE-ConnectionGUID: E+YbgiEWSWyavn5WV/Bo8A==
X-CSE-MsgGUID: wzFHGD5ZRk2gWX31B7jPWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="243436582"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 18 May 2026 08:09:17 -0700
Date: Mon, 18 May 2026 22:45:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manish Baing <manishbaing2789@gmail.com>, mdf@kernel.org,
	yilun.xu@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthew.gerlach@linux.intel.com,
	trix@redhat.com, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fpga: altr,a10-pr-ip: convert to DT schema
Message-ID: <agsmGwFPsgczLJuc@yilunxu-OptiPlex-7050>
References: <20260512180225.65902-1-manishbaing2789@gmail.com>
 <20260515-uptight-sidewinder-of-snow-c28ba7@quoll>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-uptight-sidewinder-of-snow-c28ba7@quoll>

On Fri, May 15, 2026 at 11:03:17AM +0200, Krzysztof Kozlowski wrote:
> On Tue, May 12, 2026 at 06:02:25PM +0000, Manish Baing wrote:
> > Convert the Altera Arria 10 Partial Reconfiguration IP bindings
> > from text format to YAML schema.
> > 
> > Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> > ---
> >  .../devicetree/bindings/fpga/altera-pr-ip.txt | 12 -------
> >  .../bindings/fpga/altr,a10-pr-ip.yaml         | 34 +++++++++++++++++++
> >  2 files changed, 34 insertions(+), 12 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-pr-ip.txt
> >  create mode 100644 Documentation/devicetree/bindings/fpga/altr,a10-pr-ip.yaml
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next

> 
> Best regards,
> Krzysztof
> 
> 
