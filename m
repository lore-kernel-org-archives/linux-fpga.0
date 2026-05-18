Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52739182D
	for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131286; cv=none; b=XDzqgDNFaD2Z3W5l4GrCPrt6MBHzSR+hG45Gp9qd1Vq1NWbBvY2dtJdFNMUPRjwit7sDhZKPmJsuFwgKJkKjFOfnWf3ACQWUIIedVBXeKQt/s2iAgq3opgZwfyL9+3g22pkNQj2Rja4svFI76ByPj55MZxVGaZtauQjMg67lOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131286; c=relaxed/simple;
	bh=OrL3+x1tcgdp6L7F08VxJfvF3uGmnc+Qbsj9WOcFBI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+9PDNv+uGfEWQ4CQg9ZM81/RB9Cpz0bU0GRg7EDF8b/rRP+0jxZm5VEy0nUFIfb99ubmGL01XLv2Gb5Vg+cTNXZBQPjTaRHq1mMCsr75xGd5W7gLhnPu0FxYf+VnnFMzY7zMtEgb68BfqCfsFKkjiBbW/VDRUPqVacXsP+NmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZuMABIv; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZuMABIv"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651c7ddf514so2500826d50.1
        for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131284; x=1779736084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygoe/8YI/F9vvMO0U7oDJ387wljZe6nsikPiQPuzlSg=;
        b=VZuMABIvBw4LZZmsjLk22c86RyG3EE1ru0uc+d8CAMnhMyF/3R2SaRNge/ttHytNlZ
         mDYg+hZgRM0LXco2MwdD/vk+aRCHaDi3jF5Wqb8ur9CP30ElYaJUFfZUIfLcPC2e4I/P
         GM74eM6V5h5tm6NOlwlekOC0iUw8suGyaA9TkNOvm6WVmulfEJ2QyBpRqSzDRgmqq8H3
         toNTt4/eUC9GKX+5jZoGunodmAebkGuabc2X5qpoX/ZNJKUuOBpJMNpCV2w6JlySJsv4
         A9+f4WrCfjPx2pOvwuQ610SijPSifCmy7rPi6h1po2O5dX0O9bjYOQdHirGfsz84MMwT
         y2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131284; x=1779736084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygoe/8YI/F9vvMO0U7oDJ387wljZe6nsikPiQPuzlSg=;
        b=W7stGdziEbDeosfTYUxUjZZPAulUcz8XC4AMhXamaMWHwAE3youkJl2+gJXogo9FnZ
         SpncsehDobnw80PlXTOOQZlqunIg3t+kYfIiz6m+eIPvZ1e0+OrHxCpZU9vPyJkC7tqb
         5KcKSjjSBkOwv43hXsVfD2qOqzimomoh5yk5hZvonMvPcFeJXIVmCo1vnsqeztrx+Rpr
         0sZK7Ez4VNweJcnF5q/S99JHzlhrJk/Q3Ay2UVwVcQtv74mRGCg4q/G/+NxwRCFAlPu6
         62Lz1B4D9sCGg0clJI2GoHrA0q3pEnTtCLShmDRG70SqLwITtrD7j9ZJDhm0LtBBG3Vm
         6UUw==
X-Gm-Message-State: AOJu0YxY1THgsMx2lQxH/csTvVrRCbPQUNwDkHVJIPtRrpz1Yh3pkXrf
	sp4xzNI7E04T6PMRK/4U2aw1+RjPL6iuuv2o3uQKsfXDhdQCpN+4offlwfRB+H6+
X-Gm-Gg: Acq92OGBpyFMVC74kIG263PRaSkHCqWnAL6TFAU7J4i/5ZDjlxbQUE30GXNDX21P0HA
	hCZ8Yn71mmWZ4lgx/Si5k1WgmiMOFpN7J1J+oMAKfmI2QKc+HQnENB6c75nBRi71EA82jwMr23M
	Po+8IW3wXRtuPSEcUDiF5Z95jlUk+fV3B7V/BOZlnL0s04SsnXIp4JovwLK9H7u8yDAG5Pe6itT
	+skUn+zJa/DQVQn4+YZdiA50rrBrSp5F7+anLH6/g38QZ4BA1tvCvDkkGbVxTjZuNQKRTVwX4q6
	TD8gfjW/zAMfRMLN8FRNlZgJE2NmOYALIjS1VDKadNzPsZt7VbdOjWKUy9NxqvwNydguOZRn6MR
	vF+GIPqc9HlS8DMynQnicOtHJDLOKoorFEdkUZQ36y4BCbFAxYsz2/qgMMhm8orKjZpBX8mH03/
	WPJrf+R2uhQFgDDMPT5fHSXf07/oHEQkdgn8oZyTuUHZzn+LzS5g4w4GsnLL9yA9y3JlnyMIsr9
	K7tUfEXFMtASEpp
X-Received: by 2002:a05:690e:c47:b0:65e:43a2:82ae with SMTP id 956f58d0204a3-65e43a28920mr9545838d50.57.1779131284347;
        Mon, 18 May 2026 12:08:04 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm6766160d50.11.2026.05.18.12.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:08:03 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v8 3/3] fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()
Date: Mon, 18 May 2026 13:07:42 -0600
Message-ID: <20260518190742.61426-4-sebasjosue84@gmail.com>
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

mpf_ops_parse_header() reads header_size from the bitstream at
MPF_HEADER_SIZE_OFFSET (24). When header_size is zero, the expression
*(buf + header_size - 1) reads one byte before the buffer start.

Since initial_header_size is set to 71 in mpf_ops, the fpga-mgr core
guarantees the buffer is large enough to reach MPF_HEADER_SIZE_OFFSET.
The only real gap is the zero header_size case, which cannot be
resolved by providing a larger buffer, so return -EINVAL.

Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v8:
  - No changes.
Changes in v7:
  - Correct the Fixes: tag commit hash and wrap commit message
    at 75 columns (checkpatch).
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Drop redundant count check since initial_header_size = 71 already
    guarantees the buffer covers MPF_HEADER_SIZE_OFFSET.
    Suggested by Xu Yilun.
---
 drivers/fpga/microchip-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea86..cc8f6d7bb 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -116,6 +116,9 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	}
 
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
+	if (!header_size)
+		return -EINVAL;
+
 	if (header_size > count) {
 		info->header_size = header_size;
 		return -EAGAIN;
-- 
2.43.0

