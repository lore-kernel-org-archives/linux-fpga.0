Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925A3B9607
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570793; cv=none; b=BIXSVAbGke3ZjSMMYMq9qmsj8LxiCTEK1Zto1yQ9zU5S2YL/3k6xTlULF6XHpILJeP09jqqYR1y37n44vGE9arWHCwnFirrR5AWZ/VAb1+Az+skNhaCiJ3+y8T51WBK4yBd85UmF43acDV6/eihkkJhKymsH2RtPx1wO5EyhkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570793; c=relaxed/simple;
	bh=yCOF9NIHRG2RRR8gjB6MF/3vecVWbHAdrOgCPcYdB5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmhqx5zD5V9bo92rsArOEWDQIdcsYompCzjt/Huw8p8ehool/p55E/cfdVNHIWirl2BwgGpToDIs1O9dm8J6dNo1IOWusZRX01pQYZKG92Veiw+m3C3y2Q2J1f3pFLxRs8Dl9Nu4ely9MFkSJmiQZNUW0ziIpoKgs5CzvKBx79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igQj9Qx+; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igQj9Qx+"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-604f1bfed92so4726276137.0
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775570791; x=1776175591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cnJhXHQf7uIWrznQwZx4iuuJLrGPih0M+p7FEUCw8E=;
        b=igQj9Qx+ojHyahMVQXEdXHFBUM5E05YGbzmwmuXJLtmjDeeBMkhqCABl+Qn4xPxpNY
         wLchJ2Jkj3dKrYG4tCfRV8SrKurBjGywFPfsBfc2rvF/nLfug+kvx8kMnJJ3pj6fqsED
         0iu8eEAb8q9mI35y1nL7efJx15IiiQRDhiCOgrXWq6Uyfhzo5+xYigcgyU63iUI+JiL9
         dTq8ezmuA9Xk5uL3IkK5a1mjBdkY0m819QZyRvv+55NsXbgEba9cTwfi0UgcxMN9rWmv
         6P9GqntKv6UvRPWSaVR4LQvKjmk4rMw7c/vik3xy4Vu8htUUdEERXS48kVhTzjq7bqOD
         +lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570791; x=1776175591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0cnJhXHQf7uIWrznQwZx4iuuJLrGPih0M+p7FEUCw8E=;
        b=j16eWfphNY+W9p42oEkc6AlHk2leMVt1y8sNGgijgpWi8foi2LVfVW7zgxmymtVLia
         oUEVZgMgMU6KejKveXPd/vi8qzQMU3jTnfDwjYDyK5cGGjTtOCfdjg3iZ110WxvJbVaL
         FrKyHTrjwGtChbODUDBZvoa29vCCnnT73asxzjbGCrRnFqtMSvUSX5c3DXgMeSodv7oN
         g+Xx6EYGIjLUEL9TuZMuLHSv0CC05mZSUwBhC6XfouqItpP/mfJAY6Hpc4wgs9JMJlYu
         qECsuQkfL9iG7o5qYtGxSO+sAs3xvkyEe0oU9C5D4oxXBfOUMWj/KMJJQytXTApcfQGR
         IUTA==
X-Gm-Message-State: AOJu0Ywtdp011Z7+2r22DnPeRPsE9gyQwPbaU4k9fhmnT50CrvBkd5UN
	LLo3H8k2dpdd7e6giXpzJ7d8jvrWj1ibTCcCeMsU9ZK1ZaCe/qYx4buX
X-Gm-Gg: AeBDievzU5VQLjW+PvsiDuCej2rkzSiijmqkYzUNIwGvnsTPYAu5YTCw347TIcaoXP2
	DvfOV23jymT/Aune9ICbbizINyKQmYrkx//FZOzcuTws8Nl5T0czB1XcAUpYDTRfey5ATL/J/Rg
	TY6Q3phNZLCe49aTeUpZsJfq/+VYYiXwbGVHE9KMHwcmTNqPVb7dqG37WoSO9pJDOpE/f0I6wNg
	Mnf4SssIq+zAy2JaZmDQ/CVwfEqm1HhmwV0h+Xnht5Sf77u+gKxQXgvueggR7ooYlvPvCInVixu
	ZQjAp9F8A3Isol0mDZtRm7TnWXXgICFi/ynZDdvzn/dSMbWw26V8fWWGnpqhc3f58hjeY3Je0mW
	kGJvP+LugHu4S9vcmCyjYNPVLzsAymDgkHElYyQV/F+nYpSN8krLtjLPjRMtyvZ5Oj74D0GecUH
	Er0bnkvcU3WWH5Cc4tpHeL6N8=
X-Received: by 2002:a05:6102:e0a:b0:605:218d:ae0f with SMTP id ada2fe7eead31-605a5050bf8mr6961394137.18.1775570790454;
        Tue, 07 Apr 2026 07:06:30 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d73:aa::11:1b5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6058304a726sm19814641137.9.2026.04.07.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:06:29 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2 3/3] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
Date: Tue,  7 Apr 2026 08:06:01 -0600
Message-ID: <20260407140601.15006-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407140601.15006-1-sebasjosue84@gmail.com>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
 <20260407140601.15006-1-sebasjosue84@gmail.com>
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

