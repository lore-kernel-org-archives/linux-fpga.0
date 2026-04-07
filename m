Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767433F394
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582577; cv=none; b=G9BvCSaQwyNjXdnXZ9OexEUWqdK96ANsePumKmwAPAJK2QnW0XXDrevp9mGDXVBilfSFUQ4r1OuNWMvTdsv/ogcBrNpoYo/UQV6bm4KSLHxdIhFjYGyoDkll/2T+jVBMChzkccB0KMi4jjtQ6/aw4ayAlcCxLIMkDQ+ysb3Umxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582577; c=relaxed/simple;
	bh=ZcAd8r2E89ehSGioFtn3ZR2V7bW32AhFgtz22gBkxCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWmGayHYV8InlwcEG39mXcbZOh+USgaKWnHyqxGszMio/7a4g38666/ajjyEmyaYOmsH9ctyZie18j335A6XbsAYNqclbknzFml/3ofGHiK5eFa/t/7Vey70DxAZDMHevWkQk13pvUGBP+h8a0OECQ6Awy9SHtuFgLj/Bmkpe0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jkc4OcsA; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkc4OcsA"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56d8365c1efso77844e0c.0
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775582575; x=1776187375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wfYwtoFl6sdyFNiCt9In4dW+DHVo0dRtpd7r2ydApw=;
        b=Jkc4OcsA3ixCr3iDkli+MCmI9lmQWGXZEU58ZAYDUTbKTn6Xl1z4w/qWBAdfzbUGmQ
         npu86gi8f80hOMM8MuHf/XEgJgtch0XhnRJITWXvs/F5QEdLuPxqpFCvhiHNJbfW9+Uw
         zv5HXimRu4GlasVkDe8CncSbOiPziVK5UIPb/cteN3ZmAAIHh0yrt0J0DF+nB+1rCnlE
         RUGX+z0AFOVlZe5ptsXbW0nvBoMIHlnbOhaWXlfVIC7VXrJD9xGf2uswCX5wo97TqDku
         3/TU3c7I4ZUR5JVyJjhE7+thXdZnpcfXklumjZnPRbs+xF/npioig4W+1ZuPQFm7iHp4
         0lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775582575; x=1776187375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wfYwtoFl6sdyFNiCt9In4dW+DHVo0dRtpd7r2ydApw=;
        b=s88BGE0Lv84uhRfokVYfuy95V7LFnZzd1SVarXR1otA7JglrjuV0v+CiN4awzybOpI
         TDvf4jP6D9xDEAuCc4AejfgR1A4NjTIpX8ARtKKIuRJ2M1AgH3Pf6XrFjxu1xb2irSpO
         8RHuG6yXT0b5XrH7FvoS/2aoTday531HxwiH9LlAr+PEFkH4hlIwmZyCvJ+P8bFVWHFK
         pBbrcc/I8D2CFC+tBAeA4Zhzz2Lo7heWEY2+F+P5riYTqKGWSxzduaSCgHlvjp1wKblP
         aQnZO2IYL0hUzO+iYgUjwaqAXcv9MzRTD9lgBZLNmF74xJaEJyeF2G0NU1Idtb+Smphe
         YWiA==
X-Gm-Message-State: AOJu0Yx2/+6TcYVMGAxdLGkDm6mwjYHI8Ca3U0AQWe4NxnH3zJ8zd8Pz
	2MkP9YAlNxUCrlpEucRMBr/4mcqcrByCqycSfHMmH5kV7kPccQZkW0If
X-Gm-Gg: AeBDievzixdaiZ2RVSeYanTHZaHAM5WDh20PqAWD+ar0igD7e5DcMRxhEj6P1hw9PA8
	zRGPHvAdLF0N7071QWZIGl+y4kdyE5VEuFciskYbShz0tm1v6Jm6r3kvNPTeD7lwLKwsILvKM38
	ONrpwmOzqDWQ/PEi61RfzsyXuEpIiypIiDqhJETJC0+uShT8DTcLuOM5XT+1Ew9WFXKnRdBN8Zj
	PQN8XmWKPGbw3kkSjCq6Pn+PbBLJ3pVcgss/fFT9Eir3Cght4vcCBf+4Q1a1cCYUbwpA76QEK95
	0P1yyx/tUOKhvG9J8RelBQL3lxyB9ar/7k7JEaxwLk3F9D/YmCfioGx215FIiZ5GzCiLj8zARLw
	zV7LeiTmEq17s9Luz3XUp0hIYwGnJ/iUzFgLAD5REegSdx6TWlLncCxKdjFdEli3FIHn53iPSTi
	VenasOWler+nRVA1MoMM7h48Zl
X-Received: by 2002:a05:6122:81d3:b0:56b:a569:948d with SMTP id 71dfb90a1353d-56d9f1976fcmr4282062e0c.5.1775582575428;
        Tue, 07 Apr 2026 10:22:55 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d74:aa::11:155])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bae1117sm18878435e0c.7.2026.04.07.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:22:53 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v4 3/3] fpga: microchip-spi: fix OOB read in mpf_ops_parse_header()
Date: Tue,  7 Apr 2026 11:22:17 -0600
Message-ID: <20260407172230.40775-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407172230.40775-1-sebasjosue84@gmail.com>
References: <20260407172230.40775-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mpf_ops_parse_header() reads header_size at MPF_HEADER_SIZE_OFFSET (24)
without first checking that count is large enough, leading to an
out-of-bounds read if the buffer is smaller than 25 bytes.

Additionally, when header_size is zero, the expression
*(buf + header_size - 1) reads one byte before the buffer start.
Since a zero header_size cannot be resolved by providing a larger
buffer, return -EINVAL instead of falling through.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v4:
  - Reduce to two minimal fixes only: minimum count check before
    reading header_size, and -EINVAL for zero header_size.
    Drop redundant block loop checks — the pre-loop bounds extension
    already ensures all block offsets are within count.
    Suggested by Xu Yilun.
Changes in v3:
  - Add overflow check for 32-bit in component size loop.
Changes in v2:
  - Return -EINVAL for header_size == 0, -EAGAIN in block loop,
    add count check before MPF_HEADER_SIZE_OFFSET read.
---
 drivers/fpga/microchip-spi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea..dca1a5d 100644
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
-- 
2.43.0

