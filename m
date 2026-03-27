Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC138F923
	for <linux-fpga@vger.kernel.org>; Fri, 27 Mar 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612135; cv=none; b=bHBa3LHKelqxO0dLCQg6+hv5thxBd1EXutWv9Q40+rRoxhwUL4Hc6XwGMrsn53ir6ARKIwuNyie57ON6Hm1LkkmqHqDlJGBErMCrpJu8U5OqLOFVK5n065dMGsiLP445g81Ff4OzuWi+0wzKYUj1T2mftb1iT2qM2Dk/ypN+C4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612135; c=relaxed/simple;
	bh=sp/IhDBmUKnNkZq4UW3TtZjgx9RAlyfRMXoZdagEuIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCNtBXKaQN4M8VXGwJZSrD9GVgmGb/3F0Qr7SOrzBtIVR1+7+qs51s4xF8kA0/QMIB+2aNDamUynsiYn4a6iFBYlOYukKxbeYl/zccBpgm+f4fKsXa4EMV8fB9aEssS8j2ZOq/5wv8Md7jzbrihjz2l9WzEYPtJ4HuRBVyNJUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huvlQWQO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huvlQWQO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so19028255e9.3
        for <linux-fpga@vger.kernel.org>; Fri, 27 Mar 2026 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774612132; x=1775216932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hmqha9k/Jw7r6pvW2ms6JnuZxlOdkxkRhbawPY0Y7FI=;
        b=huvlQWQObB5l7oFaJ8JSkM0FHitiZiQktq5euRBTWQIVCdolbTdiiBcPEPUd2fUMDO
         TlqIk87sNpXpdqL0YiKdI3fox+vwyI0+q02+C8XclhYPwEcAwk0NSRuVYqUx5wjqsKWH
         tFHJOUMqtYKyuXnYV8bcKCCggx2seP7VxtYe34BMl+YtqaBfjFan5PtXtYJ0TQ0l30kN
         hNnl0Dsqb2QkE61oXPVEg9FiEpSv63xUEBENgGEcS2kzsTgK/mxJ1ltyjECAj6buTdPY
         rPb6nMF+gRB13x+cySXNQoBhgXVPE7sOxNi15Kh77WLEFSj2EtehG/vLh+Oo7mMRMMmL
         p0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612132; x=1775216932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hmqha9k/Jw7r6pvW2ms6JnuZxlOdkxkRhbawPY0Y7FI=;
        b=rkmVz6aP7/bwPsUyLPEa5dMJxW2Ah1phR1LdI2UYr0DNBgrLa4UOIs31XXhJijTE2m
         MteFWEJ5Hj/UbQHb1qdJ7R3yLkLEoqe+snJSkA1mQo/J4VR0q/kWot41qcHuDTRjrg6q
         OaPJiVBdRdEoa312eeuwdz6ut2LWc9Q6oBQx7o7tA/uTZBB4eDeFnDUkFGykGiKpzmEX
         adonlC2W15AGD1BoratTFBS52vRsobuHotwcH0i3dhwNljMqScAIHNy9BEDWjrZbA7Ut
         6Vv+pqH/X2r1XnuMlhJFU+ZMYLSeY9TfpF4onz9VFgwtHubaQEWAIVjlpMauQFu4RUFO
         L0uA==
X-Gm-Message-State: AOJu0YxdE09PQzMWfPBCfHixeUaBoWIxYkwPDiiIHOHlmLuKY2oQrDus
	ycxhXEdvo8a6auG0P4tTDE9+l7g2j0fntmDad10DNgrQfyDy0J3t1igKYYjFUIu7
X-Gm-Gg: ATEYQzz/hhF8xdlEdl5YVrUUaLtoATPTN77yyv5rD/BzcLn2UJcSYO2nj2j1IaLLgxy
	gNqpPBm18Km8TLmMzsfkfDwWroLLkV9JXOMvADk3FxESbPSlFwtLpQdZCFJb2oISzgvKSriLma/
	+pE4BggxKFcL3atNhnJzXNHwGSTrTCAaxDuePT3td5sUaU50la4Al4lMToiD/LKY3+Pss4/xgN9
	ZhBhVLyyLjf8JT+D1PaA+W8AM6Ih8eHKMuY/1dvGecI94XAr0EOs5dvYCXDCFB9C43B9fwXepaU
	JJEZK0NWT70G+iLafZmw2+XJtQnbE1gHQad2MRT3IAGKlneR3DqcZQvN9iiuc+MbA9O8nTPs5Xr
	O4NA8k5S5sKm7lSoyltmLkl8qah+n+MRKzDNbtcZFx6Qjrwxeco/IWaX2sGhl73Pe4fzG9QseUT
	TvVTstkhzUjiYDcSqsO5T3cwUTpUm6tz/kJz0/ZU/FsRrDQ/GNj0yFgyVtJ/c99ISu7Oq3jaGLd
	YJALolJmkKMggcAhae4cPmRuw==
X-Received: by 2002:a05:600c:6287:b0:485:3b5b:eb8 with SMTP id 5b1f17b1804b1-48727ef6617mr34445785e9.26.1774612132393;
        Fri, 27 Mar 2026 04:48:52 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f28a7005a7787565d4257d0.dip0.t-ipconnect.de. [2003:eb:5f28:a700:5a77:8756:5d42:57d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d49c18sm90506115e9.14.2026.03.27.04.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 04:48:51 -0700 (PDT)
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
Subject: [PATCH v6 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
Date: Fri, 27 Mar 2026 12:48:40 +0100
Message-ID: <20260327114842.1300284-3-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327114842.1300284-1-iansdannapel@gmail.com>
References: <20260327114842.1300284-1-iansdannapel@gmail.com>
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
 .../bindings/fpga/efinix,trion-config.yaml    | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml

diff --git a/Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml b/Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml
new file mode 100644
index 000000000000..7e84397e242c
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml
@@ -0,0 +1,96 @@
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

