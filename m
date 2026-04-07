Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2433D4E1
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582574; cv=none; b=HmHrFN4lCdl3GLN9kmeLs0pQpAFFq5RIMHOl+Soa5tmMpNVBxVlMNxRrRj2eCwL6spP8oAicO2yVgn+7Z/sWuM3P+9TxopTl3hV+UOLs52M9v47gLT75yvIT+nbdw+xrfB6assrN8usjRIcLOwgjH4w+1xDNlPzAUv/vrBmkf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582574; c=relaxed/simple;
	bh=PENGNB8rrodSyMDYvWj45yPQ3gnAi8Ng4MHvP6kqE/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARIzeUaDvWcV7imUnky/9b8vaFqePT5drgqDS8QrvYL7jbxLI2gQBc2Bnk/sDo+iuS3u+3fAJZoA8HCVqAZTAuV2nOXZYAd2qJ9v6beLvz62mJu2lzPB2P0ioa5Lx2vj35B/P9BfF5+IMSALx/mPkYSzfdrG0epAt0tbQ5x7goQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4RU+hlp; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4RU+hlp"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56d85881a68so1936918e0c.2
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775582572; x=1776187372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFNdcYKOl2EgqlFAIeHqA6NsZRC/Ddu8gl6mqtB4eGQ=;
        b=j4RU+hlprmOQvcemICAkutmedMVLhzuZxEkr4YAiuEeKhoqiRUYDMArVQ0vtyObADJ
         yg/M/xRE6t+NTBaIXtXihcdkxneTEzpAMWKHLnp2YYzuLvPllSxFlsnrNqD93ZFDIuXg
         NVZ2davKtJaaC9kCNS6xgNJ/AF/liLBcbHYpTW7aPZs0iuAfWKIg5/DciZ/5EFO2J/NK
         WALMpyrs97eRjKFfO1S0LmrQTOALzV+IbPFs0Ckz9IARgR1YYkYH3XehJzcVA8k/hNbv
         gOjwHSn/HeFvkSIlsdUYfRLJ0vx9GIwrXGKdoXE2HxRNAa2ywCFyL3tx0KttbnbtGm6g
         NPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775582572; x=1776187372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFNdcYKOl2EgqlFAIeHqA6NsZRC/Ddu8gl6mqtB4eGQ=;
        b=HTA6QR3A9O/SJ07Upu0Wniw+jaNtIYWBm2+ZCn259NQI/8nrcQNfBKp2V0Q/NqpVXc
         rFRHnMF2llbFoOTwtxrP+tietfkrKzNYSeTBxmqqBLhI1TYGQ5FFlCHmduUiV/3Rrc2l
         Sj+CcowIYM2YFrj+H4cdLE2TNIRHDaM+8h71Z/LR6b3w17/PAoZ4bYM2O5aAcu1tWVEM
         U1uWPtfrEIl7xfKRenCrW+FAyublESUSTljmagxhoncoztte2VJI54RnoVi9QfEK7Tc1
         1flYdr2vPVfjujgexgmkvPBpbndHomUWx9EXt2Ad+02wELlAKD13KPI9NgF4jUWTBgtt
         gGdQ==
X-Gm-Message-State: AOJu0YzzVfYA6SU0LpUfYE7xLr2UOoqUByT7FSv8amJPYhsH8gBZq0D9
	aIJ7HdwYtWLJCJMrvEbakAeS+fFy4jy9xC2YwM1m/9vwPeLk4dnN4xKC
X-Gm-Gg: AeBDieuKDV+C6Wyq0Nfvai4V8PwX8DO+TFneslgmCGKdkCd0EA9ObdQTNQQ8PCD0xQN
	CzEOXt00SRgPKLNV0Ss3Abzq0jItd3gkYgkYyyDx3C9fJ06TxqzAUxpJstVIZZZ307VGZu8f2hU
	ENMmB5dsbsH7xrLON/R2+pARvf2BuUecl+MbldEGu3zdGOsvDmvqpCZRdk9TyX/FBE43fuT4xnH
	2XM4s/jGghOigcFu7y9O/tgt9+BavMiaCOgj5AP/Cnb+ozisWShgQd/liFwzbG+KD14mPz2Q1N1
	rAsIsonVGBleehFuESzEtkB6TDiYMHhXg3S+1W0/WgYfmQuHWzvxDoYbxLhorki78zfsue18OuE
	fkrc8sn0s44AGt68h65FjkXsI4QX75Hvzfv0xNOIwvZp6Y2Sl7mVJ6WXLO+rW8DDGgFVhvtXKq7
	H4N+Hu2RsMwmsRAX2bGSKbR9Ab
X-Received: by 2002:a05:6122:3701:b0:56b:9083:4331 with SMTP id 71dfb90a1353d-56dab9fb8ffmr6358028e0c.12.1775582571921;
        Tue, 07 Apr 2026 10:22:51 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d74:aa::11:155])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bae1117sm18878435e0c.7.2026.04.07.10.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:22:51 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v4 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue,  7 Apr 2026 11:22:16 -0600
Message-ID: <20260407172230.40775-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407172230.40775-1-sebasjosue84@gmail.com>
References: <20260407172230.40775-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

afu_ioctl_dma_map() accepts a 64-bit length from userspace via
DFL_FPGA_PORT_DMA_MAP ioctl without an upper bound check. The value
is passed to afu_dma_pin_pages() where npages is derived as
length >> PAGE_SHIFT and passed to pin_user_pages_fast() which takes
int nr_pages, causing implicit truncation if length is very large.

Validate map.length at the ioctl entry point before calling
afu_dma_map_region(), rejecting values whose page count exceeds
INT_MAX.

Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v4:
  - Resubmit as full series per maintainer request.
Changes in v3:
  - Move validation to afu_ioctl_dma_map() at the ioctl entry point,
    before crossing the userspace/kernel boundary, instead of deep in
    afu_dma_pin_pages(). Suggested by Greg Kroah-Hartman.
Changes in v2:
  - Added cap at INT_MAX in afu_dma_pin_pages() (superseded by v3).
---
 drivers/fpga/dfl-afu-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e73..097a97e 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -723,6 +723,9 @@ afu_ioctl_dma_map(struct dfl_feature_dev_data *fdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(fdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
-- 
2.43.0

