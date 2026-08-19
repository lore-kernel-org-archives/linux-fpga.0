Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A18426EBB
	for <linux-fpga@vger.kernel.org>; Wed, 19 Aug 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128799; cv=none; b=EPwHvjS4BmR3GnobHaqR86fe5G8zeyLiEWGjPXkR0bncVYVhZb3hTkJuODD+ANzOv0Bi1YT5F9GOMdAnctB8KaHYglkZjnq5EyXwW5zKF5BICYbnokTxQCsA4eu1aYpZ38/nKHdcyTBsl+ksTTmdb23vnui3acKkMOWJqPU8Zus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128799; c=relaxed/simple;
	bh=HDUGLWiuk/eVKtE186LgSFkZm9RmgGSssHuF/3dExcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0ZwdiEYrNWTG9LdA71NV5wM6znXXUL14WnTSe9CoYJzdT+PBK1hJV++lrSokMnCuK/Xq+o6ywNXlfYt6kMCgB1FZ5LuJ+Rbn5DrUuM3o71EIsqAo7yjrYi8LP0GpKAFEj/CQ4LbiyLngN5hN1KuSg+UHGDDUXL3Rd7idQQGo9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl4+Sq4j; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl4+Sq4j"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so7679885e9.0
        for <linux-fpga@vger.kernel.org>; Wed, 19 Aug 2026 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128796; x=1787733596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nHLYTAe2NeEYLvkSf0CCqbrwJ7XqAE4/5Y9ShekbEQU=;
        b=nl4+Sq4jKlGQJbh0TS7EsLSvpiqOtZV8m8E8LROMuwKiKYR1rdQKAFc2BxVNddL23J
         Uh6EMokNYatiZtlPTL1QIsThfi8imsdsg9cxs9NKdRg7AtNMQqkIEF1MHdtGUlue+L/B
         RmvfIcfMBWpV+zOqxcOqr6sg+wScoGO+WcjD01jMRoAawGha8oxkOENTnV5vwrca8wqe
         AHP0CXBSVTxUz2IsltbVF9Z/q1Rr2YcjA36EwHwLHu5Wj5q+ZAurAEboVkWDPp+ChjA9
         s2sCe0zc367cFACnmNORF7SYJMYre3XllDwCMunfmzgVWlKT5VhTvqSqdBS0Vwr0Ek9x
         Ikhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128796; x=1787733596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nHLYTAe2NeEYLvkSf0CCqbrwJ7XqAE4/5Y9ShekbEQU=;
        b=KNjtWyzxJqOdGBEemWxx9dHFQUORWgJ+/N9KRTkJM8Vv2QxYwsn/HMbum93Y9VGYHP
         mmQtqrDzISEyjc0mZaLr+syyBmwFz2pdt6BYd5HFoJaK6iEhMbjDvZ5dRcM/Pl5yPpLz
         fnPVaxFCYJjwZzBA2gsinb/7eEGiYnjEdV0LHMMu2jcRvFt5dhp7TbZko/ky/klJ5qBK
         fqJdCTc9zzYs6oxEzv3LfQ5vAssQa+ci/8e1Kl5I1Bt+XAZlFwIGRFX4IoMDku1T4KNW
         CKkYOpwqtCIcJExGNrZ6EzFr0llgmbir+lmbVsMlvYy6ncJVEUp8eUODzKKcM9nIE+wt
         Bxmw==
X-Gm-Message-State: AOJu0YyHbuuEKfkp9CGKrDsVlhWPCQGqD5CABqQDM+kQ39CmQqeA2hgh
	xcYZWg+cSmZ/rF/tSka2PRD6kRbrXJQNXefQsbBtbmeBU2KalVCWUHCPruRhGMdA
X-Gm-Gg: AR+sD12k2ds9jxo+IWXZm3NzZCslX5/qGcOrvrWfIaSj7XUZK61mOhjKgCSn+8+Cbni
	fuQuZssbFyBetIq7oHpwx3SxCHXlEwLSIL/fnxIOHYgBWXSsyb4PocJ2dw/T9wgnanBiWBPbBWP
	UITrH5qR8XNGdu2h+D3qEcTaJAqlB+NiMhIi1SAcVpwsNnJHyHueDN3KNr0di/FC6HQUrzxLo1V
	33zUp6g6kdG4FFT9ebEFhevImpqMsBf/Ad1h+tSmdNjZiGq9JGPBk7+eeY0SGaw1MBwvIFyl2hl
	jHIEdwkMclRj5cAITmpAR/UXlXGpYYmJuwAsleHhkU1G/fMCxcmlJ35M5S9kymOjo2w2AlO6IFK
	Wtxg1vEYkhgO3Fzpipfl4ri15Rzz+DjVGo/BXWDNT9/wC2EfwalK6ZnWWlgwc8P3A8IyBbCU3QH
	oFLIXrdspq/hkAptBLsmwu374L0D0r2hPHM93eiRiShN8IadyLpr1yyGJs0CcQIig9J2hJV4YZb
	YXqXl/n
X-Received: by 2002:a05:600c:5294:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-499aa1f5413mr53202405e9.15.1787128796157;
        Wed, 19 Aug 2026 01:39:56 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9aa1594sm42873275e9.0.2026.08.19.01.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:39:55 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com
Subject: [PATCH] fpga: dfl: afu: prevent read-only port mappings from becoming writable
Date: Wed, 19 Aug 2026 11:39:53 +0300
Message-ID: <20260819083953.1425-1-suruurism@gmail.com>
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
