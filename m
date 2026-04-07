Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8F3AA500
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570788; cv=none; b=tazG5l8x6AZKwY0KHsoTmFJ4vNahmW35Vml5L56Un0pTUiIg/ShRMcmaNweI99NNjU2ie06HZTnX02+IsifLsNf7sNlKuMslyx6JEEhYpvtDLZdiPGwmMrCTw/YwBAFLffXfn06WOFyrNUjBfk8OXD/QvDaCezL6zGMx35dsVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570788; c=relaxed/simple;
	bh=hR+4fVDOdwI76OidQLd9QmfZVGOhqdBSDsepnstrmBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOTouoGRu2c+vDmW3qqv3YxLgEEqhemaMbW6FzIJAIpR+qSCkcBKGJIGc+7gKX+MsnETm97Apr1gVVON0YlGa/gFH6Zy6JmOEOHEZvFR3bwIdo18h8NB/LjuWNcgq/4WM8DXorQtsIjgtDvF/2IWPOJ1+KoXoY3khGWESy9jgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es7NgZHB; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es7NgZHB"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso2160587241.2
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775570786; x=1776175586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6lsHo5qoWGZyi8rJZLp4j1toOJ5+nc1vdlTEmr6fyY=;
        b=Es7NgZHBMTRDkQN1xNjvcU59J4meqF8MMwL43WAhURGcsEtowOCgT4LMxst1Ra81oo
         r8GTOKPZ9u4OtN5jIWqIHahPuF4XWzVay81A8LyOWrN1xL+RTBH5VKD2k7U+NU/DVpU6
         EsdJW6tpoQlUc81ryQ5on+W91sGHDPEZLsQSeAH7y12d1zw5tiNLolfYHwiXvya9V4Mx
         c99h1ux+xPvL2F2Kp2BKrE7zr59lvAM0AG1udbo180ZmuCDRCuUh+wQWUh3WzU+Cbos8
         HsYPV3E7YWuKtwV3WzlYxiIGn4f+WI4V1hEONpQzCztrY6fhkIa6bv/sW5PtyHGJw7Uq
         gBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570786; x=1776175586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6lsHo5qoWGZyi8rJZLp4j1toOJ5+nc1vdlTEmr6fyY=;
        b=b1Vdjb2myKSkcaSDY1O2aud5TYgNcE2/pq7gVbH3Z5B5poympd+qybjS4p36nyf5bB
         sxROHv9b0fLRe+STD45JcUWTZ+fp3cUMqVxNwnvcrM2AZ9llsD+e6A/Yh5jxIL36SL9/
         1pFifNLqaCH9E35PvajOjdkn/jZD6mjek/kfjk/LcB5mQ7Vppio/m/jMns3nMVdozgi2
         g90JNmpYScEI4Xv/hQWgFFRTF2mTyLrmwzrWnI7PxEeyNrxUV/mi7Fvk3jhBOYOP9q3c
         QW6a1rh59DNfZKLhZP29j2JXzF3zfJMoWjhvtsjoGQY/wHusQ1TKdKDqocAl7sTuIxj4
         BPag==
X-Gm-Message-State: AOJu0Yw3ZKZfsctX0mjWubW1pJEmVgWPytuE2GlRQO4YnIGJOWOeqkAK
	Ou69jhVpT0DlRAOosYrZnpXDbkfpW9Hi85MqMGA4TcLM8MEuFaIe+e1n
X-Gm-Gg: AeBDievyNMcSAGPBGu5FZI+SNeevuPDlt6zAAxtqzqyAUb7Lb1PrkG6xsyrGWdaDHS7
	gdMTw2aAMCOhXezqrA+XCJJ+dlyysVaoqiIDpi0FT/f5LFR1oIhLsmTCdYwn9nVOkKZfBPSnPax
	3MT0GOAYQIJEK/i6ygXm96A7ai6FnjlDtNvTgSYpu/n65v8InZsHW8i3hNyS1Ra1HAIvvITQkSi
	7jL7OkCghaF875F4+b8WhliWqgXTrA5H2yIhzLLI0s+7kyVSM1UaAWvT0IA4NkMbcF8V3A/cSw9
	7C8WMmT5GfSBXxUjylCRQc0FkZkih1VBc5Z+93l57nFqkwNipkcH8az0HtHkOq4rzFhaAciUeIE
	7uObW4GWxSbPx+Hr7gCtUY1+GZfCQFKcE4vpKAX/Rs+6GuyvRHn4whBvuLAmO6gqZEEMTuLEPHS
	qdxsYUv8FBsUucz5vj1XUqLT0=
X-Received: by 2002:a05:6102:5a92:b0:5ff:c510:b7e4 with SMTP id ada2fe7eead31-605a50f88e9mr6685023137.28.1775570786058;
        Tue, 07 Apr 2026 07:06:26 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d73:aa::11:1b5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6058304a726sm19814641137.9.2026.04.07.07.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:06:25 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Tue,  7 Apr 2026 08:05:59 -0600
Message-ID: <20260407140601.15006-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125446.3776153-1-sebasjosue84@gmail.com>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
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
Changes in v2:
  - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
    The previous check unnecessarily guarded against the next parameter
    header, which is not relevant at this point in the loop.
    Suggested by Xu Yilun.
---
 drivers/fpga/dfl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4087a36..81d7a68 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1132,7 +1132,8 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
 			return -EINVAL;
 
 		size += next * sizeof(u64);
-
+		if (size > max)
+			return -EINVAL;
 		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
 			return size;
 	}
-- 
2.43.0

