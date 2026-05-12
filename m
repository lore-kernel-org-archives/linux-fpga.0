Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3CA3D79E8
	for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604674; cv=none; b=XF76O3qEkCzEJUXxztheFdl+q+EJfp8U7O8WrSZLowxnyPVWJBi6H456IJGhZPWNTUu/cpZtFUoFE/CON5FFADBz+cHH4TSwja3yJ4A+xRAnaHRDMTOIMPlpZP1RtXdSsfI3dBPJxwYZCDEGpIvarES09VHXa8WWMoOemL46U4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604674; c=relaxed/simple;
	bh=Ne/BJfjiSRPyaLcWKyCo9XECD2Da12r5Xvjw03FZkb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sC2vkfJLnWsRUb9HNL+hIEYzuVnNLtrOogXJSEz6d0IMrp7beAgS0XnA+GOq7QmUulPLFkb45cFHR0aGuwYSf+7HOBJQMqL/VrFC03XKs2CrpQZy6oA3XtfDhSVL++MXO31of47OHG7nS8pqvQTKBpQYO1CZWS9kQMGhYDJyKqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCUIqFwv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCUIqFwv"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so3558073a91.0
        for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778604672; x=1779209472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPRHRDUO4vrEmEE8ykEXGOBSQt0X0MvDaIKX5rnTdbk=;
        b=cCUIqFwvMq0+t3yhLtAGl1UaUFwt7BBZPKfWmRoNl3kIoaNn09DI7Mp4O3ia5yuBho
         yJG6x/S1AYks/GM97PXNafUDalYZlL4KM0x7CspVRusWezAj0LojusviVWPTIClBDi3K
         8bCZM3oBQVMSxumoEaQfQpiqFNlk3EiNG7SPITi4ub2SlbhMOsvO61NTybFoVe5km/gb
         HyfR1Hg+Sa7x2DPH1MVyGaOGobWUtF05Yw2+yoOgRXCFVqGVKUtCWkHugH1DRhDoGiwl
         vCC5WDwgrzG0agc5YZO/PSlgxG6UZ1azQ5QyhSaowNte74fXRbeg9eZmmCcvExSspz3a
         PtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778604672; x=1779209472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPRHRDUO4vrEmEE8ykEXGOBSQt0X0MvDaIKX5rnTdbk=;
        b=tP+BwbJEU9nuqrykQnzPi8rFDsiOO47qPkQRYOMbbbNmIaU9hN26ZBhO29r97otyFB
         lZ8b7AKpfq78bAHKPohpvP8GLRNmwv8qJEgNjccHF9djtHle3agOKWTGfoeZ2Ll2SZVz
         gxXywmgBZz8G5H9ShuaD4iqzxL1nxpqC3urpB9xLkOzLQPI60N3AujNcBaIaKqneqBBI
         OEp9W61DzM4IsVK19ACn0NcfXTWAjhdtEWp9N6D5l/SgP+YItC/e4wEwIARO1ZvrV7Zt
         32Xsoef2I/Xtr/EoGWM3P8g1i4MwkK8tafGOijgXPxnxQOvFHSwgHe79C45kn2ecPaFl
         Qg5A==
X-Forwarded-Encrypted: i=1; AFNElJ+OI+++zFxKGY8gOiLp0/orStfestjRdPkPOzznABHQP4kUgb/M8QutdY5KvRf9CLUK9vfHEX31Py5i@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEapmUB3no/kyOU3C3Qw+E6QEDVJiA0boNvWu8mGxXAvNfsEp
	jBkdAUAYA/nXeo+fBrMNMlCZ0Zj+cpZJqRcfoEVffL72MElYBjOUWgAP
X-Gm-Gg: Acq92OHatE+qzMQKqiB7fx1y3mXPnzXjPZP5NQ0BBRKVqFGnRyZptWXUx/JS10I7jaz
	+NKYvbTnPMG90haBPaEcbHzYcJY/DUHMAAfXZz3mzcjG0kHI6dOM0oO1Fda7AyXK38jNsNg57gm
	iJ1eyJvaupPoTnWCbURvpZorT92PB59/+LPzGeM67jjbt1DZ7prfZ0UE6lFJ5c60vpWi9WyBuGI
	I/Uq27q20z0FKyPiIR7ANlN2Jl2ARXpCgWMonnzJWGTTyWleBM4krBU31TOW5JoLkQks0Rz4Umz
	u+d5Axt8llwkMHpXR1ulzS+jDzv9bQqM2SLoxTV5RU9l7K9twcM0r+jhi4qusUTUChlsstBVydP
	IGaUeiEXRHYStm7PFO59g/8KZ//xTgYObgWOJP9bMo1KvNSV4trOmaYZfu4+i15XAwRqSgcXbuX
	/q58UiJs95o06yTqe4QeXCFRRfwhvYFXObHIvOKVaD+Pxppl0c+wOUInA66ZN25mvbhA==
X-Received: by 2002:a17:90b:3808:b0:368:cff1:ed99 with SMTP id 98e67ed59e1d1-368cff20420mr2594994a91.18.1778604672432;
        Tue, 12 May 2026 09:51:12 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826768a27fsm12673787a12.12.2026.05.12.09.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:51:11 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: mdf@kernel.org,
	yilun.xu@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: trix@redhat.com,
	s.trumtrar@pengutronix.de,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com
Subject: [PATCH] dt-bindings: fpga: altr,socfpga-fpga-mgr: convert to DT schema
Date: Tue, 12 May 2026 16:50:58 +0000
Message-ID: <20260512165058.64049-1-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Altera SoCFPGA FPGA Manager bindings from text
format to YAML schema.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
---
 .../bindings/fpga/altera-socfpga-fpga-mgr.txt | 17 --------
 .../bindings/fpga/altr,socfpga-fpga-mgr.yaml  | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-socfpga-fpga-mgr.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr.yaml

diff --git a/Documentation/devicetree/bindings/fpga/altera-socfpga-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/altera-socfpga-fpga-mgr.txt
deleted file mode 100644
index d52f3340414d..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-socfpga-fpga-mgr.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Altera SOCFPGA FPGA Manager
-
-Required properties:
-- compatible : should contain "altr,socfpga-fpga-mgr"
-- reg        : base address and size for memory mapped io.
-               - The first index is for FPGA manager register access.
-               - The second index is for writing FPGA configuration data.
-- interrupts : interrupt for the FPGA Manager device.
-
-Example:
-
-	hps_0_fpgamgr: fpgamgr@ff706000 {
-		compatible = "altr,socfpga-fpga-mgr";
-		reg = <0xFF706000 0x1000
-		       0xFFB90000 0x1000>;
-		interrupts = <0 175 4>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr.yaml
new file mode 100644
index 000000000000..d09d552dde5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altr,socfpga-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA FPGA Manager
+
+maintainers:
+  - Steffen Trumtrar <s.trumtrar@pengutronix.de>
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    const: altr,socfpga-fpga-mgr
+
+  reg:
+    items:
+      - description: FPGA manager register access
+      - description: Writing FPGA configuration data
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    fpgamgr@ff706000 {
+        compatible = "altr,socfpga-fpga-mgr";
+        reg = <0xff706000 0x1000>,
+              <0xffb90000 0x1000>;
+        interrupts = <0 175 4>;
+    };
-- 
2.43.0

