Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292C36BCDA;
	Thu,  9 Apr 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737246; cv=none; b=Py6KQtwJs72nBRjx1qGnv8xjJxRCQCpehEibtOuA6M+HA4fBxhc9KHWyCFUiXZ41BND8mt45ZbQ0jQv4vdEMa5lWDfCIf8Irqz+7fKQyyIzk/tj/MXlB5JmEJHdrsgDY++BuqCGzfL7/A+Ts02I/LWk9VpGjDziY2JAJd65XcgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737246; c=relaxed/simple;
	bh=HynEgZR7bDO1N2a9k4FGXpEtnEBpNhCp31qLsnt4f5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqLZ4lWNVXbDwcMF6hYnVbcCudReTPPZ14MnzmGRxArV1lArJB/UPI6H2Jm5S62+fW/5LKilMAfLpXWotQKgMRcbiRcesVLihj5GG2RGlqHanvzS7zVUa4PT6GJEkkJyN04DQKeCvb/HPIHxSQWWa9eJJDTnfvGLL+V+h8YZBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=Yi4XoUeo; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="Yi4XoUeo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1775737237;
	bh=HynEgZR7bDO1N2a9k4FGXpEtnEBpNhCp31qLsnt4f5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yi4XoUeoqg3pDoVHgVm0JXQRpD9r1JY5xDDq2Q8by1I6twxfViN5vfyjxpVHpm+8I
	 geeZEQMk/vMjlQX2hGb24RSft6ByhWwVAYm3bB70t35IZYsHtevKPNCdKk0NiBLp9P
	 cNLpJcbtVi9XVYl+jomMUSaG7yRqdnOMm9v4+rYA=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 3D31DBE5E3;
	Thu,  9 Apr 2026 12:20:37 +0000 (UTC)
Received: from cheetah.homenet.philpem.me.uk (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id DB9E35FC51;
	Thu,  9 Apr 2026 13:20:36 +0100 (BST)
From: Phil Pemberton <philpem@philpem.me.uk>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Tom Rix <trix@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Phil Pemberton <philpem@philpem.me.uk>
Subject: [PATCH v3 2/2] fpga: ts73xx-fpga: add OF match table for device tree probing
Date: Thu,  9 Apr 2026 13:20:16 +0100
Message-ID: <20260409122016.3940462-3-philpem@philpem.me.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409122016.3940462-1-philpem@philpem.me.uk>
References: <20260409122016.3940462-1-philpem@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ts73xx-fpga driver currently only matches by platform device name,
which prevents it from being probed when the device is described in a
device tree. Add an of_device_id table so the driver can match against
the "technologic,ts7300-fpga" compatible string.

The TS-7350 and TS-7390 use different FPGAs with a different programming
interface, so while the driver is named "ts73xx-fpga", it doesn't apply
to them.

Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/fpga/ts73xx-fpga.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 4e1d2a4d3df4..3460e4809f86 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
 #include <linux/iopoll.h>
@@ -119,9 +120,17 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(mgr);
 }
 
+static const struct of_device_id ts73xx_fpga_of_match[] = {
+	{ .compatible = "technologic,ts7300-fpga" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ts73xx_fpga_of_match);
+
 static struct platform_driver ts73xx_fpga_driver = {
 	.driver	= {
 		.name	= "ts73xx-fpga-mgr",
+		.of_match_table = ts73xx_fpga_of_match,
 	},
 	.probe	= ts73xx_fpga_probe,
 };
-- 
2.43.0

