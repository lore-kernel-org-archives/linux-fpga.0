Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979810;
	b=IEGcGYCi9XuLma2idiIlHhLk1MvS5oBriJ/GkqohfQAEa0MPBFZPd4YzilqZWRy2kd49
	 fI1hkaWAVLLGGLTR25BF9eCYciD1bUtP9AaGP/YRFmGwVv9pNA6aqDF4f2AjKPZDg5IRL
	 Dmlw2w9/9JwcSUKuqT/wajOuOGYeBX9UWClCUcbyaxPfoOfLvYMwKt1zCsSOX63x8TIam
	 cdqXni2vL20IXW2zd6s4fPQiCaYs4WELIzAjFLvyn8OWzIKWnzqW2Km03HfO/yqIk+zl7
	 3nVi249hhStvWWJE8IrTn1AVvCeEg4dYqv7oCtkbsCkIZ1WUV6qOWWBxZ0jBW4AAy9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979810;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Ft4rlE6xgUDwJFJWLMKbBhHCXnLHriXBruDjaCPK2Fo=;
	b=Rb1TjWhArYKcHbGHIB/awnNAjfrlfhWaTsrYxrq6/DVvLQRYv8jKEvG5zjw/WNUOCBa/
	 Su1shiIBDkAV2yQNTfZbez/EWR6JHISxWib6gBXG4ARiCDMrvtfqsQJYvdwo2ClewbhV6
	 AfJvWYhjrs8pCAhdMAg3isQ85Tptf5B7AttwYDVb66LRSLu6cSIAARRPO5T9Hq8UksviI
	 VbLXHSGufplxz1fLAVKCcsfjasUT5/t0UDBdzEJLCapYw0rtsfFcOCJNqMqsAo3t8mX6U
	 ClO6RzLwJT9+R1B/1JhDZ4bVfLEtHoZ8WOHg3Yz6uUQueRv9hHxS5IKmjnqDLNJ9ZOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LTP04wSg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45655606A326;
	Fri,  6 Nov 2026 15:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45655606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LTP04wSg
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4695E202AA3;
	Fri, 06 Nov 2026 16:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793979802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ft4rlE6xgUDwJFJWLMKbBhHCXnLHriXBruDjaCPK2Fo=;
	b=LTP04wSgXkGHMwU4eH5I0gvsxMb6EXJFKgy+abft+uvBck0oDQVs74GeoXLSVuUW3uNDhH
	I+yZzGElWxdI+GnlXhLk+B8bW7Hfki2H2ou3+TdnCOYfYQVb+AMLt6KZTT3PmwHxggsNc1
	LRWKTN5BE+TVJwT1g3eq3zO3t7Wrty/p+Ss3AhzOcvC0pzj+YbUWU5fw8fIM035N9wQZPQ
	f6+2vpqxuIzgwQyUb0U1Y44h43gSV7sZkmTIY5D/rVtihHR8GUw/2baMcviUrbXcbx3L6M
	XVnZypDE6Wkr1FzbicEo9dKfjb1aJiyuDgKuyeEu+qHajQcsWuc3MNVNFIzCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793979802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ft4rlE6xgUDwJFJWLMKbBhHCXnLHriXBruDjaCPK2Fo=;
	b=VenupWQEY8nOe84ixduo0VSMNEK6DrfczSYnifRljwVm1gXwNxBZnFO9yH3fYva9loVCTG
	N8MoCFAoUf6saTv4nDkd9aoLI1SYXXYFKMwVEPapEVNbgmf1NLeTAlSsD4Nh6pj8Lm8b3o
	XI99YBNooDPaymYJoKs8mZxSP4b6cpN28Lh8ZKxno2eLHE+/Ru1XIEIM82eyoRJjkFhvIO
	NggXiurhYzeNAfDEXvNBFvI+PWlu7lPziX3lhSbJ4rU5roIJby6c41L42jjxDI7oGtR41j
	6uP6B0FsU1mHrmd8PM+eKxgFMs7dqdGisIG7d1QEMLdecVh1t61hGMdwGoH9KA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793979802; a=rsa-sha256;
	cv=none;
	b=QI6EntLSkCs6Sxb1jZl2SzvT/7aIoTvlnurB9aIb62st+UXNxC7icuqhAzEJXwfw015arh
	Tbto7/3ZNqLn1j3tBJfZr4Xahy3EhXMTBWQex0XcMo0+1MIWdzSkazfOCcHg8wKmTfg1Pv
	xwXXxRBTZVEKIKITXymDWn3U2UGDll1wD83cHyTX5H1BpEtAff1nvP4EB4Cv99AfsktLRA
	+4vq3j7I1VptCxzuEAwD20NuobFGFzzg4e5WilgUZMsvCHGXkJ9TPrqFGXZYSQRuPOmJ6W
	+ypBa5FY3HqdZz4Ba2jxKdhqPr7F6EHfbizjWKYBaZEJ5Rt73I+Uk40wLvS0VQ==
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1xPM66-002vN5-0h;
	Fri, 06 Nov 2026 16:43:22 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 06 Nov 2026 16:43:19 +0100
Subject: [PATCH] fpga: altera-hps2fpga: do not request reset by index
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-reset-deindex-fpga-v1-1-5672928ba5f6@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJb17WoC/yXMQQqDMBBG4avIrDuQSSEUryJdqPljx0WUjC2Ce
 HfTdvkt3jvIUBRGbXNQwUdNl1wht4bGV58nsMZq8s4HERe4wLBxhOaIndM69Zy8uwd5BPGDUA3
 XgqT7b9o9/7b3MGPcvic6zwuktIzQdgAAAA==
X-Change-ID: 20261106-reset-deindex-fpga-f203618612b1
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
 Tom Rix <trix@redhat.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.15.2

There is no need to request a single reset by index.
Use of_reset_control_get_exclusive() to request the first and only
reset.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/fpga/altera-hps2fpga.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index f2f1250689cb..9b7f5b8191b8 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -134,8 +134,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 
 	priv = (struct altera_hps2fpga_data *)device_get_match_data(dev);
 
-	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
-								     0);
+	priv->bridge_reset = of_reset_control_get_exclusive(dev->of_node, NULL);
 	if (IS_ERR(priv->bridge_reset)) {
 		dev_err(dev, "Could not get %s reset control\n", priv->name);
 		return PTR_ERR(priv->bridge_reset);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261106-reset-deindex-fpga-f203618612b1

Best regards,
--  
Philipp Zabel <p.zabel@pengutronix.de>

