Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5BB3BF69E
	for <linux-fpga@vger.kernel.org>; Thu,  2 Apr 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134534; cv=none; b=Td1Zogx/mVL8DsKRj50WXbLCVCX7BYeFCj3z0sPF6NT7QqPKvGJu97HqaSpBVyUnjmXo3Y7Ebybkw4k4eu4xZeOH/vH7CgvAGVbNjvcWWn1JXZq41rllBSIrGuivRZE2oKszUNWwGED2mGSFIDMy19o3akVtm0rlu2F9wL6ezrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134534; c=relaxed/simple;
	bh=yCOF9NIHRG2RRR8gjB6MF/3vecVWbHAdrOgCPcYdB5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SG4NDY60w8wt/3PUsqCCMbXncqSWNU8H2Vt7j/JG0Pq8hTP2Z2CdjUSZASdk7YcgkYbpw1JVHTG7GQatJwQ5cUCXuOIvjpTRIiWQ9tJfGgWDiEJK/6K88drknxW5HwCbjY3MKtydDUJr5OB8iYLQqKoCowFaMEMGt7FfNGkm2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFCzbwoI; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFCzbwoI"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56d357797acso621699e0c.1
        for <linux-fpga@vger.kernel.org>; Thu, 02 Apr 2026 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775134524; x=1775739324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cnJhXHQf7uIWrznQwZx4iuuJLrGPih0M+p7FEUCw8E=;
        b=jFCzbwoIKcuZI6r45Usqc8kVWp9YwCjhbE+e5+SCVIyg2iyJDS7yD/tkgZmfCB6+Ni
         UXu/7tcaEXV6An1TB3BuXJDf5KdwePxu3VAO/sznRC+f7Kr76l86PbZI+b6fFw8RNnKF
         z2xhh+S/QOiXU6KSwFbzNAzNigxto9HJsbSXpyOGLVX91aXcdELfMqoMP2vVmJy5j2mk
         WkjDyOA7ZktqeRwl5bYa5hlymTjyA2sZkuFFd3Hpfhm3raGCBZL/wsb5cE6m14cM8WNh
         PtUa9RvVs4kkMfh1sP5pFfqCDQR2DGImU8hFOi5qr/fjuDxLCkIOCXpyKSAGSAPgD7xJ
         CEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134524; x=1775739324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0cnJhXHQf7uIWrznQwZx4iuuJLrGPih0M+p7FEUCw8E=;
        b=sbI2yvSX9vF+Nxv7jb/eCh8968FYK5nU0TpBnpBARe4zMXjfFMcN3FvYhXaXFxuNdM
         O3V15Mweksq0qnLbhDRAR3qQQ+QGudIrqs2dOnhjO7N4B5XJy1W7g/H4/NMwU/tFi0Si
         5/i5ovJkzTMH/rzY18GwXJ4fYRbGDKuPZhjHoNuLjcA0ZrHT5ywkkUo/DJuxZNDEypnM
         5MToeB0+bR5wY8EGnwEURhLN4H5v+Gb/PqwCz/KRElPXPbYTFfMYapHp2YSOmjmqNW7U
         sJJDaIkmxSxDKUy/+YURCDFBSGXgszRLizRPDobO02KcLNI3GRmiQLE9rtDCrtQd36Pj
         c+lg==
X-Gm-Message-State: AOJu0Yz4bNYd+aFqEB+gS/PyJX8C9f8blsmlbLhWeWIRCT/qd+Fhe9Sl
	yoj9tTp9nkaHeymygpeAml+jqiGArolUDQ+N5esSgg9BmFfOT+djXcEYB8QsQ4Wu1A2DhM0m
X-Gm-Gg: ATEYQzx1q6pg5RcQwLr1ymgbqfEAZIpNlcLQm99pemkrrIUVlI0qbJrQJdGU9MSLhBB
	ran0WcnbcAqaKXTu3pTxFdPVENd+J01Kdyj9LYIVxpjPvGFzFbcG74ZVVj/stDV2+LYk6D3Ubfc
	Ku2NSn0fJ/tVA6hY+p7fj5U358O6uAjzhd/LHbz7V86JV4axYjMa6iPVtITu4+9L9TfBqdNwKS6
	HGliipjfKyXp29E2WM2Un3LTTalMqwqjYrmqQoVvo4zU+d9fmNU9D5m6yJVfWu1LcRGkkrdp4YR
	hwgUKm4qUoSjhJys8c47o+1sIx7CJDZloMlHJbZLG0qIMwLKlAXM9Bg6xDShJ5k1eA5JwOGSXXG
	ym9dV+wQ15Sh8cgcZScm4HUQgmnXfPXHj0273BX6QUyElSQ8z+S6Csojo6+O77O7V5MWPswNnZR
	qnjARd7/Bg2V0Rt4OY5dv4/sL0ere/yMCNSw==
X-Received: by 2002:a05:6122:698c:b0:55b:d85:5073 with SMTP id 71dfb90a1353d-56d8a834f8emr3573421e0c.4.1775134523627;
        Thu, 02 Apr 2026 05:55:23 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d73:aa::11:178])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fba6af44sm3080950241.8.2026.04.02.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:55:23 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH 3/3] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
Date: Thu,  2 Apr 2026 06:54:46 -0600
Message-ID: <20260402125446.3776153-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125446.3776153-1-sebasjosue84@gmail.com>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>

mpf_ops_parse_header() reads several fields from the bitstream file
and uses them as offsets and sizes without validating them against the
buffer size, leading to multiple out-of-bounds read vulnerabilities:

1. When header_size (u8 from file) is 0, the expression
   *(buf + header_size - 1) reads one byte before the buffer.

2. In the block lookup loop, block_id_offset and block_start_offset
   advance by MPF_LOOKUP_TABLE_RECORD_SIZE (9) each iteration with
   blocks_num (u8) controlling the count. With a small buffer, these
   offsets exceed count, causing OOB reads via get_unaligned_le32().

3. components_size_start (from file) and component_size_byte_num
   (derived from components_num, u16 from file) are used as offsets
   into buf without validation, allowing arbitrary OOB reads.

Add bounds checks for all three cases: reject header_size of 0,
validate offsets in the block lookup loop, and validate the component
size read offset.

Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 drivers/fpga/microchip-spi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea..7954dd0 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -116,7 +116,7 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	}
 
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
-	if (header_size > count) {
+	if (!header_size || header_size > count) {
 		info->header_size = header_size;
 		return -EAGAIN;
 	}
@@ -139,6 +139,10 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	bitstream_start = 0;
 
 	while (blocks_num--) {
+		if (block_id_offset >= count ||
+		    block_start_offset + sizeof(u32) > count)
+			return -EINVAL;
+
 		block_id = *(buf + block_id_offset);
 		block_start = get_unaligned_le32(buf + block_start_offset);
 
@@ -183,6 +187,10 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 		component_size_byte_off =
 			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
 
+		if (components_size_start + component_size_byte_num +
+		    sizeof(u32) > count)
+			return -EINVAL;
+
 		component_size = get_unaligned_le32(buf +
 						    components_size_start +
 						    component_size_byte_num);
-- 
2.43.0

