Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8D4949E1
	for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123218; cv=none; b=Syd+vTgtu9LukEn8XYBecegBNaIWpPz3NKLAPQgkffZRGXdIg7JPwXuUprsmhvyg5hOte1XBTZf1wvvsClubPAmmxcjlOfGwYfwuRWZI6LyuoNmew/hqXf/2B1u5ZoGg0rlRpNmwffCLvMenKqzeaUDudBBdtRMMyyV/N7MsU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123218; c=relaxed/simple;
	bh=NBZHuKv2ldtGIWJAnz+NCfK2xasjAlOHK3ocGE6MaRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DA6ljeFTV4kq2lEJNsQfsyZrvDoWYDQ3m1pn/26laLezMqpD1RnTnYnXpND5VwOJtXZY+oVyDFlUOM5/ovDow0p8C2dyWKzp7Pi6Q7C61+VY1vSkEAZYNZjot6zOAiwUPAUgfTAed3p4c8wh2k659nZOcuuzBdPuSG1djDIZwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFbqnw/Q; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFbqnw/Q"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so20171947b3.2
        for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123214; x=1779728014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taXFjdWmYy69nXOR8QvrAj+hN3E0MfqomsmbUhRahH0=;
        b=sFbqnw/QVvvac7icwqA+B83l9++wx76rwbXAuqWO/ojKzdMas9pJCpQwc5fFaG9yBF
         EpktwLP1DXu53HAdD+Rt/vXkh+Tl6iKvbGHylxqTnlsk6QCsVVVPVmWuWHXZ3udTi4a/
         bNbEo3XgVtulBKKnaXSOHTRgudEuDJOaxbU5O9Cc5ec7BdjM4TeH9n2ndSrTc+ac/zi6
         AIaONSvERsb9IBsXntp/ubp5tyOG283t6h4KQB9WgaXIHlL4ZkA+TG2/fofRh2/pNRBd
         w9X5Ph5q7PAB6lKJGHarV1Yd+FHGOOc5dTTRuqEOybjtEasiImQwkYMu2t4/Tw+uqoVy
         PJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123214; x=1779728014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=taXFjdWmYy69nXOR8QvrAj+hN3E0MfqomsmbUhRahH0=;
        b=nOfu9rvgy/ymZpKAqQd8YxFQYDxUKK99gdTGJV3fXGnUzw/B+Qw7Esiu8ZzqIL/yRB
         4NZA+21WE5Or7hCGwl0MNOi88ULM8Nf5R8a+GsUt3yo7imYAWIpO7lLyB8Iifz+t0MTI
         uw71ZMz0LNEF0suF2c1DQ0nzf7lF790InVkdaXYetMGWAkEngdETpbsNPiSmV6mbsayW
         pLemswZzLP2YaSTJihjUWbUrbju2DmGLmG8+HFiT+pEtLW6qIOfZocht7L4k0vT2ob+x
         PPts9D7oh9PQTJ/adjkmmg+TyVMouKcAwZcBQTyjfco398viVvOHYyNdUkXSShsfH6vx
         lWPg==
X-Gm-Message-State: AOJu0YztJl6y4Ya0TFiT8BruKHa9o8PMHUvUMY1CKGKLjL6FluQtwaQk
	fGOfjnbPd5HlnI4udGAHdZdzHaZ1G4aHYL1UBo8nOochAhiUJbXtsLi9
X-Gm-Gg: Acq92OEVuMEbzdIf29AFoMrMr+vt33mThKsLAQ3+o79/5bvItasLIsj8vHRRlYjmaQ2
	BBtqyQ6pdmFQ+kNvDy4iM6z5f3b09OIt/Kgni1L4kni63gKYHvrKG2W6SIsqFmIQY1mJCQqviL7
	0X35swXLL86ma4shOr02y6xvI7A6GMwpEQTHegqQIeXxQo3ydQjFa1CZkmYrUmP9ABVgv3cdvNe
	XMRp+H/wgcvzxrdmsDO4leh325B7LIytoihrN1dVv+pYOldAmIfrXiFGRH9OUe8CXljcnaUTxLA
	zugdRxGENFMxvGBA4VEhuwshjVKGu2rxTAjTjZmkNH20GeYkp+JHqVVcNdQXEZyS9h5MmgGn9qG
	CbV1P/l0o66rMn+q96I/vUuXgLmSn5892Da8nKFtljAIgqUDra4kfBZmFdeNozFUD+hHMrQyySo
	26ZCTwJ+mvEnbNyQ7jnbR9Ns2L1q53OQEZdntJwu9ibmkMbztCY6AxIXcOC07E6Y+16p4CBFDCI
	B0qlrffglvk721L1fn6pk0wNpE=
X-Received: by 2002:a05:690c:38b:b0:7c5:f6c:d132 with SMTP id 00721157ae682-7c95a967084mr182102907b3.17.1779123214581;
        Mon, 18 May 2026 09:53:34 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc965ab98dsm24232957b3.0.2026.05.18.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:53:34 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v7 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Mon, 18 May 2026 10:52:17 -0600
Message-ID: <20260518165218.35388-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518165218.35388-1-sebasjosue84@gmail.com>
References: <20260518165218.35388-1-sebasjosue84@gmail.com>
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
Changes in v7:
  - No changes.
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v3:
  - Move validation to afu_ioctl_dma_map() at the ioctl entry point.
    Suggested by Greg Kroah-Hartman.
---
 drivers/fpga/dfl-afu-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e7338..097a97eee 100644
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

