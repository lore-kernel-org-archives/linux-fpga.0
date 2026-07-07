Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B31372057;
	Tue,  7 Jul 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399217; cv=none; b=nucBA4oQgIZilgEX8bKaQ8oxqKn7/hgsboMXcWyqGV3oqYVzIkuqQycxdVcx81kujA7jHA+RR4oJ7onHc+q38Hy5rpPynnsAK4SfMFR68IPdZHM0d3xUVz+n/4Lj2ey4LoXP/To9l6lC+toOpa8nuGOGWJNWvePiK4899mOX4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399217; c=relaxed/simple;
	bh=cJ+dPfoG1oPDfikr6/e9W5zjq7YzhVJ2o0c7d/dFJI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoULtHMJO2n7wNPg+/x54SggG1peBWmy4toKDAU387pTag2EGaCP1SecnkFo79kizSBPXfYrCR0Nbhjjz1SoyTqGCn352I8t8S1XttAfmtlGLCEGvxKLX9cHnUm2aH60TOHf4UTNYAQpBIjmkOAhhWE6Nb/5uNCpqxTLIyIdOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nyr50nwc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nyr50nwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783399215; x=1814935215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJ+dPfoG1oPDfikr6/e9W5zjq7YzhVJ2o0c7d/dFJI8=;
  b=Nyr50nwcm5IQu4Q60C1wutAjNqIo3YSMRRtaaxDHYo0RQ22KCk17p6Zf
   KsNG0zPRNPv2CXG9aPWdfMmUGtOubDnVlVRU6/tb5YvQELoQ3ZX1WINxY
   TSKds9/hT5lvbqkJNQgv1mBHFHCPVCaeNKaNtdGGcb5wyAcVAeOAx9Xpl
   NqGBdSiBsG6jKxX2fpMb2sDGnIEGs0s34dmCGtLI8Cl4QSdWtgUkZcC3b
   BMWJc6Yvm7+YFAt0gyF1HEXFK5n60076fvwP4fSvjmR0cH9xom//mOc3W
   EQU/cH7rXTMxquiPfycjtEF3LZ2Lks5Qv6DLUDyNuL9FczyADaC13tQEc
   A==;
X-CSE-ConnectionGUID: 62Q9xKCDR5y/ejrtZb3UvQ==
X-CSE-MsgGUID: GOZBBEWkT8WZtTHYyuij+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84063805"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84063805"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 21:40:14 -0700
X-CSE-ConnectionGUID: YHlnTeiUSQa+SRGDubDBgw==
X-CSE-MsgGUID: HQCFECdqQieAx5fcnw1yeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="255821450"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 06 Jul 2026 21:40:12 -0700
Date: Tue, 7 Jul 2026 12:40:11 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: tze.yee.ng@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Richard Gong <richard.gong@intel.com>,
	Alan Tull <atull@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] fpga: stratix10-soc: Fix SVC mailbox handling during
 reconfiguration
Message-ID: <akyDKzyRjI87IO/O@yilunxu-OptiPlex-7050>
References: <8768ce3260489c9febdfce08e27d03f5f5ed9c33.1782801986.git.tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8768ce3260489c9febdfce08e27d03f5f5ed9c33.1782801986.git.tze.yee.ng@altera.com>

On Mon, Jun 29, 2026 at 11:57:19PM -0700, tze.yee.ng@altera.com wrote:
> From: Tien Sung Ang <tien.sung.ang@altera.com>
> 
> Fix incorrect stratix10_svc_done() usage during FPGA reconfiguration.
> 
> Do not call stratix10_svc_done() at the end of write_init() on success, so
> the SVC session remains active through write() and write_complete(). Call
> stratix10_svc_done() on failure in write_init() and write() so the shared
> SVC mailbox is released when reconfiguration aborts, allowing coexistence
> with other SVC clients such as soc64-hwmon.
> 
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> Cc: stable@vger.kernel.org # 5.1+
> Signed-off-by: Tien Sung Ang <tien.sung.ang@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.
