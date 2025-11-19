Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386526158B
	for <linux-fpga@vger.kernel.org>; Wed, 19 Nov 2025 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578058; cv=none; b=rLo0GiVtIaVGB+ea4ztwoZiMSrfJ//M1amvjFGYWZsMQN3YTYu7KNkwX5dmqZLPLV6tTSEAntxAZACHYBpNIga4r2t5IcjZFNfuHcjzWVxe2eN6k8AZje+m0LgIEi0VsVMlvUQGqAyl0bPTx1HyWEoq0C1zPu9hhlTGkLKJQMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578058; c=relaxed/simple;
	bh=1VU8vez7VAT++QNZEEkDasqzO4N4y/rnpDpzft4h/pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv13K6NwhKqH3t6LRnG7udhxO1DAVpGBXikX3gduM40WMuoo/kiFhL/BpGU8Pfz/YpeOLajFaswXWM69Af+H1HwOTj6aSOgY7GSwzv3gpqcBZCwZHIgQz07soyqC4jURZQG5HbB3jm+ll7M6LW2LRO16Sw/bsX8vTtZH3I9YHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itnFfpwf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itnFfpwf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so725295e9.1
        for <linux-fpga@vger.kernel.org>; Wed, 19 Nov 2025 10:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763578049; x=1764182849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A83IouDszoOM4nYAvaeRYh1AjY1berYJB856i9pOeQQ=;
        b=itnFfpwfa3JcijLUSHrXO8GJExmWS97VaR57kpB1bf2QtkcCiizOExBezGaoLVsOB5
         WiaHiZhAWrP3imFu+dc4+4g6689srY2kUJ1qau/ifvYgNlEztmBCO4peuw33rnN8XdOp
         1BOYok1f6e4c/YOJRK884JUV4vNL6FfgofocVtwSNBKKn7alyZrLJkU6ceplL0jnR9Wp
         HA7XdQQGDE7edayBrnJF7Iwcxq7aM1B7oIQvKv3UcMwdwMhOIBD/ZWoBwCzs0Rv16qmV
         PZ5ntUUCx2i2cZ2rSK9b1aufY5lOVeK78nwnLH/WVejemPCsXrbcubcaX3qUWKLicazR
         mqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763578049; x=1764182849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A83IouDszoOM4nYAvaeRYh1AjY1berYJB856i9pOeQQ=;
        b=dvqvNsKp4YiuRct7V2yGtPMB6DnoOsHDpEycupdK+uwfu3Yb8vxd50eMBfMwGBPgKj
         n9fvFjWUt/buB8klOtKRgN5Iu+6XfUSyp7geipujj2Pu48ApEVNB8OvpBhrgeoC8SjmZ
         0/27TT/VP9Pf61psRzs4UmDCml48y7Gi5OICE9eZxzmgypAEhpzUuerCehzDnwisAp6h
         lbD97IV33bIeVKBX9jM/n2X+HOxYaaypQYSV+r+1rdyDrU4x2pzNe/TYb4Qk67iCxiPs
         198Yubfo4tBNvlV2lP6SigbeZrfoO7NkF6Kp5aY4FJhq0/b+DffuG6Vd4zG1r91C4RMk
         NL5w==
X-Forwarded-Encrypted: i=1; AJvYcCUKMzkEiZdW3MqheG/yvlJTRwk5+4FlR2/cWhZgp5jDo6TspQRR1oAnRO16pk+9KmqHbCnNj17tXnLQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJencM5csJj+Jw1Tkv5lEy/LYFish23OKyCOeqXXXPUFw5Z3A
	hk+fghoUonxM+s5xvpjCVLtMf3CPtViU3CDjMPyEDk+S4pMaVCHG/3/s
X-Gm-Gg: ASbGncseBJxA2dkAFX1e+OK3vxmX8HUMo/BAh3L8H9SDt3lV03fitkPxHU31Lo7OVhI
	pN1XbycFlPiggbvgeGCWq+YALCA0tj+4LGol+K54oiSXrC+/I2WxyRKvniqAdDjpcZCBnI0C5+G
	ZizHlx9CuEIDgZxxb+kQTV8EBEZm/XafFg/Jsue9Lp6IF/tci+NAlVTn5PHmnNOlCIYAAbhwSPz
	V7xD3HiLmpoqLFXw6F6WqXa6cVc/caF1p3SkUvbmaJ69EdIKy9ISwdUrTDVAbsARXASREB4+PWa
	+23iyKYe9rwcWUxxMonSDMgApT2U+887xrXQK3sxgW+D/+Q9wsMHvTFD+uA39MbbhGmGL0u7i3m
	DIi24GaEHGx9jf/V1UyCSmNJqQ2Iyz5Lz7Dat8CbYCAFOKVKtEQf0TpBhQPO5oCUCYANhcjIHE7
	IMGFF2aD+QXaT8CGMnTe7slWnfppbZonqH3mtyTvRq2ozy9ukS15mw2XhEfJgUvuERmye2c2VVf
	9UXNrvyIoa+8BJz/B+l+zbP
X-Google-Smtp-Source: AGHT+IFROQbeM4xEw/+SN2gJ+GHD1xZYoJk0VErnDEBIQaVp+K4Ys8C5aaRCpGFODkSNEgs1i26mpA==
X-Received: by 2002:a05:600c:1550:b0:477:b0b9:3131 with SMTP id 5b1f17b1804b1-477b8951fe9mr2833495e9.8.1763578048520;
        Wed, 19 Nov 2025 10:47:28 -0800 (PST)
Received: from iris-Ian.fritz.box (p200300eb5f27c400b58af32dfc3cbd97.dip0.t-ipconnect.de. [2003:eb:5f27:c400:b58a:f32d:fc3c:bd97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82e8ea6sm4909795e9.8.2025.11.19.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:47:28 -0800 (PST)
From: iansdannapel@gmail.com
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	kever.yang@rock-chips.com,
	dev@kael-k.io,
	iansdannapel@gmail.com
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Alexander Dahl <ada@thorsis.com>
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
Date: Wed, 19 Nov 2025 19:47:04 +0100
Message-ID: <20251119184708.566461-2-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119184708.566461-1-iansdannapel@gmail.com>
References: <20251119184708.566461-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add entry for Efinix, Inc. (https://www.efinixinc.com/)

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Alexander Dahl <ada@thorsis.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882009ba..afe41267df32 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -469,6 +469,8 @@ patternProperties:
     description: Emtop Embedded Solutions
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
+  "^efinix,.*":
+    description: Efinix, Inc.
   "^egnite,.*":
     description: egnite GmbH
   "^einfochips,.*":
-- 
2.43.0

