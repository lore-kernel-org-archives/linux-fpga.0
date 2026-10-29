Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246010;
	b=SVj0Gqx3rDksFbeOMSfXn5GX0+v4jA+5fPSxg8H27z8k2pcapKkiXeKN7S8SRSG0zhNm
	 qncAf3QnrfSzMSAfKwT+CWQz/y8usMyN8lint3Hg+9+Ry995YtZO3vkNGus6NCUhzb1yQ
	 DQJ33Q4cY/b4hb2KTc5IXUrrr7O77iKuXz+u/u6cN9r8uYW9zZQtP+pmVJHlHo++w0xOJ
	 FgxR6bC5nZdA8ScWfxIpJ0Kra1Hsm9TAvnyA1b71DymBG5h4vHWnGgOTe8MRhkzULU190
	 7NlkbRFgE6BXxSCIrVSZW17Ug+dv+zQQG/IXuLaQcZbN+KjAcpMq2fGbx72lGhA67hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246010;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UyoRSOjPYG/A73IxTzTbyWdCpIvdHiidP3D772dsd90=;
	b=B56SmCwr9el3WG406y6akTFGW5FX7ctVXBXqZGSfAysT7/XbEBeBpukNTCWRciHpSo8x
	 HvnHO8nU4KsgTvP3CzeZCyHMPnoQ7Udg3G4JgqvB6/dcv/RikMbeDGhbocHhcP6jsjOPt
	 T2HKPZgKZWzabA44osqtyDpnUSrm49hCxkiRXVfx313UW3tv4utR3FQNOMq+ZOtofFroA
	 4w4Iz0OSmXDenwpCg382IDlNBRoFjliqnIfLI3OpufDbQCpd3+Sfg5r8O1Z3OJsTJ/h/E
	 /2lhe9JS/okm5YpV7lZZvBTEpHMJW8Hi4P9NmG0ZNaespT0zup6a1E8KcFLFCwR3SHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=QOlTjWlo;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4AE606A31A;
	Thu, 29 Oct 2026 03:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD4AE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=QOlTjWlo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793246003;
	bh=UyoRSOjPYG/A73IxTzTbyWdCpIvdHiidP3D772dsd90=;
	h=From:To:Cc:Subject:Date;
	b=QOlTjWloOw4m8JSzfkNii79DTGu8Lm/52IWitjUo8A5Wo2OurXRetLtHmUZcpGTpF
	 TBXSqQbVIJ8xcabG62L+UnOFQvGROhKT/9ycb67+xB170SgwqHl4bMpR4ZCS+2Qkn8
	 gLMEKMzZuL0HearS3gIHnMfkdanp2Ki11u/VaG6E=
