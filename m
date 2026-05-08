Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C43822BF;
	Fri,  8 May 2026 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227622; cv=none; b=I8cJFFzOWYt1izfXB/+XRCLFZUloEa2OCYDnvIok0j/i+inqq1tHN7CJieiUQDt/Fq1H3qGoKPshznp5sRxncFxlvMCdWx7gim6cqgKZU9qovkYGYGmy3qVMxFIzBe8OZoPSTaVtOUPkDXRfZmjSFLFk+/MsAxs/JKL8trjW9cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227622; c=relaxed/simple;
	bh=h8Bi/7RgyeiDM7y3FxDuWhgYwDZuF5rUTAp05BiUTAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMtlHq7i1EDHgrZbmeXVWZtqUxJwmSJO1tdXtWbaa/Rk3EkVX0ac9P6y9OGrchGCusgbTeSsMn/m2HEiS6SzF2XdDJUW1x1+hF15kmw3PJAnVwDQGRU0O7RdlWHbUF4Cm/PlVunQgGtYgc7wobns5lJE5fjMHbLPgQlovlu5zDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ff+VCBA6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ff+VCBA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778227620; x=1809763620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h8Bi/7RgyeiDM7y3FxDuWhgYwDZuF5rUTAp05BiUTAg=;
  b=Ff+VCBA6Q9JVBUWeraYx3vWgomuKH5qsYlqtD8iau4vzRpsYerkWgyMI
   LvZYLjfV4/nT5Bs+wlitGlY6rRbT+cQmMHSah2o/lkvs0EBTlHh23QSKC
   KgXYqs6NynPuxGbm/W032fdlgrAaXJN9vP/UyV7buScX8K0EvEg4x8hb4
   IB3KGfPdCA29VerPkYZCxRZUljC1mzsbFcdWXcSHzWzAERper51snz6S+
   j2HXRyj+eRP8KA3zHknpV20hFv4oKHfnl660OSS1jNAPrZoO8iSwRfbaI
   ggJ2nSxmIyPgBS+oCXS3T0GZXk1Lid60Jy+a2j2qfFIEXHTXWVWpeQSnV
   A==;
X-CSE-ConnectionGUID: v2Qo7C26TKmYsf9esK4MWg==
X-CSE-MsgGUID: vWxePEGUTlOjshC+AdUYqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="81756538"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="81756538"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:06:53 -0700
X-CSE-ConnectionGUID: QDY694q6TuG7hjHBcSd6xw==
X-CSE-MsgGUID: zC4R7CPCT3WXtmtgdHqiOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241675858"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 01:06:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7F8D098; Fri, 08 May 2026 10:06:51 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v1 1/1] fpga: lattice-sysconfig-spi: simplify with spi_get_device_match_data()
Date: Fri,  8 May 2026 10:06:50 +0200
Message-ID: <20260508080650.1144588-1-andriy.shevchenko@linux.intel.com>
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
 drivers/fpga/lattice-sysconfig-spi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
index 44691cfcf50a..6a906df45941 100644
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
+	spi_max_speed = spi_get_device_match_data(dev);
 	if (!spi_max_speed)
 		return -EINVAL;
 
-- 
2.50.1

