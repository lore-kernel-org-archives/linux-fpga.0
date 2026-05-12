Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67E397B06
	for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591252; cv=none; b=MmmTBja9+WRKwSQDw3/qYgGd63XyPkOSqtibJ6Cs2IKKH72WuyZVSV0yCl/ECI6YsP7gX69UP9n5ObHhToPh3Ls0j2y6UVM+lnhUxM7DTCUS75VXwjFgYHn7FZtxGK31KTmgIM/dxImakLVZ0GMHv+KrKVUFJvyyHhJMNtW5Oew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591252; c=relaxed/simple;
	bh=POp2n1MrrBwf4XyFtHBqsdLJqGpnHG4C59dkVpAvLgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn1iwmwJlGfY8B1tp1kcXoC8dIRLm5EVWmqY2SVFEn1qXzmIddy2toZgVPkj2xHjyaFmalDkCehpGJ9Ff/O5JwGxxVruw/Mj1vqoS4nWHRKLOUq6YXvfSDR3rtbJSvO1AoBSGpRfvI7mELhkgI5ZhshzDRv7cgSzj3YxJWdunuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7DidAs3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7DidAs3"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7bf1eaba464so48023537b3.1
        for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591250; x=1779196050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOG4qriMr29psJVDOI0klbLQYjbJN0xxiaQ5zdjbGPA=;
        b=S7DidAs3BIgOX7gYt7VHXkXH0BpJgSe8o00099C9kmDy5JGw5wtsDsnwThv+wU83Yw
         D+rJEWFlu1c5YslnT5sqSOORwJbkri74NCgnkfruHJVsN5oIVP+upmqyRNrRBwGrNBHk
         UjEhB+wMlzFbh5K6ndQUXk53loRADL5COzz4gUeh8TXi6iz/OyjdDT/B/5pFn+9SoCpy
         CMffMJ/Rv5wbARqtowGpqf1rkE0KFV2A9SaQm/fGE9gaitSavVXaYtAk060wJneFNZuC
         Eo3XTKPQPDrYz90m+f68dHauihpEVE44d1yzWVRRi4jhIQZe7c28RCOSRNavSVpLym7o
         Kcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591250; x=1779196050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOG4qriMr29psJVDOI0klbLQYjbJN0xxiaQ5zdjbGPA=;
        b=TKWoUa8my/gLkAXZv5jrjrQW7MJkO9HX94GABZXkfSj9hMA5xU2cy6X7VWKSWGAFCp
         mFmH8iziS8z5iJ3jbSDiKy2oY06ivI5ZjKJyRtm36+0Ts6RHEvpHskBfGvCESbiXJuh6
         PyuItY/AvavdurQykUvoQd7El5jUjYJ/k98viEYKm6+zj8Nus8j/yFCKA/0D64P1JzbZ
         24sxupragBiARmVj6y9rSS3yO9rpztVZm+tSrRDgYJ0pf8CtzGS4Fw33Fcrzi9alH5II
         1DISb2sVNnvsJKYwwj+En3JnaVut4eY0GETdta7tWEFuOGDsToH9boeHIRUuvngvkzcK
         i1PA==
X-Gm-Message-State: AOJu0YxLShFFOV+SK03c21QLL9q6Kw7SOAogJhEGACKeDz4TjYIqngvB
	ppgnKb9qOXHRAYFxshqMnXuYhu81jIxrvSZBs344tWNmYWNLMFCjL1TOFf4okGVF
X-Gm-Gg: Acq92OFmbeCru/4CEMhpA+5lo45Zcdg/w7e4qHs71rYwn8dibrEllMUx7GGK275O4O0
	xv263ctSHIKbQ0tixjPh3uMBx3GrlNgjf7S1FI4ynSAO2toBFVQeuVWgT/gUnd5g09B627rV8vT
	NVOKcUsAHpsrlxzHeuCR+41xdWIC9i2okiEzf7RF3ngoeoTkmL4R0EJbsJSSnuL8qYGGkb3Yqz8
	YdRz/Zwl6g4nDG0ZCU/7CCjgZdzCsMLEujK0g4jTWEMnecbdy4uCsgqpHVLYY+Oz0OM5duu3owG
	Ep1AFTqQFN4t+5P3qzwKRdA9uyO3GLq6sqzHUsdqAS6oV0eTwHiN4Qw6zD1bSyWjLJ+fCFhz3ki
	DOO/u1qHCg2ob53kYLzLe+HkVQjxaEpisH0oCQBi0Ecsovy/m/MLznJwIgDZ8Mg6OORHsQ2UKpC
	r7KGHTAQMiu6Ht4KUxRQBMLjoZ9zs04Gxqp7F4AJ4HCO5zzWoDaegwUvYt
X-Received: by 2002:a05:690c:22c6:b0:7c0:82ec:fe75 with SMTP id 00721157ae682-7c10255d217mr127949657b3.10.1778591249713;
        Tue, 12 May 2026 06:07:29 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm167459037b3.39.2026.05.12.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:07:29 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v6 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Tue, 12 May 2026 07:07:08 -0600
Message-ID: <20260512130710.933089-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512130710.933089-1-sebasjosue84@gmail.com>
References: <20260512130710.933089-1-sebasjosue84@gmail.com>
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

Fixes: a80a4b2b2e4f ("fpga: dfl: add support for DFHv1")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
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

