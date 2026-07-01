Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D13EF0DC
	for <linux-fpga@vger.kernel.org>; Wed,  1 Jul 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898033; cv=none; b=qWfG6S5TdDJdIJDBLSt4HrVK6qE58/KGwGfTq32FlUPuCfkVts6S50Z2qR6GlYUt7cl/ai1l8oaO3mSf7/fEBxcCjNl7fHfv/SOqgb2ndgxytxMefE670qFriXjnvXUllVb8yTKsJZYhd4OnCaTXx5RAwoKmcchjWUTu9vMNG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898033; c=relaxed/simple;
	bh=h6sT8/IH9/xnjxCsApEBfzjA6yyQVafQ4VI+kiL2Sc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqWpHrpHwy3FnDFbgf2mJl1HEc3awAjU6b5S7Ny+uP0ZzIfJDCt/HczllXvZkFAJIOoDTqYIC8OA7teo6AoHA61JJGMUlDkxQI0eZYYc1cz+y6VWMg6pcnJJaOKjGn4/zNvrtBbGcJjIfkCRrvfIrLLI3wc1mMszg5G7GDmh13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv95ZQVR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv95ZQVR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c7c61b5292so4348265ad.0
        for <linux-fpga@vger.kernel.org>; Wed, 01 Jul 2026 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782898030; x=1783502830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzLBf2n9YXcGPuEnGzwo7oC81VhfipRTtknuMwqNDro=;
        b=jv95ZQVRTlqUH8+MDBYNhgNi2PO14f71IFh2Lt7DGN3SR8fImtt+1aVcZHH7wmeccV
         SZSg08ecdPuSffRtooSU9PKeNox6W6MuiuP+YIOae8eBqQsiS9Oy2meRARP0/Bqiu0CA
         cZb5evM26sZ1vVKa3i+2WGhKJGYcVYDStSdbWQigIpSxlvdmAeVweJFGEQMo52MWoTrS
         oidNWTJK1HmldIXF9VLWgKx5lbg+fUF3urtqHU8cpxfTzVHJjhyzSgx/qsLrArGrouwf
         0lflnG9q1ksCxf8Cix+IaP6i6/YvUXstRhf2PsDqD7M1Z/uCRr5/AnSGygvJV1nb3Pd+
         PwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898030; x=1783502830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzLBf2n9YXcGPuEnGzwo7oC81VhfipRTtknuMwqNDro=;
        b=mJ9fTPX7goazhDI7wZocu1Pw8OomMAjximzYSD/LqXC8Tg7MYXnci1vXGpexNbZnxO
         7diz7fkoLPZugV2YZyQCLQw7ecD98JQuEWproYJtnJzGbN6Q75mhUu85V995/X4kQFgO
         l4SpyedTX4AqM1sUCKInoq/5Vgpn4zHiJCV00C4xbueugdwyK9GlpWiWOtNMGNZhF2s8
         8yef2dtxgHFG0U7VS3II5m2XKGMYe21AdRV69AvbF/If4OqrsuCbQuHDzsCFpI9XgHFL
         onfaN0agEzDTxxoY7mQHhWyPkwKQRpr1sn+glOOOZvmCwK/OIgE8GQDece4mxtbfpVj0
         HYlQ==
X-Gm-Message-State: AOJu0YxhJ0K4arWVMaF0Nyq+tQkm3cMwBNL4yqn0zaqQC87/47kPxEoR
	D1FapUD7B6zCWZJ6YZh+/2IBl371pSbjmsG6N6Rv2OWAzNRyvsjb6J/6
X-Gm-Gg: AfdE7cn+o0gXEm+1jqDJcJ+qyJALThfhRiBo4Ug/fCvHIZzdljtyW5AdomJsL211EA5
	7cQqvA3VvKvaHu7AQMoniJNBKfQb2JXnZtYEc50H1g4vN+SMY4Jtkh8JBG5dVEmQkbqXkv/c41j
	NU1Z5m8rctlf620XWFiNh2xpz6t2NXt+w+pATPwlqkARx5Fz6rqKB865BN8aP5fWkPG0GEdeO+c
	jj0JJ3BMx8UySzKZWJvthZjw1GPSjr3D0m+q2BTXaB+R5ADsDFW7ypJaAc4sLVrzSr2agAmL8jh
	dCKjHNwxzWOg8oa4A+r7ezriLS4LYuuXoyDI/atXVQw+0VUCnx02S06RL6K+azLsx1HpLn0UyOw
	lFF/H1ZQZQAQsFSkiB1qTnqsrYFXpEjW2QL5zynMV1CQQueHq0KIf61Onelu6IwGuVLNEmbh7nZ
	DYwDVCaNxmT6OHlTLlJ2uvA7Fc4twf/mif+TSxUcxx
