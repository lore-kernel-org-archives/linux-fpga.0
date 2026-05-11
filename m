Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16331282F;
	Mon, 11 May 2026 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513776; cv=none; b=IiTLw/3KC+/fiyTpaJm+wBdRNaWSqWKKctGTBi2PxNwmJFG25NUVFvKPM/ywB6LWwTQUZ4Dl08+EIa4g43w08M6rcmf4/oixISmMX5Zyt1r5OD/b6PHHWh/HTfeT8dcAQwVfvIyu3E3YYJC8Zs1Y90BBDcQSqU8kABNgX8EPXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513776; c=relaxed/simple;
	bh=gDP3VBab0tj9SaYt/W8bAvg4khJLxtZ7JwoCjN7VVBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqq5qwoiyQ4KpCa3Uo+c1dXIX1sf6sea0Eg33utNPBdA5hEWnqdDlbCC7jd/58eM1LNCcRgGkT4rQOnC2QMyOUKTtj0g5t79KlisZqiZ7fUSWpvpwaF49xtaHfB1u3cVP8MytXBK2ixarMcrQLfIpFSC82OW7uysDCEpe4w8GJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhgSpsca; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhgSpsca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778513775; x=1810049775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gDP3VBab0tj9SaYt/W8bAvg4khJLxtZ7JwoCjN7VVBM=;
  b=QhgSpscauEb1eZOqOzZvzNxPdbsiVttB1PNKbd/egqkMeB5EeDHS7dkO
   5B8AW3p11STQ7PPHPURYzvTCo+G2+4QWEK8dwQHnfAjwc0OIZUgQGlKhF
   gP+UBugP9s1Y+Hij3bvrxC8l8rXM8i0nZtuhxVZy1CLKEQnmOTvUBrd+R
   O/RXT6WB7Dn0rPaRjaFxwLri3F9+HTt4J+m8rYWhixrPzsRqoLZcRl8Nd
   uWPAZBtLqQT4NLYbVVS9u5BNhA3QqN266hV/JCT7FWsNaE6BL6y4z5rK5
   JeS5iKLAKnK15AzlupqdkBzqNIzD7KZRw+brvfPPdwe0yeDiXOinCy2m5
   g==;
X-CSE-ConnectionGUID: YqjCg2yNS4i22SqQ1epO9Q==
X-CSE-MsgGUID: Me2SPG1rQfmnSsqCb31N0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="96968978"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="96968978"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 08:36:15 -0700
X-CSE-ConnectionGUID: DPPZ+r5aRE6aF62hLrHomQ==
X-CSE-MsgGUID: beK3BSk8Tz+NzAaBGNjiXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="275613697"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 11 May 2026 08:36:13 -0700
Date: Mon, 11 May 2026 23:13:03 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v2 1/1] fpga: lattice-sysconfig-spi: simplify with
 spi_get_device_match_data()
Message-ID: <agHx/zJ7nabPITP3@yilunxu-OptiPlex-7050>
References: <20260510090556.1582900-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510090556.1582900-1-andriy.shevchenko@linux.intel.com>

On Sun, May 10, 2026 at 10:51:58AM +0200, Andy Shevchenko wrote:
> Use spi_get_device_match_data() helper to simplify a bit the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.
