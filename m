Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21298C11F6D
	for <linux-fpga@archiver.kernel.org>; Tue, 29 Jun 2021 12:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F325361D70
	for <linux-fpga@archiver.kernel.org>; Tue, 29 Jun 2021 12:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhF2MO6 (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:14:58 -0400
Received: from first.geanix.com ([116.203.34.67]:56706 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233340AbhF2MO5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 08:14:57 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 25B3B4C46C5;
        Tue, 29 Jun 2021 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1624968748; bh=dlHlr9p/LQJuyOibEgRm43ZjzPeacyEo6smnvyXPzJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XKT5nAEFSOz9hKq5A0MUV67us2b11IOnilRYr8Uxf4b1TuDDJLqq115V2Sq/mfNtl
         d5XmnnHYHHJ5GPEbEIKN8mkoXdRsD36fcq3Q4UfhG4j6uBeNQF5WNV3ZJx22Qj6aja
         i14TEYkCLulNJ1+DYLo3yc6HsSgzJ33KkkentpHlua2hWN6QOoBWxvSCQMzlGhPtsB
         /vg0NWwxY0j+6yPnPx3vK0Hnzpcj7FIKTuMIQPIahGneFeZxfwQOlTWqj7uNPIM1Q3
         +xmzBSQGD2UWzC1/PsHZJP0hiALhrm/QDe2nDpEH9vhD+ZQtFcvn9spI+jx3GeAxFV
         U5/RRvXRJ4KvA==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 2/4] spi: spi-altera-dfl: support n5010 feature revision
Date:   Tue, 29 Jun 2021 14:12:12 +0200
Message-Id: <20210629121214.988036-3-martin@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210629121214.988036-1-martin@geanix.com>
References: <20210629121214.988036-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Martin Hundebøll <mhu@silicom.dk>

The Max10 BMC on the Silicom n5010 PAC is slightly different than the
existing BMC's, so use a dedicated feature revision detect it.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---

Changes since v2:
 * None

Changes since v1:
 * use feature revision from struct dfl_device instead of reading it
   from io-mem

 drivers/spi/spi-altera-dfl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 3e32e4fe5895..f6cf7c8d9dac 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
 	.chip_select = 0,
 };
 
+static struct spi_board_info m10_n5010_bmc_info = {
+	.modalias = "m10-n5010",
+	.max_speed_hz = 12500000,
+	.bus_num = 0,
+	.chip_select = 0,
+};
+
 static void config_spi_master(void __iomem *base, struct spi_master *master)
 {
 	u64 v;
@@ -130,6 +137,7 @@ static void config_spi_master(void __iomem *base, struct spi_master *master)
 
 static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 {
+	struct spi_board_info *board_info = &m10_bmc_info;
 	struct device *dev = &dfl_dev->dev;
 	struct spi_master *master;
 	struct altera_spi *hw;
@@ -172,9 +180,12 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 		goto exit;
 	}
 
-	if (!spi_new_device(master,  &m10_bmc_info)) {
+	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
+		board_info = &m10_n5010_bmc_info;
+
+	if (!spi_new_device(master, board_info)) {
 		dev_err(dev, "%s failed to create SPI device: %s\n",
-			__func__, m10_bmc_info.modalias);
+			__func__, board_info->modalias);
 	}
 
 	return 0;
-- 
2.31.0

