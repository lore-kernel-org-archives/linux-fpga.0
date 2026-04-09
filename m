Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A12857C7;
	Thu,  9 Apr 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737247; cv=none; b=tpBUfeVRkbvysU0k1bMc2W1P2XFVLqkBucjcKZRDPSDA6WHnMB2A8sBgdEceXn2aC7BGHdaItc/NLDWPev9bS5IMW7zDf21Teysk+3aBbppEtvgYknoHHqCWiJoXc8o/KFzT2WjLBAd63QWXGq/FfTp2mkTLV554fq6OcBgCcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737247; c=relaxed/simple;
	bh=nHrfKi4UPCBf1Noha5/iA8Q1iNkJLlLzxhiUzUmvBN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjHIS99y54H4t6Tk0y7+XuJEYTeIEl4aSlRQ29VQ4FnKhqaI346VOjRNtI9pMXOswT18dWc3BL/AX6tpBQWMMmQRDKkn0zW7IGxCvBauIhiBO+loW6mM5pPphWOkbtvv8xOuIIS2fBj1LHoghPEOuNZWZzs2xE3IonPpeZwn1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=DoGXEVSf; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="DoGXEVSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1775737237;
	bh=nHrfKi4UPCBf1Noha5/iA8Q1iNkJLlLzxhiUzUmvBN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DoGXEVSfgDheIOXovz6GeSVNMgpL0CkDE2SbdhMw0gjThjaouAZSfPdGpl/gAEZ1e
	 47Ua5tld+MtZgVP/O7Sr/2Q0xwLN0PYLWWLJMhDzFeg1WnTEKtc8qiTrldmW6WIhwt
	 gM+hivPCyuheJNlRb4cgMtktrvGhX83P9xqI1d/E=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 2DB92BE5E1;
	Thu,  9 Apr 2026 12:20:37 +0000 (UTC)
Received: from cheetah.homenet.philpem.me.uk (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id CA7695FC3E;
	Thu,  9 Apr 2026 13:20:36 +0100 (BST)
From: Phil Pemberton <philpem@philpem.me.uk>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Tom Rix <trix@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Phil Pemberton <philpem@philpem.me.uk>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: fpga: Add Technologic Systems TS-7300 FPGA Manager
Date: Thu,  9 Apr 2026 13:20:15 +0100
Message-ID: <20260409122016.3940462-2-philpem@philpem.me.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409122016.3940462-1-philpem@philpem.me.uk>
References: <20260409122016.3940462-1-philpem@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the Altera Cyclone II FPGA
found on Technologic Systems (now EmbeddedTS) TS-7300 boards, programmed
via the memory-mapped interface in the CPLD.

Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../fpga/technologic,ts7300-fpga.yaml         | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/technologic,ts7300-fpga.yaml

diff --git a/Documentation/devicetree/bindings/fpga/technologic,ts7300-fpga.yaml b/Documentation/devicetree/bindings/fpga/technologic,ts7300-fpga.yaml
new file mode 100644
index 000000000000..c93e3a1a135b
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/technologic,ts7300-fpga.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/technologic,ts7300-fpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Technologic Systems TS-7300 FPGA Manager
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+description:
+  FPGA manager for the Altera Cyclone II FPGA on Technologic Systems
+  TS-7300 board. The FPGA is programmed via the memory-mapped interface
+  implemented in the CPLD.
+
+properties:
+  compatible:
+    const: technologic,ts7300-fpga
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
+    fpga-mgr@13c00000 {
+        compatible = "technologic,ts7300-fpga";
+        reg = <0x13c00000 0x2>;
+    };
+...
-- 
2.43.0

