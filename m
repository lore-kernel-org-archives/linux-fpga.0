Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8D3AA1A6
	for <linux-fpga@vger.kernel.org>; Thu, 10 Sep 2026 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015552; cv=none; b=Fz4SdvTXDU3ix4qqHF/RWZ2qn+Z+bDPSQQu5wVZShnnwD/BMR6QTQHv6Wlvr3fMP9YNwQ7kCBhzHkoYhA+jZy7VsMKyfqJs8osn2ivjrWkDhJ5mKZtKyMNVTbIn61uPy0D2La8h2N9x9eKrCXx0qefYdPiFXYVCKr3IS+FRBGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015552; c=relaxed/simple;
	bh=Pd4H0pkta7Qbh3kWSRXYBoydIxmEAb5Kxu72LzoN5SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxiFBXvZ1zpim29wrt2ZU5IO1zHtpBQfLHgOH4WYJ3izVzH7T6k1ljFhH/pLJ7x4N7mQaRb6u3qSHHYePFeS1MeBS8ifaEvd79MPuSOUJjF5j0PSBVz3zyNez6k5IncHnscot66Qxbwbhb/E/J2O863+iRUbD1GySWxa3FKccpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptwcmFRb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptwcmFRb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d8f265cbe6so57183045ad.0
        for <linux-fpga@vger.kernel.org>; Wed, 09 Sep 2026 21:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789015551; x=1789620351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bngJIhfOMKuLkdJ2ArarfYrqTvvdpGe/G7JNNNVxMzI=;
        b=ptwcmFRbNlMbxvvBHCtykaSnbivI0qAaudeccZ6thCgZ8xyofbvvTAzF/7NhjgYsYk
         NI3J7wERhfCyqCqPq3NU5wZ6xONDJyQlhL+Al1jcHqPyC1Iq70yPT3dYyQjbUtVEahNT
         K/2hyakw6lWI/9mvYrFjjdmUEg91iDrYkFNRTXddSwHmOs79DFxr7NYc4Hhi2Jbn0P7Q
         4zxbv54NLClhOM+Aq9SMBVmpfzNOWFibrZbncq+7QwXNE8mRazLoysurybud+d405i1N
         ILbQZiibigPVNrgJVXlPsCp+l1AtA+xDkFjzkuv4UQw7jbngvcON2oGE9ICYtWqMk8qM
         awpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789015551; x=1789620351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bngJIhfOMKuLkdJ2ArarfYrqTvvdpGe/G7JNNNVxMzI=;
        b=CBi4kNPqlUYIAGkjSLF/fdVJPQJOIUlzIm++LpRdK9GyTgzrs4q5FtgTu4utMKcKR/
         64PchbmzExBjd9k/6tEuVhzKAoznHaYIf5h+LNbSnyaV2v3hqkIANsCemvVRJLsTQf+c
         2UOUn5cBSjFmzQQmnhVlUWvMV9jBCCGjJqknBymqyruQDxapbpJNPFefTDUiMp8TnAR3
         uV5+fJ2D70PR/S3sVJVXHWZlvJjH+nvCyNLbUv2vwbgTjH9i+mhkTGhQaeh2oFwa/X1v
         FkKi7AU0yrfOS5I/L8bJ8knFa3P3HfkKdT79WN+fdOwwckpCQ4Zwt8kMRPOeLOFSBoCJ
         jvyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVBsjWfsj+fpjv1oImEiOB4T9Ij3chhN7SbSIBiFv6HQP97q39Ni8GBvGfFrBujbNsySWuzTMzC6IS@vger.kernel.org
X-Gm-Message-State: AFuF++ncANedPrejaAFGtQFxs9XswPK5Ma8X4yjt+UVP+/bttY893Kn9
	zdywklsx4o9v6JboCfAAOnvGTZDSNoCtZD8N8eOTWjWSZoP7Fs4LeQmo
X-Gm-Gg: AYBFou0B/IjkazQFpAaP2vTZLt1VjPh1veZQ4ZSJDClb+lnPfnEC9ZnH0fa9+KW8Ndg
	ZLI6QAgB4yWvpBnD0wQBLjv+kTQ2rk9MGL90S7m25Vo9EWJvTDO6LyDojAVEb7IKuFGgCyCsCrp
	NwzVhoOSHx9yyrT+GM9MNDSsNaRonTDdiCroHEgttWFSvEdF0qVtvWDXQ+IOqhcZLroECdCxKkE
	TJur74+qeML10YUKRV72a0J1Q2IJcuOc+FbWQkJx5z5KSdkHEo51uBA+mGQrVKwMOqTmhlVOqPf
	8HfJyR+oXtZU5U/RMb8ASdO6tQbcC856T9pUJ/DOQP9G6rd8FhxdSQHI561zU28CoJACH8ZFvC1
	O5nse2XSgWgb58EmeXMJO40xReoFMnjfk2fpoKSSwDsXhox55OxBIxYNVtl4MR7VaPaCBgPWQ/a
	DVS9a3QwQxofnY0hf1B6N92geNz2l+0JlUUUooqVAIqtOyP09oCcKVoMFZ8IoThzHruG1U5yxfp
	MNldCF91C3ftupRRuJalpf5fw==
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-39b26104798mr54382631a91.6.1789015550835;
        Wed, 09 Sep 2026 21:45:50 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm48377608eec.12.2026.09.09.21.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 21:45:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: mdf@kernel.org,
	yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] fpga: fix typo in s10_ops_write() comment
Date: Thu, 10 Sep 2026 10:15:45 +0530
Message-ID: <20260910044545.50261-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment reads "reuse it to send more data or free if if all data has
been sent".  The first "if" is not a repetition, it should be "it", to
match the "reuse it" earlier in the same sentence.

Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
v3:
 - move the version history out of the commit message and below the ---
   line, so it does not land in git history (Xu Yilun)

v2:
 - "free it if" rather than deleting the second "if", which left the
   sentence without an object (Xu Yilun)

v1: https://lore.kernel.org/all/20260904112153.35820-1-hemanth.selam@gmail.com/
v2: https://lore.kernel.org/all/20260907044344.3130-1-hemanth.selam@gmail.com/

 drivers/fpga/stratix10-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index b8ec2e6f615f..5aed560050c2 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -286,7 +286,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 
 	/*
 	 * Loop waiting for buffers to be returned.  When a buffer is returned,
-	 * reuse it to send more data or free if if all data has been sent.
+	 * reuse it to send more data or free it if all data has been sent.
 	 */
 	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
 		reinit_completion(&priv->status_return_completion);
-- 
2.48.1

