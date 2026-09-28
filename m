Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363318AE3
	for <linux-fpga@vger.kernel.org>; Mon, 28 Sep 2026 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558161; cv=none; b=Z3/rs3lVXYDLczthyL9/rbYQdstNgNHhPvOJGEE2zkyO53b3evZ6ORp8yVYEHgJSQsvnUQcaRC1IKCEvh5QFucpsSVsLEcJTOwknsOAwxBo9DWc9qy555fvEEDKbiXF26JiH/foXqpZZ2qB+7LDb2ZeiaK1xtnxVzHaMpJwyBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558161; c=relaxed/simple;
	bh=+I2BolBUioXjtWJBg+bex5SMVHjpHt/tnYuBkI/f4jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwQWQIvU1/YUoNE4pQGqE60yKidpsXV/4oE7ohq1YaxgrmWbIJMvA7gzNqL7tmvMhbnBYfpg8seq2qpsMP4AH57zlecodDMZyhGgsD7v6uBltrslv/LVMFOaV20wGUydQdNyJLdNl0vwACr1o7y/XDK5Sntp57e0ZDBnJwmTxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoahKGr3; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoahKGr3"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bbb11f51so190906a91.2
        for <linux-fpga@vger.kernel.org>; Sun, 27 Sep 2026 18:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558160; x=1791162960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhcu3imKwpmuJ1Tju1r9h/N7S7nL7GpOkubpL/2zJc8=;
        b=ZoahKGr3XikS5e9HejiR6qwxx3tVqe/v21x7tANAM1ATDrnoEdpnGWFvV7NwNsQw95
         Tesqvn2dt6UkoGBGQiYErKsEZHow2HBKvxFW2D4TwyUx9qylPnQfL2kopQ5WX1GtC2z7
         TY7HMJy2l4nR+UwIrqXPhz1a+kft8DUNbV1AoCWFFwJh744Nb8XByRkzzFLj1roj4Qmo
         JPdvBJ13ST3KJ2PI6RPPO7kN9lwIqZSYU5Z0Xgbb/7Fufmta0hbpqrzFpdI+oX2kRNkj
         qvaeroQ8JrkxeKASXPnFj02xWOgPtGJCTGkEVhJ9msM57rCRDvFGL6yEIqKABzZbzjU6
         pcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558160; x=1791162960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhcu3imKwpmuJ1Tju1r9h/N7S7nL7GpOkubpL/2zJc8=;
        b=TlubHOxp2RLNUMoF+4nGPVbzOE7sCAPehfdP4jrw6qdmIcoy4UBlzIHAvTyLAN9IMN
         vUi1rRcvXmtdTtjD+Di8u0+54M5ia9AU72OUAYkj0AvOodahjcR0ysrZ2hcKzSx5JHMm
         0TCzqGsrZqmuCVGe+JCmzw1lwEnk8ZO7OH4sXkfPnhBx+N+P6kltFFq2Ytne6Q0A2xaF
         RD7jiszj1weTPukfAFuOyZoltQ+jM2WsyFNhRHU1dGIGmJNl3GR9Dm1ieSzjobFVLgYw
         jCVO8lGb2GB6rBYcWTdIFDEj77VOqN/pWL5UMNSSTa5UAykPPxYkhbxkXtgeIN14koQF
         tfYA==
X-Forwarded-Encrypted: i=1; AKwUvBxgTL39gaFOE16KvuKntOg80nhHe3yEfj4yi3MlS31dpM88eZQN7bfiyTaYhx7rnyjsjJLM8cbNYDZ/@vger.kernel.org
X-Gm-Message-State: AFq9FYK+cEm0+TOTfVXlnnCauM/v+EAvMGFmDmYl+Xg8W03ijYG8rHf5
	3zPGuYyi3EBch3+Re0NfAirlrv4LU7exEB3n5DqBFnPpjHX9Dnc1d9h3TXIroIOJJsY=
X-Gm-Gg: AYBFou0HlX+1W3lCMvQdjPPVe9NBWEsFbBb5mhqxqlN+C7pPy5F+HZHfsHyXU8fIkKx
	NbL4ibVyeHW78LRb6mSOOTBAyDWUTwghy5qC0wBoASm0cXWQ+3UfNPWzgdDRcz7YhsdgnfA7YWG
	8a9w8Evtb8UavbOwxOsTbgIX7EXzHk3zEDthbZNx0aLhtzA1SY8JdwIIfxvTI8Zrc+KJm52VxNH
	Fe1Jt/eFeTQdtr+NN2mr3NYx8UieSmKA9GJgbBJSo4fzDwxLpfCIYtGsXyiTb3yxfu74yMBNj0J
	8Mon0dkdQSZvYXt/cOjDbChC5+3szfNLr1DHzjBgyrsDXIGKpPxk8Aa0Tu0BeXdv/AFFWf1bvml
	z7yyMQwIhJsIwldcQuQJNNT8Y82IpuEC1a5nmCNsyxJ9wr0YZynUjzPKOCLkHiUpuuW9OApAuo4
	ER8HDk0mO4sSlWLWblace0kmabIE4eELj0noaZPMg/od4dZ1hbIXB4SB2o1iy1DZecL9ViAyEnP
	OaIcUk=
X-Received: by 2002:a17:903:1ad0:b0:2da:dd0a:99e0 with SMTP id d9443c01a7336-2df8e6db03amr104467805ad.2.1790558159845;
        Sun, 27 Sep 2026 18:15:59 -0700 (PDT)
Received: from LSSP.an0.nb ([2001:da8:7001:22:6cf6:6d8c:1a91:b208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142937asm33747505ad.46.2026.09.27.18.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:15:59 -0700 (PDT)
From: Guanxin Li <bruceli20040604@gmail.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guanxin Li <bruceli20040604@gmail.com>
Subject: [PATCH] fpga: region: depopulate child devices on remove
Date: Mon, 28 Sep 2026 09:15:51 +0800
Message-ID: <20260928011551.15629-1-bruceli20040604@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_fpga_region_probe() populates child platform devices under the FPGA
region using of_platform_populate(), but the remove path does not
depopulate them before unregistering the region.

Call of_platform_depopulate() before unregistering the FPGA region so
that the child devices are properly unregistered and their references
are released.

Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>
---
 drivers/fpga/of-fpga-region.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 9107a5b461d3..fd3f81db0385 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -429,6 +429,7 @@ static void of_fpga_region_remove(struct platform_device *pdev)
 	struct fpga_region *region = platform_get_drvdata(pdev);
 	struct fpga_manager *mgr = region->mgr;
 
+	of_platform_depopulate(&region->dev);
 	fpga_region_unregister(region);
 	fpga_mgr_put(mgr);
 }
-- 
2.43.0

