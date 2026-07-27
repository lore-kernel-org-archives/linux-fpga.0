Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C5233723;
	Mon, 27 Jul 2026 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785129761; cv=none; b=CoIrXyMiBRrAdY64//8DjjdzNfp5a+UL+7hr1eM+kFJSVhXg58rTfQt+Nl7+uNja0KZr4tXZ5jRg3rbuGKVoNuh3uH36dSo6inyjGuYS8C83CXCUAo1kt35/+t6xxdeyA/75AHS6a6H9v9l8dEiWNJ14fFN/DffUL2KdsQyd0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785129761; c=relaxed/simple;
	bh=uMDlH5nwJXBn0wKKQko96ASZ5KMhTdr5be0MMz1jYjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZF3Xk//hUThhaJUlrW7X9LfP784uu1inqPuXRBurFrAlT+4RTkiJ1rKklJBTB7dCIAVU6dEorc4sioxIy7274D2sJvFTyu0qLEi7+dh/PnbexhdxouxKBtRhvJQ0fWxslX1XkfRALkwfF1cgGIuKQbTDyUa5zlDg9zw6OxoHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=EvKRMMvy; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="EvKRMMvy"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B2B4118321;
	Mon, 27 Jul 2026 07:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785129746; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=C7u7qt0q5CoQ4f3u+rALRaPoEix+wn4Qau2fUG98YwQ=;
	b=EvKRMMvyeQkVrUDsdyf9MBofKMZQk5cPoCYNjZeJt45cTSlWqdEF5HwNFyAX7kBa9g5+ax
	hrG2S+8c3STQLQl96mvWFIUM0+KG52I9Ywo6aB5+5pySOzMo0/8zgjyTusPzj8p+hWSRjR
	Ij752wcUBcf9FUJWON2YXiXxACLqV2Gjm4s48wcedriTDkw659GLdlvpgUAQHqrh7Wpons
	BufOkIGwdK0HxsYvy3JTkYUJ4TE7Jg0GUF6ADtcYK/9ypjFm5hmc337lgua/q6F+DamkOj
	03j1JSEk8S+fM4MCTjKJ3HmgefxyXFvNUhADyy8Fe8csmcisHV9dIjGmENEQgg==
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
Subject: [PATCH v3] driver: fpga: xilinx-selectmap: add csi and rdwr support
Date: Mon, 27 Jul 2026 07:22:10 +0200
Message-ID: <20260727052218.4079979-1-hs@nabladev.com>
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
afterwards. As a result, CSI_B and RDWR_B remain inactive throughout
the configuration process.

This may work on systems with a single FPGA where these signals do not
need to be controlled by software, but it does not support systems
with multiple FPGAs sharing a SelectMAP interface.

On systems with multiple FPGAs sharing the same SelectMAP data bus,
the driver must actively control these signals during configuration.

CSI_B (Chip Select, active low) selects the target FPGA. It is asserted
before configuration data is transferred and deasserted afterwards so
that only the intended device responds to bus transactions.

RDWR_B (Read/Write, active low) controls the transfer direction on the
SelectMAP interface. A low level selects write cycles, while a high
level selects read cycles. During FPGA configuration the driver drives
RDWR_B low before transferring the bitstream and restores it to its
reading (high state) afterwards.

Store the optional GPIO descriptors and toggle both signals around the
configuration data transfer, allowing multiple FPGAs to safely share a
single SelectMAP interface.

Tested on an AM625 based board with two Xilinx FPGAs connected to the
GPMC bus.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

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

 drivers/fpga/xilinx-selectmap.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
index d0cbb5fdfe3a..35078206a3a3 100644
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
 
+	gpiod_set_raw_value(conf->csi_b, 0);
+	gpiod_set_raw_value(conf->rdwr_b, 0);
+
 	return 0;
 }
 
 static int xilinx_selectmap_probe(struct platform_device *pdev)
 {
 	struct xilinx_selectmap_conf *conf;
-	struct gpio_desc *gpio;
 	void __iomem *base;
 
 	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
@@ -56,15 +72,17 @@ static int xilinx_selectmap_probe(struct platform_device *pdev)
 	conf->base = base;
 
 	/* CSI_B is active low */
-	gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpio))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
+	conf->csi_b = devm_gpiod_get_optional(&pdev->dev, "csi",
+					      GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->csi_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
 				     "Failed to get CSI_B gpio\n");
 
 	/* RDWR_B is active low */
-	gpio = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpio))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
+	conf->rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr",
+					       GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->rdwr_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
 				     "Failed to get RDWR_B gpio\n");
 
 	return xilinx_core_probe(&conf->core);
---
base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb

-- 
2.55.0

