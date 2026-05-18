Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331138F95A
	for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131283; cv=none; b=IHMz8U94x9mWq4WbV27eP6Gjq3+ndQ5OL+0Qp3nMi6QU331ZwNiyG3AxF/f+cpWPA96GW01WlpbCQ2CIVmuFbDJr7SRDpjAhYZreymmr+LVhmdCQpHEVdSHL5jRMoRXyreppIdsZpEg248i0BB0yeh/ze2Vlxy4RCQpgsIgYK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131283; c=relaxed/simple;
	bh=lr/Il1RBfm+qfe8Cae/ztCEpMom3cE9zLIvaGjdLVQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpSSEZUAnkHmj0Tvl47CGF6F1pGvJjWD3vcPx4U2XLGv/rJjfGHzZSyrw7T8MKCnQW/1k79/LSIzxp9kgrkFvwIsKIyYnUGnrzeO0jzwQrsUJRHbjjNExDp0Md9KmXEv19wkwy9MhZ7fCDMuvuBh+EnHH2p7v/r8O4/mhjKsX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQLMv2vJ; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQLMv2vJ"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65e170f1ca5so2787210d50.0
        for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131281; x=1779736081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBDXdrLaiJs5mJCkZrMnLOovecApXs5qp8DhmlH8DV4=;
        b=ZQLMv2vJV6e7TEn0C29mqs3kXyWUO0kZyvS5woroyiWejXY7rUwIRpMUE4mf2tG0lC
         NUcPY/TkBxe9B5qfOUKCwniQBnPlXuOu0fuM8GeDf1gIPF9RsHe62uR42OiU1RCC3EfM
         ZpafBQC+AARdBj+gIJmP9dOJ7j+1ESfoa/khA99ZD3w6boT+jZxaxrIiM4Zhqw88wcLL
         4RkmWqMDCYKP3cdEfoRnaxDcuM8pC1GMZHSROtk2ipSLYfEWLp9Fw6tWvZf2r0YcpYwr
         TjwdkQoyPFCtZANxiQ30pIBaYhtneedlJvYfqNf1ia2+oDL7FwWnQrBSueJzbH70Wlnx
         Sgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131281; x=1779736081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EBDXdrLaiJs5mJCkZrMnLOovecApXs5qp8DhmlH8DV4=;
        b=OxgDY35S5zrbtDUnF5eFcTX15+WKR9X0HeP/BqAvu1k+O9As0RcmG9sEysnHn1WAda
         /UyAyJgeNvgGzNDkZcffjJgAM0NPSv7qdcF32hKrIWGM9geQAfjrnq7M29PfQpe5ep1M
         /03Ye2nI2XLbBEA7HI4dMfC3RreoU8zZ0DoOWwCSEMAb/QfHvK+Rj3xxlTCux6Phe79A
         GAo7AwrRIXJWqLFvuvzzH0k9S4Lt4izVnq12UoVVoJSxD6X2izHRovVxxivqGL+WU7hD
         qANmx1Gqaj0biOv/NvfIdXMlZrHX7Wl4tD/Svut4aYU2gEjis+cjbiQeHPy0MqqoKkcH
         +WSw==
X-Gm-Message-State: AOJu0Yw3KPthN7iol0J0vIlSp3tPqCHPuA1WdURbELt3tEK9ieEceKGA
	z62ffeW8e+8+gosclTIkWcpIGYoaWeAD3TQcb2xHWzoxpT1NyVM0urHV7+5/yqye
X-Gm-Gg: Acq92OHh00d4nX0DlY3m4HWOTw/1ivxcq4GVDzJVWjA+hC0kzpz5w6r/VBxOcpzEB5G
	Uiu3LQQNH1JCWZdyUq1RnCJv4GXP0zOA7SG5RNRqqGuPnFHcblIE9qgbugTEFwPAL8yY9c2PEFz
	gbkadJdTJW331lP4bKwk5zm/6qxLeOhF6UyMu3JegbIH3gOLHx6qidi6OeW4Gou9SNAbMKf9G15
	XG8kCRPtgFLwKJVK5WvAc5IQJj3jIkBVjjr4TNBOmplRgAj0bNHP6LodJngZigCraY0qn1iAk7n
	MzavIMZ4Ftf2gun5ehQo4Y78VFxaJSbFkJIJ4/zAjTk5vyE799ioq6Ag/CG4GxqGUWvHi69U0K6
	l5ssvyJPnPJKMVdag1F3LR+2+57Q2YbyQBVejbi2eW5kB55F23v68aYhBd6lZouLUJZu+zlF1k7
	Pdzq6kmAtTyHreo3o/cagCwQqTPaP3ZMQ9t65e9s0+2aO0IuNk4FskvH/+Fh9+ICyDscVUPv5oR
	k/jIYTKR5im6E4LLx3i6RQWFR8=
X-Received: by 2002:a53:d045:0:10b0:651:c734:ed4b with SMTP id 956f58d0204a3-65e22686be3mr13638970d50.2.1779131281317;
        Mon, 18 May 2026 12:08:01 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm6766160d50.11.2026.05.18.12.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:08:00 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v8 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Mon, 18 May 2026 13:07:40 -0600
Message-ID: <20260518190742.61426-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518190742.61426-1-sebasjosue84@gmail.com>
References: <20260518190742.61426-1-sebasjosue84@gmail.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v8:
  - Add Cc: stable tag.
    Reported by Greg Kroah-Hartman.
Changes in v7:
  - Correct the Fixes: tag commit hash (checkpatch).
    Reported by Xu Yilun.
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Add blank line after the new bounds check.
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

