Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17485346AC1;
	Fri,  8 May 2026 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228842; cv=none; b=O+z3JzaMalIcX1N2LFecSxDqTobQnufrM7RhypqrnppQndQ243wljOW3GXLHEB1b6hozziZVl7TmDd8UU0kYwJYQmHRVS0KZ5lyeGiUY2SKsLsCU5Q959nRemkyiRZK1clurDxj33G5Hbsf6YlLVdDdU7shY4qGUzyhAu57k5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228842; c=relaxed/simple;
	bh=/hVFHDBW18CcavUAceaBKVfBL9ica4pT1tFT1hrAIFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYSbgF3KSBWJCHN02BZx6bakQVZkxU7w4/PfH+KQ8L324BgtZqft9s4gIiVpzKD83TJL66LTxFwxfJdiKiCi1AxFiNl706wOK43X8tgoNBSkwvIxqg+RT5BfNjsGbDaH59WiGJdhw1GQX51UerfP9N3SQxVLReF3tbjHROy7U6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwI9Oaqz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwI9Oaqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778228841; x=1809764841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/hVFHDBW18CcavUAceaBKVfBL9ica4pT1tFT1hrAIFE=;
  b=gwI9Oaqzm+yXReOV/I7OufHg4umMMKUEpewCfkmieHaWXfzIPsxc+E94
   gAaJhashL5LJaNElZR6sAhYb4y8qMPKPuj7eOcL3RKA/T4GWNRo0pZfLs
   IEBE68XgsBTdhaW8w84T09JPQv37HZVMeNIAlKCuvZ/2r5uXXHtcPkW/B
   BlaiY+9OHiBn2diF/R+UU+KKFgNzpIttcoJkYYH8sYhukYiUUTk9r+pBc
   b/ceL342UmAQ2KmZbbZi2Mwia+Lr24AtK9VzYS+zIGSmLMaC5t/u1yaeP
   Jx6g8oT92roRnCviMo4h7V0wacqQ3PgYOroBj9kn5P1L68XkZ7kufnOe1
   w==;
X-CSE-ConnectionGUID: eujeiQw5RJ+tBtK9UHLx4A==
X-CSE-MsgGUID: 3g8FIKF9SKW1daFiEHAX0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79130486"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79130486"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:27:21 -0700
X-CSE-ConnectionGUID: shTOi+HeRnmzXwf0pkWyZw==
X-CSE-MsgGUID: I3ySZHxbR4qWN6sZDxPi/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241679962"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 01:27:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 66F239D; Fri, 08 May 2026 10:27:18 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v1 3/3] fpga: lattice-sysconfig-spi: Don't use "proxy" headers
Date: Fri,  8 May 2026 10:25:37 +0200
Message-ID: <20260508082716.1156192-4-andriy.shevchenko@linux.intel.com>
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

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/fpga/lattice-sysconfig-spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
index 76df5d7ad1f4..8462bc4be06e 100644
--- a/drivers/fpga/lattice-sysconfig-spi.c
+++ b/drivers/fpga/lattice-sysconfig-spi.c
@@ -3,8 +3,14 @@
  * Lattice FPGA programming over slave SPI sysCONFIG interface.
  */
 
-#include <linux/of.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
+#include <linux/errno.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 
 #include "lattice-sysconfig.h"
 
-- 
2.50.1

