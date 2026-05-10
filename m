Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAEE2D5C83;
	Sun, 10 May 2026 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778403965; cv=none; b=Na22cyRJrX/G5K4R8/cXk/mOpZfa2ssvpCUO4vfRvPYR3Fx3WrZc5y8Jmq4iH3BJC99S57s8y9hSRWAztV7a2p92G0pWEN04MYGFD402/ISEzyE6/Mvt+PuRBAmHVoVBI0kEm6j6TeUQ0c4QLCMjakCZeMhwV3STDNwpyO+hd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778403965; c=relaxed/simple;
	bh=0Isckc1yQzXmLlG0vSYnNBNWmKaeMjQ2pooa5allG/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akBhQd84Wn7o9+avjKvc4meLjIbwZKjQbDqLNXzMKCZbICdcjh+3pUI0txxzSEsT0TMaMq4jJfVbVOTwRDNh+6axsDpvmcb7OWKzbg/SD2RnYOOktmHqT1MnjGhy/5bOKJAEMUsdCL/aFSoxgH0SMc3bM4DeTdY21x2Wb0MkJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSV0SPo/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSV0SPo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778403964; x=1809939964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Isckc1yQzXmLlG0vSYnNBNWmKaeMjQ2pooa5allG/Q=;
  b=WSV0SPo/I9fNu3prBjUcK/d4dKWZMleK2OJxFxkLyKWTPM7FLkwTDdAT
   JkFwt+P9sGfNs8AYh4frKvvf9sYLw5u3zZoF67qo8i6TKF8GGiP6pM0fk
   85bFhEuBZET2MtdyPrCYGjk5yiBtPsodRwpIGtabesJSV25v54xi+u7Bt
   OAYBqQmQQDLSq5EBiTtU37+JXSnx+ZgWCnDXXyYanfPNVTJCtvv9TNqz0
   PCeATbIW68RRqIrso5raOVVqzIAfsNSybSMhc/fpDwKsP7Zgy/9aLmW5U
   57shh1hj7iXIIEpzoa93sC2yVMbvnniZgozCGrDUuLx10ep+ghsqpWpDU
   Q==;
X-CSE-ConnectionGUID: 0n/Lx2nKSLKNyIyKIBYybw==
X-CSE-MsgGUID: cs1mF9I0QrWMWv/UE1q+Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="90787130"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="90787130"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:06:04 -0700
X-CSE-ConnectionGUID: A5xmgIGVTiCAX7bVeUycqA==
X-CSE-MsgGUID: rgaVewntQNSDSsskhY3wXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="232706427"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 10 May 2026 02:06:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A3E0095; Sun, 10 May 2026 11:06:00 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/1] fpga: lattice-sysconfig-spi: simplify with spi_get_device_match_data()
Date: Sun, 10 May 2026 10:51:58 +0200
Message-ID: <20260510090556.1582900-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used correct parameter (LKP)
 drivers/fpga/lattice-sysconfig-spi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
index 44691cfcf50a..a62ee5b7bfeb 100644
--- a/drivers/fpga/lattice-sysconfig-spi.c
+++ b/drivers/fpga/lattice-sysconfig-spi.c
@@ -85,7 +85,6 @@ static int sysconfig_spi_bitstream_burst_complete(struct sysconfig_priv *priv)
 
 static int sysconfig_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *dev_id;
 	struct device *dev = &spi->dev;
 	struct sysconfig_priv *priv;
 	const u32 *spi_max_speed;
@@ -94,15 +93,7 @@ static int sysconfig_spi_probe(struct spi_device *spi)
 	if (!priv)
 		return -ENOMEM;
 
-	spi_max_speed = device_get_match_data(dev);
-	if (!spi_max_speed) {
-		dev_id = spi_get_device_id(spi);
-		if (!dev_id)
-			return -ENODEV;
-
-		spi_max_speed = (const u32 *)dev_id->driver_data;
-	}
-
+	spi_max_speed = spi_get_device_match_data(spi);
 	if (!spi_max_speed)
 		return -EINVAL;
 
-- 
2.50.1

