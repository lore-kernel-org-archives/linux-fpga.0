Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90510E3
	for <linux-fpga@vger.kernel.org>; Fri, 26 Dec 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766761476; cv=none; b=B2Xdn3saVXwyWcPWgyzog4NPDw+dQg2malNe9RnIVGJV1U53TwS4qR0T7s0R6k7ALfV5kGeU1LXaOyTr2P7a7O3UoZveSV53iFAB1O0JM0HpWlzcUHTFYDNCtd3wPIioe/m+r7etofqnbuakWkJkWSMJGqCpKsnALCc6YuH7+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766761476; c=relaxed/simple;
	bh=IU26Vp+tLWYf53WiF7AZaMjBQdD/VnnXXWXos+0ZvTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErJQ76CHtGvHaauGHH/5O0fdtPAmquvWf63IuydjXWH4QLI+MTJfKtgyv9LW1EnUNcTM4rZpRomNO6AJi6yn0Wo3RELqZ10WX/Fjk2V0hoBw2XBmSfVVnxScmWRJCQxX46XdyLTZMyhJoDPo3hslRth50WrGuIHqkvenL/77hD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwtVH/ta; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwtVH/ta"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso7628381b3a.1
        for <linux-fpga@vger.kernel.org>; Fri, 26 Dec 2025 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766761474; x=1767366274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7m8ZiyHfstGYBRbGrj9a04n2E9ctj4Agtg2+8W6zYU=;
        b=iwtVH/tap4O/FuGcnazA1YTsURqWwNzf+mNZGxhkrgd9igY0sAe5uS8Hde5mnqlBFd
         pyyPV6gbxQlRK2XhiGdBMvJvAoPVKZ54HrrSBLy/DjPbJE8p+LqVr29Wi8PzuFAJvpc5
         C91P0XMMcEcNGd/dzOyTNFhUOo+FGTEav5mS9T5wQbI5Pm2jAnhKvpPhi6l1FoCT+ZOM
         QjN0QelkGfCci9/Jcqh4z8FXFa3pSLiegve1CQ8cFIqjetHOyLXmWt9JfMJ1OLFrQ+7Z
         kyu6MvT2OGpvx9f7iwaun89SO2dehTK8LB/GBaPFUAmVgiBprqtxCaGfwaJlqQUcdKBS
         achA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766761474; x=1767366274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7m8ZiyHfstGYBRbGrj9a04n2E9ctj4Agtg2+8W6zYU=;
        b=qQoPIe5ukVJ90wL5eBSghO59GrEE9kEFIFK2fKyUJgd/xKkPWDym5b8MbgXYgZAETO
         gxcjbIxwG0B+TB8x3poJDPdS0kk4mFWgK/fypc2d7pqbPtEw/CqRKXv3iC5mGtR43xN9
         L74+o8V5TeP77apfoZywflJClymJAP69jGlY7F16veLYEHLgA86k9TkxI1nxtG6JiDIm
         CwJlnmakUPLnqpTGAfmzc0uD4sieFfrYhczfZlUJKaWGUtp471XeBFoJyn5FS8UPbZCh
         IJObsd+PDuz1yGhjmljXDFh09uZDI19w5N1rTgkXPhd+HZvZnXdtoNjYIUxaf6EqeDJO
         gQtA==
X-Gm-Message-State: AOJu0Yy+A7Cw60+4345P1AAPYtRjhfwzDDL1zLI5i98LqiVnPN37Vyjq
	wo4+vGAG6hbLaVZNZxKqj92NbqHuTUq1Sv6T8UxNqmBRA7HanWrahKCw
X-Gm-Gg: AY/fxX4LRP+r+ltTfT9jrchTTCyhkDZ6hgHJnmUGptaiu+Tdsjo7Ny68eL8IJrxPSgH
	hNVJXtRYyp5X/RYPAboFW8SFEONiOAoGI4ooB9v0e/nUVjN4ivId2sFcKP/Zd7N1k2Uqd47oVRx
	yasUq+Pwz3sfAMoFZ12X9hx/HKJt/ioxnLyUfCE3GyWh0qABrmQini1nRMTIs8OHG7RTJYvEJir
	F51rcxUcCJsXfQITuCIXaxXXrnqOVfAVtHDj9Nw8GrtOTDasf7jtEKwP0Zn+4g9QvuIGQuwAihX
	nvEiEC8a+SlXZEH24NzJ2x6vHDvF7AOwUhpAIV6Hkky5CPbA/NJ1oKzo9tBCAjzgjFwC12vB2l2
	qm/Ig78011tMntLtdcZODO+OFrPB/tC4H/oMGwlOrcYxgkYah9reUtlR6Ci6Rxustp4qvV30+9i
	pP1UiiRgsq+odTJLjw1FjVjOxZwfNENduJCKO0yA/c7HMXLw==
X-Google-Smtp-Source: AGHT+IF6LGwTHuD7qQGu2/jUfoQdBi9bVpjRwXTqnjGOGXWs5XbFdP/iCb5gjktBrHL0hwXraG8+HA==
X-Received: by 2002:a62:fb0b:0:b0:7ab:e844:1e52 with SMTP id d2e1a72fcca58-7ff657a3c3cmr15419605b3a.23.1766761473790;
        Fri, 26 Dec 2025 07:04:33 -0800 (PST)
Received: from LAPTOP-6UA20HG0.localdomain ([122.171.20.215])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e88cdaesm22152554b3a.63.2025.12.26.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 07:04:33 -0800 (PST)
From: Mukesh Kumar Sisodiya <mukeshkumarsisodiya1981@gmail.com>
To: yilun.xu@intel.com,
	trix@redhat.com
Cc: linux-fpga@vger.kernel.org,
	trivial@kernel.org,
	Mukesh Kumar Sisodiya <mukeshkumarsisodiya1981@gmail.com>
Subject: [PATCH] fpga: dfl: fix typo in header file
Date: Fri, 26 Dec 2025 15:04:08 +0000
Message-ID: <20251226150408.2802-1-mukeshkumarsisodiya1981@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix typo "definitons" ==> "definitions" in DFHv1 Register Offset comment.

Signed-off-by: Mukesh Kumar Sisodiya <mukeshkumarsisodiya1981@gmail.com>
---
 drivers/fpga/dfl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 95539f1213cb..9549f63b00eb 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -82,7 +82,7 @@
 #define DFH_TYPE_FIU		4
 
 /*
- * DFHv1 Register Offset definitons
+ * DFHv1 Register Offset definitions
  * In DHFv1, DFH + GUID + CSR_START + CSR_SIZE_GROUP + PARAM_HDR + PARAM_DATA
  * as common header registers
  */
-- 
2.43.0

