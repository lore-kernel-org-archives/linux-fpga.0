Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2D3CF67A
	for <linux-fpga@vger.kernel.org>; Thu,  2 Apr 2026 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147004; cv=none; b=eukYKifNbu/of+l8cdFIQ51IYSJgyDp5g6wEBnCufza6VBdeiJ2P2wUl+N/Fk9KzowzHikMvWNj/nAgf7gJqCOiZ6PQZYTXCuGrDlvFVsZi6DZ+A7qJic5efDPuKz3U1FNZPRQJQm0UmF22BScHEWhE2sOTtoiWFGteHucCzKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147004; c=relaxed/simple;
	bh=3A9KGYgeMUK2GEJvMz06J7Dl9SaVyCfHnRlIITPKZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODsYXuNVAntidLqKXlk7jZCVW+w+HR4YfbqaXUiKkZcqyfA9EGuySJFeDouLbXxSF7UmZjvEo/DRxswpCezbZk5BI1DZne3600zVeahNxs3FALHbAH8X6uhvdt2osU2gxGMZ52OvLLUhgwfrkafiWBCsWtMVBkIae+FPCOOD5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3ENU/fA; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3ENU/fA"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ffe1c73287so362235137.3
        for <linux-fpga@vger.kernel.org>; Thu, 02 Apr 2026 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147000; x=1775751800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQdnjdTuHD1u/JHVHdnYj1E1ndYIkWP99vNZk5JKW3I=;
        b=I3ENU/fAUva9w93Mmo9L4LlCOgyK5ppccR+W7kakCDRCFbM8WuAxHRvQbL3RwmgPjX
         LNn+FRE3A9WMVrEh3//tgjzYl5qT4z1nMaDIgl8obYuoxBoIAaqLlwqxIyoLrEAvbKLz
         v3a5O/3OvNTcHivZIjeDbDG6ZspYyZHxUlpokbXqHymptpstd5l7EGmdxY0WIvxzpPZ5
         Bt85BbFUt3FHa8G4zMR+zWbBVJpWdjAEJPAin5J5hekF5hlOAW8JBb+pgrD90yzFZ746
         4tcts7oOYhfSgb2Z4jYvCNPho30WormOff1h6GWrEn94RP/FlqBG2ar2qdG277LzUDa4
         M6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147000; x=1775751800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQdnjdTuHD1u/JHVHdnYj1E1ndYIkWP99vNZk5JKW3I=;
        b=ZD2Fn0XJd8Q8H0FQKumZg1da2hNMB99ZMs+Wy2AMOppMGHvE7tZ2mGSpTxZOY5AlV6
         JhiJfA1paPWfsJ/x8t2S0DHKdl3piAirNjO7hqbCEA6/rPkSEM+JAeM+BDNQIj3lHXKm
         6DX6P8BP/jEtelfOWSpb3VmqLm/cEU5FanrMJDiYCWwsPkChxKLap0jesH6rWmH5sWbV
         MEK+BNbsjaN2dp5bD6JJMTp/VT0M4rQDCY2cl+uU4X6mVUe/3pVCC5QypBNo2sNn7dqM
         Vg8xiSDLK+ufXr3BM2kBd5GZ2LkjAf2n1UEyWO3OohcS1S0HE5KBRWstkU8doD8cXM7Q
         DkzA==
X-Gm-Message-State: AOJu0YwzFsIMzwi4PqMzgKl3KLOmadF3kOpXqeAbYMerPj3XJgRzORuD
	571xMBiYjDH5Xqd3fKivstZ/g9kZ8sZqGP9Ut4YE9mpj537wGu/hmenOOAYFopPr1TkUaDor
X-Gm-Gg: ATEYQzwbYWabCZap6smb3wQxj5Q/H6up8RIyfsUUbASbiidLn88qRc0TNHxEUx9gS0c
	kVfbhYFRWZ+GmUoW7w2FMdE9AWtb1cSipYGeVr+4bugFJizUrYalsntK65F7KFOtDk53sfcGLM9
	CjhMG9WH6DWDSCii6SDFoM5JOafPWTczHFbmX42E0E75Yf1+tpWmbIHmNwGGMallvpNSLOOrIon
	PhhxEKXtaO4ZgfSxC19syuIBlop8lu2Kk4LnKqkVQSuLv7ibUyeW8tC+k0u9mbhQKU77NMeu4Xo
	hVgWoK7Gtp1KI0JRBt1ZPK1MGRXU/MojeFqSH9s8QAqkjRA64MHO+LvGQcYNHpwQdYI41kRCTCC
	Y3iYSVvynQzIOTqW434seg7lL83SRy1rVHa4LoMqbsNCCGmXxa3H17zLk80cEzYulSazWze5BDJ
	uidQL/P5+LZkrea53NVsEJGOl7
