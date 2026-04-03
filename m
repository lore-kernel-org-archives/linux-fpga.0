Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599B3D4130
	for <linux-fpga@vger.kernel.org>; Fri,  3 Apr 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239206; cv=none; b=nA+iOtsTBYPdUNRwEuI/h2UI7nFD3hUGfBlb+s+FbU1Pr1mRnUJXvnylo3dKrPr/86drGna4gkOB+H+vYwhl4fdeXBCQ0PWPbm7VuI5Nk70Y6aBJGo69MLkktSp1PtfQJKrD+lYvQn5/KjX8urhfz0nZt/5aVVcSapOKfxZ5H9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239206; c=relaxed/simple;
	bh=2fsLGvVY0SMsUTJJT9axs6GRqBZulL3PUToPu4loSEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqFunJnheIo0i8H7XsHi866ODztpu6EyayZf1nN5bZen5a8vpBYw7PdoTPcGm6BJYlcZGJCU/XFOJcTt7W1+bP2gpYVaW2xVYu9eCFgMzeFLTqYYYr+VhdltMdb7anCNRqf79T51lR8R+tebfmU6rHiJz9Zuo2BX0/nudpASwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkJTvl9m; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkJTvl9m"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56cc67e01deso1919520e0c.3
        for <linux-fpga@vger.kernel.org>; Fri, 03 Apr 2026 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775239203; x=1775844003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijE/S0QXUtP/n/cKmQTpWwB/oVtiQCLvUkDKjZ/lj5A=;
        b=gkJTvl9m0FHIR7FbVv7yX9QVezT4/biaKuikfmldrp05b7OjM5913pCnvbBZzmFp5y
         uxZLrBmae13hWUQyRoFNom7qXsv+ukv6V4evuKJVQNBYk4KNOaKj7l0f5ldZ+f/E54aw
         E6t6cwfSzEfAn4Rk52w8Cvr2/A9hFdSCqm/C4PnitAK0kqXQzW+KvzJ+IBJZkxlyMQiy
         efJSYZl7X5EpVNPMYS64/uEQ0ZkJXgp/yQHmpqW5sy1TCPNLOYi8zs/Kf/gQKYK1Vkas
         M0b1kqFTOFbQ+nQ9FkPknA5dLGC7WTGeGeAt+YKKfIeUDGtWNtQnXUF792OwXXcIqbiw
         RVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239203; x=1775844003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijE/S0QXUtP/n/cKmQTpWwB/oVtiQCLvUkDKjZ/lj5A=;
        b=D7LElNM3nLyhwaaIRoVwaYWzaxjaFskrckv1/Kb3KLVp08VoMmTetMrWNmHCEQ/iXf
         VbH7HDnbFsJFtEA4CXioyH+XiC4hrAcYe5pP/3ep7A5wkkzJp1vrlW1BikRGJPFjO/Qn
         ny7s9Qz8uZWg4XS/XKwFOfhkCPwffNnv1qGGNeEzbyzhuCTeWd72XQwNe4n82vXuJYA7
         XYeXRL33L93gyH2B8Sb39bNF5yH0KAbuUORpcoXPR0/Jvc1irw5GpxTDOAaFlVwF7oLD
         FI2F+aVi9WHCGHO0ZX8KTGIWOVrWJCXiMBuObQ5sFWwyNcDkBViCQd8RuoeqaWIDZH4L
         xMPQ==
X-Gm-Message-State: AOJu0YwPR7lNdSfQMUO00F7qsiTmfaSmp6v+B1h8jwR+VQt1omKiETy3
	esFs/6EnNKo0rzyQUKE7vYk5+1HpP2GWP9AL3EO5SLvRjUukbhtRGadC50bSGnUNvnw=
X-Gm-Gg: AeBDieuzogHasnf46LTNk0TJ29GO+ppcWOVQ10pcthRh8ZFl80T34+hPBJGcTOHi3fu
	bcYnSHoA4fzKQh/XeNs9hohz79/Ta2cpCQZ7OsNjIxc+og1/585ED6n1LILIrMVEkOskwc/sN21
	8G5ZHUfuHXw51Vl/4JtKd6fbAP2Y1dILUiITQ2efWx35/ML3nLIL2ZOhjwHu/4THA8bCeOLUBZR
	i9W6CauN5pH/WM4QQa2nM0IvRw/4cSIn5COs5Yx4d3KRnZMGcJpnjQ9v3uw0AmDE2uTiMQzRWjZ
	UGep8o21bGFnn2vC+GlQnmJMftkVVo2b7tC2l1UTEjVDQ7roI3Fxf7It4ikZkVeHynDBbkDWE+N
	rlQC7TmhLk14+6la3NKYnsvsVjxbdw+NH1M6aU7IA0I5rfa3xTUK/SvHyX/+MumNw9C3Lt7m5Kg
	WiDxEfppCWhiwMXFjbhq/nCu5u
X-Received: by 2002:a05:6122:3a03:b0:56b:579c:83b with SMTP id 71dfb90a1353d-56dab8130f6mr1657452e0c.2.1775239203501;
        Fri, 03 Apr 2026 11:00:03 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d75:aa::11:1de])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bd03371sm7339999e0c.16.2026.04.03.11.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:00:02 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Fri,  3 Apr 2026 11:57:18 -0600
Message-ID: <20260403175719.75904-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125446.3776153-2-sebasjosue84@gmail.com>
References: <20260402125446.3776153-2-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>

region->length comes from userspace via the DFL_FPGA_PORT_DMA_MAP ioctl
as a __u64 value. While the function checks for page alignment and
address overflow, there is no upper bound on the length value. When
length >> PAGE_SHIFT exceeds INT_MAX, the downstream call to
pin_user_pages_fast() (which takes int nr_pages) receives a truncated
value.

Add the length validation alongside the existing input checks in
afu_dma_map_region(), where all userspace arguments are validated
before being passed deeper into the call chain.

Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v2:
  - Move validation from afu_dma_pin_pages() to afu_dma_map_region()
    to validate at the ioctl entry point as suggested by Greg KH
  - Keep npages as int in afu_dma_pin_pages() (now always safe)
 drivers/fpga/dfl-afu-dma-region.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 0d1f973..7f434a9 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -34,13 +34,10 @@ void afu_dma_region_init(struct dfl_feature_dev_data *fdata)
 static int afu_dma_pin_pages(struct dfl_feature_dev_data *fdata,
 			     struct dfl_afu_dma_region *region)
 {
-	unsigned long npages = region->length >> PAGE_SHIFT;
+	int npages = region->length >> PAGE_SHIFT;
 	struct device *dev = &fdata->dev->dev;
 	int ret, pinned;
 
-	if (npages > INT_MAX)
-		return -EINVAL;
-
 	ret = account_locked_vm(current->mm, npages, true);
 	if (ret)
 		return ret;
@@ -319,6 +316,10 @@ int afu_dma_map_region(struct dfl_feature_dev_data *fdata,
 	if (user_addr + length < user_addr)
 		return -EINVAL;
 
+	/* Ensure length does not exceed what pin_user_pages_fast() can handle */
+	if (length >> PAGE_SHIFT > INT_MAX)
+		return -EINVAL;
+
 	region = kzalloc(sizeof(*region), GFP_KERNEL);
 	if (!region)
 		return -ENOMEM;
-- 
2.43.0

