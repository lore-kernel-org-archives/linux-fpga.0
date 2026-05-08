Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEF35DA52;
	Fri,  8 May 2026 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228842; cv=none; b=ufzXQ95JzB3HEN7mGH0KDT+ItzzPvWEblUEaznP5cXDKhqrYWsT3hnvq5S4uNrYOVEplI5P5ZuEZ0DaKos5JvtJAppkA9K+2kKnPaHFivMT/JlvgEyG3PtMsWPsZRKLRpo6ep30+0CEAn4vfkpj/hXtP2xF691Kw+U05VK02WWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228842; c=relaxed/simple;
	bh=kfhXdlnyWswJLKT1sWbVHUIv7yLZ6hbXOzBPIIx/pzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BaOm/uPehpsyX6BuPrt/ic9kdz+LZkPltxIcojl1gGNfq2W6p9oYdXNq7xBkJKEN2YkNgAU+soOxHvrKT04TWrC6Wjsbruamh308GT6RbQA8sEp8mikYq9E2UL9zlb8+OKdABadEN1m8vFHBgmoKS4ZvRKzo+G61L0QLKVZADRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmLlloOf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmLlloOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778228841; x=1809764841;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kfhXdlnyWswJLKT1sWbVHUIv7yLZ6hbXOzBPIIx/pzs=;
  b=JmLlloOf0lXInFRD1D7QNrSt23DwkEmo9h7mzcS7Zm6FBTNVSCETJUI9
   8oT3WFpdwmOOiD8cTvXe+80Xz3GShS3UzRZ9MtQLFC69qGg14PtNqlYn0
   DxlyB0boRN2xFbQf8HqSzSEfts3gQCOQhFd+s3Fkn66PiHERxOl1t6gFh
   +baKZtnuUeovz4YQqGlLG9KCu98RSHtSDOhaoaVT4RxtJRUcXXAFHt+pi
   2gGsEffNRtegItzV/tky8JkRYTIqzlDzC3xue94kpOM2r+mV11oKfuA9X
   rbBlRFX6415GQIkmOgFBm1P7DPlCc12N1ZFqF+6X0MeXlNkTy1hE7sXYf
   w==;
X-CSE-ConnectionGUID: FRT2kB6GTYOzMv8JLm/5xQ==
X-CSE-MsgGUID: 0nw9oTlmQUCDngEUQzzd5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90656604"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90656604"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:27:21 -0700
X-CSE-ConnectionGUID: SkqziLxGQm63kvXcdm2rSw==
X-CSE-MsgGUID: m55Pz19mQrOsEoVFOm54Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241054196"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 08 May 2026 01:27:20 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5B22498; Fri, 08 May 2026 10:27:18 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v1 0/3] fpga: lattice-sysconfig-spi: Ad-hoc cleanups
Date: Fri,  8 May 2026 10:25:34 +0200
Message-ID: <20260508082716.1156192-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While converting the driver to use modern SPI APIs, I have noticed
more things to improve, hence this mini-series. Note, it's independent
to the above mentioned conversion patch and may be applied before or
after (separately).

Andy Shevchenko (3):
  fpga: lattice-sysconfig-spi: Fix the terminator entries in ID tables
  fpga: lattice-sysconfig-spi: Drop of_match_ptr() protection
  fpga: lattice-sysconfig-spi: Don't use "proxy" headers

 drivers/fpga/lattice-sysconfig-spi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.50.1

