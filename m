Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A141480978;
	Tue, 21 Jul 2026 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634188; cv=none; b=iF7yTKidGWQoDU5AIMC5WnQvQEZUgpiMmPWqAu+N44iHnILYD4OBNNcy7ODfwYILZiMHhHP+GCRDisHIBh9ll+p8iCo1vFRLjvbj9T6q5IixWLZ+TxjOoaD113ICX8lGTuAkfYStASo9o+3FdzNgWV732r1/l6vIjuf8KcqzF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634188; c=relaxed/simple;
	bh=VZOolQ4CWKMdkrw+Fw11eXnpbTDZlHhByo5k29tkbJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUZ1jsHGrutLgpEgGeStxZqtNljZ0dlXTjxSaB/s8tCmBDMC/Q5si2elb12ss3VTsqWkmjZDd9KM/5cAVjVvF8t/MkTay/dTGiBowWkw4stSP7axFhfHrNRoCHppwJzdwTZs0kzYOrWgEfBGRSlN0mN/tv4pwccY0VuG8Pj/7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=fGjhJKjI; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="fGjhJKjI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35CE011A8F5;
	Tue, 21 Jul 2026 13:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784634182; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=A65APZFEd7fz0qjViK+USe3yaX2qjEZnD7YJQbU3HoY=;
	b=fGjhJKjI0PWc05levVac34+6Ks9BavSELaLLgCN8mq3fV4axt1/UaPP8lDlcPkK56sECsI
	wDKScqnMVGDlz85CVrANvpdnfXOea5cIxPn/CM8H8yjfYKGufEnfpvCaSxkkZwAMyoX53u
	ASNSlxpmOIVFDaMrHfqaeWpgmzdnWYIbQy1L27FCSdMNN5423Xgk9Nm9sk9YtpTxcIwC83
	9ieitJqpn1x8eNUa0BXzcWZY5EPO3YZkqW55XI6FCjMNbJXEJVvNrm342HHNZ8Udy0QB7C
	oeL7gdscxtndxHZpEr9XkoeJNOYiPCQcKbzbC+7zxRzu2CxBoQBJz4RAsX1EBQ==
From: Heiko Schocher <hs@nabladev.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Heiko Schocher <hs@nabladev.com>,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2] driver: fpga: xilinx-selectmap: add csi and rdwr support
Date: Tue, 21 Jul 2026 13:42:52 +0200
Message-ID: <20260721114258.3324794-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add csi_b and rdwr pin support for the xilinx,selectmap driver.

In current driver the pins are configured from DTS and set to
GPIOD_OUT_HIGH. This works in case you have one FPGA.

Extend this to really implement csi_b and rdwr pin function in
driver, so it works with more than one FPGA.

Tested on AM625 based board with 2 FPGAs connected to GPMC.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v2:
- add comments from Michal
  - skip check if gpio descriptor variables csi_b/rdwr_b are valid,
    as validate_desc() checks this in gpiod_set_value() call.
  - initialize the gpio variables csi_b/rdwr_b immediately with
    the return value from devm_gpiod_get_optional(), so we can
    drop local gpio variable at all

 drivers/fpga/xilinx-selectmap.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
index d0cbb5fdfe3a..d5175f9430e4 100644
--- a/drivers/fpga/xilinx-selectmap.c
+++ b/drivers/fpga/xilinx-selectmap.c
@@ -19,6 +19,8 @@
 struct xilinx_selectmap_conf {
 	struct xilinx_fpga_core core;
 	void __iomem *base;
+	struct gpio_desc *csi_b;
+	struct gpio_desc *rdwr_b;
 };
 
 #define to_xilinx_selectmap_conf(obj) \
@@ -30,16 +32,21 @@ static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
 	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
 	size_t i;
 
+	gpiod_set_value(conf->csi_b, GPIOD_OUT_HIGH);
+	gpiod_set_value(conf->rdwr_b, GPIOD_OUT_HIGH);
+
 	for (i = 0; i < count; ++i)
 		writeb(buf[i], conf->base);
 
+	gpiod_set_value(conf->rdwr_b, GPIOD_OUT_LOW);
+	gpiod_set_value(conf->csi_b, GPIOD_OUT_LOW);
+
 	return 0;
 }
 
 static int xilinx_selectmap_probe(struct platform_device *pdev)
 {
 	struct xilinx_selectmap_conf *conf;
-	struct gpio_desc *gpio;
 	void __iomem *base;
 
 	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
@@ -56,15 +63,17 @@ static int xilinx_selectmap_probe(struct platform_device *pdev)
 	conf->base = base;
 
 	/* CSI_B is active low */
-	gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpio))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
+	conf->csi_b = devm_gpiod_get_optional(&pdev->dev, "csi",
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(conf->csi_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
 				     "Failed to get CSI_B gpio\n");
 
 	/* RDWR_B is active low */
-	gpio = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpio))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
+	conf->rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr",
+					       GPIOD_OUT_LOW);
+	if (IS_ERR(conf->rdwr_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
 				     "Failed to get RDWR_B gpio\n");
 
 	return xilinx_core_probe(&conf->core);
---
base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb

-- 
2.55.0

