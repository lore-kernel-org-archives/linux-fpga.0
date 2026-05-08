Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE4371CE2;
	Fri,  8 May 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228843; cv=none; b=N/HOrp6cnTO9NwJbYXeo8KglEgqcP2rXx0xv/W2ycXaNNXM3oKjuoLu6j5Ffzjw7n0v6KnxISOFKmHA2le1vpypdVj7D0nHCOgNm4LGDBIvvjKlQL2hl0zm6VYLIg4/aAf8kRyE72N0E+yN1OUoVZwH4WXTH+fnr7+cHAjOY7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228843; c=relaxed/simple;
	bh=2XtyrkPKcpb6jkfUwPcwbCkoYesqJAKaxKgvl0WqXWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkAcKMQYZTpDa77uSlKvtNTe+lIjJeSXwJKkEOWHmEGP1/AuPjGR3WyPuXugxc+p14MEPFuLhaoXd7j82HLwHUg2XaGA8dEW0w8gQ3fxCe5kRdFepBbXoUgwFkk5V5p1CTct0F/RLtXqKknWSztiee06HIYZBE6p30zbg87nXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hv+ZXPe6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hv+ZXPe6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778228843; x=1809764843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2XtyrkPKcpb6jkfUwPcwbCkoYesqJAKaxKgvl0WqXWU=;
  b=Hv+ZXPe6S8VvFDaD8Vl7/1bCHmwsmrTJBIHUE/gk223SeuQV8njby1yt
   USQHCnF3SpQU5ctKPPpN/zQTSnEqAGED0L6WhUOG2yOeuzadLOFz4IIIl
   xbhnkpbiVkoIEC0YbzFnlSt4WEVBXvF1JtLXH16xNlR9f3W+Cq4jjQmh7
   CtaSTWZRm/LEodaesWhqz+ytjr6N6gDzc6g74kjXvFzh0SA5Olx++4fmn
   HpR2myrzWL6VJXiQE33QiUq8LFX92cGfVmMia1h+T/qlDzMYVUookb9ju
   fRGN7Qa3QtsMuUckyOYsyYSMUMRUFRFHNK1iw6B/ZVFSbSv6eRGIjJy0o
   Q==;
X-CSE-ConnectionGUID: BRle+HzGQfS4OKlLjGf6fg==
X-CSE-MsgGUID: M0tVDiRUQxO73JWI1cIlfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79130492"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79130492"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:27:21 -0700
X-CSE-ConnectionGUID: IBYkuPZ+REqOkkGo2/kfDQ==
X-CSE-MsgGUID: o9DHPeCSRaC/bVCb/ALX8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241679966"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 01:27:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5E76899; Fri, 08 May 2026 10:27:18 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v1 1/3] fpga: lattice-sysconfig-spi: Fix the terminator entries in ID tables
Date: Fri,  8 May 2026 10:25:35 +0200
Message-ID: <20260508082716.1156192-2-andriy.shevchenko@linux.intel.com>
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

The whole purpose of the terminator entry is to be the last one.
The trailing comma makes this statement prone to failure. On top
of that the style is used for the entries is unusual. Standardize
this all by moving terminator entries to their own lines and drop
trailing commas.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/fpga/lattice-sysconfig-spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
index 6a906df45941..d8d5a33a25b7 100644
--- a/drivers/fpga/lattice-sysconfig-spi.c
+++ b/drivers/fpga/lattice-sysconfig-spi.c
@@ -116,7 +116,8 @@ static const struct spi_device_id sysconfig_spi_ids[] = {
 	{
 		.name = "sysconfig-ecp5",
 		.driver_data = (kernel_ulong_t)&ecp5_spi_max_speed_hz,
-	}, {},
+	},
+	{}
 };
 MODULE_DEVICE_TABLE(spi, sysconfig_spi_ids);
 
@@ -125,7 +126,8 @@ static const struct of_device_id sysconfig_of_ids[] = {
 	{
 		.compatible = "lattice,sysconfig-ecp5",
 		.data = &ecp5_spi_max_speed_hz,
-	}, {},
+	},
+	{}
 };
 MODULE_DEVICE_TABLE(of, sysconfig_of_ids);
 #endif /* IS_ENABLED(CONFIG_OF) */
-- 
2.50.1

