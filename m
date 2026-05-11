Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA76246AECC
	for <linux-fpga@vger.kernel.org>; Mon, 11 May 2026 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523187; cv=none; b=UonlNIjtCijnFHkEUqJURQn7nLdbkrY9/K6EsUG4DZE8YBhmWPAlHlOAmcXDUs5VHFNPIaVYCPShwhbsW4/Hpg9zRlBcRhadt2BQlfIvoSLUsDSU8dafFqSWZXYVvA23hh9NsvhEiF4CHn7CYku5YY8hNfKX/byguBYJ8tAlo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523187; c=relaxed/simple;
	bh=NoB36IZEgJkI+tMI6ftJrPQBlm4ipXplXUNXUgfnavI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udvd5y1kD/Pe72i+IGrxd7SzCJ/1VwG/+316DQTivXre9oCaIb0xzyBtQco2r78yL5fk1uwKSTRb6ZUpjUAXuo+LUXjlLETmveqbn8jfzVKw+truiSl8Auj6IrPCX9xw6JDcrQNXEkAucTZNMdZWXmgCSKqH5rKRUHdkmBsAb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yt4b7eD0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt4b7eD0"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c822652f82aso3289135a12.3
        for <linux-fpga@vger.kernel.org>; Mon, 11 May 2026 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523186; x=1779127986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wy4rHFR1J3QE23I1tHHT9S/ejRZhlJ7cxFAdJ8TxDZI=;
        b=Yt4b7eD06glAH5rwpSGp7HIVxoKPblWURLZCHdzR3WIHfnhEIav2hUwFgUxX+b+n2B
         0WfEVhY6UGOkIIbhsl3QTdHGIPYF868WF1IyYDSkiBee5uz6WKRHbKEop6WRCu1LHG4m
         ErVNyBGvU6wFF6FXJ1kxC/YHX5eFnaRZObEdSrpJdzS9QYkWr84FSY0r5oxWWQwNh7W3
         AORuPJVrGAVTjrs2Uj9navaNKDGxvwUqsGgD+OTwaDreONAQSYBIIplqMYbUo/55OaSv
         RsuqfR+ay1rPpmVubdsUtC765uoaRYVmmTO//lPAx+u4MYdt0kclB+YKO8y0G3Ok4lF0
         LoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523186; x=1779127986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy4rHFR1J3QE23I1tHHT9S/ejRZhlJ7cxFAdJ8TxDZI=;
        b=FL3KQn8XZyg/TS2gwYeHewmWryThutM63XhkNh2NdvSp2wCaSFmxYjAH8XlW5yPExP
         8HgAsYXjpN0NFfZ8/QZ1JfWZ9qMdzzjqn+/zjtQTeTNkZ2UNcFlNzSD6G5XMjgfRhiwI
         MzZXG1bcWK40lahvfq48RiUkh6HSzaAcr0b6jL+0DrqYhWxAGwIOlx16+GqpP6OvoeOu
         OrNlALUf3VkCfwUhFqM+j3sUmNzEhokqg6LHsO4VXWrXceQ6onZophZ9uQEgtYHWqgkz
         uwC+bdR3Y6VoTqwScVfoFMTHgkfjDCUZDQKDUgxzFljZPsLHs9tPKUfbkkVHPBtCa2k1
         XuGA==
X-Forwarded-Encrypted: i=1; AFNElJ/GSjMdmT6psEaL2rYdGRurAn4Vujl49gY3XCOr3GPb3/JbvFgKWXlmAX+IYzQ1c42IvbWGUr6qgZhN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2EmNw8Ky1zhz+/LaZZvf0GKMGk6HZCZDCuR11y9/9C59/bGg
	7gIxGY1k7I8WTilTbPCYVj98Z3+AAzj42IvMAJrzqDpT0LlkTQwpo4cX
X-Gm-Gg: Acq92OElxqkUdfynnE0rFNI8Q9iWuy54tx4HHdocxN8fvfnIkrBq1y5W9dP6bmmoDUJ
	E9/FBt+v1+Lj+sEuSupZdyZ2nrhl9AW/LYJQ0QWnkFERb8X8RWtQMKzPxo/SyQe5Ap9seSk3gRb
	aQ2E5y2J6GABDGBiPgxj7f555YIFi1ysn1mY1UJ7fgFPk8XELMw4qAnq10oPRzPUkexAHioeIwD
	l/OlKqzDwT0htsrCH+3UAdOl2HJnMgBVtsKUd/ByVpbRE/zo+5jKDYotRLrHEdXjzyl6c1B9EEb
	zDUv2TZKqXEOyH5Zius4VZ3sScQG0Ag/G3qoxekHVYfIf6V5T+v74rWSBoqyhCdswq/uvRsi0hL
	ysiY1eMKAnV/75Wn5MC/1Y8sMXHjV8UtgI/HT3Bs7z1RABNIj4iFQXvCR0MzlJCanTPPzrRuOHf
	InVkwItxhIrkPmjyuVlqD3rnSGM8Mq4dug4dmq
X-Received: by 2002:a05:6a20:9149:b0:3a1:f82e:b009 with SMTP id adf61e73a8af0-3aad42e2dc0mr11161186637.18.1778523185932;
        Mon, 11 May 2026 11:13:05 -0700 (PDT)
Received: from Strong10mede.domain.name ([122.161.50.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82675fb236sm9947993a12.0.2026.05.11.11.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:05 -0700 (PDT)
From: Mayur Kumar <kmayur809@gmail.com>
To: yilun.xu@intel.com,
	mdf@kernel.org
Cc: trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: [PATCH] fpga: dfl: afu: use kzalloc_obj over kzalloc with sizeof
Date: Mon, 11 May 2026 23:42:40 +0530
Message-Id: <20260511181240.223224-1-kmayur809@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpatch tool prefers the use of kzalloc_obj() as it provides
better type safety and conciseness compared to kzalloc() with
an explicit sizeof().

Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 87652d58d03..8a9d705ebe3 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -316,7 +316,7 @@ int afu_dma_map_region(struct dfl_feature_dev_data *fdata,
 	if (user_addr + length < user_addr)
 		return -EINVAL;
 
-	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	region = kzalloc_obj(region, GFP_KERNEL);
 	if (!region)
 		return -ENOMEM;
 
-- 
2.34.1

