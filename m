Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87B2DF6F4;
	Thu, 16 Jul 2026 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185237; cv=none; b=d/zS4tNkSsNjwJxt33zc/+CvTGmaaKWLgc/pvanN4scvM57DiGXV4pURdQG6w4fer235iYOeexTABBJThT4F7skeQsKr3xSrrjlwDAXoqo9WkfH7mYrdlWPPraYkCpG2BdViYJFmZEfzFzuJky5BQAp22GVHDtkTGDU53uGbrsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185237; c=relaxed/simple;
	bh=qJXA2DX2OOpbDUD2mcw1gLUbNHh4fRpVhTGcJ6rigI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foE55K3zw5Y/sohyXZ81uthPS9AU/5aYepavLKvdKIiIivBBgFIFID/CSiMp9h3Pz3UzL02erc9YcPpce3qNlLV7/zBOD1a3CxJz47ZdWRzQaL4Yntk0j0N441N4JsK6JNCH1m5bU6Qa5CfuJNesW9KcQ6kybWrmwH0Krq4C+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Tdubegq3; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Tdubegq3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07BD1119C5F;
	Thu, 16 Jul 2026 09:00:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784185224; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=cOYOG/tMAZHpsl9rtrAkayAE0wym5RSRRAJN5onSY2w=;
	b=Tdubegq3tanEWXYpwbVKOYIneplybv/vKqf6RUiDSA6QfvLeWnzmZ2ErsskzG9EpmqO/M4
	jrHJZu4L2ztrJW8eeHR7OQv1r4RugSUoRctiNNVlmCx6FSHV4v1fX/S54F5slOgOo15CNQ
	OAtCJZzSbVbBGvFAIFqasqoZnreu1LR5YT+eEe2moWC5KjbZrUp0ikhqBQ0qftvcPLa3Z+
	M1VdNbjMEvVlk0q/FufJaqcKDSlYzDvtEFzoDFyB5bE5yaoGtfPopQQamsugKuCs1ub6jQ
	9uPrG0jRDnNHKa70CsGBW4ntMjFzw63gYkGQQIiHYNRQp39bW4swJWWgfo2vBg==
From: Heiko Schocher <hs@nabladev.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Heiko Schocher <hs@nabladev.com>,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v1] driver: fpga: xilinx-selectmap: add csi and rdwr support
Date: Thu, 16 Jul 2026 09:00:12 +0200
Message-ID: <20260716070020.4113618-1-hs@nabladev.com>
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

 drivers/fpga/xilinx-selectmap.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
index d0cbb5fdfe3a..b5fbdedf8aec 100644
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
@@ -30,9 +32,21 @@ static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
 	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
 	size_t i;
 
+	if (conf->csi_b)
+		gpiod_set_value(conf->csi_b, GPIOD_OUT_HIGH);
+
+	if (conf->rdwr_b)
+		gpiod_set_value(conf->rdwr_b, GPIOD_OUT_HIGH);
+
 	for (i = 0; i < count; ++i)
 		writeb(buf[i], conf->base);
 
+	if (conf->rdwr_b)
+		gpiod_set_value(conf->rdwr_b, GPIOD_OUT_LOW);
+
+	if (conf->csi_b)
+		gpiod_set_value(conf->csi_b, GPIOD_OUT_LOW);
+
 	return 0;
 }
 
@@ -56,16 +70,18 @@ static int xilinx_selectmap_probe(struct platform_device *pdev)
 	conf->base = base;
 
 	/* CSI_B is active low */
-	gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_LOW);
 	if (IS_ERR(gpio))
 		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
 				     "Failed to get CSI_B gpio\n");
+	conf->csi_b = gpio;
 
 	/* RDWR_B is active low */
-	gpio = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_LOW);
 	if (IS_ERR(gpio))
 		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
 				     "Failed to get RDWR_B gpio\n");
+	conf->rdwr_b = gpio;
 
 	return xilinx_core_probe(&conf->core);
 }
---
base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb

-- 
2.55.0

