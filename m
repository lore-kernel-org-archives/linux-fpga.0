Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BE338598
	for <linux-fpga@vger.kernel.org>; Thu, 27 Nov 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259139; cv=none; b=C4JwDVtmcEGvJz2Ehk3mqBq0mjsciP4ml2YT4kyEbLbNvx6Hel+KPdrefXVJI5lWHmDmmvKDAB3Oi2drTRKk3QMJaQOhDZP6kdqE2JrfpOdj60vU9xYuYkOcnzWWIQ3TujNnDVcQETyS4Tuy7oN+YP4tfogC3ntODS5fxB6leAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259139; c=relaxed/simple;
	bh=OTsahi+laEV7d8DYR8KjywBeR3QzPhQyNE6ESIy9KZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U4O8u/6KXKQLy6eFBWa0O1P2thW/GwzOXkfY4wTuc+4ANFfNng7YmRh3aBMe8f7NwBAhnOB0NbvsEyJFzdGg2ZtUASNeuYeisRw30CxFdkI2XoRabLZBwxlF6t15uHKXVjtVRGwZWaWHGMzaayInGzPoEqDHS7piIC/45PspF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BS8FldK6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BS8FldK6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CA6C41A1DCA
	for <linux-fpga@vger.kernel.org>; Thu, 27 Nov 2025 15:58:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A003060722;
	Thu, 27 Nov 2025 15:58:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8489102F2ABC;
	Thu, 27 Nov 2025 16:58:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764259134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=eufNWz7IvSjdBi+UEIltwBbYJ3dz5TGUDVoHWNsh1yA=;
	b=BS8FldK6/4NVoM9rFvFQs/4IOhkeQmHxnNSNEAdcoNocZeaqdy8JRO6By3bJHiRVlCvUUm
	nRL+mpTYUlG1uH2WE6RctxETmi4E/4RIF122VXhS9+hMyH0PUdvyGfa76Or48GjqDqPwlp
	/QkqXZHQUa3bXqHp6smjLX3shtzBLDzG/xfbFysb72rM6t0nUOwNIHg3AIwD7xFRuOsBJB
	DZ6LzHJiy5Tu7X64T6ijseLLkbMMNTFeT1o8x/ER3tTnB+qFG74tMT4cTBH9Virwh8SJQI
	nDtX9yiP5qHGEn+uRHR2T/CNE9T9v+7DpuEvMkZZCcZSLXBMW37oHFR6fKpXUg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 27 Nov 2025 16:58:48 +0100
Subject: [PATCH] fpga: of-fpga-region: Fail if any bridge is missing
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-of-fpga-region-fail-if-bridges-not-found-v1-1-ca674f8d07eb@bootlin.com>
X-B4-Tracking: v=1; b=H4sIADh1KGkC/x2NwQrCMBAFf6Xs2QdNak31V8RDNLtxQZKSVCmU/
 nuDx4FhZqPKRbnSrduo8E+r5tTAnDp6vX2KDA2NyfZ2NMY6ZIHM0aNwbCrE6wcqeBYNkStSXiD
 5mwLclcfL5M5DP0zUcnNh0fW/uj/2/QC8sdJuegAAAA==
X-Change-ID: 20251127-of-fpga-region-fail-if-bridges-not-found-79e568743038
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
 Tom Rix <trix@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

When parsing the region bridge list from the "fpga-bridges" device tree
property, the of-fpga-region driver will silently ignore bridges which fail
to be obtained, for example due to a missing bridge driver or invalid
phandle.

This can lead to hardware issues if a region bridge stays coupled when
partial programming is performed.

Fail if any of the bridges specified in "fpga-bridges" cannot be obtained.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/fpga/of-fpga-region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 43db4bb77138..caa091224dc5 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -83,7 +83,7 @@ static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
  * done with the bridges.
  *
  * Return: 0 for success (even if there are no bridges specified)
- * or -EBUSY if any of the bridges are in use.
+ * or an error code if any of the bridges are not available.
  */
 static int of_fpga_region_get_bridges(struct fpga_region *region)
 {
@@ -130,10 +130,10 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
 						 &region->bridge_list);
 		of_node_put(br);
 
-		/* If any of the bridges are in use, give up */
-		if (ret == -EBUSY) {
+		/* If any of the bridges are not available, give up */
+		if (ret) {
 			fpga_bridges_put(&region->bridge_list);
-			return -EBUSY;
+			return ret;
 		}
 	}
 

---
base-commit: c9243d6df0d617535e842aa4c3d1d7dfdb91d07b
change-id: 20251127-of-fpga-region-fail-if-bridges-not-found-79e568743038

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>

