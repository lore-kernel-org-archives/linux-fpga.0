Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427F36C5A1;
	Mon, 10 Aug 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342887; cv=none; b=oAYsGzZozdqLUDbGY9iTPVg4mnNPle96vAr3Ybh0vb6uijxH3glTNI1ZcS9kUky6/VM0ZQuNRRpZSDH8U/1zHWLdTpl0L9EczLyrxWE+fV3rPBZOUYreo7geLcl7jCX4b00sp5W6NPvkW+b6UKh49OFhV7wneXHsQ1QA/IA1T98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342887; c=relaxed/simple;
	bh=2mM10romqLpq5O107SRCTjwfedWENZiCE+DZ4PUg6WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f30nG8eqKbRzmZkF0jph4li/RayQRDVBvFWD8bvxOfSNNU4EabK8cha+4Gt85auwj6ir/lxFry2pEaLN4I7X3ipJUp01dEJInqgcdWbC2cKpmulUvU/tMVZRTVV8/W5whS30RoJpULPno6oNuqipjiqz9Yw9+fdA4gPgNEbkM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=DoJCGJul; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="DoJCGJul"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E3FD11B494;
	Mon, 10 Aug 2026 08:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1786342873; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=TIcYkXIenvNkMTJ1YuV3o4EGTcYhnPA+PcvQgIsAFFM=;
	b=DoJCGJulsBPRy6JS3ixEUSVrFe8PLIcqz0AV9dMgE0c2ta4xuNd52VcgEO2m8+7XMdoW0D
	f4IVkh1MvMHVPOGdQ/o5fG6WEKJoSWuaLCvdTMdKmx1qY2gLFdf9jAA9m07w+CArEtGTrS
	WsWz6W05WTQLgBjDBmiUeaeYaRXPAp5MX9orAwZfVCC70PKljktxTFy/lmbcRCJmgYNZhL
	qS0bEIX9FP/v6G93p9ZXHJn5v0Qlinw5bmZe2aJr2OC0pgGna2j10vankCQk81wv47lr9I
	k0KgiLUCaCNPYzhxzar6YpzXqnjcSto23ZUig1PPM1Igu+1pHX5p8zDfb7+yhg==
From: Heiko Schocher <hs@nabladev.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v4] driver: fpga: xilinx-selectmap: add csi and rdwr support
Date: Mon, 10 Aug 2026 08:20:51 +0200
Message-ID: <20260810062105.299808-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The current driver requests the optional CSI_B and RDWR_B GPIOs but
only configures their initial output state and never changes them
afterwards. As a result, CSI_B and RDWR_B remain inactive or active
throughout the configuration process.

This may work on systems with a single FPGA where these signals do not
need to be controlled by software, or where the signals are configured
to their active state. But this does not not support systems with
multiple FPGAs sharing a SelectMAP interface.

On systems with multiple FPGAs sharing the same SelectMAP data bus,
the driver must deassert this signals in probe, and actively control
them during configuration.

CSI_B (Chip Select, active low) selects the target FPGA. It is asserted
before configuration data is transferred and deasserted afterwards so
that only the intended device responds to bus transactions.

RDWR_B (Read/Write, active low) controls the transfer direction on the
SelectMAP interface. A low level selects write cycles, while a high
level selects read cycles. During FPGA configuration the driver drives
RDWR_B low before transferring the bitstream and restores it to its
reading (high state) afterwards.

With that info from the datasheet the driver is now changed to:

- deassert the CSI_B and RDWR_B pin on probe and store the
  optional GPIO descriptors in private driver data.

- toggle both signals around the configuration data transfer

This allows multiple FPGAs to safely share a single SelectMAP interface.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v4:
- add comments from Xu Yulin
  replace wrong gpiod_set_raw_value() with gpiod_set_value()
  deassert CSI_B and RDWR_B in probe as in patch version 2
  rework commit message (correct the description what current
  driver do on probe), why this is not a problem with one
  FPGA, and why it needs a change if you have N FPGAs
  sharing the same selectmap Interface (clk and data pins).

Changes in v3:
- use 0 (deasserted state) and 1 (asserted state) in gpio_set_value()
  as commented from Micahl
- rewrite commit message as requested from Xu Yilun
  - describe what rdwr_b and csi_b do, and why this change is needed
    for more than one FPGA.
- add comment before asserting the signals, why they are asserted
  in this order.

Changes in v2:
- add comments from Michal
  - skip check if gpio descriptor variables csi_b/rdwr_b are valid,
    as validate_desc() checks this in gpiod_set_value() call.
  - initialize the gpio variables csi_b/rdwr_b immediately with
    the return value from devm_gpiod_get_optional(), so we can
    drop local gpio variable at all

 drivers/fpga/xilinx-selectmap.c | 36 ++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
index d0cbb5fdfe3a..e9b1d15ca054 100644
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
@@ -30,16 +32,30 @@ static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
 	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
 	size_t i;
 
+	/*
+	 * Assert CSI_B and select write mode.
+	 *
+	 * UG570 states in note 4 in Figure "Continuous x8 SelectMAP Data
+	 * Loading", RDWR_B should be asserted before CSI_B to avoid
+	 * causing an ABORT on the next CCLK.
+	 *
+	 * To be sure, set first RDWR_B pin before activate CSI_B
+	 */
+	gpiod_set_value(conf->rdwr_b, 1);
+	gpiod_set_value(conf->csi_b, 1);
+
 	for (i = 0; i < count; ++i)
 		writeb(buf[i], conf->base);
 
+	gpiod_set_value(conf->csi_b, 0);
+	gpiod_set_value(conf->rdwr_b, 0);
+
 	return 0;
 }
 
 static int xilinx_selectmap_probe(struct platform_device *pdev)
 {
 	struct xilinx_selectmap_conf *conf;
-	struct gpio_desc *gpio;
 	void __iomem *base;
 
 	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
@@ -55,16 +71,18 @@ static int xilinx_selectmap_probe(struct platform_device *pdev)
 				     "ioremap error\n");
 	conf->base = base;
 
-	/* CSI_B is active low */
-	gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpio))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
+	/* CSI_B is active low, deassert signal */
+	conf->csi_b = devm_gpiod_get_optional(&pdev->dev, "csi",
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(conf->csi_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
 				     "Failed to get CSI_B gpio\n");
 
-	/* RDWR_B is active low */
-	gpio = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpio))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
+	/* RDWR_B is active low, deassert signal */
+	conf->rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr",
+					       GPIOD_OUT_LOW);
+	if (IS_ERR(conf->rdwr_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
 				     "Failed to get RDWR_B gpio\n");
 
 	return xilinx_core_probe(&conf->core);
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58

-- 
2.55.0

