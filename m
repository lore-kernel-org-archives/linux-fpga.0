Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31A29A32D
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582572; cv=none; b=iOmw49LWz1xouAU9NKEk7kj4EoekPhbP2cHhY+n7eMiNQ1CsEPzluV0d8m77ZVeIZyiB7/BM9Z7orz3b9kHCVmFyA4Zc6HLqKyEUz4HwN3e60Elw9v95pf+FEimV1V2oafDrirm18Asm5luDkQoscvC6lYn1romSiAe1T+ztkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582572; c=relaxed/simple;
	bh=KDi1v7Zhzb9QhyQMTyCHXbSMRyCApqaprJEc69q0tV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqQD3a5aEJ8nO5vDaPX6ndiroWRokZ/b8/BAUoFbv3IKyxVI+ogAqsZnLEHw2eZWwgnTieTY1JiDAwWJu/m0ojrx/V9AVq+eTe7cghA0E4ornaMqBb/NK32d7Y4HSsJ2X1t2dyP8yz06sB3F94n+z3GNzAoHN2A4Uo3DCgeJmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myoeg0Re; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myoeg0Re"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56a9076813bso2416694e0c.3
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775582570; x=1776187370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAd2OPO7eQX4lVfc/O2yYYdNpinA6DdggEH+CtV5kkM=;
        b=myoeg0ReWyyjhfb5sVXnHimvpbELSS5ZH7N1eC9Fe0ej1I78xK5/SPVjH7fpknfLKc
         x/gJ68CxXNJpN94N1qAr2NmpK0sE9k7+9u1EE0y3L5yWTyq/ucVOVXvOe+H4U6pSGK0h
         Ig+SNg9XN5qEJpKzUS/2QCpiTjTzBUVU2bHPk/BVMadIBXYsIHIgp5EL24jQi5Jf+a0r
         k3hwyxoS5Xb24lRhmYE43Td6B4lpjMR5KfMucbL77yGIfN+jhjmxkXt+8taPeCDFLy4v
         OI5dwZ30dBT3vFizXN7MyFWzKbhCyqj3zpiBtxLc2ztgveZEUEfhNIrkzqEXHcR1e+34
         3PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775582570; x=1776187370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAd2OPO7eQX4lVfc/O2yYYdNpinA6DdggEH+CtV5kkM=;
        b=jf/OJJ/OR8E9fYYZiTQG07GcrWqp5PX5BTXPNHACtfHOfXcRw1pAmA0OxRTwou3OTA
         wK4bkgS3ZP/JGGSwI2XeZaicc/1xh5+3BQIn0k+8i6Ce5JN4l4BYiQl9lg/vc6QKDD6Q
         93kASVVA2pJXLKcRVySxLH3zq7ji0+g3Mu2A4xd0SE3xttBpZEBQhYXFUKGqoE+cwwfk
         XNphqgOq+5gsTevYa8l+2zjBUicjs3VBAnr5t9a946ljYKEl6dRcsT67NzGyAzq1jt8+
         YbzAbeaWCsavEh+M0AipUVoi4TKuOOGP8sCdARy/IlFwIBPSENe3bkCliqA73RAYcFEh
         /MBA==
X-Gm-Message-State: AOJu0YxXWvx7VstnkEJsrSnU0IKcJXCNPS2YXGUPyteN53tfMA+lki8F
	1Sylj//m/1Jmz8Ff8lxRvyLsbopWLxC7uhKGdWRFiNk8ke2JPhN+k8AW
X-Gm-Gg: AeBDiev47nein+PqoK1utxR8wchSWu7yc8LTPEAD1pQ/uwH4adqQIGatPRm7hsqwK03
	cHqVAgNyfxV9HGay+UGuXdRF4HCZVdJdGi4mPxH2VtYNQE29NGpEgDk9tGSOnJ4OpNDJxwv7gSW
	E8zNmluESgpJw6WZu5TcJetIUUBAyiNkaP0TPEJNfndb74hZ/XH56wdjTy+M8OsX/viIf6t+L0K
	gyOXrns77rPcbEjfCleIpPGm4PCPtT6EjSxJglfL0iEy8kkiQTidQczRVXpSDIa2w1tZAg4DyZt
	ASeQEImXa6skCjfKKfuw/DGgpBjXuXgsNXXFqIW2y5Z+DO7cB6rMg61VMgliC7MDXyr0rdf0366
	3AeR3XGE0zl71HsxdE93SiwGbzS6fNJrq4COUfGQeey/L/GyXPMrfzMH/Dk+rPXe6hPprutL4/J
	VGNvCH5Z88OE+DAkIbuaQcQNdE
X-Received: by 2002:a05:6122:7c8:b0:56a:9841:9f81 with SMTP id 71dfb90a1353d-56dab8e9fd0mr6192497e0c.6.1775582569504;
        Tue, 07 Apr 2026 10:22:49 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d74:aa::11:155])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bae1117sm18878435e0c.7.2026.04.07.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:22:48 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v4 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Tue,  7 Apr 2026 11:22:15 -0600
Message-ID: <20260407172230.40775-1-sebasjosue84@gmail.com>
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
Changes in v4:
  - Resubmit as full series per maintainer request.
Changes in v2:
  - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
    The previous check unnecessarily guarded against the next parameter
    header, which is not relevant at this point in the loop.
    Suggested by Xu Yilun.
---
 drivers/fpga/dfl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4087a36..81d7a68 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1132,7 +1132,8 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
 			return -EINVAL;
 
 		size += next * sizeof(u64);
-
+		if (size > max)
+			return -EINVAL;
 		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
 			return size;
 	}
-- 
2.43.0

