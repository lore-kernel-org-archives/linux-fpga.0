Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60542C4E7
	for <linux-fpga@vger.kernel.org>; Wed, 19 Aug 2026 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128941; cv=none; b=Xur0Yf6VCiZ5ThiwbU2b58xk+Bon65ct8mcTO4F3JQlypyVkZHalpJ71rOKUk6QYLFD3TSL7t2qHpyteHSAllNW3CG/Ign5IMuebcBJuQADty9HosMqiMBeeXbqyzhw3g91CO9lKCQsA+VXf7xFt1rmTbodUAA8t1QrJaJGp4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128941; c=relaxed/simple;
	bh=HDUGLWiuk/eVKtE186LgSFkZm9RmgGSssHuF/3dExcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbfWDLpu9a9Dwlcsaq74W4lMlf2+FcT7IFuGtcnrMQcoq44/RuptXMZsSVmfIDG9q4wqM30ZvXH3cP6MAZAkSBgQUaz413Y03zyN0zoTJ15FNy8CLB633BgrvBsjjdkNMFFQthwOPuytYX6g9N3bede4OW0LyXcIxasugQ+AAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NntbZKjt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NntbZKjt"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-499a4d1d7f1so6021635e9.3
        for <linux-fpga@vger.kernel.org>; Wed, 19 Aug 2026 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128938; x=1787733738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nHLYTAe2NeEYLvkSf0CCqbrwJ7XqAE4/5Y9ShekbEQU=;
        b=NntbZKjtz8sxVe2VyeHMUb+BORrV4NEPHlc2SccvkHnbLXjxaV9AKsP6FgXcz5Apuu
         cAuMZRHIcvz8nSM/ukomcOPKLjefeW9nzvNQY6cSnwcnstLXDq1gWVxF9hMot2Umm7kZ
         3dEFN1xf5MMRPSIfLCpM4gIl+cC1FtrU4yGkS9WwNH11td4VF8BA36jKFNAj8xwhfF6s
         qV3uMjPd1vwg7iiRwAMTAtB3Xoe7aJ7j2N8LmdgFTUQrKTUV+F2CMai5cIj0He/o3VLc
         2S9vymmQdM+nSUVH/NbMpkG4SP8U3KJ+yBic4mVm1ZIeOoCrafg0Hhp4MUJzdMeifaKC
         szqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128938; x=1787733738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nHLYTAe2NeEYLvkSf0CCqbrwJ7XqAE4/5Y9ShekbEQU=;
        b=dnVJIvZSbf4ltopk1KE0wBjG5hwcMnwS3KgThNi8jA98Nv4+XA1t/z/6LzhBGy9wnD
         ExRD11c5CSWi9Dic6YuQFXu6qMwtH+1e79qdkC8AJSj4kyLWnBvqMoS0U+Svrr53XZRd
         KrdHgDxags7n2fjJHIIQ00hQGqDKqbBEbPiSAMvLXaNaPkjqdRsRo4LA+IW+B+RYw4gc
         LcTCUs7GQDJYz6Lxjovx0LFrc8YubpfZ+irzJYKMpEGRVUVE6T+xB0woHfYnTJAcmNIX
         epuCA1MojZyhYynFLX4K5G63IaaizQo+3rONIUKlSXGchflsmHJXx2MZphntWndbPEXj
         MSWg==
X-Gm-Message-State: AOJu0YwWcz/X/VZfY1Ky8RMCEXUxobkVeTyIYNH9z4bxywXaEJCS8rab
	9ay6lPmUQ3dtiHaWnrUtPSD3+mBg3AiZNcA4IbC1hbIxXDH8d2/xQjf94VfKuDA2
X-Gm-Gg: AR+sD10VMgoMKn8jR1n6XrjWi3HutOCLUQRvq72iBrkHSF31VJMi2yhrELTt/nOoeIa
	CVb1SN//WZnpe/HzxjsUR2/khd+w0AFcjWMNYoi5DZCbJEHVJJM1PFLxZO1CM6lMO4Vm7Qrl9qm
	xsJrd+KCeo8jXXOLvUq+3AybLs9ZhKQylwXnmlCgcNQbQU3LEn5/AI9BDgZXi49mEqvQrKAaKpU
	+57t0XzLoM0MQLBq5LL+oYZsBrlqnC7o4QkQ/ZvsD/HUl8raHD0Zs1evosnvoKUWZEEKoHte0I1
	h5NaqqkCjszXVpvniTJT7AOTP3JDu0Txyyl13NcKpC91wRbh7utthPOoPntI0woUkJFHC/9nzNN
	HS1j8hF2zLyE36BJwfNcApp41AFDGRNApC3b6Q9/c+0qvD+ASAjRqrZlTzNsmPPt8fFQMLdqgbR
	+/M3vuBX8LQg0J8n6D4WR4Tmm0g1upvn+gP8vRQwLpvpn9qEKm8pbyeuIccUs2ETbeXVBs
X-Received: by 2002:a05:600c:3e0c:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-499aa1a3e87mr54233705e9.6.1787128937141;
        Wed, 19 Aug 2026 01:42:17 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm48420125e9.8.2026.08.19.01.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:42:16 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com
Subject: [PATCH] fpga: dfl: afu: prevent read-only port mappings from becoming writable
Date: Wed, 19 Aug 2026 11:42:13 +0300
Message-ID: <20260819084213.1560-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

afu_mmap() rejects writable mappings of port regions without the WRITE
flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect(),
writing to FPGA port control/status registers the host owns.  A guest
assigned an AFU can use this to reconfigure or reset the port and
interfere with other tenants on the same FPGA.

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Fixes: 1a1527cf5ddac ("fpga: dfl: add FPGA Accelerated Function Unit driver basic framework")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -836,7 +836,11 @@
 	if ((vma->vm_flags & VM_WRITE) &&
 	    !(region.flags & DFL_PORT_REGION_WRITE))
 		return -EPERM;

+	/* Prevent read-only port mappings from being upgraded with mprotect() */
+	if (!(region.flags & DFL_PORT_REGION_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	/* Support debug access to the mapping */
 	vma->vm_ops = &afu_vma_ops;

 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
