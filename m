Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604DE3CF058
	for <linux-fpga@vger.kernel.org>; Mon,  4 May 2026 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896823; cv=none; b=ZoTri3L2eO8NFEaQpgCpYzy9pK1hvFU+a/HT03nO6piNKYyvuRoy+fzefrTEZZ4mpPf5nAeQ2AbjdKIV1hdM5wMwWXlSrxMgya3RPrmLGw7EShZzpfNV+dwl+CViFC7ObGxobt1k93NzQFO7jjHw+9IcqQ44U/yJ4uSL+oei8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896823; c=relaxed/simple;
	bh=XNNpH1F5wvOWEqcIvtiZ7uYlDMRnhSh/liAy8ctj5SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN3TelmDf5GWAEnsgrdFQ7MZggv05JEkHvbUVyl0urCNJphPq43v8GZTn2Z+Zm5YU1gmvydJGBHiIsdZeO/Qny2QGv0Zg92fKVeP7KCYX+YTC6oFifL3S74RFliA705yqwHI1gcwhFet9t9NGcK3ASXXIJYoWIiKuGg1bXd29Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3WLX3l0; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3WLX3l0"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd8cb26219so2902947b3.0
        for <linux-fpga@vger.kernel.org>; Mon, 04 May 2026 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896821; x=1778501621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM5dGgpkjSsxJQtB3BR2yd0n4llyOuuMJ1LAIAlQ75o=;
        b=D3WLX3l0AXcCNKZlUurWw4ZDO6UmsrO3V+pAw+JcDjPiDgH1mfO1eKnP278z4z9Utm
         GTfenXEI86lMRF0ZNNcZ+Fzo1v8jRqpnYsYUSOykZYfGjCSEDtk0SeYUvLHFdQJEfkRB
         joK04IpR055SgY+vgSeiauf9YgunWmaN0BCXOJo7fh26tApJK04oiE2j0JubBaSnhGmr
         VFI7D6QFr60XDJ2prFxPTQfr2Ap1Q4NG9xpwK4pCUIZp5Mug6WIdhTvKeRUJaJZu28G8
         EpjiJZx/xnf72aml5K1h8e4c54Hb/Zi+nY6DMM//Er0u+Q46Y0DuIuPqCjuAwhNo/qqk
         /sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896821; x=1778501621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XM5dGgpkjSsxJQtB3BR2yd0n4llyOuuMJ1LAIAlQ75o=;
        b=rTEmY+1TR1Gm5KToO5l/QZDVFVffvKYMZEpzYq+0oViiUSaJ/gjvM6GzCzpBhBfu9d
         ZMG5bo8c7/w20EP4RGRv9XmdFjNqvBPHvKQ8Z2iYEWn+DZbkAyB6qbUTLmsTafLhTMta
         EUhkIzemHUEkompbkdQp85XK8qr3ttrNywtbFxqdkginf4H/jNnw01XttXIYq2FHij/e
         VciTll2vrZJrkq4eLki0MqnWT7ABsu7vaBeYXbgvUPmU2jxUZOSJnGhBljm0rqgRuwn5
         IJqF+SK6NUz5yZge6TaGH9KOWZZWtBOz+LEeWSAx8R7927XL3G6Rc5S4zp2CFVIEbWl8
         +jBw==
X-Gm-Message-State: AOJu0YyIzHTCqyhVRWUNGIcJq58t8Eu7osKpRBxknV7TMcJvvEhV8oTJ
	la8blT3nGqJ6tlssNYJlLr8YgQmhY3Z+0Fg/lHnFs4t9m6unPDzN5QcH
X-Gm-Gg: AeBDieuERlycj75Lg9kbq0alSJzC7SwFG2pY0UE1fD5ROPDpSdolfDfDel2+omSbUQy
	SpzVJLKGd0G2LoD+DCPdJAKatS6yV2JvOUeTkhin5xjPvoMkAiinq8XV8EwpwofazSyNwk/S8pn
	+hdJWQl02qLQOJAzqdMWNwjivYvg487c/wk9eBhKOBN6VhoNBMCqKxajoY8qC45963JAsLA+LFd
	w0qAfIRT6B6Wrsj4ndHDB+f2P+XguTtGvQU6a6P+GZSh4a/D9pxOzU6SzjJGr5gLwZ5pM0E1szJ
	TVWqOORGrcmE7pkzzUAv/ALtVnn0uq4ljrvuYq9yfwH6MSHwd2UvJZBm1coltojkYcS4e5YZyjJ
	CmS8ZWNWy/wo/b9y/740+bOi6WT24FMvw9KdNVcohxdSaVOXWnWqitT+djKXozniFd+oSeIkFZ1
	LsHt2Q3UJXO2hNhZnlW5GmLG8HmUUx8PIGdCrJH7VXpEt2kEOkBoNV7i0=
X-Received: by 2002:a05:690c:a01c:b0:7b8:bc4e:ac3 with SMTP id 00721157ae682-7bd77104b4emr88139017b3.26.1777896821391;
        Mon, 04 May 2026 05:13:41 -0700 (PDT)
Received: from ubuntu-linux-2404.ts.net ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm48417937b3.11.2026.05.04.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:13:40 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v5 3/3] fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()
Date: Mon,  4 May 2026 06:13:32 -0600
Message-ID: <20260504121332.1053563-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504121332.1053563-1-sebasjosue84@gmail.com>
References: <20260504121332.1053563-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpf_ops_parse_header() reads header_size from the bitstream at
MPF_HEADER_SIZE_OFFSET (24). When header_size is zero, the expression
*(buf + header_size - 1) reads one byte before the buffer start.

Since initial_header_size is set to 71 in mpf_ops, the fpga-mgr core
guarantees the buffer is always large enough to reach MPF_HEADER_SIZE_OFFSET.
The only real gap is the zero header_size case, which cannot be resolved
by providing a larger buffer, so return -EINVAL.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v5:
  - Drop the count < MPF_HEADER_SIZE_OFFSET + 1 check. Since
    initial_header_size = 71 is set in mpf_ops, the fpga-mgr core
    already guarantees the buffer covers MPF_HEADER_SIZE_OFFSET.
    Only the zero header_size case remains as a genuine bug.
    Suggested by Xu Yilun.
Changes in v4:
  - Reduce to two minimal fixes: minimum count check and -EINVAL for
    zero header_size (superseded by v5).
Changes in v3:
  - Add overflow check for 32-bit in component size loop.
Changes in v2:
  - Return -EINVAL for header_size == 0, -EAGAIN in block loop,
    add count check before MPF_HEADER_SIZE_OFFSET read.
---
 drivers/fpga/microchip-spi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index dca1a5d..cc8f6d7 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -115,9 +115,6 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 		return -EINVAL;
 	}
 
-	if (count < MPF_HEADER_SIZE_OFFSET + 1)
-		return -EINVAL;
-
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
 	if (!header_size)
 		return -EINVAL;
-- 
2.43.0

