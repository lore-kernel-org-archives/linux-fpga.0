Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57634390987
	for <linux-fpga@vger.kernel.org>; Mon, 27 Jul 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166004; cv=none; b=cv4rJGaJ6VcGVFGx7tbAy3HSxO+aNaeOq2J3+JO6uFJSO028OGeHGxdYl2UicQ3W8Dl4Ot2GGG7fXTskPzaT946jxjVOwGEppGhYqvryyW3wCxoAT9a2blZaHoxsTkYKtKtc2WsD52W0ossukxZYBsStnJ6NHnh8p1lPJCgj8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166004; c=relaxed/simple;
	bh=ISP610h0pIjGjDJdZJ9iKEDs9O+oLvjm3WkEqRp142A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFOJg3rJ2R4NkCYCkQ8MnA1B5Gb1S8M8u5Mi7y36A7MvLV9jf4Lz+uzOVqFSt0WorfgtfdVD5Zz+rr+iDUpQT/gW7kKB4uwDg+mVQNP+BFp3MGd42TsBlW4ZeplcazkqmUyCGv04xG1shPKGyXHh4+EuWtsYQ7b/DE4Bgi1zbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abu8ynJq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abu8ynJq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso2870249b3a.1
        for <linux-fpga@vger.kernel.org>; Mon, 27 Jul 2026 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166002; x=1785770802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZfaESFDQ/TT+cWft73CT875+I8BWbYNhIvagQldErE=;
        b=abu8ynJq2iqv00w6xCCgNATO1OcYMQhbiwBxrcV6p+S3yDaofQ/aHor3deWIkFBeab
         X7M3ncR2FurWMnOQPDFjqXo5d66/R08hRFwcx4mngo5T86BKI7EJXoghY6hXl87XgNgB
         3QdcBR8cgWVy0lMuD2oK50f6wmxrjN6puZS4r4EZA55iDyZb8UHXE5FWVpTsuFaiwzwq
         FQ+7Y0A3vqSp69SIdoBWZxN74FUxIceZVNeIKgnz15RcVoeKgM69UxSRL7tRb6G8SsHW
         14PAxzfUAfU6MnZKmJe4KttYIQsRj0VAJtvdD2pCn7DMh64x93APtLnV9ZGo77TFXatM
         sOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166002; x=1785770802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZfaESFDQ/TT+cWft73CT875+I8BWbYNhIvagQldErE=;
        b=ixvULafi7wgp3Rs25YTrZw/egdhlYxAEKRXkMPF4PuPSBVaboYa/W6oM6kmOh+mHlI
         7w67CcAtb6/vus+Zz3v1RiKtCRUaRURMLzjFSPxJlcqBDwh8Sq7ixg2PsNlGn6Pc77jg
         aZpB1rpQBLw0RrIPd9etbc3Inj1aucP5KYCyKdNVR4+cMlDFyIUMFVWhPRoHReCe1pBv
         LeC9ANLw3ky/ohJ0b3vLQfDOlG3i4DVpqrjSLXYLPw2hvQ4WUSFEOaKQIROl+RtvGBSa
         EKDZwbDyO7GpU1101vd54M2N7ZRxepoHasZqVBgDJdQXskr0whHGT4Z7nzCaFrPZdIi7
         S9LA==
X-Gm-Message-State: AOJu0YzZbmDNqSyYuJ4JclQwMp1GOE2iZvhYvWrQxptcdkfk6NL9+b2r
	sqvwp39XrCX120r6mn/wL8ddEGLuPLlQJ2PkqiEPpe4cnGDBblkDHV8=
X-Gm-Gg: AR+sD11if8r+PXu6Sc2bNKTmiyOS60dMFyKY1CDYBZaS5XthQej6jqNng0hSmNcRXkH
	ImdsIuv3j8r7vEUhbhTBKRmlsjvurfgwJq4/+vf4MjY5+dBOq+HEV+19skfPWWMj1IhKfUEqV8U
	kU+IrCcnPHxHPE19YxqmHQU8Fnr0GsY7ooYcKOFj9XCybY7PPIwge8SOlRZhkTY/aS/k4IDbceS
	w3GyUnZ0Lp5iK2ZQCCE1sY2yD1RWG1xsBB5yaLj7W+KSk+HHXKmSBrAy4K3AQiiMZUntoEP1Gm/
	cNt1IwDhWQo4eL3qgOObDQl2cdidXGjpG7bCRtVZ3DFC6UC0pIfRih9R0WDHz+WaNup5nTriqwN
	uJv8cvDLqp4C9cflW02z8ALqDwMzagKWbynapHmkuK1avAX9r6CgxUcNUrnYYNkSCJF5md/lI3/
	7Wm04=
X-Received: by 2002:a05:6a21:60c4:b0:3c4:320f:42f4 with SMTP id adf61e73a8af0-3c67df86a42mr8708325637.56.1785166001492;
        Mon, 27 Jul 2026 08:26:41 -0700 (PDT)
Received: from localhost ([2405:201:8018:1843:d8be:597a:58b:f8fb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm35908967eec.18.2026.07.27.08.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:26:40 -0700 (PDT)
From: Ayananta Paul <ayanantapaul@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org,
	Ayananta Paul <ayanantapaul@gmail.com>
Subject: [PATCH] fpga: dfl: fix spelling in sysfs-platform-dfl-port ABI documentation
Date: Mon, 27 Jul 2026 20:56:34 +0530
Message-ID: <20260727152634.5983-1-ayanantapaul@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "responding" which was incorrectly written
as "respoding" in the Document/ABI/testing/sysfs-platform-dfl-port
ABI testing file.

Issue identified using:
`codespell -D - -S "*.bin,*.o,*.a,*.so,*.ko,*.gz,*.png,*.jpg" Documentation/`

Signed-off-by: Ayananta Paul <ayanantapaul@gmail.com>
---
 Documentation/ABI/testing/sysfs-platform-dfl-port | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index 65658267fcc0..40e555abca20 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -84,7 +84,7 @@ Description:	Read-Write. Read this file to get errors detected on port and
 		to clear errors. Write fails with -EINVAL if input parsing
 		fails or input error code doesn't match. Write fails with
 		-EBUSY or -ETIMEDOUT if error can't be cleared as hardware
-		in low power state (-EBUSY) or not respoding (-ETIMEDOUT).
+		in low power state (-EBUSY) or not responding (-ETIMEDOUT).
 
 What:		/sys/bus/platform/devices/dfl-port.0/errors/first_error
 Date:		August 2019
-- 
2.53.0

