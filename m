Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A03C2BA2
	for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591255; cv=none; b=Zi3kZjgtK6e3djpCmMyEGeRC88xmytSMiT0PgUsFIh/on27ptScYoyXWyQbjr3VXZddpGaFs4VTtrQ4QBf9L9Ba2r7sOAncX75Ntogo23jb8xkqmuy3FQu6uynXyMIg6KpugAVRVO8Oalwxs1BPhSL/EmSmPQsBfnI8pTzEfNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591255; c=relaxed/simple;
	bh=052JeFXhre6eO/VYITYmvVypNbYdkagBvVoKDgWy/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Phh6l2ZLzQ8aOoa4GoLUzi36tzs+C4ffDZ3zauOjlGqoT1bSrtiF3nw1zGjBGPPGtXM2kKqfM9YFoN62HO1gZgwbypUK3z6oqvuqIPBS65rw+cLa+AGDqLp6oQ36RMYjKd3bRSjkDYpwUUscYsgzB3u3tzmE+ce/cPvVe1ijK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jExI3swQ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jExI3swQ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bb0d18c7f9so51026347b3.0
        for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591253; x=1779196053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nxlr/Fuo3DPIglH7by58rq3oaK6PaKeNC/vr3JaVbs=;
        b=jExI3swQ8wa73J3X7tEPqmlPc7KkYi2RqOJAt/Jn/xigzQ2STrx9Qk3hJLPb3sPSn7
         hRU452HMLvS8kcefuO+wg5FVTOzfCYbcMJJaZYQn84E3bvDK0uAO0mdSnZhlv7APMLVO
         nH1bf8P/6E0cxASNhS5Ba2MoM2siiTksjzFgV/NQMYQWDqZ4OsySXBjKa39j5X6U5A/e
         uzbkBtGwnwgteW4wu3D7SkHzwItlivZCTwSdLs/HUX+raPPs/UZz/nNhqvaJEiNxwzWo
         safnWN3lzojdTkS18t8ea+6e47q1Hhg58EavQQJKEDkO9L4gcPs5K7j9LA0DHkovgtTM
         1VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591253; x=1779196053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6nxlr/Fuo3DPIglH7by58rq3oaK6PaKeNC/vr3JaVbs=;
        b=Ep4O+YxjUQpYC63e1p6PHLTcjLgQ4oFFeKQLTjkiGcRhklGpphHgUVN61iLU/ap9UB
         zFuAtP6MeMtDmYkIVJ7ZMuDaxqkHPSzKm05FYXD2tfOX6vm9E/iPIgTGUgM6OGdg+G0+
         HBUgIfSs9NutuXjbXI8LIJgAQX3mIG1j/D+M4u+0HzJxl8wckeSAOCXwq4WCQgaw1Ecj
         4g8XLDlQjg3mZCCJ/TyUhsUnPGzb1x1Gg4vLm/X/uQSSlyd/vGyCadSXoVdi/Jt6qTrG
         FZBtEfS9QY1jDUCbzThdo91NK9YE1s+a/cTNVhLwJUVioisK8AKlUV2nmP627nvqXUu7
         9YOw==
X-Gm-Message-State: AOJu0YyIxRl8GmC1R+wJru8BotNgJdvzMBRh6NpUwcm+PrKyYp0ENi9B
	/2h8f3evUsA5aIZIFotDouXGfqcq4rekO01BmGP+FjHiEmvp9HvoV5CINRmYEFur
X-Gm-Gg: Acq92OHBa2Q+Da985XAzK4+aA69HFpsoqxbZ+y9ePmZ7/3yRMIttW4jFIwuqxN0sF9i
	rrz4aMEkTQ4w1zp0lNVJCyn2SjLCp0bzi9ZfFzu1M6JqjjcSxb8LNp2Di6mzQbPTabPvSY+VmEH
	CI4MdDaUa3TbKtKibotB1AaT4ReqOdYLcYCyiSq2NPKuY7zdBHaxokuKjfhMAEnQgKNDh62oc8p
	3fbu1hopc5S2DB5oAI6aYUfz0KGYortXnywPCTqUHx3rFuLl6oAQm4khXTbeLf85MAnRAawjGvW
	pkp2Jd0NNVWiX4ediIUNEXcOx3P/HdAKRb8YmiIf+gZJfhzpKy1bFLpUzlJHcNl8pwQuWGnot1X
	q3g/4v9xOyTlwHGPxGUL0bs94InDRv/TL8aVpXXo6p8wpXehPVbaxVtKvpSoxdEy9IpheoNX3SJ
	/fZ2pNIQVsU/iPZ7l1yRhN8Zd1FH0uATtx4MLQeGPO/h7rIH7VPaIzDs7A
X-Received: by 2002:a05:690c:88b:b0:79a:daf7:c4fb with SMTP id 00721157ae682-7c564333efcmr23522777b3.50.1778591253072;
        Tue, 12 May 2026 06:07:33 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm167459037b3.39.2026.05.12.06.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:07:32 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v6 3/3] fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()
Date: Tue, 12 May 2026 07:07:10 -0600
Message-ID: <20260512130710.933089-4-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512130710.933089-1-sebasjosue84@gmail.com>
References: <20260512130710.933089-1-sebasjosue84@gmail.com>
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
guarantees the buffer is always large enough to reach MPF_HEADER_SIZE_OFFSET.
The only real gap is the zero header_size case, which cannot be resolved
by providing a larger buffer, so return -EINVAL.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
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

