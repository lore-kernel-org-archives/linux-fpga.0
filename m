Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47576494A05
	for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123215; cv=none; b=ehfiYwiM43FW5UeVc4yI0B+KZw3RdvJNNpi5rdcCpPgn9lD0jcgDaQhL8XaypR4h0AXPcquO6STdtHPmATE5cu7ccEqOuIqKnoTV0dLS6lzlWjy8uKHJ0eU3Qqz8rEPtCY6Ej7Hq6brrJH7gTLEXvORyH/NJ4jlQ5dGVO58xk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123215; c=relaxed/simple;
	bh=URFYTieCVSZC7c5z09SQJ1b36jUaan5k48W0s0/ZCLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqVGLDzJzJZ92BaUBP4pSONTkj7RDwVcIedjrJZvfgsptgkxJGwlTzqv0k8WO2G0dm5YokdNkSmornvy+9MrZdqT5gtSZ47ZnZ5fCl1Z+5bub4TpyiDmjzUFoEltA1VNwlLM4jMZ7mxwouJAVzZM6wVCmo8wEkBdOG2LTEh0gLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rn1wewad; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rn1wewad"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c477a3278so2720708d50.3
        for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123213; x=1779728013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qta+TGt8f8bCNU5lXsak/sMOHDnwEN56jda27IdO8xA=;
        b=rn1wewadbMdYNBApEV9E1quik05bze1uz5pNbmVDetrKQLcHduphxPpJqPOlzFz4Ha
         bemBwZR+M2j1Zy8C6IvX8LmT4YaYy/AyHH0TzZuB3J7P1Y72vmYNLnMWpcPrrZtZNVVe
         G0fkHM2WnxxnDqPyBgAvBhfew7mxF/OzaXKV+Z7rN1MK3VWDYYpHaPTqWApqJ2bn/EYJ
         kI2470hRWueZen/ObOtLjqSaH3TNn5QkaOlG/BLLlG20Wiamq6G17jxLIyYC8n8t3+Ze
         /0Ot75kKWD0FRqO88wdKxQLWSAmF/3XfEnckEH5P1zDnjArhGInQnOi5pyG+aEoX2oAa
         GYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123213; x=1779728013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qta+TGt8f8bCNU5lXsak/sMOHDnwEN56jda27IdO8xA=;
        b=MPcY7w/JHDi6lL6WdFOmb15utEoACgTaVsw7n68gk0Ft0sneYp/uoEniS6kYz/8OqS
         1yStL7ODxsBEy6slFm2tSL7506kCupaSVaDTqaxK2BGlBxIv3pFJF1CL45nExkj9ouSW
         fNWSnlVOFIZNFs+LQtAS+x4CME9Wix6LZh7XYcmQPAppO5Y29nmy94g5PSfCP6oMqTsL
         UfB/L4Hpq3Fh3x5Ne1LGJ9zifc+dS+un5m5bhydq3eNAV1SrKSdbExnctII7UILj0dOl
         gRXlXUiOqMcSXK8eJN6mheMmWBxVVivNw7sQEbpaCGyfVVqsaT5hqcfmAD2hPkCMdKjM
         wEcg==
X-Gm-Message-State: AOJu0Yxe8+zps+8y5BDxklM5Z7OMo8Gfdg0WPut3191WYkzOeKJOuwv1
	5ewpm9jZo9hcmj+bPobAiFekz9MKAlFl+ZlJpmDBZgzsNHMhyeirgj4b
X-Gm-Gg: Acq92OF9BmRZl18BznDhlfVxPCos/yEnLWVj17xGsewcIkizmY3ARsOHGeYjXPkILna
	fYMXx7UmdSuv0A6J6vnPgzMXpSP/EfU1W2z/eNtmlci+kcFFeoIHF1cEncSTvsY2w2akcs9pbh2
	ja7FoYVjAT47U62dUiP5pS+/fiwDF1M+8OMYXRNSAvucIKLgWqTq1AmhSYFh5um8Uw9MvujXh7N
	CICUtZ0D8eDnq+fJZnojsgkJxhIRQkLex9CExe5NCHJyXVgb65l8R557BClB6sGewPD2FHaLeYN
	Vw09OJBFws87/uPfGzXfdzfp4T8WIN9CoM5sEyvg1ycYeaMnBoi3fDX/hO45Gy5+2M+ZWyn6KG7
	AyrIcIZ6mnFNk1KMC79ajQwuLcjhCMzOSgd8XZvnf24BONsjZtVkLV+VJbE3KVHNSvbVnjFu/03
	OJTQK7VKtLPXf0HJj9/Tvj7YUgzu4SqLVrmhvE1EQmrGygORtgSYZa7xdjdnGNIrVsvaCVCqIdg
	Pl5hYeRCuOqQh+u
X-Received: by 2002:a05:690e:1482:b0:651:b13e:f9ef with SMTP id 956f58d0204a3-65e226d2c42mr16777704d50.14.1779123213099;
        Mon, 18 May 2026 09:53:33 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc965ab98dsm24232957b3.0.2026.05.18.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:53:32 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v7 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Mon, 18 May 2026 10:52:16 -0600
Message-ID: <20260518165218.35388-2-sebasjosue84@gmail.com>
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

dfh_get_param_size() can return a parameter size larger than the feature
region because the loop bounds check is evaluated before incrementing
size. If the EOP (End of Parameters) bit is set in the same iteration,
the inflated size is returned without re-validation against max.

This can cause create_feature_instance() to call memcpy_fromio() with a
size exceeding the ioremap'd region when a malicious FPGA device provides
crafted DFHv1 parameter headers.

Add a bounds check after the size increment to ensure the accumulated
size never exceeds the feature boundary.

Fixes: 4747ab89b4a6 ("fpga: dfl: add basic support for DFHv1")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v7:
  - Correct the Fixes: tag commit hash (checkpatch).
    Reported by Xu Yilun.
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Add blank line after the new bounds check.
    Suggested by Xu Yilun.
Changes in v2:
  - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
    Suggested by Xu Yilun.
---
 drivers/fpga/dfl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4087a36a0..4c63c7c85 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1132,6 +1132,8 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
 			return -EINVAL;
 
 		size += next * sizeof(u64);
+		if (size > max)
+			return -EINVAL;
 
 		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
 			return size;
-- 
2.43.0

