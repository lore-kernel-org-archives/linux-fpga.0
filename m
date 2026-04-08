Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7A3B19CC;
	Wed,  8 Apr 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667175; cv=none; b=PoEDs1egxrMDEk2ChVbRlLPNsygQ5ZbIQy5l9m/ZcTjGwsG/d7KfWs4eMiqxIownRsMnkYBweUDZeSfI+Ca0qoaCqa1T9WbnK7egtfzs0V1IQSt2hYxcnGo9ciq/ig8Nr2B740Xp6O0Niw+67lDxL/z63qd6gD22ayiujJ8GCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667175; c=relaxed/simple;
	bh=0Maaoz+2keI1/bqfwflxirvmnxTu0/X4KLdFAANGdXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oliY7UnJ6PS2iRglYEmeT3gSBAKqMI4pir8YBYamGDBMvkOlNgQSgthzwm0Neabcpg7XJ1/3FfGLpXsVOIkBS+FcKALi5d+WO7hEbyyB8X1MA6ntBS6Fo4dE2FD6IHQNqXtUgaXfrCHe27Ee2s7rcgXADlvQ/+nVDySq4ki0yzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=lYCecKeu; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="lYCecKeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1775667172;
	bh=0Maaoz+2keI1/bqfwflxirvmnxTu0/X4KLdFAANGdXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYCecKeu9LotoJY2fSgZg1ePa5kSvMEGJ+qVTXmtvOStnyWz7NK4pZK23W/cAeoNi
	 cMtnBwf8Qy8AXzC9/CQ7WVbCuefum2BtXoA+6FFBpqOsRC+l8y1vTF3KfDtZ+eIy4f
	 RKrTrXcmAEK7PC5yJbUv4LHjDjy5Zbh6ts8r2uDc=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 98E8ABECE7;
	Wed,  8 Apr 2026 16:52:52 +0000 (UTC)
Received: from cheetah.homenet.philpem.me.uk (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 649495FC38;
	Wed,  8 Apr 2026 17:52:52 +0100 (BST)
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
Subject: [PATCH v2 2/2] fpga: ts73xx-fpga: add OF match table for device tree probing
Date: Wed,  8 Apr 2026 17:52:23 +0100
Message-ID: <20260408165223.3051759-3-philpem@philpem.me.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408165223.3051759-1-philpem@philpem.me.uk>
References: <20260408165223.3051759-1-philpem@philpem.me.uk>
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

