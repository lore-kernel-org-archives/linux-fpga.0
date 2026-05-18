Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB8390C88
	for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131285; cv=none; b=daODSqTxD1Jgyj79pAztNK/joVtj5zVdRQnJ8Oq79C3LDjZjTW+Luroyv3ELKUwmrtVijq3mVZmd7KKVzSPCE2t3tg4PuJ90TR/laCTav6EWOFF09yHhZIDog0ga+WFCf0lhB4J72TqeHmNw8944ZCQbaaz5Blgwgc+Im08g+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131285; c=relaxed/simple;
	bh=cyubYiPMoczepqR7H+hZPOJL+jDn0Z9aHj+sP8Kujlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMTpEf0S55aGtOxb2NNA79Of3bmFKCzin1R0jWEzzaFAjjuIJLT12dinEU1Rf/z+5aPqGnPU9SUSq3KJm5PyNBSHj5+AMgkuP2uOD8dOtHxVupHtibyHG4+5VJtqGaqxBOgoLZp37+QRe4D9nPDGVoc9lYeTyOqR/urw5+vlV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNThfi+9; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNThfi+9"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6530287803cso2796675d50.1
        for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131283; x=1779736083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7T0H8dfncXmprC9fFYzqugkaZEoxcqSE96XurOHhvI=;
        b=qNThfi+9lnMXXFDlJdZa+xEqovyClsnwI2Pl6/vrk6DIKNDz96EI1BzCieKv64ZW73
         VN+e5DkPFt3WK8ImevzuSoGpStLQTiclntCTtDiw1YVm4MD6DkBXho+GGjBI2XP5Swn8
         egn6OucTRwGX96aCCXfSkSO4K+AmWI2GP79l1IqNUL7nEPWSQNChOv3olKP8ZrDZFM8q
         XhA77bBpSga6LVmzL6ph9+ouVDLIrM5FQyhwtOeDdmvpOa1CJ4MVefeu87ss8YijD9Cq
         lzEI1owedC/dvxYdz1TEqiv9ZhQfea2VJOyziHUveqxwEMDo/RJOZgvwLDEGZYehLmhw
         4sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131283; x=1779736083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7T0H8dfncXmprC9fFYzqugkaZEoxcqSE96XurOHhvI=;
        b=aJjbYFhn4V0RPftK8KypSvQ/gRBttB19BijeWwJKntNdxl5u4NiP25/Ug9k6W7p7lS
         uEHQMbDGSR4uqhVp3U4lLfP9poA3SMWQpXOm2X7X1lNJ4bM6eMHjL4GvMfkjhLRvj/oB
         8D5k6MVqWadC1qBy5/G2tBCVVyHmOv3Tan+Cy82rk5yixLKkmtFUExFabFE2zvO47fRh
         5n87M612Apnj1+aGlxCoUmFomuVrFCyTMvQn80GTRTVDQ0GKV5s0duvODahVX20Yin55
         mPhbeCiOuDsEITzv/3VserTWGDIChcxmQ4jg7FVIVmvvIHD8v4azA8DxxEAch9shmxKZ
         Mv3Q==
X-Gm-Message-State: AOJu0Yw7sHSgCPvk5ikCd8DMMTLt9ZpZYIqB4nacKQc3xyxwoVHbqSDt
	k5aD1pQwFoWlA0LAmr8yQdkA0VkJdgT32RE5f9xXT1MxFIi7eBmuXAJj
X-Gm-Gg: Acq92OF1419yYIVOvHR6XbPpZLftwbbUsSTKb9WW4aZK6fcB6gx5l+iZ9TCjosQ0ZM7
	SHybV5vx4N+cc3SeJ0gwnSpDFll8ebNDVI8Z6IxwMpVSAutv6hSsxFndX3CLVyqyjM/UwAtJ0Oe
	HeOG6dzrZKEU3rb0KcJgc1V+SRjI68oxDv/7acexs/sasEoqXolOkMRYkZWt1PMnGCsB5aDbLlZ
	QZA7Qd9AFfrTVWATIPg8UDL09p6oO2SmT6lMBZbZsPh2oQOqE1cUKpGVrw0+8Ww2mUTkCd8/Ohi
	7UhyfymKdV647zfph4ibTvuZDjb5hjFIKpJSNdOTrXiKP/6ILPMfJSea8eoV7C1teTFYBx2Ckh/
	A/QkqgJINEGVYVynggLSQ9uxbf6XFa0Qti8wYvcLEuagi5fpRqt+65ptff78YVU7gl5WL0QIZlM
	qd3GpDPR32aT2iSR+yPr6Ecri/rnBgeMVTdaTusUa3pSO5JQr61EpU29uOPwFL3Avx3zDOLtHOn
	9jnK70f9ThQVjyh
X-Received: by 2002:a05:690e:4409:10b0:650:18fc:f557 with SMTP id 956f58d0204a3-65e2285bec6mr14123598d50.56.1779131282796;
        Mon, 18 May 2026 12:08:02 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm6766160d50.11.2026.05.18.12.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:08:02 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v8 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Mon, 18 May 2026 13:07:41 -0600
Message-ID: <20260518190742.61426-3-sebasjosue84@gmail.com>
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

afu_ioctl_dma_map() accepts a 64-bit length from userspace via
DFL_FPGA_PORT_DMA_MAP ioctl without an upper bound check. The value
is passed to afu_dma_pin_pages() where npages is derived as
length >> PAGE_SHIFT and passed to pin_user_pages_fast() which takes
int nr_pages, causing implicit truncation if length is very large.

Validate map.length at the ioctl entry point before calling
afu_dma_map_region(), rejecting values whose page count exceeds
INT_MAX.

Fixes: fa8dda1edef9 ("fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v8:
  - Add Fixes: and Cc: stable tags.
    Reported by Greg Kroah-Hartman.
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v3:
  - Move validation to afu_ioctl_dma_map() at the ioctl entry point.
    Suggested by Greg Kroah-Hartman.
---
 drivers/fpga/dfl-afu-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e7338..097a97eee 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -723,6 +723,9 @@ afu_ioctl_dma_map(struct dfl_feature_dev_data *fdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(fdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
-- 
2.43.0

