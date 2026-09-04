Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE842AF9D
	for <linux-fpga@vger.kernel.org>; Fri,  4 Sep 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520920; cv=none; b=g0e12atVmzUeIBl3LhpX/Pc0UtZMuCyYntcNioGmA8VvuEqKOyKAQpP9DxNxhAEoOWpDfor3hdafz5SHAVypWd+WCzp1vEbM7PVVeb4pIQtBahQUpHhaEX4Jjl8Z7zWKyC5MI13TyzwQsM4lSkb/e+4m5lcsaButu+ey9NoIUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520920; c=relaxed/simple;
	bh=Wc6pgt7YhERBx8wee7jvDtqzYFDwXexGEaDpDSo98GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLt27tiSjLbBJIyHN+taxrZQiNAzkEoq46igwYtz1ENyiKLqzIwmMzhkqlROX8m+hAdaQliKahJkB0UpcolVCHRyNm0znth7nUFdD+63HefTqjJi8S+BNtCtk1lwv3zoyYqW+QRtCeYz+Po6JShBM0/twwhTV2vKyy8toRzBtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyseFi/y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyseFi/y"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so985249a91.0
        for <linux-fpga@vger.kernel.org>; Fri, 04 Sep 2026 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520919; x=1789125719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YpfeOJNW2r8GlKUp3djYiRs+6CRfoMBlInK9gOtGNZ4=;
        b=SyseFi/yibuyIuWHxNbyIjbqpKlDzbq7EtUvmpC76WV6YvUxxQixBD8Dv7LmATAYa1
         baXcGmxifDGydx9/UxJnTxG5QQLgfXWxWm0yBWyj5Urtemp3G3lwNXw36u9dwFCkItgO
         gpYEPZyu8xvy2DtAOkcsytV8tuQtdzQDcPmmzMS/BBk+b9s6g0kbxLukeddkmD8qdhBq
         BqsoHLfW/nF6WHleNfdBdPy28qkcU9wF8AvbyFvVMiSZbB7LAr/1UvHfCo16I03J5ezN
         yttDpj/HLpvEd4DEezS8BFDb0jo3RDlGekX+RoyWz8Ke3Ymkcdahuq75aM0zjF+VJXVh
         TxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520919; x=1789125719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YpfeOJNW2r8GlKUp3djYiRs+6CRfoMBlInK9gOtGNZ4=;
        b=Ma5gZLkXqCFRciCbWUurT3ohoMf80P1iL9s6PCtT1br4Wxx32Fxa1Kkat25tKDFctG
         SMcZI1vxDH4cFVdTWYJVj1TCAlpyv9Cx0dB2uvzqsBVmEqrD0t9cLbefPWHd4qFrB9w/
         TCae98Oq/wVokpe6ItmtfFweAhBY6vkbzjccNrguTIn7Dw4BhkS+pWsNLbnkwIAGopQs
         GDiTmT60O6LlK6V9OZYP/pHqa/BtLRQwPbUvn8z+VJzmKhdhQa+nZ/tdKupB8VROhL74
         BnBPdCNH3AHknwJJ3HbDaTvqoeUw4MmMskDeweD2t9d+x0nLJSfMlsMvkMbL2DlmERqW
         8JhA==
X-Forwarded-Encrypted: i=1; AKwUvBxxiF5lru+sgCzsu92o/ugenLP2jnia97mpCT2Su4atA1m/7T1emJlh/x9jnj1DbrhIZAZ3ALwea4cf@vger.kernel.org
X-Gm-Message-State: AFuF++nUXx+TLIWnnYpRVoNKtfCQhAAxo94J/EJ8Ctsz6+9bpyywJ+QY
	MJpXIUwpSECVKE255BNDzfUiYEW1FB+b+foL4p/EYBsxPImXo5/CTetz
X-Gm-Gg: AYBFou2U6vh3kuOBhEeIaM5GNGbGfwX654X1lFDjF8NUfVHSgKSN9ZmsiT30mEWJZpQ
	3APYmIuoCWVofhG517h5iDuQw4e43AKCjVqXSCqmR3oeJX1dzsE3HfWcZxMI58ba+RX8SlFkX4C
	Xk/4s3As+BKr26V72fKQ1EZZBReTnvCiYQLvlaQa0DISQUMqr0JLtfK4HZ+tgR1pLHoKGC1CdR8
	UYUvdFOflyPHdyfAC9MeWflWp5X1A760aZ0XWVBhFJMgK31AKaoQApb4JffjP2DnoUJqdW3MYpt
	sIHUl/Eg33XaB8yh0O1NhvbRIkOb8IqFdnVvj7g4cq2HCJB2EASM7+AWKbW4Sn/m6yN/7vwd4zI
	ypZFxmFv5hd2TcUwpyR8IPmXmfGy7wQa8xOl0BZBztf5XdPUhn8P3WsoVWxAq0BvIAe7Gn6aebU
	fbG+peCbZWU2gx+YYZ/OiWVwr6x79f5GY+K32btsGyXnGJ6jaPsJcuZB0l6xtX0sXAFOupl2OmO
	i84mD5iRbwGFQI=
X-Received: by 2002:a17:90b:2e46:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-39b08653554mr16094570a91.19.1788520918783;
        Fri, 04 Sep 2026 04:21:58 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm6121711eec.26.2026.09.04.04.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:21:58 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [PATCH] fpga: fix repeated word 'if' in comment
Date: Fri,  4 Sep 2026 16:51:52 +0530
Message-ID: <20260904112153.35820-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'if', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/fpga/stratix10-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index b8ec2e6f615f..c08d60e3c85f 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -286,7 +286,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 
 	/*
 	 * Loop waiting for buffers to be returned.  When a buffer is returned,
-	 * reuse it to send more data or free if if all data has been sent.
+	 * reuse it to send more data or free if all data has been sent.
 	 */
 	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
 		reinit_completion(&priv->status_return_completion);
-- 
2.48.1

