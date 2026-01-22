Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593828506C
	for <linux-fpga@vger.kernel.org>; Thu, 22 Jan 2026 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075247; cv=none; b=lFPkZIEvbTvEMTAxKcVsCiFAYu1j73TdfXV/7VcDgC6aAfOK0hMpFMhQKsLXM4Mj1Kolb1lTfkIkhLIr9oyBe9cbosdOh7TqpDNsldLrsyQktNPFOXMR2lA928OMISJdGouuUWzM64mNSPkAiMV9FEX3fl6c5MgzuRDHmNC7tLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075247; c=relaxed/simple;
	bh=cEA3T/YT+wWLQrChPRAFWQRHM9Io9+amF+Bg83/iKGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SGoMs+yCQODvZ4gW3PEZkuMhiG3MlKZAsKW3vUQKEoBAX9z+/6KoSUtTuANdL9PLmCZRHiOpr7ROqn4y5sAj4Hul4SZkVehL3gv2yDMCAJgBH4VUtcSgSn0pfZUJQx9dH6qvR48ihvNK2cokEDC0p5xzC0VrPPdP4vBv20k9Jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlUOWv8E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlUOWv8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769075246; x=1800611246;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cEA3T/YT+wWLQrChPRAFWQRHM9Io9+amF+Bg83/iKGM=;
  b=DlUOWv8EbeIJDN+S1je47hxeuTJibBVUTcrgdm2fAy65rF2opCaXftOo
   yWutRyrywFauvQ59/NAZoE4PONhtoyXSRlu6waLsebv+iXwlG8XRiMT8C
   x71F+eYdwH5r0yPDX8olZXIG8bGyXV09YqzCvYH+3acHThskaYnKWa7VA
   TyosBauInzuw8ke9hDSpLlWBJXnxKGp0+BJRcEl4YMrT6vkKApt+KWWIb
   6GqdwuaNZYfn+HgRP0J7W2Vep5klQQKvuG9ohPsh1F9kbhCyxpKW2CPFq
   Jnp+F81gH6yWZa/vpmTmlYcvYuBnz+L2F+GJRPq0hE0ILwvx1+MbPrkJq
   Q==;
X-CSE-ConnectionGUID: RuLnJd0SQVu4efEDZsVNDw==
X-CSE-MsgGUID: HH+g6f7iRvGdvpsjaCdrUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81424436"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81424436"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 01:47:25 -0800
X-CSE-ConnectionGUID: zUM/GTHlSAGPAAsjBky5RA==
X-CSE-MsgGUID: ku4DyZZZQSiehtKTtOlBwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211707659"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 22 Jan 2026 01:47:23 -0800
Date: Thu, 22 Jan 2026 17:29:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.20-rc1
Message-ID: <aXHt+hVR6uIy/xww@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-v6.20-rc1

for you to fetch changes up to ae801944cbfb70326afc373c11a282d1ce3bae97:

  fpga: dfl: fix typo in header file (2026-01-22 17:08:06 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.20-rc1

- Mukesh fixes a typo in comments.

- Thadeu adds support for built-in dfl driver.

- Michal changes his email.

- Romain corrects the error handling when an fpga bridge is missing.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Michal Simek (1):
      fpga: xilinx: Switch Michal Simek's email to new one

Mukesh Kumar Sisodiya (1):
      fpga: dfl: fix typo in header file

Romain Gantois (1):
      fpga: of-fpga-region: Fail if any bridge is missing

Thadeu Lima de Souza Cascardo (1):
      fpga: dfl: use subsys_initcall to allow built-in drivers to be added

 drivers/fpga/dfl.c                 | 2 +-
 drivers/fpga/dfl.h                 | 2 +-
 drivers/fpga/of-fpga-region.c      | 8 ++++----
 drivers/fpga/xilinx-pr-decoupler.c | 2 +-
 drivers/fpga/zynq-fpga.c           | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)
