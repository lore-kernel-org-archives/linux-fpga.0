Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D81351C04;
	Wed,  8 Apr 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667175; cv=none; b=OmGP3e5jE/D3Cn0X27S8VxSvXm6LLxqyWXBy7YkkPFSIW28u5zSxaE/MTldcB1ZcHBbyK2rapelYXukdMZWKznO5h3dntirFWTzwrwm2tSesT2LH4rHHsjhswMPR5CtsOv9SyBXJtA17ZUDXufN7BjA62wrh6ULRDvPJEI6iNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667175; c=relaxed/simple;
	bh=nSvAG6rd675zY4LThJE3UpB3biRRMUTLuDO1NJwB9h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VumsJKQVWwB895WEq61vqa93gISTIF0nvbtQyhP/fOamZhp9W6vvEgAr2EfC8sEIu01FZRUOPguu0I/IjABGJc9CpKI/3PsrBgJwhL4OXp4ohrN5oTAjInGMVQ2XHpbbdrel4A3Tm6XosWAt7StMDxdUL1p73CzGIZnqiV50+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=ofmNkPuY; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="ofmNkPuY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1775667172;
	bh=nSvAG6rd675zY4LThJE3UpB3biRRMUTLuDO1NJwB9h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofmNkPuYsqlHSasC9EFWeGxTAO2jxEpRT2GYvoea6LB3+aY4ro+XkhV6lkKxCGsSt
	 PhOlgD/aXvbFJZCB0OZqLGwRY+mHmHhYmI1BVmCRcrLvQSmLO/DvUW6jjfgry5ClJ2
	 5FPmMSahurI3/V2JeNisu+s+P1G4eKZcsCQ5cGXo=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 888E3BD6ED;
	Wed,  8 Apr 2026 16:52:52 +0000 (UTC)
Received: from cheetah.homenet.philpem.me.uk (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 4D9FE5F938;
	Wed,  8 Apr 2026 17:52:52 +0100 (BST)
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
	Phil Pemberton <philpem@philpem.me.uk>
Subject: [PATCH v2 1/2] dt-bindings: fpga: Technologic Systems TS-7300 FPGA Manager
Date: Wed,  8 Apr 2026 17:52:22 +0100
Message-ID: <20260408165223.3051759-2-philpem@philpem.me.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408165223.3051759-1-philpem@philpem.me.uk>
References: <20260408165223.3051759-1-philpem@philpem.me.uk>
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

