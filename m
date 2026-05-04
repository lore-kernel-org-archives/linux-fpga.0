Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75F35A3AD;
	Mon,  4 May 2026 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894870; cv=none; b=VEcebqHtckM/zR8ChYX1dmAoau1cTCjKEq+dLut+xDnx4qhya3OK2X2LmKgLcC4uLotVwVuVfV+oPDC/bzahrwv4OVf4U2aRKPqBPMFSBCUCURvf84yZCF/GtBJbtUYqpc8jD7btdtxPJ2/jfqJSkrdH3BI8PLgHw7BuG8qK7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894870; c=relaxed/simple;
	bh=3eGV8OYFkq805Nwmqn9XyS/g1IhWJZEPy7qTd1HJp0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSD36U4K7vGBgoQ2Juqgz4TxwdBXkCtIvGULGvh7XcSbjsHoixOz1QrXblqDv+S6MvOpMH3epUri9uEM8eXm7lgBMCptvNiN8swcAW/VLN0C14qxY14SbfJChZXZ0FhAYJk/Ff48XohtfttroP7WQr+6QGAnVjsTjJ0tHYrkShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMInOIiZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMInOIiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777894868; x=1809430868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3eGV8OYFkq805Nwmqn9XyS/g1IhWJZEPy7qTd1HJp0k=;
  b=YMInOIiZ6XzPH4pnkRoIUmtQtvUF/r+3H2RmW8ZoPwd9WbispkgjRnx9
   AzDN9E+p/7Ns/g5ncWKSByOX2581ZizC3S8rT4h3Kl/eAF7F5UdezRzil
   s0av/fQZzqqQzAWlsrHH8v+w+PACoOGLtEOjhQNjMDeUe/tVsQty9AqPk
   +9AWJb2gJFogm2U2VXiewnHIIksKnHD16YTVgnbx62HZ5mrxM/pu8qD/3
   vPvUey+6G//aIghlXPJZfTm2z4Hr5KcN1ejQgz3zJIj9RmFnkWKRpwH4Y
   flMQtUmRbgJoszvGAHVveKa50/OYIKpZCzQoq0I8kl35qy8GgqfKFfEqT
   g==;
X-CSE-ConnectionGUID: V0ajjAOwTGulyd8vTrYBLg==
X-CSE-MsgGUID: iSI4hMGlSHqu7Z8mZuBKVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89440583"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89440583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:41:07 -0700
X-CSE-ConnectionGUID: b+apxqhNQKyBvhWcalTnWA==
X-CSE-MsgGUID: scoYSW3LSgeXCBSsmsvAyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="258847201"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 04 May 2026 04:41:03 -0700
Date: Mon, 4 May 2026 19:18:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: iansdannapel@gmail.com
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, neil.armstrong@linaro.org, heiko@sntech.de,
	marex@nabladev.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io
Subject: Re: [PATCH v7 3/3] fpga-mgr: Add Efinix SPI programming driver
Message-ID: <afiAdwJ9NOg/sPUr@yilunxu-OptiPlex-7050>
References: <20260416144237.373852-1-iansdannapel@gmail.com>
 <20260416144237.373852-4-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416144237.373852-4-iansdannapel@gmail.com>

On Thu, Apr 16, 2026 at 04:42:36PM +0200, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add a new driver for loading binary firmware to configuration
> RAM using "SPI passive mode" on Efinix FPGAs.
> 
> Efinix passive SPI configuration requires chip select to remain asserted
> from reset until the complete bitstream and trailing idle clocks have
> been transferred, so the driver keeps CS active with cs_change and locks
> the SPI bus for the duration of configuration.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

I applied this series to for-next. Thanks.
