Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000D3E5580
	for <linux-fpga@vger.kernel.org>; Thu,  2 Apr 2026 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134530; cv=none; b=p3ALc9a7xzh3ZPH/5eRpIXw5bp9sS0Krgzm/5gHPbuU/wVH1186yAZwOLKMHg9uJzWuABRy0CswbjJ6rR649QD+AK0Xce45N8cn6pSjhsgyK1Nlpga4uU+MPVLWcqjy8GH1xwHV82OhfD16so/JmMfwUoYSDTBNLKErCgyneTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134530; c=relaxed/simple;
	bh=+XwAz1WI5ah5S4NeumOZ3kgf/WtVzeiZRQij793c8Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZoFXU+5LUU8Ec4u295HGgzf0H8R7W6knokoZdLnn/i5KKWG6y7AD9slZMZplQGJXupqIRp5jOqEqXLyCD9AmQ74JMugcNemqRaircpzwEjKA9XSP8N6YGr74LmHvkSjG8u5fw2HZ054D3km217ww3oyicIyZok1eAI8OFxlDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=saLoC7qh; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saLoC7qh"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-604f1bfecf1so534229137.3
        for <linux-fpga@vger.kernel.org>; Thu, 02 Apr 2026 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775134520; x=1775739320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUGZdZqGdvHzMx1k3Ek8/WSt4jcVtA9CO60KzOm8meg=;
        b=saLoC7qhL6f01+gvBOC2RUlSm8NZfCYMVFvnK1XLuZZuiVfv0NCuyJQaDHbajbgCkr
         /zMU5VF1cW+09Jaz6OmWrvawQlEFHE7jnEXtcnSdTE96c6nuRMVdwlQYly9GhXxw2EKs
         8CX31tlpP8WRlKTUflqPpG6NX+Yr6XVMPqzumTIlwn8Ixd0FMHcpkv4EzbNQo3yMzEu4
         h/bH8ZE4qS7SwCJNtoQ/iE6fxFko6VDN0f4jVtLWjfz+wPzIabh3SLB2KibFGwxvkBPz
         pX75uSXdJCYpax4TErWBq8SeWRXs/LcT92tlVhrQQplKryRxZ7CNBIwyGemSlTSzHi0O
         +QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134520; x=1775739320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUGZdZqGdvHzMx1k3Ek8/WSt4jcVtA9CO60KzOm8meg=;
        b=Zz9AYBUti68ZDvIT5JfStSlni+Hv/HgNn7iOwN1hDpGkIW1BQ16kDztGuvpRddLqia
         C7ffMA9xco6aCUcDQwFwV331FZIAVGObh/70T1wQTBgnVX9y4FEk3XEpZJKZfHiGbwex
         XcS6zJFonpOnKDVKpkfBFLE0TFhyY84ORDai7lP2d3MBt418CAzoi6VSziw6oC9MiQlq
         KdPtBddbsvsJihpS1uKgwZgRx2TdC7WU9U6NywGAXSx6ONkzDSheWF1G3JdhHqApwwgl
         1FNx6bLYw/wsggFJJavk7oKzJqmqEded6YMY673uzCOce9ctrIEKUnxI28acaHIK/M6X
         N5ig==
X-Gm-Message-State: AOJu0YyE1uhoIdGiVwJdCvYxmxnskzkC4YK5kCmegpA8gu6dAp9sxp6H
	ABt0ur5ySeolChqu6wyDUcn4InAYMftSt1YWMJWVIx+MQgI4Iyp0odd8rJxn98Z2f9c=
X-Gm-Gg: ATEYQzyfMV6Qs46LD46Iz4ZlfQpFyu3cZ09X0rsrkiza23kJtdw6Gtcca5S+aNnyzJ8
	WQPtKAwKOHIrQASuQ7PnQ/jhWcxr+oYu6tS66PmnkhnkfhndT9dVofqa/JA2tli3DWNpgI8Bi9Y
	II045XW8bZhurhA8a/F9knjct9/gp3mAShxyy+Llasty/ZcIk2/MXSp2xtLo6RVNOPqjWogOkIZ
	/R/ZIdFXJNQrIO/F3zNkUoxUHf8eFnB1/p3ReidyH3tdICZyzpyHuWS9freXAuVnvPZYR6yabwb
	/NngtXaddfYilMo/pKzX9KTfwI9pQQ5TjTaYAvxzjjYkXXbBHrRvhaY0WG4cxRS1M8yjEJBgaQH
	gmwfYKcHMrV2hflfcqPgTMGF0RVrQU6kXZkuo7yA+RKBVgj/jq47qawe+LAujAAkSvyJ/0p+QUL
	u3NjxqfkhgTQOSFLtZvkjZOb4=
X-Received: by 2002:a05:6102:3581:b0:602:8a42:321e with SMTP id ada2fe7eead31-60583fd1f67mr1334161137.23.1775134519884;
        Thu, 02 Apr 2026 05:55:19 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d73:aa::11:178])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fba6af44sm3080950241.8.2026.04.02.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:55:19 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Thu,  2 Apr 2026 06:54:44 -0600
Message-ID: <20260402125446.3776153-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>

dfh_get_param_size() can return a parameter size larger than the feature
region because the loop bounds check is evaluated before incrementing
size. If the EOP (End of Parameters) bit is set in the same iteration,
the inflated size is returned without re-validation against max.

This can cause create_feature_instance() to call memcpy_fromio() with
a size exceeding the ioremap'd region when a malicious FPGA device
provides crafted DFHv1 parameter headers.

Add a bounds re-check after the size increment to ensure the returned
size never exceeds the feature boundary.

Fixes: a80a4b2b2e4f ("fpga: dfl: add support for DFHv1")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 drivers/fpga/dfl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4087a36..0f0889a 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1133,6 +1133,9 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
 
 		size += next * sizeof(u64);
 
+		if (size + DFHv1_PARAM_HDR > max)
+			return -EINVAL;
+
 		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
 			return size;
 	}
-- 
2.43.0

