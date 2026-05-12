Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A15534DB52
	for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608957; cv=none; b=i94tPdqA3OCiWER376m6W3JnN/pqyT3jJ9BREjdCCExeDWl9hvfG3rgu71E7tFUve232Y8pLu24oNJrGfzj/Xaeivn3VH+w5pRbPdEjltX/yx4WrLj2D4kQuAP1yEgqRvzXWqRN94vFSxTugl5pp+eFH5rZsGC/vnKqHln+vZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608957; c=relaxed/simple;
	bh=Fap0G3Ulkv05tUIGsv1rmjqPE5yf2rdWpkgolbi02wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8hmSW8Eyaea+mL+2RgDRnA+o7Updp3rcD1BJMzlEMvJWw6f5rpVE9gcskvIHWY5Hr7Z9yWT0PEcfeX2V6l8sp8L13uNJcwjxxYDSe0t+QQofLprxRY/8Zo79jgbD+tBH01iYTf08FNlCDXhA26xwppr/phrSSOP70xVXGgy7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TABmaJca; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TABmaJca"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c802803ac17so2647375a12.1
        for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778608955; x=1779213755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xci0mD+Fhw27MfGGBTyO8q5KCYyJyTfSheYswRyFak=;
        b=TABmaJcaZKJmIKTZ8PXkKAksvoax4G2ztGyegLCObiFURy0F2EVnPyb8Iw3OJHLo8i
         VP8SFODrpN9CmUMV2vHi2QJLYL4tRG+MXY+Z8E2G6ctn5XZkRaRc3SeM2QlRlKfn0WOZ
         pKf2l91rvix4eIoEKkPLbA74Q6DR5vNtFmWHmeJ13Nb7KSylphkzjpCfv+FEnLaaDxKm
         duXHlyKcIlT6tTwbj9ewGGwMfrBcct7g7TDaDrses8lroleMU56eGN/fwrt9qWKzdjCP
         N1ZtEUI6LPRS+6R2IItrBh6W0k5Mvax/eNXj3HDaqFg8SksSjLum2yROXU2hMi2Q77pS
         QTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608955; x=1779213755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Xci0mD+Fhw27MfGGBTyO8q5KCYyJyTfSheYswRyFak=;
        b=etpOhDXu/oVBkjZpzk7jrwjFaMY7ck+vw7lIrGZ71whPCLYJrq9dK4BBYKdUIFK15e
         D2nB997hc3TPHoxAh4z87L/JPdTKf62XC9UMK9G41Al8vV+lSweLoO+d5HjIh5jf146p
         kW3DidpHQsQo/dTmigwetSKreaMQSvLgTi/DaGkP0STSX63lO151Rs2T41pX91Hxtiuu
         cvQQ/BSegDe4HwOi+LWB1GUXRPo4nHQhvS86GrkohY8TYmGnDaWi3SoWnX4y5Z9RNrK5
         KyHgdogj48Mj3fWqTiUhObfuqOJKa9Dp3iSKRrmNX+wQlHSJwbf6XPF3aualXLjkWZIc
         eRWA==
X-Forwarded-Encrypted: i=1; AFNElJ+2N3dOEnUfSasMlIPmAZ5Zef1xHYr0Efz+0o5uqePf4mKILvxkbc3jFpBSb4PNDKhlqGNLt07077ZV@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjUunR9P05LAgOQd5h0siMKJwG4khd7lMPkkRzXHeKjf8ZVrV
	39f0tusfcPodjV8cu3e9WBUhDrrWp+NV15wXYbkILKnZJKx+AiowmKGu
X-Gm-Gg: Acq92OGF0SAyAZ9caU4tXTkB/Zep4YB2cL6rYGGs9PDtupQDrBI8XYXRKZOm9XOn8Ww
	IjSXLWpF/PnmftvUbfEs91bmDwvWWXmQc0NuUvY9EXjVwyqQWk4tzAss4Ilwydj62MivYqKQXNh
	6QV5DdrnnvwBfmg2CRfJIT97wdeVUi2FJPPK/g6dGf6/2qC6sSiB+dBceBgcag7qADGLqpAfP59
	4ENf9ikwLXdi5x69lD88w75T5XkLrrbqw7e6tOGjVCwPk5RcCzT4cDa1xI38jX0zBJ8f3a9vasP
	uukVY7xMHug9EnzZrcn3mXrC8vAGvGnS0BJDVu1MjfZ4UbAGS7N8pfuY/NaEzOeiKcnoW6+H6r4
	E/tD+mvsQMzBR5od9N06+AlKnzY8O3ycE+bIAemV4i0+RLT0AbV83k7UfwXqhReNou32KaZ1X1w
	k8Cz0rjBKBPpwl0Y8A584K/f14Uf2bnPWEq6pUY87soUHid9Pmz4puVuKbAAP4qj3U6Q==
X-Received: by 2002:a05:6a20:1585:b0:398:7ca0:43a9 with SMTP id adf61e73a8af0-3ad9a234f27mr4595033637.36.1778608955243;
        Tue, 12 May 2026 11:02:35 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767e677sm13120456a12.4.2026.05.12.11.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:02:34 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: mdf@kernel.org,
	yilun.xu@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: matthew.gerlach@linux.intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com
Subject: [PATCH] dt-bindings: fpga: altr,a10-pr-ip: convert to DT schema
Date: Tue, 12 May 2026 18:02:25 +0000
Message-ID: <20260512180225.65902-1-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Altera Arria 10 Partial Reconfiguration IP bindings
from text format to YAML schema.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
---
 .../devicetree/bindings/fpga/altera-pr-ip.txt | 12 -------
 .../bindings/fpga/altr,a10-pr-ip.yaml         | 34 +++++++++++++++++++
 2 files changed, 34 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-pr-ip.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,a10-pr-ip.yaml

diff --git a/Documentation/devicetree/bindings/fpga/altera-pr-ip.txt b/Documentation/devicetree/bindings/fpga/altera-pr-ip.txt
deleted file mode 100644
index 52a294cf2730..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-pr-ip.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Altera Arria10 Partial Reconfiguration IP
-
-Required properties:
-- compatible : should contain "altr,a10-pr-ip"
-- reg        : base address and size for memory mapped io.
-
-Example:
-
-	fpga_mgr: fpga-mgr@ff20c000 {
-		compatible = "altr,a10-pr-ip";
-		reg = <0xff20c000 0x10>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altr,a10-pr-ip.yaml b/Documentation/devicetree/bindings/fpga/altr,a10-pr-ip.yaml
new file mode 100644
index 000000000000..1f4df40308bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altr,a10-pr-ip.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altr,a10-pr-ip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera Arria10 Partial Reconfiguration IP
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
+
+description:
+  The Altera Arria 10 Partial Reconfiguration IP core allows the host
+  processor to perform partial reconfiguration of the FPGA fabric.
+
+properties:
+  compatible:
+    const: altr,a10-pr-ip
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    fpga-mgr@ff20c000 {
+        compatible = "altr,a10-pr-ip";
+        reg = <0xff20c000 0x10>;
+    };
-- 
2.43.0

