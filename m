Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B739903B;
	Mon, 20 Apr 2026 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680512; cv=none; b=pat4grlvnY4mtAGVbD/Wq8rhntHELOoknTnYCjQWlShUKhXgRVtYV9nLa9t74hhPO6M69vP3C1loxD00aMq5hPvG4Bawhi+HBoMh2PGEwOx/FQ14hMoII1hWrXz9qNOjmkGahZo8VpJRyjEhDYXvhEN/rDDUMFxHBOKkF1VxC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680512; c=relaxed/simple;
	bh=eMf62htc+Xx7OV9U+LrgSF4FP9paJCF1kH8N8DUxkPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ug+t6R+IB99tBdkCiRt6+/pFx19ghem/8+uQIuvXF8gxw6wqP2CW72MdiL7+HkNLzvAYR5cQC2ocmcE78QCbIAa+mkg/BzHOZG6D5ayd3c9N9Ck40qvbckvkyDNrLe+V2u4/AfJkDbmE2qTY1wJWIHBB/AKp8xYg+FMPeXjyNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lzMjKBAf; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lzMjKBAf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=LR3dKIzkREZRp01svB0t6h6suyV7sdDyD7oKmpIYFR8=; b=lzMjKBAfNclK678tRF6N3Jyo8E
	d0MSakp5btha2n2tM5rh4EY5VYfs+/G5ZeqcuX2q857cpV7AYQN9I/AvSGpVblAq/mw4l1WSmiK0+
	5RNbJkATsGKXAzy2aJdLFk6OKO2U+sf59mx3l7D8JO9iUCT3YH372LXRrCaj21tLhXYT53f9Fs87M
	Cmv+5u62jwdtyS8r3uOVQdPF1CIYEsJadzokySM18qzyS8MsYCv+1PFo6NvDBUM9vIdYfj7cParrr
	k0Q2AgVP61SRsXc63kTaZa877jvRy6Lw9GPsX6xw83sbGIFdI4lV4DgTKpvWMHBj5eFtSnxP71ytP
	ExiWW3kQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wEll6-000HlK-1E;
	Mon, 20 Apr 2026 12:21:40 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wEll6-000Agf-1s;
	Mon, 20 Apr 2026 12:21:40 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fpga: of-fpga-region: use dev_err_probe for probe deferral
Date: Mon, 20 Apr 2026 12:21:35 +0200
Message-ID: <20260420102136.333673-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27977/Mon Apr 20 08:26:26 2026)

This also adds a message about probe deferral.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/fpga/of-fpga-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index caa091224dc54..41e6da296cb3e 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -405,7 +405,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	/* Find the FPGA mgr specified by region or parent region. */
 	mgr = of_fpga_region_get_mgr(np);
 	if (IS_ERR(mgr))
-		return -EPROBE_DEFER;
+		return dev_err_probe(dev, -EPROBE_DEFER, "FPGA manager not found\n");
 
 	region = fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
 	if (IS_ERR(region)) {
-- 
2.43.0