Received: from HAPYCAO-MC1.tencent.com ([61.151.228.151])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id D548E249; Thu, 29 Oct 2026 11:53:20 +0800
X-QQ-mid: xmsmtpt1793246000tx00o9u6u
Message-ID: <tencent_C59525D78A2FBCC2425A3CA9EF4C53D56F08@qq.com>
X-QQ-XMAILINFO: MGhvBmtDPvWEuMbQS5tYTj3TMCbJjBzyxyhZk0kEvVN6aXdP9mrlocGPwYUjJI
	 gZ3z46fgtYtxBXdccJVcft/D33d1B0fwO+0mp36GFVKWbsWeRek8Bsrhw2JKNcqD7u1shKEisXXp
	 LcuuS/ReWdUjytbmxyZDZDFikYEosJ1SmR9jubeTXi4OwdRAvJJfqDQuHjqG9D3vwImwk0A1AaLQ
	 VjL+c5TnRvpx0twjUdyfWQ9p8lT/o3Je+iE5q5wVXy70nUcD5z34OqBOFc/ZKVi1Rt/2AS1Le7Ct
	 502ZtTu2rAfqD860Da3xZnd/AVMgoLasDAyyY+vOAxaPZ7lrVZUHSgOerOjusyrPv5wQnL6JeYrt
	 bXOHTO8JxGjUbMPg45TaZoYMQ62dbUY7LmGZnHjGNJBaBg7TDylJTzwKtpsBAkQzM6EtiK1zEGfY
	 TQLDNdIJcn0k6nOcyF4GjMg4oIy3vA9ZvVD/2NShjcoQm681LC7WN1RZm5Yp94y47h05a4VJT0+H
	 2nqsGHIvPbRKUMbyOeampJOCMb8li8VYALPaZW7NfJ1gz7q6SH1GiKVf5+4nXVYtotspAhOhi8XW
	 RJepv+N24AqPzSI3qQpwkH/RwCcRt6b1OfYkqI+gDp5jxPScoSmBnQ3RHT9CCYyP1CYYCHzi99Vd
	 LyPnBItPGV9vPzdoN0GFHARZ69QGIOlm8fSoPFFOt9ZD03rv0im3n0ftFPqqEUhv34HB/xkiDeDd
	 VUheXaRRBaj/5ZlqnULtnGcMGKDY1ONwV6NQ0mg3hvJ2yEmH4Yjq3tc2u6pY6/SYroNRHRCawbUv
	 oO+4wsxDow5WnmyBkJKlLC/TnBuxev1Quv3DOgHghEUSHS3Dk5zjosFjma2d6fSs21FJBTz9g64O
	 y7ejY9WiG26mu+3wuq9bZ8ad1px4msAt3H7v0QXbcHAgvwgMH3YEty+MUYc4QhyW6R2c6FRXHAG0
	 t9iqhMRJKLx+HWzH5c2FVI2azULqoSRsfc7bx8IL4u6i+7PaeQcIjudike5wqGZIDJpFtMq9bNRA
	 BLMwZTAPrr0IALiuP+9uKJPw04e7aUle3mAnpBQ2Ftl5Sz+BPGHgD6Btt4bjJJzIjAWCI2mltSvT
	 XQUEsadc8Tcm2JHYeV0GPBvhUf8Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: bo cao <treebacker@foxmail.com>
To: linux-fpga@vger.kernel.org
Cc: yilun.xu@intel.com,
	trix@redhat.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	bo cao <treebacker@foxmail.com>
Subject: [PATCH] fpga: dfl: afu: prevent read-only region mappings from becoming writable
Date: Thu, 29 Oct 2026 11:53:17 +0800
X-OQ-MSGID: <20261029035317.44339-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

afu_mmap() rejects writable mappings of regions without the WRITE
flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect().

Clear VM_MAYWRITE for regions without the WRITE flag, as fixed in
vfio/platform (commit 420bed9131db), drm/vc4 (CVE-2026-68445),
drm/panthor (CVE-2024-53071) and ptp/vmclock (commit a5edadbae57e).

Note this is defensive hardening: the in-tree callers of
afu_mmio_region_add() (port_afu_init() and port_stp_init()) all
register their regions with DFL_PORT_REGION_WRITE.  The guard costs
nothing and keeps the mmap() interface honest if a read-only region
ever appears.

Fixes: 857a26222ff7 ("fpga: dfl: afu: add afu sub feature support")
Signed-off-by: bo cao <treebacker@foxmail.com>
---
 drivers/fpga/dfl-afu-main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 097a97eeea66..a802309e0473 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -833,9 +833,13 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 	if ((vma->vm_flags & VM_READ) && !(region.flags & DFL_PORT_REGION_READ))
 		return -EPERM;
 
-	if ((vma->vm_flags & VM_WRITE) &&
-	    !(region.flags & DFL_PORT_REGION_WRITE))
-		return -EPERM;
+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(region.flags & DFL_PORT_REGION_WRITE)) {
+		if (vma->vm_flags & VM_WRITE)
+			return -EPERM;
+
+		vm_flags_clear(vma, VM_MAYWRITE);
+	}
 
 	/* Support debug access to the mapping */
 	vma->vm_ops = &afu_vma_ops;
-- 
2.39.5 (Apple Git-154)

