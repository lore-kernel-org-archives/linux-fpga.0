Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA63624A8;
	Fri,  8 May 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228843; cv=none; b=MwzcrR2u8ZPh6++qR+JpSgh3foH43Nx9A04XPONPHHZLLugNqask6ebQpxkpD9mEXJyXwJ8nKaQLen+jIfAGHOuExmFUbudfIg9yDgMjAIFolLglsf844y2lUbUyBC8HQYw8KoclRG7dQOqRLRwCv2+AqPK40v787LWl5Vxvc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228843; c=relaxed/simple;
	bh=vv+GTFKGr2CZEbWCxzJX9llfRdEhYVJ4RSHglYFIAXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIqGs+5klnW2nI7xY0McNVrnRzI0z3mapbw1qbZqEsXAVwkNd4NPFu3VpbX72F707t25s/X/LIWtuuuZmdAEGRzna9zFTo79EivFJIz5R/1EOStaDysJS6DLPDdf3shQ7AqI7oeGHH6/Sj9zgDRben0ECA8TxjP8xH1rsDwt2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbJOi5fj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbJOi5fj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778228843; x=1809764843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vv+GTFKGr2CZEbWCxzJX9llfRdEhYVJ4RSHglYFIAXc=;
  b=UbJOi5fjeVsdIQy7Ja9fqnDqEM3E8Yjr7HuAEeofNda6Ui2XxTQHD0sS
   /QvFI7jHhMqb9ql5u56PwcDmIrsLCuaORr/5X9H8MWl3FuJQ/k2RgGG39
   tNnH6D9Vp2zwa5QX/O6rKuZySXyDRmQSS1jjXmYgALaOK0OTM7sv/b2ZI
   JD2lI0zmXn3Ec5dtBPLAGOULPFvEM6OjjPVQK8Rzlpm4qaEkA1DwVP4wr
   aiY8//Rn9l4wUm8yvQ1k4InvzgOG/3Ldf3a+RC4ffu6E73+kVEkYbOAAq
   PuQM1VnHa1X3HVG6lqFKQPNdf5Dq+4SvJfTv333h+5s8j6kMsMTLow8Fy
   g==;
X-CSE-ConnectionGUID: 4Jip+E0WTdaoWB6qIlNVrg==
X-CSE-MsgGUID: wqgq1xO3TTK3DheiAvgtVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79130489"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79130489"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:27:21 -0700
X-CSE-ConnectionGUID: RhAcvhDgTSGWmo5PiryFMA==
X-CSE-MsgGUID: 386BLQC3Rku9megj1sae3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241679964"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 01:27:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 62D929B; Fri, 08 May 2026 10:27:18 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v1 2/3] fpga: lattice-sysconfig-spi: Drop of_match_ptr() protection
Date: Fri,  8 May 2026 10:25:36 +0200
Message-ID: <20260508082716.1156192-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508082716.1156192-1-andriy.shevchenko@linux.intel.com>
References: <20260508082716.1156192-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Limiting the scope of devicetree support to CONFIG_OF prevents use of this
driver with ACPI via PRP0001. Drop the dependency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/fpga/lattice-sysconfig-spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
index d8d5a33a25b7..76df5d7ad1f4 100644
--- a/drivers/fpga/lattice-sysconfig-spi.c
+++ b/drivers/fpga/lattice-sysconfig-spi.c
@@ -121,7 +121,6 @@ static const struct spi_device_id sysconfig_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, sysconfig_spi_ids);
 
-#if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id sysconfig_of_ids[] = {
 	{
 		.compatible = "lattice,sysconfig-ecp5",
@@ -130,14 +129,13 @@ static const struct of_device_id sysconfig_of_ids[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, sysconfig_of_ids);
-#endif /* IS_ENABLED(CONFIG_OF) */
 
 static struct spi_driver lattice_sysconfig_driver = {
 	.probe = sysconfig_spi_probe,
 	.id_table = sysconfig_spi_ids,
 	.driver = {
 		.name = "lattice_sysconfig_spi_fpga_mgr",
-		.of_match_table = of_match_ptr(sysconfig_of_ids),
+		.of_match_table = sysconfig_of_ids,
 	},
 };
 module_spi_driver(lattice_sysconfig_driver);
-- 
2.50.1

