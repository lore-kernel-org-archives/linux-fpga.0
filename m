Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5403E0249
	for <linux-fpga@vger.kernel.org>; Thu, 16 Apr 2026 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350572; cv=none; b=JANp7Lbvl4TvDpebPvhSVOxBtCORK8ciMSBkf3aZ/ZRYp2LOT5IBg02JsTNg6/+woXkK5lU/MLVi4RWjMsubgodmpEarpLs+ptB4fGb2MqUJxzKvZFm3YasgyJpbpMrlC39jInHbSQOmv9IDVprXIw2S2folPu8uHZDWKAdLbSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350572; c=relaxed/simple;
	bh=xrrPdpYsYhy0eGksuw8CEsG6UEANm6hhyh3Ohzaysz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iok3pRzpsE2YW106uJBkC5Zyf0xAbFy6Vkkh4dHu42glSi27oiqT4P+u9t1NBQ4R3mJt7tBUxSP7aSPHk9ICXK9bF8y0mzr5XEGGFTGIaBcM8tvgIQlrCv1N4YRJtMA2oz0MGdcU4x2t7fckKtcBTb35X1WzUZ9p8R1c+bt1LOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io+yRIDm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io+yRIDm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba388bc0a9dso47373166b.1
        for <linux-fpga@vger.kernel.org>; Thu, 16 Apr 2026 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776350569; x=1776955369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpzCqOy3BCsfajpy7vpm92RCmf0w4xV2D9F85Ngay0g=;
        b=io+yRIDmtKgQ3maPFTVDH9qg5FC6K0I8jW0mbHGwvPXRTOXpoOB0duG1DmAJtfc8Pz
         FABa1eU76JOg/VA1a7Bl55LFfvxpBvJmjZ2zL6tuEBAcKkUWljp0XSbYDhqZwENXSk2v
         ZMydh+JkEVmvXTjmfGCCrNf7E1NoOvwqxoF2x86xcSOHM8x+ao1DMPk8Ca8tsdLmikkd
         kIQbOUWwklJXaaRyTOTOFH+ggjDvng3D8PrWSQVYdU5kYvj8VJq5e18NBuxNmodrI1pw
         Jy21Wt3RspcBeKaIqo71IJgmP37zHzcfMzidbQ7JwHSVoABHqtQYf1znn89ctvNufdHg
         lNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350569; x=1776955369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpzCqOy3BCsfajpy7vpm92RCmf0w4xV2D9F85Ngay0g=;
        b=qigfg39hMb4L4aphMyHUxRPAay/ThjzN3GEkDnvSi7L4laRxrLdLBYj1x+f7KZWiqW
         Ide2zNfl+RMgsIYjtCC75i+9C1W8PoZJ0Bl3UBCCKoZ9T+YFsjV5qn11TXrF2gfcis0k
         RXCSCCIoWxj3s+iKq5d1swSvPWpC9tFLc4LKz8d8KDBChAaugXT9mdF8/Ex/v34QOQwG
         43WW/5CUc6RGQ+qg6pRydV9BsAbLjQ/pQb7nk4Au+5cg9n3+USDqoC/AnNE6RvLpzA2M
         pNAqfKz5XbfGU5jatUSjRTNpsJ6D3oM7fvFd3bZ216fjMaYIdnp9Trf9N4NT1GeFF8ei
         CGTw==
X-Gm-Message-State: AOJu0YwZJ/P9UHn62w3X85cDvvoCEQp/1PNCS/OFdKZ3QmmbPZWEpCLl
	l0w/5fsQeXxvEJuP0T/9gwG3s4RtTjbwAdYTtd5FMwo+ZRqWtZqKVjD/JCJehunL
X-Gm-Gg: AeBDietNRCeqmAJXqdhKcpVY1M2ndWlI+R7izxw0uYt+l5jfP5mzNJQDDS9IqCAL9AK
	JYatjDh+m+3+JF05p9ANB4NHoMbBPxMGWm6XbAsZwLhEJIEbnl+RvHPz73e/VDWGzAPBkru0V9/
	P11uzaRbTeAZpG1ExNDOt5jvAO2dVgdVlAygOHultrmofbsYjRs6J8j/0JjTJQnqB7z1FiTziu0
	nVuKrbrSIB/+djWwOfTLfieLV1PQ4za+XbfrBrMo7ME8clpqo7jGGBapKszyPmBDK5WLK9lXByj
	ElYfxtUKXOW+W7Lv+qlfIIP9OBne4vRKGZn4DrP2+mHn1zTQPVaHxq0MNPpZJ35oJtGzDMDXl7y
	EItSVfNbdz5DiG4MU4vY0b1CC/AG+237fwUoP/iQKqZ0hMbtrd83RrDydKdnEKsfmg6yQ1cwqUv
	r7aoXyxF/SpXrdHmA5FWZtN9fLpQ10xhXDp2RI3FTDdDX6MK0=
X-Received: by 2002:a17:907:3e88:b0:b97:c684:57db with SMTP id a640c23a62f3a-b9d72792a5dmr1601267366b.12.1776350568737;
        Thu, 16 Apr 2026 07:42:48 -0700 (PDT)
Received: from iris-Ian.. ([2a00:20:636a:3838:3bf9:3a9b:8000:4975])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba2a112cc9csm90502766b.40.2026.04.16.07.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:42:48 -0700 (PDT)
From: iansdannapel@gmail.com
To: linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	marex@nabladev.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	Ian Dannapel <iansdannapel@gmail.com>
Subject: [PATCH v7 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
Date: Thu, 16 Apr 2026 16:42:35 +0200
Message-ID: <20260416144237.373852-3-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416144237.373852-1-iansdannapel@gmail.com>
References: <20260416144237.373852-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add device tree bindings documentation for configuring Efinix FPGA
using serial SPI passive programming mode.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 .../bindings/fpga/efinix,trion-config.yaml    | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml

diff --git a/Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml b/Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml
new file mode 100644
index 000000000000..7c7444ff9c3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/efinix,trion-config.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Efinix SPI FPGA Manager
+
+maintainers:
+  - Ian Dannapel <iansdannapel@gmail.com>
+
+description: |
+  Efinix FPGAs (Trion, Topaz, and Titanium families) support loading bitstreams
+  through "SPI Passive Mode".
+  Additional pin hogs for bus width configuration should be set
+  elsewhere, if necessary.
+
+  References:
+  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.3.pdf
+  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.8.pdf
+  - https://www.efinixinc.com/docs/an061-configuring-topaz-fpgas-v1.1.pdf
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - efinix,titanium-config
+              - efinix,topaz-config
+          - const: efinix,trion-config
+      - const: efinix,trion-config
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      reset and re-configuration trigger pin (low active)
+    maxItems: 1
+
+  cdone-gpios:
+    description:
+      optional configuration done status pin (high active)
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - spi-cpha
+  - spi-cpol
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+      fpga-mgr@0 {
+        compatible = "efinix,trion-config";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+        spi-cpha;
+        spi-cpol;
+        reset-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+        cdone-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+      };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+      fpga-mgr@0 {
+        compatible = "efinix,titanium-config", "efinix,trion-config";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+        spi-cpha;
+        spi-cpol;
+        reset-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+        cdone-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+      };
+    };
+...
-- 
2.43.0

