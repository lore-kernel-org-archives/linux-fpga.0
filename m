Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577B3905FD;
	Sun,  6 Sep 2026 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788665976; cv=none; b=dkdUlBkpj/20e+7T2lPfgtYRD9mSyicw9COX/Pf/txOYjNi6fkyIUaz1z8z8nWfIiyX5uMaHdG1lZY3+/Vqhsr7O3V5fXvCNLmRBY5i+0tIEz4m23EIeQugYOPhJUnODMCxwF4jq2eno+7ScClJTFH6nR6QONIWcVvyUWYoKqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788665976; c=relaxed/simple;
	bh=tIIE/P6kRnMeC1KllYwjT54FxrzUOGkTQR9qnIoNW9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2W4khJ4vgf9ZTjhBFMJ26UsKJwMsazKRejYM50XxlSq8RPdZkOIttp9Te5E2Xqcuk8siE59ktV0i3+cOrQQj4q2f/JUQhq+gqlLPQE0F6s4KkPPmYYAs1N/XVtpHBflz+0kcFHBGW8CRkeoFveZ9M4yleeUgi60lcaGOOrbopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m06eIyMh; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m06eIyMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=H8
	qa5EWidotdpbNWGI1etUmCpVocKitmEGx3yejZzng=; b=m06eIyMhjsDhxaxOEX
	6+y7OntgpR5WzSyqvhd2zA6U/aBQ7yD398sEntOtsXxeP7gkZ4LWhHmBzElMBXOO
	QSu2NPEl/NWtdi8xwFgv4v1Xwvh6EJornkzGfj0s+sjBH2NdACfs7j34WIQQQcQH
	vNBH1pV/nseCG6afQlN5LH42w=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3L+pW4JxqJlXIAw--.37702S2;
	Sun, 06 Sep 2026 11:39:03 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Tom Rix <trix@redhat.com>,
	Alan Tull <atull@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: socfpga-a10: Propagate DCLK completion timeouts
Date: Sun,  6 Sep 2026 11:39:00 +0800
Message-ID: <20260906033900.84849-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3L+pW4JxqJlXIAw--.37702S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW5ury3KryDJr48Kr13CFg_yoWrGFyxpF
	yagas5Kr1DJF1FyF1IyF15Xr1Yyan3tayjqFW8K3yxZrnFvFWUCF9rKFZrtrZ8G3WDZFW5
	WF1FyFWxG398tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UO_-QUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxRcP12qc4FdB7AAA3m

socfpga_a10_fpga_generate_dclks() waits for the generated DCLK count to
complete but discards the poll result. Configuration can therefore continue
after the hardware did not acknowledge a required DCLK sequence.

Return the poll result and stop write initialization on failure. During
write completion, retain the existing cleanup sequence and return the
earlier PR error in preference to a later DCLK error.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: acbb910ae04b ("fpga-manager: Add Socfpga Arria10 support")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
 drivers/fpga/socfpga-a10.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index 0165a3c86932..f707c2bdc189 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -124,10 +124,11 @@ static void socfpga_a10_fpga_set_cfg_width(struct a10_fpga_priv *priv,
 			   A10_FPGAMGR_IMGCFG_CTL_02_CFGWIDTH, width);
 }
 
-static void socfpga_a10_fpga_generate_dclks(struct a10_fpga_priv *priv,
-					    u32 count)
+static int socfpga_a10_fpga_generate_dclks(struct a10_fpga_priv *priv,
+					   u32 count)
 {
 	u32 val;
+	int ret;
 
 	/* Clear any existing DONE status. */
 	regmap_write(priv->regmap, A10_FPGAMGR_DCLKSTAT_OFST,
@@ -137,12 +138,15 @@ static void socfpga_a10_fpga_generate_dclks(struct a10_fpga_priv *priv,
 	regmap_write(priv->regmap, A10_FPGAMGR_DCLKCNT_OFST, count);
 
 	/* wait till the dclkcnt done */
-	regmap_read_poll_timeout(priv->regmap, A10_FPGAMGR_DCLKSTAT_OFST, val,
-				 val, 1, 100);
+	ret = regmap_read_poll_timeout(priv->regmap,
+				       A10_FPGAMGR_DCLKSTAT_OFST, val,
+				       val, 1, 100);
 
 	/* Clear DONE status. */
 	regmap_write(priv->regmap, A10_FPGAMGR_DCLKSTAT_OFST,
 		     A10_FPGAMGR_DCLKSTAT_DCLKDONE);
+
+	return ret;
 }
 
 #define RBF_ENCRYPTION_MODE_OFFSET		69
@@ -334,7 +338,9 @@ static int socfpga_a10_fpga_write_init(struct fpga_manager *mgr,
 			   A10_FPGAMGR_IMGCFG_CTL_01_S2F_NENABLE_CONFIG, 0);
 
 	/* Send some clocks to clear out any errors */
-	socfpga_a10_fpga_generate_dclks(priv, 256);
+	ret = socfpga_a10_fpga_generate_dclks(priv, 256);
+	if (ret)
+		return ret;
 
 	/* Assert pr_request */
 	regmap_update_bits(priv->regmap, A10_FPGAMGR_IMGCFG_CTL_01_OFST,
@@ -342,7 +348,9 @@ static int socfpga_a10_fpga_write_init(struct fpga_manager *mgr,
 			   A10_FPGAMGR_IMGCFG_CTL_01_S2F_PR_REQUEST);
 
 	/* Provide 2048 DCLKs before starting the config data streaming. */
-	socfpga_a10_fpga_generate_dclks(priv, 0x7ff);
+	ret = socfpga_a10_fpga_generate_dclks(priv, 0x7ff);
+	if (ret)
+		return ret;
 
 	/* Wait for pr_ready */
 	return socfpga_a10_fpga_wait_for_pr_ready(priv);
@@ -393,7 +401,7 @@ static int socfpga_a10_fpga_write_complete(struct fpga_manager *mgr,
 {
 	struct a10_fpga_priv *priv = mgr->priv;
 	u32 reg;
-	int ret;
+	int dclk_ret, ret;
 
 	/* Wait for pr_done */
 	ret = socfpga_a10_fpga_wait_for_pr_done(priv);
@@ -403,7 +411,7 @@ static int socfpga_a10_fpga_write_complete(struct fpga_manager *mgr,
 			   A10_FPGAMGR_IMGCFG_CTL_01_S2F_PR_REQUEST, 0);
 
 	/* Send some clocks to clear out any errors */
-	socfpga_a10_fpga_generate_dclks(priv, 256);
+	dclk_ret = socfpga_a10_fpga_generate_dclks(priv, 256);
 
 	/* Disable s2f dclk and data */
 	regmap_update_bits(priv->regmap, A10_FPGAMGR_IMGCFG_CTL_02_OFST,
@@ -422,6 +430,8 @@ static int socfpga_a10_fpga_write_complete(struct fpga_manager *mgr,
 	/* Return any errors regarding pr_done or pr_error */
 	if (ret)
 		return ret;
+	if (dclk_ret)
+		return dclk_ret;
 
 	/* Final check */
 	reg = socfpga_a10_fpga_read_stat(priv);
-- 
2.50.1 (Apple Git-155)

