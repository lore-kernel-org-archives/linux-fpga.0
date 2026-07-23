Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073AC37DEA1
	for <linux-fpga@vger.kernel.org>; Thu, 23 Jul 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794794; cv=none; b=f1I/VTA/1NhXM4T1cToSCyYbCdap7lHzey9w17Dat9C7+mGop6lLHmGBD5dHoWjpc5wDmmica/JAl1Grjvg9ABzvaO/ON3q9omI7ynIz1wjh4EyW/hWeuq8snHJJBTUEoSIqYpdRNqwKeTz/Xocz0rARwOjxFtnIGL+3UIi8alQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794794; c=relaxed/simple;
	bh=bc4YnX0z3jLmmRhDroa4qW6sRydTM4BFM1W2fMArarg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDiCa30f1qufmD9cH6iGyyQI+iYrLgTgp7jPNit2sveIIEech2RX0whYVINfyj5qXZb2it3/LVyHgi71zOMgV+t8dpmI5JD6yZNa9MhgKpET7zvBAwb3oBclcIqlFssJEo+HQPkWLw3r5a3xLVwpmCHyWOYN4fGZg3KIMG2gxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkiulGnL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkiulGnL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caea3f742bso4650055ad.0
        for <linux-fpga@vger.kernel.org>; Thu, 23 Jul 2026 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784794792; x=1785399592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x5owuf45PkLHQwOgEYbAqO6t9FOV67kEeSuoKn/ZSBU=;
        b=OkiulGnLr9elSj2fBtddBXha8tVEUSbBNZ2K1KSkUZ/A6+6D7+sATqkX8xXel3ijLT
         RfCreUeI/oXm6ZWvBJ/1+oNDdBvCxnq9CjvVulwXuzdEGB166TCQ0VZMK5iWzVb9Ht2P
         50ku49OAlrTSpW5fov4ZeJLvxEKgGvkxrpWnXHqd+Ry+DX6OOZFNXTU8hvgWTbZLQvfJ
         +LQBcbZ6P4RwFcl0+FgVNHe41BhyILHfaystG9Tf+kVdv83SWB0oD+gwSxGmQ0hwk+3o
         mCeDFAVTUy3AOkqtcV013TOugPCQI46Pr7M2fRfsKbyciJ1eoWUnnk94eY6ZKFuvRWPE
         mUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784794792; x=1785399592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x5owuf45PkLHQwOgEYbAqO6t9FOV67kEeSuoKn/ZSBU=;
        b=QPdgYJutlConMeyYhrspT1CQLkP0Cj9wUnqJ0Uvw93PxEJZDEEqBFWtWRDjrtQho61
         nIVY4ALa+Lhr3tLgkRFgTwSLHrSZroreu6dysqPyqd7bC4i32N7AI5IyjLd6IwXFzfzF
         2YTXy3q3mHXcVwAnlgQt2lNqACd4wqBQp9u6ON3j+J77tJPH8GfeDwnBTIHRZQ/EahCL
         IgFFdHhRnhMzmfW6V8LFN705ejgIPr/HSunGeogoyf8upftejQWiWVUNvBZrB0AYhpkG
         QixRYTklwAPiM/WHOU3t8aX0ryIGmw48fwvhHwOf7WFA/xEEi6JH0yeyPc+mMLqgsixE
         btbg==
X-Forwarded-Encrypted: i=1; AHgh+RrbzY2pH/sZmcTvo1oDHVjwqKwIv+Ud2hEj5fsFSmWzkg3ELaj3GW23rQ6kNDY+ufbSS6KCdqtM2AXY@vger.kernel.org
X-Gm-Message-State: AOJu0YziDHDQkdozsO/szcCPMpXQ0+Imo8cL9u0bzcIR8RCyLiL1IMJ8
	rKZuMFXvRmAHeYgxFpMdrdoKnd3Vk5/px4syKisZCJGTSOJF9JHp2jHu
X-Gm-Gg: AR+sD12SvuWRs4MDVzPJjB0K9SxVITslhYKuekN1mzzs/ZlaXgIJcrUyy85FFT8pi3D
	t/nl8/U0LPoQM1dzZv6miQB+Xfk6qtLSlxUK634cutXm8CGh8x7Z95Wz3W26UP3aLvBy2u493QO
	m+cbGmEV0e3ihq2W6F1vSg9Bd+L9gVYhfvACWlLmwSTTQrGZdzbCQVKXgE9ehXDwiPpz2p/UGik
	q3MdFCRNMp3aWhyzKvSUHU4yWoJOvmYtr2CLgBO4DcTVbFtEqbgzxsKTYxaTUy/Jsr/ZWhvUBfJ
	EifsDTm+VNbut/SLR6JZM20b4CAjR+Y3X/l3cXzRXl3u7+EiA4cpE6d+uWjEeR9aFfYF9oUxa/8
	/5ABzVrQYGBdqAvdSuSicDx2jFmHpomnNLVC0o0WJAqmAQIvDmJ0slsSs+HWfQkIaKJYibRrYFX
	Gg1Mr5otuwbcpVGLw+a9qbuP1Q73VDTQ==
X-Received: by 2002:a17:902:ce05:b0:2ca:ef16:8e8 with SMTP id d9443c01a7336-2cfa708d1f0mr25368575ad.29.1784794792208;
        Thu, 23 Jul 2026 01:19:52 -0700 (PDT)
Received: from trigkey (FL1-133-202-37-214.tky.mesh.ad.jp. [133.202.37.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd76c4sm29740865ad.23.2026.07.23.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:19:51 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: yilun.xu@intel.com
Cc: mdf@kernel.org,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	Daisuke Matsuda <dskmtsd@gmail.com>,
	Daisuke Matsuda <matsuda@preferred.jp>
Subject: [PATCH v2] fpga: altera-cvp: Avoid out-of-bounds read in trailing byte write
Date: Thu, 23 Jul 2026 08:19:12 +0000
Message-ID: <20260723081912.74082-1-dskmtsd@gmail.com>
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
v2:
- Move the declaration of 'word' into the trailing-byte block as suggested by Yilun.

 drivers/fpga/altera-cvp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 44badfd11e1b..070c025ee215 100644
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
+	u32 words = len / sizeof(u32);
 	int i, remainder;
 
 	for (i = 0; i < words; i++)
@@ -270,9 +271,10 @@ static int altera_cvp_send_block(struct altera_cvp_conf *conf,
 	/* write up to 3 trailing bytes, if any */
 	remainder = len % sizeof(u32);
 	if (remainder) {
-		mask = BIT(remainder * 8) - 1;
-		if (mask)
-			conf->write_data(conf, *data & mask);
+		u32 word = 0;
+
+		memcpy(&word, data, remainder);
+		conf->write_data(conf, word);
 	}
 
 	return 0;
-- 
2.47.3

