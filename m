Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31A25B0AA
	for <linux-fpga@vger.kernel.org>; Sat, 12 Sep 2026 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789207785; cv=none; b=uAuiGaxnFqfi7EyymVSg1dRgPxoXWANlsClGuS6A71AcvaXCzQCgSjHF0LnEuVcYEYOiIM5rJjPfd1T7BpR/nKauUjGWuzzlDKfnzjvN9bF22IXVLHNj6073k3WADBg3Q9yA/OgwS8ck/c+Tl6JhMLqy800a5QTJ7qt9TF2PKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789207785; c=relaxed/simple;
	bh=v9ViFWCtxW/zxHuQufqiHJMj7bOlWvbo9EOZPYRc76E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YJS6AXH/TmQlM2Qruoywt48NTqfi48orjwfHEtm1pdxseCVh/wMzA5TX5Z4O30Nzpt2qTvBSBp7lQOSBuEk7eswSKebKSA4+bZZwT2x+vmW8e826Zxyu3QpoNGyVfmP+KRONTC5i9DlgWyNZVpjDvjk/Ec+f0xQVSnb1TPL4h1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NauLUaHs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NauLUaHs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso7935245e9.2
        for <linux-fpga@vger.kernel.org>; Sat, 12 Sep 2026 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789207781; x=1789812581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1W8AsMdmrXRE5TTBDW1GBqzHNpVIxdQkkdveRPDbSJ4=;
        b=NauLUaHsLpxxOgKsKIO+WK/rBNt9nwy8Tv2nP95Qigdyruab4SSxtIIOISqaWxSji0
         lQO/D3AATe6ObazCgiIKruIBQ2UB24trCvRlzLONP3tQvVR2zWgH5ngWqBSTal+vofNI
         Y/Ud7UZ8FL46sTzbKlnOA5uH08HraSzS/0cgqWtuJloId1MFzI0inB8KBZZt7tUvfVuh
         6KHBUxh4rJWL7wnQcnF7sfZ3HhCr83Dye5QksGSMJIvyFxrJjj5PCqowfM355RDRWk6c
         lTJj3uSL3wWM6fhRJAGkhpHs4JtKPafzkWchvvHQrHKVuzF1M7ial/Wn3UegisB0LKtx
         YdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789207781; x=1789812581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1W8AsMdmrXRE5TTBDW1GBqzHNpVIxdQkkdveRPDbSJ4=;
        b=QN9EplL+MN6fJ+IDgYtKKJIKMLwtIlKNzMYMTfIUJfvlSzRMhPgJ39hFDdMqBu8Vqe
         XnO8cztzRrWS+sSWfQ74fWVgTzQe7hJo40pDxXSj9CofSgcpq9kjQxU9d91ZhKp7bCjW
         HuZfpDHFBC6Qz88NOqegZmneOQnvHGTWBLqNiq1pJDOeAjIEIPOJhs15vju2ap3PKg9u
         R/qcyUbGuio3eOgMyHnyrvf57z500voCKhdlYUtVl8xZaZGWBiYrfIkq2mOshKjQ9O/P
         rulwEwyZDe97lxUjTTkUsQhA4viWj1npcu2VfIMZLihTkIKB17tzTK8aeXQcteWqPVPd
         MKGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSX81bg6xNYehbOXXA5Ks8pjD+UYd5wjJK7/7c6oLcn0G5Wp07A3tBnGVKBHByJBDC0TeIdArsWfl2@vger.kernel.org
X-Gm-Message-State: AFuF++nwOpPUOfGIuF93zb0d0rB9LcWgG3Mr4oK3rV88MRcaR8tWK1hm
	IXUkpMus5GBGXbjSK8mXYLL+AZ9fYagCNZ7n/Bo0By2WzmLF3Z7jZWhC
X-Gm-Gg: AYBFou3OiCDFPHMtInRivs2vaVcHhy2lc2ZxNB8e8hdwjxJbtcEm6YBNMxUrlQPePML
	Chh6qR46c0uluE2TAbRmBOgQlQTZuMmHNfQyhGasLW4Lfvch7FuFwmhvd9w2TxdC4JdE+JhT7E/
	1KrBDxiv9dNT2m+x0vInS4a8+BczT4oWpEzqjPe1cGUAGJlO4T+YsR9OWU5frbXDdupEywRyKO8
	SRktQbl8jH9L9NIwQBCh6pbJ1+A6e/lPpsTO5gBgP9mvBYS2gLzwWcvJs2P8dZKxVFiOWvWnmke
	lZhLjklve5FogWGNlxa1+5xq0HHjCB/OxL/vx5vqKUJ0gxBolH3Rl3G3Vrmk8ek5xolFhkHrFn9
	Jto4foh1Xku5K8tF5NRwpSkxhzUd1hHblw437saQzTiqp1MkwEHe2YgRHLoWOwXOp1My7Ul+7I1
	qS1QsFmUJUKJYGZMNPgGFvLdbabipnOO4t2ifl3/F29FEo0608rVWu5ynT+PAAvVmmq6Ru6dmiO
	8PcH3UGhJDTO/udEkvX5V0yA40E3QyXVz5ZBc6+tFR8Nqjq+VFC0aLrhR/Giy3Cf8kbRCCwLmZp
	GRSzJXdDl+d6RZoXl3mB3vhVJQrBGGM4tp5pV8hozc60sKZ3gXYu6YFqHB78V5m3gBS3FjTq5TY
	bJA==
X-Received: by 2002:a05:600c:3b11:b0:49c:f617:7cf with SMTP id 5b1f17b1804b1-49e61645c2fmr153458935e9.0.1789207781220;
        Sat, 12 Sep 2026 03:09:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60acff8bsm149239155e9.9.2026.09.12.03.09.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 03:09:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alan Tull <atull@kernel.org>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: Fix of_fpga_mgr_get() reference in fpga_mgr_lock() docs
Date: Sat, 12 Sep 2026 12:09:37 +0200
Message-Id: <20260912100937.86316-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fpga_mgr_lock() comment lists of_fpga_mgr_put() as a source of a
manager pointer. The helper which obtains that pointer is
of_fpga_mgr_get(). Correct the reference.

Fixes: ebf877a51ad7 ("fpga: mgr: separate getting/locking FPGA manager")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/fpga/fpga-mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 2672070ced026b022454e730520ab147fb02431d..5a0b7780b335887f36f7f182c28c8514f75e1733 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -744,7 +744,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_put);
  * @mgr:	fpga manager
  *
  * Given a pointer to FPGA Manager (from fpga_mgr_get() or
- * of_fpga_mgr_put()) attempt to get the mutex. The user should call
+ * of_fpga_mgr_get()) attempt to get the mutex. The user should call
  * fpga_mgr_lock() and verify that it returns 0 before attempting to
  * program the FPGA.  Likewise, the user should call fpga_mgr_unlock
  * when done programming the FPGA.
-- 
2.39.5 (Apple Git-154)

