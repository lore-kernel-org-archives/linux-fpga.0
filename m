Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF114AD20
	for <linux-fpga@vger.kernel.org>; Fri, 14 Nov 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118044; cv=none; b=WjKhZcPp0kxzGBV/UFU4sRtF+cBF+OjH8c7BGxvrrp+6j7TR3xNGHhiXlvYF6mRVSDFiNaLIFmOL1AIsMcjM+HFGV6b5dNSgcdw1Rri6+HG3M8dzHrFep4tM7mY3rZX+pahbYD7o0xYvQxAfbbqDK2d+mB0KSulxuqvdPhmBXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118044; c=relaxed/simple;
	bh=ezC1/rUXe19y1CoFKvZlQiWBDtnl9JoKrZ1RE4XI5kk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jDYP6scQm8YMILTuvLGTFfPRAzirxeod7es/M+qwbf3Fh5Z/MIOZocLG8agLOqU97oVHkJun8HfmoSxvlTOGyh5m/Y3egArt/TXwCIezbltUOz7uOSKSQOjPvoqiFgTSfoDffT+xVFPm8yySNrn+c/c543uKNhvnDbvTtmpQrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9f81ygU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9f81ygU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763118043; x=1794654043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ezC1/rUXe19y1CoFKvZlQiWBDtnl9JoKrZ1RE4XI5kk=;
  b=K9f81ygUb+9AbVn6Fa8wuN8YwzdWKfZ4KQWTQq876H1iRpcTW9H6mz6B
   NDu448iMx2A2wGLYNZSsi4yx59dMdkFFm/tTr2Zn4Y7xrhMiZYwI/X4pE
   7X5aGRVh/7IKecjmHGrekPglq12t8l2crY91o7mCwiQyWfVVFC4685zC6
   OiUczslj+BrDOV0eti7PyVSurQhbwT7XKL/KiVbVmrclPwBHjA9YQoUAr
   x6Rrq11SVsDLFbR55Az9UpRFDgpYtBfJBLBHW8rgdIMO1gjn6p4a5dcHK
   VuKRW229K3Ccrhu/diPWEuZR9Rnbm/GgHTgKn/vBbk/ANyDcBp3tF9y9j
   A==;
X-CSE-ConnectionGUID: 396Q+ZZhQXCrZTpaUF7y0w==
X-CSE-MsgGUID: rI47iYClQ5SAsufh/AhRrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="76557011"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="76557011"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 03:00:42 -0800
X-CSE-ConnectionGUID: wZzGUdGvS4yu5QHiLUgYoQ==
X-CSE-MsgGUID: qeYWP3UhSMq7XzdJ/V4PtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="220615602"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 14 Nov 2025 03:00:41 -0800
Date: Fri, 14 Nov 2025 18:46:07 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Subject: [GIT PULL] FPGA Manager changes for 6.19-rc1
Message-ID: <aRcIb/DDDGTBTzDa@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.19-rc1

for you to fetch changes up to c9243d6df0d617535e842aa4c3d1d7dfdb91d07b:

  fpga: altera-cvp: Use pci_find_vsec_capability() when probing FPGA device (2025-11-10 15:03:13 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.17-rc1

- Matthew hands over the maintainership of Intel MAX10 BMC secure
  update to Yilun.

- Fabio adds missing spi_device_id table for xilinx-spi

- Dihn updates link for Altera & AMD's dt-bindings.

- Andy uses pci_find_vsec_capability() instead of open-codes for
  altera-cvp.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Andy Shevchenko (1):
      fpga: altera-cvp: Use pci_find_vsec_capability() when probing FPGA device

Dinh Nguyen (1):
      dt-bindings: fpga: update link for Altera's and AMD partial recon

Fabio Estevam (1):
      fpga: xilinx-spi: Add missing spi_device_id table

Matthew Gerlach (1):
      MAINTAINERS: change maintainer for Intel MAX10 BMC secure updates

 .../devicetree/bindings/fpga/fpga-region.yaml        |  4 ++--
 MAINTAINERS                                          |  2 +-
 drivers/fpga/altera-cvp.c                            | 20 +++++---------------
 drivers/fpga/xilinx-spi.c                            |  7 +++++++
 4 files changed, 15 insertions(+), 18 deletions(-)
