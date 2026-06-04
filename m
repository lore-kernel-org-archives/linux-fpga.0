Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5923D7FF
	for <linux-fpga@vger.kernel.org>; Thu,  4 Jun 2026 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546952; cv=none; b=gB2OgI8M05Tmoce9VlMY6zi6U2NU4FqM/sDM7/I2B+Ar208K8dFpvh3cxUHNqy8HhagWbE0dIvgliQKzq3etzTnXXK01XzUivQuVRLYJivTFNiv7Rp+fbxXHarBui3zPTrMvONO8GAUrxUwgLG7ZxR9NR6q7+/pf0FLHbFwqaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546952; c=relaxed/simple;
	bh=0eIG2XRC3CZVME2Du/QOne/IbkPPK++26i5wVU1vllk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZJz0tJtEZ0OI0oiMTvi95s6lB8JHysdnRkrbBDHbpmjFLDNo4M9nseWbBDC/c0urQZN4B0aYT6GmyNzfl4wjHL4/ro2kHkkaZPoevLP/p0FVUNz2+7VLDU6+x5DkDVDTtLda3PBYtiLHfFFFSGA7Fx0Qp+4dhHi3mB3ch4OzwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntzwNeZ3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntzwNeZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780546951; x=1812082951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0eIG2XRC3CZVME2Du/QOne/IbkPPK++26i5wVU1vllk=;
  b=ntzwNeZ3rdeyzHdwHAIN8DfwWJnaFZIWIZmBo+WCPTuFbf0Kfqo0h1A9
   7+QBRs45ZL2upMnnSB8BQmI+0iS/E50nGrz3Dq76V7w1H++hGyIVejOIP
   bco/f9A7JKEI6amsBxQ5nKQt8a5UrvMVTx4IbOiNF5gh7w12+aW8psn+b
   IgsdKDxJhDZ3Ocqm9+0I8Fw2b9wQC+u8Xh9HSxjfC+qGNkRUlfD4C+OQN
   ilNEQwlNJA7pIgR3JrxEwRQD9UOSgXfKs+1yDvOrBYaszk2LME6faAz48
   SgjlxQo0yQqgn0BamhUBTkL+Lywn97eQRetbb1LzhM3KFZJbM2BDx6YfK
   Q==;
X-CSE-ConnectionGUID: BxY0DhaSQ3SMBqficmM0TA==
X-CSE-MsgGUID: kcZ2VUrSROyZrOeA6l7B0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81400775"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81400775"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 21:22:30 -0700
X-CSE-ConnectionGUID: Js1rCwO0TcGQIgzgfQtZUg==
X-CSE-MsgGUID: WM6Hrj/MQpi0x8mY93MDYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="248375286"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 03 Jun 2026 21:22:29 -0700
Date: Thu, 4 Jun 2026 11:58:10 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 7.2-rc1
Message-ID: <aiD30tC74Rn2KjGM@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-7.2-rc1

for you to fetch changes up to 43a1974da6bc7ce8f4d1dc1d03d56997428c29c3:

  fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header() (2026-06-01 12:29:40 +0800)

----------------------------------------------------------------
FPGA Manager changes for 7.2-rc1

- Wentao fixes use-after-free issue in of-fpga-region
- Phil adds the of matching for Altera ts73xx fpga driver
- Ian adds Efinix FPGA SPI programming driver
- Andy fixes several minor issues for Lattice FPGA driver
- Manish converts dt-bindings to YAML schema for several Altera devices
- Sebastian fixes several minor issues for Intel DFL & Microchip FPGAs

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Andy Shevchenko (4):
      fpga: lattice-sysconfig-spi: Fix the terminator entries in ID tables
      fpga: lattice-sysconfig-spi: Drop of_match_ptr() protection
      fpga: lattice-sysconfig-spi: Don't use "proxy" headers
      fpga: lattice-sysconfig-spi: simplify with spi_get_device_match_data()

Ian Dannapel (3):
      dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
      dt-bindings: fpga: Add Efinix SPI programming bindings
      fpga-mgr: Add Efinix SPI programming driver

Manish Baing (2):
      dt-bindings: fpga: altr,a10-pr-ip: convert to DT schema
      dt-bindings: fpga: altr,socfpga-fpga-mgr: convert to DT schema

Phil Pemberton (2):
      dt-bindings: fpga: Add Technologic Systems TS-7300 FPGA Manager
      fpga: ts73xx-fpga: add OF match table for device tree probing

Sebastian Alba Vives (3):
      fpga: dfl: add bounds check in dfh_get_param_size()
      fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
      fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()

Wentao Liang (1):
      fpga: region: fix use-after-free in child_regions_with_firmware()

 .../devicetree/bindings/fpga/altera-pr-ip.txt      |  12 -
 .../bindings/fpga/altera-socfpga-fpga-mgr.txt      |  17 --
 .../devicetree/bindings/fpga/altr,a10-pr-ip.yaml   |  34 +++
 .../bindings/fpga/altr,socfpga-fpga-mgr.yaml       |  38 +++
 .../bindings/fpga/efinix,trion-config.yaml         |  98 ++++++++
 .../bindings/fpga/technologic,ts7300-fpga.yaml     |  36 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/fpga/Kconfig                               |   7 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/dfl-afu-main.c                        |   3 +
 drivers/fpga/dfl.c                                 |   2 +
 drivers/fpga/efinix-spi.c                          | 260 +++++++++++++++++++++
 drivers/fpga/lattice-sysconfig-spi.c               |  29 ++-
 drivers/fpga/microchip-spi.c                       |   3 +
 drivers/fpga/of-fpga-region.c                      |   3 +-
 drivers/fpga/ts73xx-fpga.c                         |   9 +
 16 files changed, 507 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-pr-ip.txt
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-socfpga-fpga-mgr.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,a10-pr-ip.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/technologic,ts7300-fpga.yaml
 create mode 100644 drivers/fpga/efinix-spi.c
