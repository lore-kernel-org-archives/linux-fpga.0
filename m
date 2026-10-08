Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58C471431
	for <linux-fpga@vger.kernel.org>; Thu,  8 Oct 2026 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449227; cv=none; b=dyhuYHUTppbCt7BQTlfwaVAWnDnr9KRr2E2sbP9Mkmlfkk71jQQXyxF3t/CgCEfSPVGghoQXnwEpOdChy0J/5X92oxSwQujO7cnqu3YioEaUszyR5tWNIkPLBfBgKuSNoUOvUYgxwMm8hzpF2XklmpxkM9kzbRcUk1uf/sWCR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449227; c=relaxed/simple;
	bh=7dB1VPAsiGRSwyWvrlHX5k5ZoH1VV+QM7k+j2FFTGnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HCp/qbRP8JTj1cXtfnn9HWwYwz64a5FK7kkmJJzWvscbpdpu+1qSTdOAwoA+4699m3vV+/ruwFcleDYezqNc7gPXTIrGdkLoUGbt0bi0zVZYytj1K8CcgTTwrxCJZ+lLJ09h6CF3CnhfLf+pRjw4JjHIda1yoKGvWBXDwvrpEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9+7xEsA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9+7xEsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791449224; x=1822985224;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7dB1VPAsiGRSwyWvrlHX5k5ZoH1VV+QM7k+j2FFTGnA=;
  b=K9+7xEsA40dzb8lYskHaWngedOCzNNmfamPYyGaGNSQe8awxVizJ2ZBJ
   cUPCqYiAw7b8AHVMFnQGOfjVWCZz9elFfPLr9ugkA23nRWtq6SDFKcXTB
   WjzlZXEFgd8fxwaL7Hk1hamUmaOSER/2o1toucPskYeqG8VfAGcXcQz6D
   vNLF87gpW3M6VNCSC/nhpfMZ+UEQbHeuDnHYswtihT7TG0powUT9Xh4sI
   aRa9YsugmTiHbMR62eY7MmcHBdOe91PY+CsV0ZXuxRGi17EYTUECZi09k
   4WO45t4VJMwZMYVJzjcaAvSSF3dDz3ZthZpdHxLVDy0rdarxtXta4UsyY
   A==;
X-CSE-ConnectionGUID: lgDVkWiXSAuEeBeavSiv2A==
X-CSE-MsgGUID: DohWhk6vQAaBMnSLo8Ouaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="229301"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="229301"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:47:03 -0700
X-CSE-ConnectionGUID: rCfHKLiiSXeKBoEOiEfEUg==
X-CSE-MsgGUID: bttIFnczQYmB+rCTf37cXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="336719"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa006.fm.intel.com with ESMTP; 08 Oct 2026 01:47:02 -0700
Date: Thu, 8 Oct 2026 16:43:50 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 7.4-rc1
Message-ID: <asdXxh/YnEiCb92U@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-7.4-rc1

for you to fetch changes up to 093da48782df3d50953c520626b345ca70af8cbd:

  fpga: altera-cvp: Retry teardown and reset CVP state on failure (2026-09-29 18:23:46 +0800)

----------------------------------------------------------------
FPGA Manager changes for 7.4-rc1

- Uwe drops unnecessary header file for fpga-dfl driver
- Heiko corrects GPIO controls for xilinx driver
- Hemanth fixes a comment typo in altera driver
- Karl fixes a code comment in fpga manager core
- Nazim introduces a graceful error handling for altera driver

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Heiko Schocher (1):
      fpga: xilinx-selectmap: control CSI_B and RDWR_B during configuration

Hemanth Selam (1):
      fpga: fix typo in s10_ops_write() comment

Karl Mehltretter (1):
      fpga: Fix of_fpga_mgr_get() reference in fpga_mgr_lock() docs

Nazim Amirul (2):
      fpga: altera-cvp: Add helper to disable CvP mode
      fpga: altera-cvp: Retry teardown and reset CVP state on failure

Uwe Kleine-König (The Capable Hub) (1):
      fpga: dfl: Drop #include for <linux/mod_devicetable.h>

 drivers/fpga/altera-cvp.c       | 43 ++++++++++++++++++++++++++++++++++-------
 drivers/fpga/dfl.h              |  1 -
 drivers/fpga/fpga-mgr.c         |  2 +-
 drivers/fpga/stratix10-soc.c    |  2 +-
 drivers/fpga/xilinx-selectmap.c | 39 ++++++++++++++++++++++++++++---------
 5 files changed, 68 insertions(+), 19 deletions(-)

