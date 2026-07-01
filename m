Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD43EF0DC
	for <linux-fpga@vger.kernel.org>; Wed,  1 Jul 2026 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898021; cv=none; b=p96gYBf18LqkxL0juZnLxCWtVgJmoQNRYGJJzy0kJp3p3VjLAiAnKGaTbIzJz1CK0xtShjd7JYsBE4l7X+Y7lAO4O29Y2TjKMMPZHX1c6YdocVAhI5rFBHRROFCL81x8fHEOGoW8IJ1KD8LGZkKNDQO4fw25WU4ZOZzQRFH7Hr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898021; c=relaxed/simple;
	bh=tdHKaWa0Gt4+LZ4Wk7MfneHiBviRjXEooHrfKoQ+v7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAhBuk4bbegg01/tpDR6RVS3c5WwhD3iFpxlnhSeMHdA2KUkII6UwMeOASXcdjUYBPmUVuOGS+LbJvt6F6+X2x2dKfAeRN36qS8RLwmDxzYpMJzOs4a+OcnFjayZG7a+P4sMIkz7iFS/jHo+GtfGwJDWo2HgFVXst6eOLt4Dhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFeXFDH+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFeXFDH+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c99672293cso2705075ad.2
        for <linux-fpga@vger.kernel.org>; Wed, 01 Jul 2026 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782898018; x=1783502818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b1WR74p3+F3IkoziGHyid7Q9TSWQf8pWT/tkboKzlew=;
        b=oFeXFDH+YYS/BGChorJN1uPTVz/cxEET/eQUrY5mOTEtxwhBWyBZnXXkmjT33IiRgb
         ekhgAjCpg5eTCXlAMewYktCFV9sw3VBbbi+9jajjpOfq4aRq0ZAa5Tc8UHWo74js0s3k
         DHti43mkIhrm4e+LmT6ewb53rcpPswNUp9OAxeUWqbJyHODejQqz2UQpQeZ2N2cGkaoD
         vf7sQQcgB/NR1Jn9fRPeNEIRCL++HXE5akLbZ7KTDmMiDEEIf/ZjiDXuq6+HSijZtYiK
         /jlylRhD5SatM4VdvONr7rHqsFaIL04ybafIqTLSO87yA1VJBBautMs2+8BtVBwiFDE+
         FR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898018; x=1783502818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1WR74p3+F3IkoziGHyid7Q9TSWQf8pWT/tkboKzlew=;
        b=FZoFzT7TYtDFksYPQ0rsGVVxxX1TP4pY2YPeTSYj3SgTal7v4QyG6BYMB/9JP55Eje
         3e3h4+Kpy/sRhJR/gz2dA99TqsqoVeXf/4HOEz0sopzWq8OJ0kRocwEzUjalDsgB3AS8
         0TTtzxo2Kh+I4Sc0sBzS6J4yam+anyHAlUh989cPt3njSQMty7X3Zhoc3cX53avKa0x3
         jwij7O0KlVNKY2P/6TsvVC1pXWVkSfJ114NUl07d7GoE735xUjwIyJmSijcs/kBoZtY/
         2MXjhqWh4QRj1L3i/tnFqpvHp0RT0zGQoUDhCO0VMTUBMV5AnoFKvbmj7ROOGuIHlJzl
         n73w==
X-Gm-Message-State: AOJu0YyPCVEDOAV3sxpm2U9Egeqr7W3F8ugQiSV0yPDQU5QyjzPsk8mQ
	u3Va+M88AiMX0qlhlUyU1YfE3QW9LWAKQQbivXo+tGdug39fqRUAcMC0
X-Gm-Gg: AfdE7ckIvJK9IIF19Z6Kksrv+yCubwFQKT1x9ityBBWvFZQ8pr9+YsrzGrdsKF/W0Xv
	wZO7TIdwuyvkjNl5GcO2PZ67A3y2ywRC6Ob0H09Ym3LjjcN7P2YFjV3LmdBfETkUzaU92jm1/a1
	xlIWJRvYkM54jAWPTkgDpJdtAT22168cnjYu51PS5itjjhaA4kWizeSRT9Lc59Gnz5QGTvy7ejh
	SbJPt8HFvNcjHO40uQ3R4V/L37nY0W6P/oaCO00N8v+bA+M9wKyLA9Tci8N2cstJ6S+JNNpKuk0
	4jpqQKJL0xg/eLQZrYtk7Q8PsqaIC+2MhIeYXLjAqA0Wy3dJOsJIvCS1zXUkx1/J4y7YZbYyZle
	1yS+FKuP+AcVLvrxVDGETJkRaSIbH+qWNEyKRwDW/9Fe+f/OQ+LxwScL3ozaRaFqdIWAtq0wS0M
	fWJLV6MZDQx7i7o3TU0DgmUZWHm34kwMYkMXF/5eoQ
X-Received: by 2002:a17:902:ecc6:b0:2c9:fa31:84f9 with SMTP id d9443c01a7336-2ca7e682af0mr8905515ad.5.1782898017723;
        Wed, 01 Jul 2026 02:26:57 -0700 (PDT)
Received: from trigkey (FL1-133-202-37-214.tky.mesh.ad.jp. [133.202.37.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca6853f616sm11138795ad.37.2026.07.01.02.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:26:57 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: yilun.xu@intel.com,
	mdf@kernel.org,
	trix@redhat.com
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daisuke Matsuda <dskmtsd@gmail.com>,
	Daisuke Matsuda <matsuda@preferred.jp>
Subject: [PATCH 1/2] fpga: altera-cvp: Avoid out-of-bounds read in trailing byte write
Date: Wed,  1 Jul 2026 09:26:32 +0000
Message-ID: <20260701092633.5146-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daisuke Matsuda <matsuda@preferred.jp>

The trailing byte path in altera_cvp_send_block() dereferences a u32
pointer even when only 1-3 bytes remain in the input buffer. If the buffer
ends at a page or scatterlist boundary, this can read past the valid image
data and fault.

Copy the remaining bytes into a zero-initialized u32 before writing the
final word so only valid bytes are read from the input buffer.

Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
Signed-off-by: Daisuke Matsuda <matsuda@preferred.jp>
---
 drivers/fpga/altera-cvp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 44badfd11e1b..c00292370a8e 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #define CVP_BAR		0	/* BAR used for data transfer in memory mode */
 #define CVP_DUMMY_WR	244	/* dummy writes to clear CvP state machine */
@@ -261,7 +262,7 @@ static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
 static int altera_cvp_send_block(struct altera_cvp_conf *conf,
 				 const u32 *data, size_t len)
 {
-	u32 mask, words = len / sizeof(u32);
+	u32 word, words = len / sizeof(u32);
 	int i, remainder;
 
 	for (i = 0; i < words; i++)
@@ -270,9 +271,9 @@ static int altera_cvp_send_block(struct altera_cvp_conf *conf,
 	/* write up to 3 trailing bytes, if any */
 	remainder = len % sizeof(u32);
 	if (remainder) {
-		mask = BIT(remainder * 8) - 1;
-		if (mask)
-			conf->write_data(conf, *data & mask);
+		word = 0;
+		memcpy(&word, data, remainder);
+		conf->write_data(conf, word);
 	}
 
 	return 0;
-- 
2.47.3

