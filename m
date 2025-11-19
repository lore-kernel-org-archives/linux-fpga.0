Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04C30F539
	for <linux-fpga@vger.kernel.org>; Wed, 19 Nov 2025 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578062; cv=none; b=l2lcTfOd9vjoW7ThPQomyD1/1NyaUBljY+bpTj3oqsdzWa996zgR/trOO+5/8lRjavO6oNZ4bwr12lL9keCHBNz8jiMf+n7v3EY+wy0k6QdAJydYFiUQR4maxpjTONmbNcxXAcgDOolvb2UEPFN0x3ESUyV7P+8pyvm+Ffm9M8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578062; c=relaxed/simple;
	bh=U8TCrBTBHMBDeRXWEsimFplzVxGZZOM7cBfndCP4s3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7m4SexjE4ofAup0UG5rdAq0PeXfZnyhLi7vjQ3akdAnQwqqDQZc0uQLMlc0Nx4833bdtj5raE2xhaAel0iYLtu/9ERsw8sDxcgHPCxy/5Re+maA7C/LxJBzLf55eqLb0sXuVNX0FZPueRHC7RnpDW1GUrF/wNtMBKs9VwDEySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWZOlnL7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWZOlnL7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso611925e9.3
        for <linux-fpga@vger.kernel.org>; Wed, 19 Nov 2025 10:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763578052; x=1764182852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RR3qWt/sDG3G1Q99fkPxp94915dORCZ61UZ5fAGW9WI=;
        b=KWZOlnL7cLAs4HvV+SBMXOJbOWC2F0AKzFCc9tMMGnpNG406AY/hke/G4n0U/Tis7R
         xZfiLB0wEHrQmwKSDQO0D1IW/IVxbWo9XdRZ4ZKspgIyC7g21USgJ+z0t2tsp2+P+Rec
         DoTh0kj+hyUX0AoH8sQ18qPkJnFTKmp9Nx00wEwebRwAXHj4fU4L4MVnFJvK6K64i75m
         E7/QAY50fVCJp5UGdu6OKsoFh4nwThKcRo36BYfUg77qFv0vGbXHB/pvPY/LgwsiYrp9
         OO85GNefK1v8ZiTSfhwCmMKJONa6v290pTsXmwfov501NtULcK5r7AnODeSja8+0VPF6
         IFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763578052; x=1764182852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RR3qWt/sDG3G1Q99fkPxp94915dORCZ61UZ5fAGW9WI=;
        b=ir6eUPJZN5rbPREWfUm7RfO8j3z+Qcd/sPsicQkqKiukdpLpW0qm2LrhlcKobb2mfY
         frEPkL3ZvcTRP4QaiH37evTrtXACV4v5iX6m/Nlclgt/cQKdhIjG9TAqSdFKNEPqxa+X
         rHQmanOX1v5KDol0XnJjxIZwahTvzespOVBuTdkppf6ZJV/RRYkhXAQ6JZR65JTZKbrX
         lqCvKamXg2ZoDhQXr3FGi1c4z5sSD1+zZNOMSQRQqWmE9ZKaCwXS75+EVpVQYWdc1TWJ
         Pz1iSxCkCwZ3C3pLHEv2QX6Ygx+LBav0xIT+4IyTEkUzoxAtITObSU4U25dQQYOCihVl
         shzA==
X-Forwarded-Encrypted: i=1; AJvYcCVr9yp/ZvTHIFx2WhrHdUHBaLu62vf/H44NXn7ASCWcCrC8GShOgG8/jG/IIWWk5HaFMUIKyPN+PmUU@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAD7V73wHVZOp1o16vCSQNy51HS8NcwHM4SINCf2SW2ZSC8lX
	fOUTH1V8OuE3Vvi5GKWit6yW737Jnx0so7N6mN6n8JXJJZEVqn4b1UDvF5Ij6HTj
X-Gm-Gg: ASbGncu5/09gzGP5GN2ilYcju/bZDVKI11Jr4P+OL72lGTXcpgmvnh4ARUvsdwoKCyf
	qRv9CO6GXhvepJGPNOqD7WYV/2Qula3I8YisPvJ+QaV49TTp5umOarhm5elzdtWUVhPv08iZvRr
	Vdefngqe4rdatbGV8l9pDEJ1Nzz8xgJ1cn7roXkZeyUP7K8dEWMI0TD4l98WZmdKldMscNQRz1b
	AELjWhHe/Q6if/4YGhQ9z43VxoJQ46UB1URuWP8Wq7tu/Y/gF98DdmXP/9ISuwcXyoS1xqELH5T
	vNE18hkRC7MgcS9uQyIEN4Hg4m84PDeORAvNmdiab2SLauumd0FjCkqoft7/8KIBpRWrqBZVF7x
	IVCbu17lTLyJc7KHFauPnznyNtsJXl8XWddEVmulh5xeCOChmjW54C/lbEmMv8smn0CI7jXEDwK
	lTEli78FXS8ulAxYenIiOR0UZg2qmVFJ7HFHWpXzPah9GKV5Q4Sf38HG02UOeCzR++zb6hB9QEw
	VPE8nQ5oRrCDK9BxDa5/yTX
X-Google-Smtp-Source: AGHT+IGWVqRzVIdI2HiJbqd9d8aRb1UulJ8h0GdhVCJ4DwCO+QpTMuGuwBn/M4IYR3NluDI6T041PQ==
X-Received: by 2002:a05:600c:458a:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-477b8a50e23mr2549755e9.8.1763578052194;
        Wed, 19 Nov 2025 10:47:32 -0800 (PST)
Received: from iris-Ian.fritz.box (p200300eb5f27c400b58af32dfc3cbd97.dip0.t-ipconnect.de. [2003:eb:5f27:c400:b58a:f32d:fc3c:bd97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82e8ea6sm4909795e9.8.2025.11.19.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:47:31 -0800 (PST)
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
Subject: [PATCH v5 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
Date: Wed, 19 Nov 2025 19:47:05 +0100
Message-ID: <20251119184708.566461-3-iansdannapel@gmail.com>
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

Add device tree bindings documentation for configuring Efinix FPGA
using serial SPI passive programming mode.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 .../bindings/fpga/efinix,trion-spi.yaml       | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-spi.yaml

diff --git a/Documentation/devicetree/bindings/fpga/efinix,trion-spi.yaml b/Documentation/devicetree/bindings/fpga/efinix,trion-spi.yaml
new file mode 100644
index 000000000000..9ac37e5e5094
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/efinix,trion-spi.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/efinix,spi.yaml#
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
+  Note: Additional pins hogs for bus width configuration must be set
+  elsewhere, if necessary. Only bus width 1x serial is supported.
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
+    enum:
+      - efinix,trion-spi
+      - efinix,titanium-spi
+      - efinix,topaz-spi
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
+        compatible = "efinix,trion-spi";
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

