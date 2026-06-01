Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CE357A3E;
	Mon,  1 Jun 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346750; cv=none; b=kCQCicpkSn5dH1nQZ5KvwwZah6oC8zHomHHnVVFTPEE2xAPWMQ+cI5UJPGAbTz6gp8IzuVTDf569pDTanJFtOqrKVhNcWM/zNjyQJTjFibeKhprYyBaqqS38rLA6qsx5rGIJx0WIvBM7jdNL+9HngPYXd+tar+bySOkLMyk2ID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346750; c=relaxed/simple;
	bh=oeZqWpuV/ZMOU/utD2uANJvOve2lVcFV20TukQiXLsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQ/1bTVwWpwTaW2R9VgvzXB5M+hpp4MmfTuEaSX+jUxYH3VfhTTo04k87vPJUFXmW3FiIbSPv91QWQ2upV9Fhe31ZNuzAuFMpbSJAn0KiHhSLqwPGn/krrB7L5KklmJbUCWKr1DejXyv4s1vXm1tANOX8WDwdyVb1bWv56lQb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theesfeld.net; spf=pass smtp.mailfrom=theesfeld.net; dkim=pass (2048-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=ytRcUfMI; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="ytRcUfMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780346742; x=1780605942;
	bh=sNeMpRk+CfukDwa9c+urhEAdFIqJjmSwuGoafrznwfk=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ytRcUfMIHXELM36jt/46Rr8Jv/m5TGgGvbHQcZ/QCetq7Z62kxf4xvY2qUJQPj55h
	 RpaJ9PXCFtjdvBvDm5gIEiaNawFKQ/33ZlWQg57cRINoivi6dV4cpWwRC/3IMAA/dN
	 qFMeraNgSeciqC95m91cdVa2InZY1sCdYnw/+sIj5jrtmKOJhFukE3H3xtS5+nX84l
	 aTMDio1KIZbKyWtWi87gvrY9KCMJww1ye4jWGRvwJHWFTA4hP7TkRPgDsD8IJ6AExV
	 eahrHj/bNtAlwwk+u9BgQ8OzMU1eUggUP1tJe1JVTG6/aQ5AzcLqx6+WuiYNoSI8K2
	 dHX1S0NfGRVuQ==
X-Pm-Submission-Id: 4gTmFJ2ZQxz2Scd5
From: William Theesfeld <william@theesfeld.net>
To: Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: dfl: dfl-fme-perf: check devm_kasprintf() return value
Date: Mon,  1 Jun 2026 16:45:38 -0400
Message-ID: <20260601204538.663614-1-william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fme_perf_pmu_register() passes the result of devm_kasprintf()
straight into perf_pmu_register() as the PMU name without checking
for NULL.  devm_kasprintf() returns NULL on allocation failure;
perf_pmu_register() then stores that NULL as pmu->name, and later
sysfs path construction under /sys/bus/event_source/devices/
dereferences it.

Return -ENOMEM on devm_kasprintf() failure, matching the pattern
used by other PMU drivers such as qcom_l3_pmu.c.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/fpga/dfl-fme-perf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6..db56d5241 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -925,6 +925,8 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
 				PERF_PMU_CAP_NO_EXCLUDE;
 
 	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
+	if (!name)
+		return -ENOMEM;
 
 	ret = perf_pmu_register(pmu, name, -1);
 	if (ret)
-- 
2.54.0

