Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384F2DCBF8
	for <linux-fpga@vger.kernel.org>; Mon,  7 Sep 2026 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756231; cv=none; b=DT3hDppNicQOZzsECyCI2WGQ2TkoR3D+1DxeGIsG/adm6VSEb9kgD5Up06sDW7kAJgjC6lnYZKQ9ujMpCQHhHXl3dci0fZkK33Hfytn6sBlOssJWgsTt8ArXsrnaj2Oq+V9WInRrFmD0EoZuI+JJNu+qMKb1+fSqwwn7htt9cYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756231; c=relaxed/simple;
	bh=szSxtnLkLD8y766ygpoyxw5b57yeR+v07JAH+c84q2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BtmXO7AVIi70vVu5LwzGw52Pn8fw9/GHsJi4eZeiDoBxOiU5hNAkFOvI81gk89P4rATQgmzPp70thpLvpCMcbjX4jBMJwHRVWDTFRXBSOeRZ3VOvu7z10n72maFI7L87gBK15AB7wLWcpZwGHGGDogjhdlp1w0B8Ieknb18X0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+UKFO6w; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+UKFO6w"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso2472794a91.1
        for <linux-fpga@vger.kernel.org>; Sun, 06 Sep 2026 21:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756229; x=1789361029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dPgrBT9vT0SIt0HFkd622ENZoHuhSkvhFrUGA0BZyDc=;
        b=E+UKFO6wfsH1ySkBOCQ6A6aEO3Ehgv+Z239LUNrIbetXj36S7HjNPHRBdQKyNGY5xX
         ey63YnGww33Ph5Q0mHX4XfJvDYWDf3SBFdAQMSEBn6EN9L6Tc2kznKKLE4bh1vD9pbZb
         voIX3ZAAcpVT1j/yt0/vcypB9W0r4519hS1iJNT6hAW5AsjgyQ28RT4Hk/luQtCH2EWQ
         HFOyw6l+z13GSoDv1QUF0iNVxrLBD058X2iJ3Yg5zE9wzEFg8IsaOTUvnphkqmLz9xp1
         k3Aq89J6V1z9EPZ/UzDZ1CdAU/+de6k9jsgR/bkiJo30W2E6H9WEGqFRM5J10ATE0wkn
         UAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756229; x=1789361029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dPgrBT9vT0SIt0HFkd622ENZoHuhSkvhFrUGA0BZyDc=;
        b=a6KSdTanzvExnmMMjlUxL2GZ8OqRbRAzSI4Y2+hsT6mNGWk8CpiMOvAmiV+eDXBo3n
         YWrajoVDpYb6F2IkWAtnjr7PBehM1YeDE1gI/DEfoWbYedj5U1dzgH01Yt1EwucSUyLb
         Ai7SkZGL9D+s/J3dcpBvwcKUp19weKWfajRLEni19CBRr32G6TfTbQnOfgCppPf3K15y
         iYF+GDLbxE/Ty+7qPWgKHWqZTLd/w2d34wwAoWvKQgbHPhxw3/rpfBmCbJPwdycYTUIV
         SPV7pQSbgphQ4CxUUkq5c6fhUOM/FXIb57xks/HPcBRRnYN7cnvYFH9pDzNnKP+GmThS
         eDMw==
X-Gm-Message-State: AFuF++msE6zUXvFGzD0hOTfEhWNWCaqQAS2jzzjzCn/bbiyBxrBw/3fl
	F08yBBnGGCUdhEcGVFZH38idI5i8slvnAklAk8BdetnFw+TzlAsDm+vP
X-Gm-Gg: AYBFou2uQxQtOW++vE+k8oKcqasTbDzNoF1hhEJudr0T+dQ2AMcTbFXyeyWx6B4peEO
	Vx0S23Z6XsxKWX9Bk9PTrPqlutRTfOydeSETjPX1WrrhGoHlcirmESYs4C6DeZKRDpKR3Dqin26
	DxLWmEVn4H4GqE80SMlH4ea7RgQzyAD3UYRZtjnjwxRMqtM/+h/qoOkSifEc+jrv5olbVcDSeNY
	hXkOFyrjvbwql3g21USq04ONcsl6RnGE4CaZfWyFR4Uw+lrI8jX1KYuj4qhcwHNyFWR9xLY1ov4
	hbTGHmPMaNTnqADgZrV+NGtH44uH5tP15wiQKvrJFJUeZnYnpprnAeOWRrdzQzbdf/RM9IR+Tzv
	EOmhZBvUyCJzDl9L7tkNtRV5qnmRmF6/ISZjfXbW2peH/N+ygIxqMbMUdpEo/BkT94HeGs98Yu6
	D2CvoRl/b8xSbomjmXK08pf95EF1KBZjLuuBT8vKfF7oVxqRjX2KP3JSI29iH0jbC9ESCF8aDIU
	DGRb8++zZi3Ug==
X-Received: by 2002:a17:90b:5807:b0:398:9be9:ab8c with SMTP id 98e67ed59e1d1-39b26229bd7mr32443957a91.17.1788756229132;
        Sun, 06 Sep 2026 21:43:49 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm23587320eec.13.2026.09.06.21.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:43:48 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fpga: fix typo in s10_ops_write() comment
Date: Mon,  7 Sep 2026 10:13:44 +0530
Message-ID: <20260907044344.3130-1-hemanth.selam@gmail.com>
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

v1 deleted the second "if" instead, which left the sentence without an
object.  Xu Yilun pointed out the correct reading.

Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
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
