Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913B36AB4B;
	Tue,  7 Apr 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583938; cv=none; b=QdWE1JZZtZMnYGFaPy0zhKgQqTczoxlCYVdKQnKwsD9ecz1SDFJ2Ph0Po1JoXoGQ4hh7S4jkpfpjaYDBRHvHWeCT6iwuCVTxSPh9c5l/J+ZmYugWVDADYcPtH9xWXcPEbGjTmyvRwbEvkG8hY2VQHs43B9BIzGUm6e5npxO+4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583938; c=relaxed/simple;
	bh=w+vKCKfHMvhS1aVWwFTOux6G+nLbV2lIGJDPw1lRpi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRU5tdwVZ0QsiJhGHBC/WVwXR+exOUeNRFF7rANluShWMK3T5Ad5WeE7UrSIOiWRN2bpeJYhlxRTcQKOZg5vNHJGWqM1g9esnjhO4JsWF8b87RLuymPhSR9tm30aQ7zdZa1VEGKl9wZtPTaXmLDw7BR8OHQB9f6NHRzN7ChCVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=Ipf6dniA; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="Ipf6dniA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1775582853;
	bh=w+vKCKfHMvhS1aVWwFTOux6G+nLbV2lIGJDPw1lRpi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ipf6dniAJdm/nQjHwiM2UsiQo2dDlMkOdb7fZx46NxTBfsRx23kBaeKVm8Uh2xjGr
	 UxwzQUiUeBf3/coGM18DBxxX6vlp24ACp+/Zn+Vxr1xGZIoha+tfuYp4M2KjBW2MjV
	 V9XqldOG1Bu4fyUFE+PdjbRBgr1teXm3wabbLg3c=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id A8A5DBECE7;
	Tue,  7 Apr 2026 17:27:33 +0000 (UTC)
Received: from cheetah.homenet.philpem.me.uk (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 60ED05FC51;
	Tue,  7 Apr 2026 18:27:33 +0100 (BST)
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
Subject: [PATCH 2/2] fpga: ts73xx-fpga: add OF match table for device tree probing
Date: Tue,  7 Apr 2026 18:27:30 +0100
Message-ID: <20260407172730.1779804-3-philpem@philpem.me.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407172730.1779804-1-philpem@philpem.me.uk>
References: <20260407172730.1779804-1-philpem@philpem.me.uk>
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
the "technologic,ts73xx-fpga" compatible string.

Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
---
 drivers/fpga/ts73xx-fpga.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 4e1d2a4d3df4..5c8a2008d5a2 100644
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
+	{ .compatible = "technologic,ts73xx-fpga" },
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

