Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670167;
	b=WlvB0VBfEL+ILCf21zw1bjIYcvOkQUzwVfPEzAmBLyeATMIwCFSZaSLleVSRORr4obja
	 WieyL78EhyGXyhBWBpVWXWXfmSY99to9WjZ/CVJO3aIvIMaU2DzenFNpPl2C5Bi0a1kLQ
	 eF4JcaoPqfRpidCApMOMxInv4LPRTJAP1EfZaBvSLho1CPWxNWPDMeSC5+efTyTUmH39c
	 mtbHmdpHPo/WqpsUFeb/kxqXYfLKEFBs9Z8YbwURGWNJ2YqoMWgziBO9ZmHrWSemlj9If
	 kVDtb7sFuPXXY2NbfWQoQ9XRrSKJpWnNfknoJPZNOkNWKzzqZR5CzxldczpTg6aVijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670167;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xlaK4MZbpQ6o9Yco876nSvoPM63Qif5CtOMBCdr/j/I=;
	b=e2C8LwJhCG6luLh6G1EMhYrI2OkXOe6TexaaqbgHuA6sk+C1qKL0HHdzcR4m+lDg2pDe
	 LM2lBYYlJROMqLMEl3mvSGwskPvHpp1CFT19nPc2a2+1rndolD9J9xWHojPPBZKAAeGRs
	 AgpXE2Gw+Eb6t/E+7gBPWJZWNDRe3a77oNoItQIThwmIcDN3+GTWfGnHGpWa1uc02qFLj
	 lt218mgHmSaKYi88nwwcP9t4a2pmVYcEuPKy6iSrOqqm9hvCum25dXKenlDVv8aCqzoqI
	 xpd9qahV+xrDnsLFfpy/PKvgh3AnHaDFRMYYFCTkGQU+TS4ACNEPbfc/ASSwb9EDERQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QIfnE9RM;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98A606A32F;
	Tue,  3 Nov 2026 01:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D98A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QIfnE9RM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QIfnE9RMcrt+g77V+EuUktR1PMPEcOdQq+dFgpPIA+zjKTFa4RmivsO0o9+myl73nNn7gqE2+VM2t
	 Ddt6Kmx1l0k15KwgcZj40of6hh5WGpGDVLL8FEpaHfk9VcPRTWmLLKK6ObR7Kmtw6jOGI4sKEl37S8
	 pDIxy7EpoCm/8P1Y=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ae93c10177-8e4e5;
	Tue, 03 Nov 2026 09:42:42 +0800 (CST)
X-RM-TRANSID:2ee76ae93c10177-8e4e5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36ae93c10c41-e17fe;
	Tue, 03 Nov 2026 09:42:42 +0800 (CST)
X-RM-TRANSID:2ee36ae93c10c41-e17fe
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] fpga: altera-hps2fpga: Fix reset control leak
Date: Tue,  3 Nov 2026 09:42:40 +0800
Message-ID: <20261103014240.1194-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alt_fpga_bridge_probe() acquires the bridge reset control with
of_reset_control_get_exclusive_by_index(), which is not
device-managed.  None of the probe error paths (l3regs lookup
failure, missing clock, clock enable failure, bridge registration
failure) release it, and alt_fpga_bridge_remove() does not call
reset_control_put() either, so the reset control reference leaks both
on a failed probe and on every bind/unbind cycle.

Use devm_reset_control_get_exclusive_by_index() so the reset control
is released automatically when the driver is unbound or the probe
fails.

Fixes: e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support")
Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
 drivers/fpga/altera-hps2fpga.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index f2f125068..6d9798bb9 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -134,8 +134,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 
 	priv = (struct altera_hps2fpga_data *)device_get_match_data(dev);
 
-	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
-								     0);
+	priv->bridge_reset = devm_reset_control_get_exclusive_by_index(dev, 0);
 	if (IS_ERR(priv->bridge_reset)) {
 		dev_err(dev, "Could not get %s reset control\n", priv->name);
 		return PTR_ERR(priv->bridge_reset);