X-Received: by 2002:a05:6102:b14:b0:602:9b21:eee7 with SMTP id ada2fe7eead31-605682b9af3mr3456400137.35.1775147000487;
        Thu, 02 Apr 2026 09:23:20 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d70:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fba6da8bsm3648919241.10.2026.04.02.09.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:23:18 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
Date: Thu,  2 Apr 2026 10:23:01 -0600
Message-ID: <20260402162302.3804617-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125446.3776153-3-sebasjosue84@gmail.com>
References: <20260402125446.3776153-3-sebasjosue84@gmail.com>
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

1. There is no check that count is large enough to read header_size
   at MPF_HEADER_SIZE_OFFSET (24). Add a minimum count check.

2. When header_size (u8 from file) is 0, the expression
   *(buf + header_size - 1) reads one byte before the buffer.
   Return -EINVAL since retrying with a larger buffer cannot fix
   a zero header_size.

3. In the block lookup loop, block_id_offset and block_start_offset
   advance by MPF_LOOKUP_TABLE_RECORD_SIZE (9) each iteration with
   blocks_num (u8) controlling the count. With a small buffer, these
   offsets exceed count, causing OOB reads via get_unaligned_le32().
   Return -EAGAIN with updated header_size so the retry mechanism
   can request a larger buffer.

4. components_num is read from MPF_DATA_SIZE_OFFSET without checking
   that the offset is within bounds. Add a bounds check.

5. components_size_start (from file) and component_size_byte_num
   (derived from components_num, u16 from file) are used as offsets
   into buf without validation. On 32-bit architectures, their sum
   could overflow, bypassing the bounds check. Add an overflow check
   before the bounds comparison.

Add bounds checks for all five cases.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v3:
  - Add overflow check for 32-bit architectures in component size loop
  - Add bounds check for MPF_DATA_SIZE_OFFSET read
  - Update info->header_size before returning -EAGAIN in block loop
    so the retry mechanism can request a larger buffer

Changes in v2:
  - Return -EINVAL instead of -EAGAIN for header_size == 0
  - Return -EAGAIN instead of -EINVAL in block lookup loop
  - Add count check before reading at MPF_HEADER_SIZE_OFFSET
 drivers/fpga/microchip-spi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea..10be986 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -115,7 +115,13 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 		return -EINVAL;
 	}
 
+	if (count < MPF_HEADER_SIZE_OFFSET + 1)
+		return -EINVAL;
+
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
+	if (!header_size)
+		return -EINVAL;
+
 	if (header_size > count) {
 		info->header_size = header_size;
 		return -EAGAIN;
@@ -139,6 +145,12 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	bitstream_start = 0;
 
 	while (blocks_num--) {
+		if (block_id_offset >= count ||
+		    block_start_offset + sizeof(u32) > count) {
+			info->header_size = block_start_offset + sizeof(u32);
+			return -EAGAIN;
+		}
+
 		block_id = *(buf + block_id_offset);
 		block_start = get_unaligned_le32(buf + block_start_offset);
 
@@ -175,6 +187,9 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	 * to each other. Image header should be extended by now up to where
 	 * actual bitstream starts, so no need for overflow check anymore.
 	 */
+	if (MPF_DATA_SIZE_OFFSET + sizeof(u16) > count)
+		return -EINVAL;
+
 	components_num = get_unaligned_le16(buf + MPF_DATA_SIZE_OFFSET);
 
 	for (i = 0; i < components_num; i++) {
@@ -183,6 +198,11 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 		component_size_byte_off =
 			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
 
+		if (components_size_start + component_size_byte_num < components_size_start ||
+		    components_size_start + component_size_byte_num +
+		    sizeof(u32) > count)
+			return -EINVAL;
+
 		component_size = get_unaligned_le32(buf +
 						    components_size_start +
 						    component_size_byte_num);
-- 
2.43.0