X-Received: by 2002:a17:903:13c7:b0:2ca:4f33:e86f with SMTP id d9443c01a7336-2ca7e6bd91dmr10268585ad.12.1782898030345;
        Wed, 01 Jul 2026 02:27:10 -0700 (PDT)
Received: from trigkey (FL1-133-202-37-214.tky.mesh.ad.jp. [133.202.37.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca6853f616sm11138795ad.37.2026.07.01.02.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:27:09 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: yilun.xu@intel.com,
	mdf@kernel.org,
	trix@redhat.com
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daisuke Matsuda <dskmtsd@gmail.com>,
	Daisuke Matsuda <matsuda@preferred.jp>
Subject: [PATCH 2/2] fpga: altera-cvp: Propagate PCI config access errors
Date: Wed,  1 Jul 2026 09:26:33 +0000
Message-ID: <20260701092633.5146-2-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701092633.5146-1-dskmtsd@gmail.com>
References: <20260701092633.5146-1-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daisuke Matsuda <matsuda@preferred.jp>

The CvP control path accesses the VSEC registers through PCI config space,
but several reads and writes ignore the return value. If a config read
fails, the driver can make decisions from an undefined register value and
continue programming with bogus status or control bits.

Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
Signed-off-by: Daisuke Matsuda <matsuda@preferred.jp>
---
 drivers/fpga/altera-cvp.c | 137 +++++++++++++++++++++++++++++---------
 1 file changed, 105 insertions(+), 32 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index c00292370a8e..8a896a93eba8 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -82,7 +82,7 @@ struct altera_cvp_conf {
 };
 
 struct cvp_priv {
-	void	(*switch_clk)(struct altera_cvp_conf *conf);
+	int	(*switch_clk)(struct altera_cvp_conf *conf);
 	int	(*clear_state)(struct altera_cvp_conf *conf);
 	int	(*wait_credit)(struct fpga_manager *mgr, u32 blocks);
 	size_t	block_size;
@@ -116,7 +116,8 @@ static enum fpga_mgr_states altera_cvp_state(struct fpga_manager *mgr)
 	struct altera_cvp_conf *conf = mgr->priv;
 	u32 status;
 
-	altera_read_config_dword(conf, VSE_CVP_STATUS, &status);
+	if (altera_read_config_dword(conf, VSE_CVP_STATUS, &status))
+		return FPGA_MGR_STATE_UNKNOWN;
 
 	if (status & VSE_CVP_STATUS_CFG_DONE)
 		return FPGA_MGR_STATE_OPERATING;
@@ -139,19 +140,27 @@ static void altera_cvp_write_data_config(struct altera_cvp_conf *conf, u32 val)
 }
 
 /* switches between CvP clock and internal clock */
-static void altera_cvp_dummy_write(struct altera_cvp_conf *conf)
+static int altera_cvp_dummy_write(struct altera_cvp_conf *conf)
 {
 	unsigned int i;
+	int ret;
 	u32 val;
 
 	/* set 1 CVP clock cycle for every CVP Data Register Write */
-	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	ret = altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	if (ret)
+		return ret;
+
 	val &= ~VSE_CVP_MODE_CTRL_NUMCLKS_MASK;
 	val |= 1 << VSE_CVP_MODE_CTRL_NUMCLKS_OFF;
-	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+	ret = altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < CVP_DUMMY_WR; i++)
 		conf->write_data(conf, 0); /* dummy data, could be any value */
+
+	return 0;
 }
 
 static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
@@ -159,13 +168,17 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
 {
 	unsigned int retries;
 	u32 val;
+	int ret;
 
 	retries = timeout_us / 10;
 	if (timeout_us % 10)
 		retries++;
 
 	do {
-		altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
+		ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
+		if (ret)
+			return ret;
+
 		if ((val & status_mask) == status_val)
 			return 0;
 
@@ -287,21 +300,31 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
 	u32 val;
 
 	/* STEP 12 - reset START_XFER bit */
-	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
+	ret = altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
+	if (ret)
+		return ret;
+
 	val &= ~VSE_CVP_PROG_CTRL_START_XFER;
-	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
+	ret = altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
+	if (ret)
+		return ret;
 
 	/* STEP 13 - reset CVP_CONFIG bit */
 	val &= ~VSE_CVP_PROG_CTRL_CONFIG;
-	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
+	ret = altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
+	if (ret)
+		return ret;
 
 	/*
 	 * STEP 14
 	 * - set CVP_NUMCLKS to 1 and then issue CVP_DUMMY_WR dummy
 	 *   writes to the HIP
 	 */
-	if (conf->priv->switch_clk)
-		conf->priv->switch_clk(conf);
+	if (conf->priv->switch_clk) {
+		ret = conf->priv->switch_clk(conf);
+		if (ret)
+			return ret;
+	}
 
 	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
 	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
@@ -336,7 +359,10 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 		conf->numclks = 1; /* for uncompressed and unencrypted images */
 
 	/* STEP 1 - read CVP status and check CVP_EN flag */
-	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
+	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
+	if (ret)
+		return ret;
+
 	if (!(val & VSE_CVP_STATUS_CVP_EN)) {
 		dev_err(&mgr->dev, "CVP mode off: 0x%04x\n", val);
 		return -ENODEV;
@@ -354,21 +380,34 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	 * - set HIP_CLK_SEL and CVP_MODE (must be set in the order mentioned)
 	 */
 	/* switch from fabric to PMA clock */
-	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	ret = altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	if (ret)
+		return ret;
+
 	val |= VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
-	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+	ret = altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+	if (ret)
+		return ret;
 
 	/* set CVP mode */
-	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	ret = altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	if (ret)
+		return ret;
+
 	val |= VSE_CVP_MODE_CTRL_CVP_MODE;
-	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+	ret = altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+	if (ret)
+		return ret;
 
 	/*
 	 * STEP 3
 	 * - set CVP_NUMCLKS to 1 and issue CVP_DUMMY_WR dummy writes to the HIP
 	 */
-	if (conf->priv->switch_clk)
-		conf->priv->switch_clk(conf);
+	if (conf->priv->switch_clk) {
+		ret = conf->priv->switch_clk(conf);
+		if (ret)
+			return ret;
+	}
 
 	if (conf->priv->clear_state) {
 		ret = conf->priv->clear_state(conf);
@@ -381,10 +420,15 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	conf->sent_packets = 0;
 
 	/* STEP 4 - set CVP_CONFIG bit */
-	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
+	ret = altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
+	if (ret)
+		return ret;
+
 	/* request control block to begin transfer using CVP */
 	val |= VSE_CVP_PROG_CTRL_CONFIG;
-	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
+	ret = altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
+	if (ret)
+		return ret;
 
 	/* STEP 5 - poll CVP_CONFIG READY for 1 with timeout */
 	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY,
@@ -399,8 +443,11 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	 * STEP 6
 	 * - set CVP_NUMCLKS to 1 and issue CVP_DUMMY_WR dummy writes to the HIP
 	 */
-	if (conf->priv->switch_clk)
-		conf->priv->switch_clk(conf);
+	if (conf->priv->switch_clk) {
+		ret = conf->priv->switch_clk(conf);
+		if (ret)
+			return ret;
+	}
 
 	if (altera_cvp_chkcfg) {
 		ret = altera_cvp_chk_error(mgr, 0);
@@ -411,16 +458,26 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	}
 
 	/* STEP 7 - set START_XFER */
-	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
+	ret = altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
+	if (ret)
+		return ret;
+
 	val |= VSE_CVP_PROG_CTRL_START_XFER;
-	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
+	ret = altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
+	if (ret)
+		return ret;
 
 	/* STEP 8 - start transfer (set CVP_NUMCLKS for bitstream) */
 	if (conf->priv->switch_clk) {
-		altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+		ret = altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+		if (ret)
+			return ret;
+
 		val &= ~VSE_CVP_MODE_CTRL_NUMCLKS_MASK;
 		val |= conf->numclks << VSE_CVP_MODE_CTRL_NUMCLKS_OFF;
-		altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+		ret = altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
@@ -490,17 +547,25 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 		return ret;
 
 	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
-	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
+	ret = altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
+	if (ret)
+		return ret;
+
 	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
 		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
 		return -EPROTO;
 	}
 
 	/* STEP 17 - reset CVP_MODE and HIP_CLK_SEL bit */
-	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	ret = altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	if (ret)
+		return ret;
+
 	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
 	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
-	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+	ret = altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+	if (ret)
+		return ret;
 
 	/* STEP 18 - poll PLD_CLK_IN_USE and USER_MODE bits */
 	mask = VSE_CVP_STATUS_PLD_CLK_IN_USE | VSE_CVP_STATUS_USERMODE;
@@ -590,7 +655,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 		return -ENODEV;
 	}
 
-	pci_read_config_dword(pdev, offset + VSE_CVP_STATUS, &regval);
+	ret = pci_read_config_dword(pdev, offset + VSE_CVP_STATUS, &regval);
+	if (ret)
+		return ret;
+
 	if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
 		dev_err(&pdev->dev,
 			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
@@ -613,10 +681,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	 * even if the concerned BAR is not needed for FPGA configuration
 	 * at all. Thus, enable the device via PCI config space command.
 	 */
-	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	ret = pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (ret)
+		return ret;
+
 	if (!(cmd & PCI_COMMAND_MEMORY)) {
 		cmd |= PCI_COMMAND_MEMORY;
-		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+		ret = pci_write_config_word(pdev, PCI_COMMAND, cmd);
+		if (ret)
+			return ret;
 	}
 
 	ret = pci_request_region(pdev, CVP_BAR, "CVP");
-- 
2.47.3

