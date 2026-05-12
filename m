Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0F3803D2
	for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610044; cv=none; b=s2ZBgCoIlRz5IUHC1LHoBDyTzxj1SZ5AA3lqz3sdMUhzqsuvC5h1b3L3MFhm7gPOiOH2Np+RutT1PUAFYxSvQa3z72aeEzb4aOv+WnU13nfNkBA6Ai7+XkD50FGbevsdUMC31PcL7vLUXrFDJ9kl9+OrEHONn76yRDkhePsddcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610044; c=relaxed/simple;
	bh=pO8NlAmiTWkHmRBLgfiKkiU0z5nI5RLtmSmBflRQil0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hG3jGfe8rwQF4RwnqeUMOjnRnVgBVymogHsmrCAXSvR14pIozTg5S4Oss2Bc+o5Mca2OBd/Z5ur4A3yBpCBdp9MdQjWdG92sj5iLGytHwgcNMQCUQ0H2in5/BZNGn7++UNWw9BZmjonDzINsDLLEU2jeB1YZTZOD5vei91e1/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN/mtUVm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN/mtUVm"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8028fa6039so3877674a12.2
        for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778610043; x=1779214843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ofX8j/LRQqY8OmZou1joEHESeXuEQsIjw2iTr6XNHZk=;
        b=gN/mtUVmLIcvbdVIueQNlnvLHZfJVuBCNW1TbwvUhY5xpibncZaL1asYahRe+HZjlD
         iSOvDyl38MzQXDYhhTweT7tdlKd9F+a9GCxvcAu14CEmwMcifSUznO4XLBzHn9W7WoNL
         SMQSrmbzySeVe9mD2nq4U6j2Yb/ZdzR39/wTQDEOcJ9i766e8ypPYgoW20yltGypvP7q
         uwb0dDyOlHsKeYU/VK9sz5yeu5lrvFCPaoLKXWAk3ziGv/v/a3kpmfgEMt1x5izx5uyP
         +B4zYA+rFIzqEOShVL01yEsgh9p9FOiGV+mg+jlEnLtmQkCRqT9Z9gsEB7Rmf8IsHFqd
         57aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610043; x=1779214843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofX8j/LRQqY8OmZou1joEHESeXuEQsIjw2iTr6XNHZk=;
        b=qkGjxXta+0Psa6ypugtJaSFxTpqYJv7AsQeJ7huQlhD6tHBB9VsNgcHaYc71XL+nmy
         c82kf6AIxEZjdzV3Xp9y4x+1qNwPDn4QsasgaeyOmW3tbe6BWDTj408sA/VUE5FOvKz8
         JGgbJXkOGsVZ7nsJ9gLeKPzTI01Z2GGJMYPVyvnv6sxIs7078QCUmlyVFh59kpRqODHi
         yRnjnQCguJqtn21W9XJv1FhDUsc+ySdcJbYrnFHTPSYoR7yNqbF6g9Wz/HZrWcWTXW7g
         FkK40WxBRj7q8auDnO01Yp6AZNHYpdUe/CRIodDtMjVbay6hvspc7DZsWbOqBG5rai+3
         kMqg==
X-Forwarded-Encrypted: i=1; AFNElJ/SPqvHue6/1V/o6m3+XCId4x3qygNJP5tO8Y5LWUzfZYP5nJJfU22h/61CjB9DNEc8PeCttSL2wpSE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrx02HVY2eZThLKVX/3LMzvZmVVuJ3tQLB85LiWOkIDD1PNOXC
	36bqnt6i2bXd/IKFzmGnFcx1ybPO+8XnUC3U1wtPgWAukgi1jaFhcKxB
X-Gm-Gg: Acq92OGPT9krr9JcNfMG2m+WXnIbdCKcdrSfn6kXkQwT1CBRow9UaX3cfpmLViP6W+5
	egM+PeF4TmBWMQA03lmYPxhFotJicVIPj7LwOAEXDTXTsTwqrvksKpyWG1DiPqwZ/XOgXCtlyKj
	0BDXXn5zzXjBE0RvDtVSkTBplGpQ6ddV0v8mmVAEBKKqM6oKKxl/RyHsZSZ7zq5OQI9HT4roK1b
	QQu22VBTt1Xx7c2AqVMeqSmJUHEQzXk8cUSTNpENIeDPfYn6VqwTZ3GLvTVV4vrz+i/8Ak7FKhS
	xmIzQDM2kOj0bC6S/EvJKMhldP5nu5zbYE5CMc+eqhtI36DboozTJuZ65Et/UDqHAFg2Eh1/0Y0
	Gi1bIU4bumZK815iyxox+dYo1xkE6pxZ2RP+/DwdP/jrz0hCtTawdVXBmFpxMdSAObVP30v3Raw
	bf24Mlc5PvRUiSM3a+B/kRB/6+/b2UVK3PBAZkz+r8hdGhWbCM+4LS112rGJrpr+/TQJ1OElT+T
	xd2
X-Received: by 2002:a05:6a20:1590:b0:3a2:d79c:416d with SMTP id adf61e73a8af0-3ad99f243dfmr5200035637.43.1778610042797;
        Tue, 12 May 2026 11:20:42 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767bf53sm12478739a12.6.2026.05.12.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:20:42 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: conor+dt@kernel.org,
	mdf@kernel.org,
	yilun.xu@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: trix@redhat.com,
	s.trumtrar@pengutronix.de,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com
Subject: [PATCH v2] dt-bindings: fpga: altr,socfpga-fpga-mgr: convert to DT schema
Date: Tue, 12 May 2026 18:20:33 +0000
Message-ID: <20260512182033.66222-1-manishbaing2789@gmail.com>
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
Changes in v2:
- Removed Rob Herring from the maintainers list as per Conor's feedback.

 .../bindings/fpga/altera-socfpga-fpga-mgr.txt | 17 ---------
 .../bindings/fpga/altr,socfpga-fpga-mgr.yaml  | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
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
index 000000000000..9bcc1200d61d
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr.yaml
@@ -0,0 +1,38 @@
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

