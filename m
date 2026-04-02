Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBF348883
	for <linux-fpga@vger.kernel.org>; Thu,  2 Apr 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144294; cv=none; b=E03eOjR67nQJEdOCRNpiz2r21WthsBtbc/v+TL494n1M00QC5/Ckh102uvTCR/2dHFbdCBhhKiJADLWUFOWrrEtwPhVwJ7G8UdDXBsruPC8TEipfbZBwTtASKRh6kiU7c20Ff2Os19qbsFS2fvpGYKv6a5M+ip4suzrPJdlRsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144294; c=relaxed/simple;
	bh=AUcfU7ozLC1fJxQaa8e9OfGKpGskpsFLA2RJUD+6vuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egVcT0OwnJLPZGtkJDNNKxRNP5iDKhp+AZ55oNW9rl1f5cZFQ5AftH0aiHkVkTVNebqqgAyywYpsWMsNFcYvq7KvFNEYM4C13kAfpAjpL2vIRlPEOjl3+NjdYCoMhukYfO1KJG1QuQiHKFuVCgOuJ8LKkGPVHi0ar+bvOaqwR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMiyVePK; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMiyVePK"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-605590b7687so305065137.0
        for <linux-fpga@vger.kernel.org>; Thu, 02 Apr 2026 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775144292; x=1775749092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwEOZMEaU0+lFHsy/ODF1F7HIytWIXRTEWV+IDHWPtY=;
        b=pMiyVePKlHzqWtBzxIZbOEbTL5/8ew2aubm/vS52ZhvHAhvR+1Y8dc71j45jtstHOl
         0RiF+wvkqDHI/ItGlBmqlUp+8Z+42TlpFW90fIRLX8BLhdkZfybsLzmSQ0QlAYIWcebO
         8VAybTUy1aZDsaR3D5TLinC4uf+JdJVwXj0Ew4v368HJjnC9toqScG/UI7F5Ukvmh5Eo
         j7P/TrQR7J3aSnWZI4FiMQde15gvG+VEQ9JZynnH22hQXcx50KkIW2D06FSu9DtcAAFm
         m+R7Ez9SWdAyva4Od/vg0ro8vqpJSghSukf5tRsBmtSIIIB5/8aiY/Xzkv78lqeiDmWY
         emsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775144292; x=1775749092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwEOZMEaU0+lFHsy/ODF1F7HIytWIXRTEWV+IDHWPtY=;
        b=q7+blLttMCmiJa8W0QobqfbhpDuki3ZFnOfabpRWlVmFuwiKV1A9weWO7hA4hxRsES
         +jBBJOuEhIKjPNrcbklS5/sE8ATlDNz6/a/G2dBhr2umKrKCfIltRTHuekqynZS4wXim
         g5Y9RgSmBFsp5ObyevE04LTcGZCH28oacwW73mAEqVjTNzsAVkQdy/Y8pjlg/fjEaJEU
         bEYrtTwmjljl7QobnBl4rlUUOhvhj7YxI1xm3STy4O+ZCzacFqRlQ3rJljlfnq/0HKnE
         n+zl8e208aplZ1cTpZvYlsgiA7NeLzTVb15a+9bCMJ5LKQOeafW6AWjcS58Z/wrR9C3U
         X5PA==
X-Gm-Message-State: AOJu0Yw7LIUY46fQzz6RWNIH9I+GkgKYn5CWaKscnWl/Iq0YKvteZCdf
	awOBHEh9NkFsqJe3JuieS64nJHLkPhDJfuJb7zGOLwKBTCPVYttzof2YhynvDSxEqhIQqA==
X-Gm-Gg: ATEYQzzqDIKg/cm/1bZjklfGaQVz/+8rMhixdoxAZ2KQW6tR4yXpwVj4WWrLqYWoYbv
	LBMcXYmHahl8tjKndJAiFcsLWkenlCulB4176cu9nHE1rfXDMdoAKURFZPzGpbbz2CztX6I102g
	KgG9jcM0+9VEwERtRXyUT8gQXhfPFl0Vy0F3lujHCC4F5XkbmAhS4hRIhEZGJ2CltlBy0EK+BoY
	EvLtcWz5K/u/TzvPlW42Ch5wTHm7NFjXFRIucQfHZdiZsjhLZXYPmQDhNBR9Tn7f3jIT9F0DiqH
	eLcxZWXMRfuhEoc+N0jOGcpVcSe4z2WVq178X0wv8SQgDkyGO3U2scJndRfHsSdZ9MEE5rYgXcJ
	ra+woi43H4k8KE8TTelsX4lG2D3rXZTYsCKPbz2VmKgWBDhBbv3UsSMsfR1jh4eYj3qkWfuNfnC
	1DHGRlpU2+utcuUiImVA80IwP1
X-Received: by 2002:a05:6102:4492:b0:5ff:f366:dbe1 with SMTP id ada2fe7eead31-60567e7ef70mr3209136137.15.1775144291611;
        Thu, 02 Apr 2026 08:38:11 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d72:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e1d1edsm4103633137.1.2026.04.02.08.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:38:10 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
Date: Thu,  2 Apr 2026 09:37:52 -0600
Message-ID: <20260402153752.3793055-1-sebasjosue84@gmail.com>
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
   Return -EAGAIN since a larger buffer may resolve the issue.

4. components_size_start (from file) and component_size_byte_num
   (derived from components_num, u16 from file) are used as offsets
   into buf without validation, allowing arbitrary OOB reads.

Add bounds checks for all four cases.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 drivers/fpga/microchip-spi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea..00fa2d6 100644
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
@@ -139,6 +145,10 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	bitstream_start = 0;
 
 	while (blocks_num--) {
+		if (block_id_offset >= count ||
+		    block_start_offset + sizeof(u32) > count)
+			return -EAGAIN;
+
 		block_id = *(buf + block_id_offset);
 		block_start = get_unaligned_le32(buf + block_start_offset);
 
@@ -183,6 +193,10 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
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

