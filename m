Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DECD41F7F7;
	Mon,  6 Jul 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349891; cv=none; b=D/8CfKOXoP/Zm3Onj7kblI0PARLpUJpN7ryAKUfXB9/ehsSR7wM2g4o1PKtGG3v2H7ohKCD4TO913cPvr4VrMgm5Bmg6Cj9SHeY+ABDeyqQDgCWwwxC0XvN+5RMfkyMYZNqhdlbClxR7nXmvYz+Dn/+qRjEAZA3wRizTv8PHLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349891; c=relaxed/simple;
	bh=sGs6EJS1aoCpcvaJGSe3S0o/xRp1cVHrc8nnxdLeNKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhov2HPO8bzbaKbqMKUWLTgIVSR6j48SpkXSDi1IjkfV6Bv5OTr3mF5VHDGg0mQK4e/BdCHOUr3tozkMTP4x5SZE1ml+jBcod4ffJGDAoGms+CcJXJgWE0qrRVyfPWZ4TgqPh5o0jx+mDe5vEURyltUooy/irxTdF9JnWN1RB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IhdDAemH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IhdDAemH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DBE1F000E9;
	Mon,  6 Jul 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783349888;
	bh=KiAVLQWT2UUwF3AcZCxip0AlmndKjljr59DReSlI9RM=;
	h=From:To:Cc:Subject:Date;
	b=IhdDAemH93YqazHKFW2rkcOdmwDUNc5Sb3VBmi6GBCiLdo64W+eMzD3KP1edwAVmZ
	 lVWJgZeETbJliIt0JGltPV3b8NASSLJKubtizBMMDMIwN3Q4/Jt+qO0dJnzhnlJFAv
	 b9IwIyAMzBHab4MLQyjpGfmF7KOxthvqdlCqr9b0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	stable <stable@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] fpga: dfl: fme: add error handling
Date: Mon,  6 Jul 2026 16:58:21 +0200
Message-ID: <2026070620-unwired-clay-f6cc@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=xs7UNpMsWZV+KayVMtZHtK01S8ZX/g7UYwRoN5xkV9E=; b=owGbwMvMwCRo6H6F97bub03G02pJDFneh3q+cjxQb3zPdKF2xtutdvwthUXaE0/s7hWODRLYu m3h/NsCHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRbwcY5mfFTzp3pNpqc/Ol V3wtd2sWm8/I6mCYZ6LbmfGrJoNTXsqx/aXLZYZSbRkDAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

From: Griffin Kroah-Hartman <griffin@kroah.com>

Add error handling to devm_kasprint in fme_perf_pmu_register().

Assisted-by: gkh_clanker_2000
Cc: stable <stable@kernel.org>
Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/fpga/dfl-fme-perf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6f37..db56d52411ef 100644
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
2.55.0

