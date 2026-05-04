Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68B3CEB9E
	for <linux-fpga@vger.kernel.org>; Mon,  4 May 2026 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896820; cv=none; b=QdVbJ1qlWwUtTkvCrfabHrJPinTAkj0h169EeVsPhD76CpxGkucMG+tsCV9uwoCIdj7VdOroQxRhdcl4a7AsdwmTJ2ybtXsfWz0+Yq9JnKyYu8xjlbFHoW6lLXUolr+MF2pzb5lKedLkmkGabsbdHFVfEAx0izOJX/r71dvKS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896820; c=relaxed/simple;
	bh=eoFqV0cUKljCUasyMEcO8e3E2F1rKIvseDS8v5lylIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+7qIwTIirwxiln0j99a2yAh7b+YbPuEwL8Z9tq0gNajYg2VsNhw8bFcyhObHqcA/ofYBxBp5yk4Zi1H01GeS7LkjRYG8OBRM1shGDPgJh3YdldlYKy+qV5F8Q/YdlFamUMHpC3Bnx9z9aJshRhiZcSY4L6mu7j9UinIFre2wP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFpyr0os; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFpyr0os"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a46ebe2beso35901567b3.2
        for <linux-fpga@vger.kernel.org>; Mon, 04 May 2026 05:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896818; x=1778501618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/UJ2uvEr/DOGlLSCCMJfX3fenw9+ggqj8yJwATSV2Q=;
        b=rFpyr0osEA4XkXyFliRSz4mjI0NJiR6LMgbAs4GFvIesofPHtEVOK6obhjy/D1TVjw
         ep42/fYSGKT/ls06siKHNFx+5EHF94SO8gCNtgJSz/+MOb4wZd0J6dMMK3E4cNgL6DeM
         4wYtebWFAKk7BcbSLCD6+ebfIsWm+vyRe8wZQdHdNWVnmLyTI1Gej76q6RW5c++nVLEM
         plo2xMXS8ZQ01fpj0ihCRNXzplcTwgIs0HgeR7Q/8BxfC7qUrdG4Xaj5rxFxROhl3vlL
         /BxlMqIhjl7IyvMLP1oPRAQsf86xuR4Eantgnu3Oeo1OcjbPmP6gPoL0zoClFspqjIda
         8VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896818; x=1778501618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/UJ2uvEr/DOGlLSCCMJfX3fenw9+ggqj8yJwATSV2Q=;
        b=roNj6qTe9hR8WR1slP+woo8JjIKmtEPYJOQZbp80cDr5h3VleiVLAi6nlROf4EtojJ
         UV8H8dvrOFecCLfH4mpaaBYPKtcYw04diSyozTawlOsb9Xuhw19Z6evzSdsShyBMp1nx
         thizy89PIE83pmC7ztz+nmG7o2XaieoPy2lgT9KAGyrMvMKekkyBpDMjRMagc+DJSvXu
         MA6eYIeDnUjJKcCwDcRoh7QC5mpQ8YLyiYzsHUwRMseLyhQeeYK25pBqy2yxS5OyGz1y
         +P/uZUUcfTmCv11K74ekdc8BCik9+odSHKc9Ci+g56yeMtP3YiBQyzDk0zNBgG/2mp4w
         V9fQ==
X-Gm-Message-State: AOJu0YydLCuR58IGxq1NMxuOVkRz3PIJmdR10NMq0rNPwCOsusTjp1ut
	cBaIXKUgrBAblZ8Xwd+OA76o0UdNJoo+3lx1a1D38JVshcLXkJPiBXjL
X-Gm-Gg: AeBDieuYqpWhaddLOydKEPAMZQqXPSANY7+4iNcqtGT06rwN1ScFy+HNIu5v7znf4n6
	vIIalvYOtzThVxCTVDCDw1eZSrbYfudwyXc9z2m5zveHXN+Sv7wo2FAw2AvXJg144s5sSQgh13F
	Fvhnwb0uvF0lmqHL0EK077iYLx6N+J49395ScrU49LoKc/2XmlILGcRbacH9giQGgn+Dbod35ey
	cPxSlwQIl1djwyaWQdxopgXJH1kFz1yUwTqCVXaDX93RsPh9tDnfD/4qmpqK2xXnTYpFSlroo2n
	APsDfR7Dss8WpIAnDEUSTTAPvU0RJ7rzpHEELuCYpPDgmAgSOsrapjEctIcXXgNA/kZ9Lx+RjHh
	lM+Oy0NypMmCpHT9QA3FBCD+JqBbTcHuotYhByNk/bWjGzZ6HrVYPv2lRmdon6A8j977BpBTBjf
	oB+4H9lEWAhDjXLiR7fJI3V5n82459FZyFMR7nYonItApBxThd7S10GwXkHcraDkKMXg==
X-Received: by 2002:a05:690c:a00c:b0:7ba:ef98:9720 with SMTP id 00721157ae682-7bd76f80e2amr80290547b3.4.1777896818053;
        Mon, 04 May 2026 05:13:38 -0700 (PDT)
Received: from ubuntu-linux-2404.ts.net ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm48417937b3.11.2026.05.04.05.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:13:37 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v5 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Mon,  4 May 2026 06:13:30 -0600
Message-ID: <20260504121332.1053563-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dfh_get_param_size() can return a parameter size larger than the feature
region because the loop bounds check is evaluated before incrementing
size. If the EOP (End of Parameters) bit is set in the same iteration,
the inflated size is returned without re-validation against max.

This can cause create_feature_instance() to call memcpy_fromio() with a
size exceeding the ioremap'd region when a malicious FPGA device provides
crafted DFHv1 parameter headers.

Add a bounds check after the size increment to ensure the accumulated
size never exceeds the feature boundary.

Fixes: a80a4b2b2e4f ("fpga: dfl: add support for DFHv1")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v5:
  - Add blank line after the new bounds check.
    Suggested by Xu Yilun.
Changes in v4:
  - Resubmit as full series per maintainer request.
Changes in v2:
  - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
    Suggested by Xu Yilun.
---
 drivers/fpga/dfl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 81d7a68..4c63c7c 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1134,6 +1134,7 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
 		size += next * sizeof(u64);
 		if (size > max)
 			return -EINVAL;
+
 		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
 			return size;
 	}
-- 
2.43.0

