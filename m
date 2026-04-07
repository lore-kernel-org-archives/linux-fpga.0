Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141832459DD
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532634; cv=none; b=HNq0v7FOS7oQAzxk0En+GOpTqL0Eqqb2LM45vZ5EXaHjS3Lak3aYS9EpAZ2ERKbbGFnJ0pd1yqOrtRwTnAdzB/pzYXAPAQJasE0Fmcao6BSpSFkWO/3IiTospn/3aXdIs/h4LJBHhyFn6r0X6ZnUm3vRaz6j/TbREbSTfrlEWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532634; c=relaxed/simple;
	bh=EzDQomwGN7lGP+0IMVDXXbmvhvdlw3B+JOBpwmPNuHg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FqgoRh8h+Ojg4hMJe/lcIwv30StorIhX/2drdUcHYZFgvZ/8+3v/63du+bJuHRa2Y1ne2X7CzxB2Q3xKiGTgo6K5Lq84LazkdiiuLv0bOx5LNxrzf5Xzpi6on9loHp2VUPF3+GDcRiKSakUrN9p8WuzSxtwfVieHcOHI/Np+MTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fgs68Hm6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fgs68Hm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775532633; x=1807068633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EzDQomwGN7lGP+0IMVDXXbmvhvdlw3B+JOBpwmPNuHg=;
  b=Fgs68Hm6QSVvrvQS9HAu+GhZ6n/QTQAVSeSb7R7fD6T8n/ikK/ivMWbb
   3H4syRnIw86L8Bas3rCPtp50V5CTDs76+mnMHPtjW0t4dfAWymRuYyRAj
   cWb9tu9Aabt/wj/2qsILa902/8pnfRMXaZXPxKi03dHKzzOfnTr0ikigB
   a+rR7mxb6dVX12MCfuQM6xzt8VYzZgWh3jxtRrTrR0W3yswbXltnHOM1j
   CaH8OfzukdMBIS5zpBEBY3Si6RX5AYN92yBJbG2yMfVe2AzlAdYJfv+sT
   JBiQOjep+1rD3PHp5Qx0VZJhQMX/RalyvPlLjaOjR3/AqHgZnP7Vzmsu9
   Q==;
X-CSE-ConnectionGUID: IwiDrLvPRNanS8WnwwggoA==
X-CSE-MsgGUID: ue/Uh9o5RqqS8wfMcP4oOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76384625"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76384625"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 20:30:33 -0700
X-CSE-ConnectionGUID: 9SRR48iZSW+VR8m4Uw8H0Q==
X-CSE-MsgGUID: g9or8de5SqO2ZS3F/dPePQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="232920373"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 06 Apr 2026 20:30:28 -0700
Date: Tue, 7 Apr 2026 11:08:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 7.1-rc1
Message-ID: <adR1S5wFkU7dOFqH@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-7.1-rc1

for you to fetch changes up to f63ddbcc3299047e7026b9324520aa826794f0c5:

  fpga: m10bmc-sec: switch show_canceled_csk() to using sysfs_emit() (2026-03-25 14:57:26 +0800)

----------------------------------------------------------------
FPGA Manager changes for 7.1-rc1

- Dinh & Yury's changes to use sysfs_emit() for sysfs read

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Sorry for the late post due to personal affairs.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Dinh Nguyen (1):
      fpga: bridge: Use sysfs_emit() instead of sprintf()

Yury Norov (1):
      fpga: m10bmc-sec: switch show_canceled_csk() to using sysfs_emit()

 drivers/fpga/fpga-bridge.c              | 2 +-
 drivers/fpga/intel-m10-bmc-sec-update.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
