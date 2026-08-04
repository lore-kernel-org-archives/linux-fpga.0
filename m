Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE47E446832
	for <linux-fpga@vger.kernel.org>; Tue,  4 Aug 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836795; cv=none; b=ur/u0xu5J7lXO1Sxa/i15hduLTP+k4jVyNS8ycx/Rj7EbfI7ygVfJLG2UHjZVaQKg+NE91Wy/Mju6EAs53ZBK+acmr44Emxs5UX0JWEp0lqrXQlKpD9yAo+QmMCzqEU2DxAfEAnI6v3+TtZO++qTJV3glpnQPr3v0nDVVwThZp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836795; c=relaxed/simple;
	bh=Md+HplqQV31CPyvcSViUR0mkSHgDRyaOBiU0Qgqm/Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rMcGWeaaGCB+y48yA8xnrDPWEMVafh3dwERccHAO+YzZda/N4Tp+eTvSCu+lNF8u3RoW4vr0DOgpcStXTeqELFhu1E/5AEcToHDOjP3Ll4lE3DiANhygaNNfnic2qJSeBYwJ+KhWotYIYOSKMblktohuU9zloJmpreSsLQPvc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mnu3N6WB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mnu3N6WB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785836793; x=1817372793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Md+HplqQV31CPyvcSViUR0mkSHgDRyaOBiU0Qgqm/Fs=;
  b=Mnu3N6WBWjHmeUPFcA1MIh/i6C/o8TiaqIovoNGI3r/l7m4wyANYMM+6
   e6bgSmD9sP6fJxNjkT1fZwWgbTaAgBOjjhwPdzrPCMm/yK1crLLSHZpH4
   w1u539ZVmqyD3dMSHEXKFcJ7iiCqjz3+RmldiIBC0c2kUnlpbinvHSQWT
   25OIq2751KtLwR8KGMkjMV7G3112yaSqiemMzb7lFsZ8kFg9GLauRA1YC
   X1M2uESu9J4NMGE1BIlzdtBFLHmRI5RX7xP28kxd7wRjZjMdeyWjXjpL4
   xMzxMSfu+ieZ7CN6wjN5koPjNQg7PHofeNUg02Od+Jx77xFU7ABMzRKKR
   A==;
X-CSE-ConnectionGUID: ShLXeDpzQD6j5U6zVd6AmQ==
X-CSE-MsgGUID: /sQO10FpQoG/nA8tp909KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86581393"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86581393"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 02:46:33 -0700
X-CSE-ConnectionGUID: hTcvW4CIRzS+E85b2GP2yw==
X-CSE-MsgGUID: TWCT0sKZQ8m3HU5BIAo9mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="286115612"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 04 Aug 2026 02:46:32 -0700
Date: Tue, 4 Aug 2026 17:46:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 7.3-rc1
Message-ID: <anG09zb/HD1+cD2s@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-v7.3-rc1

for you to fetch changes up to 4216e549a265701c88df660f42d74a7eb4819af2:

  fpga: dfl: fix spelling in sysfs-platform-dfl-port ABI documentation (2026-08-04 17:36:32 +0800)

----------------------------------------------------------------
FPGA Manager changes for 7.3-rc1

- Michal replaces the open code by devm_clk_get_prepared() in xilinx
  fpga driver
- Tien Fixes the incorrect usage of stratix10_svc_done() in altera
  fpga driver
- Greg adds error handling for fpga dfl driver
- Pan removes redundant dev_err() in xilinx fpga driver
- Daisuke fixes a potential out-of-bounds read in altera fpga driver
- Ayananta fixes spelling in fpga dfl ABI doc

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Ayananta Paul (1):
      fpga: dfl: fix spelling in sysfs-platform-dfl-port ABI documentation

Daisuke Matsuda (1):
      fpga: altera-cvp: Avoid out-of-bounds read in trailing byte write

Griffin Kroah-Hartman (1):
      fpga: dfl: fme: add error handling

Michal Simek (1):
      fpga: xilinx-pr-decoupler: Use devm_clk_get_prepared()

Pan Chuang (1):
      fpga: zynq-fpga: Remove redundant dev_err()

Tien Sung Ang (1):
      fpga: stratix10-soc: Fix SVC mailbox handling during reconfiguration

 Documentation/ABI/testing/sysfs-platform-dfl-port |  2 +-
 drivers/fpga/altera-cvp.c                         | 10 ++++++----
 drivers/fpga/dfl-fme-perf.c                       |  2 ++
 drivers/fpga/stratix10-soc.c                      | 21 ++++++++++++---------
 drivers/fpga/xilinx-pr-decoupler.c                | 20 ++------------------
 drivers/fpga/zynq-fpga.c                          |  1 -
 6 files changed, 23 insertions(+), 33 deletions(-)

