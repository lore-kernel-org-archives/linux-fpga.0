Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5A3EDE4A;
	Tue, 25 Aug 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648933; cv=none; b=QypNmaSLQuWLlrXXMKnbh4ULX5+a3RZPACYeucwyTOpiNSlJeeooAyWdpb365LRo8oWhIHpsoS+sfHaTv8VaH07imxVeXz5uu+xhwcpS9Mu9VfT0wHQoamXk7x+fKiGCz0CjMB0aVTvS4GZL6prJighCvJYOM+nIrkfM1dGV3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648933; c=relaxed/simple;
	bh=Iz4Djjcvm64UuxE5F0u/SKdpEbk+KyVbx1S+8oyZk6Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TKNG+B+pGMyVemivi0OAV2aUGt2VJG4QzYEOElmfAFW43jC6DVt2cpWpo1UmY8r587/UzswSxpjxWImheRaXbRwrPlfNeKNoL+Cw5E4efNKYZJY5gGcv3ho5phkiPZdn4jhzEg3MKs62RU+smiK8gmonTVYQR11zUJISetBF37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=apEOj5Lm; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="apEOj5Lm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787648925; bh=Iz4Djjcvm64UuxE5F0u/SKdpEbk+KyVbx1S+8oyZk6Y=;
	h=Date:To:Cc:From:Subject;
	b=apEOj5LmTX5deYIqVzDrrh7L5IWUagosc3CPQCoUnIeowaCKsec3iPFJ/H9fAXEJJ
	 R1mF12xME+3RrEhRen0gvkouRePov+7uEcj+xiNei8LASj2TBJ/17gqYriUmNAUyKl
	 Myuyijw5DkRnLimSFu/Y7/mAps0o9j1tvOUk/mq0=
Received: from [192.168.255.10] ([111.206.145.19])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 22B1AA0A; Tue, 25 Aug 2026 17:08:43 +0800
X-QQ-mid: xmsmtpt1787648923tawaxci0a
Message-ID: <tencent_EFA15EDE0B67CF3347A9EFD9A05E6A620D08@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRVWRMCsAPiCNU/g33nzGFC2OMhQraddZnJRaL2fJcoF0nICqDLx
	 6OXW0CxSPurNCg36t4dxvbOQAfqzkJHBAw/8sETzV/NKBFLWTeOnjnYJnimswDxndHGKc2aLcBGv
	 VuPvaQBqLVTG+yU4Fw9JsKzy1PEjQQa3TtouMpsuWLJahlk8Wuw8LOxHTS1jDs+7uvEIsHGhsFOY
	 3p6bG4ddxWZD6HxqtpAElyAfgzYeu8d/CBTF9wJJahFIR/BvyvXnVbbPdsaV/bt2USoVqQMM7e0S
	 4Pk8qrlfujUhWorGlzYwSmq6OEUqTUkql1um+SSWwbgObnjnOD7nZKJqsjvb5TtiYZoyGkD/32Ia
	 2KAW56ogqgP54TIRdzdLek7FJZkMnIWgNic2UL733MQuDpT34xz96obsrfgOn5fyncHunP8X6BaD
	 jkb5gHe6cpsku2KvIvIXjq1ELfJ0ZtWPuwEHmDzYeZimGCiz4xsoice4gMPeioAPiyfxnCPOfHao
	 Yh2leKFRfQ3HhfaszSEOzMUhycQIh9tpbHWtNWkHKnqmoTRkLMx1Ir7VZENUyYwCxVpOgWtBtDCE
	 wD+DudD5XTE3qaWICfwwW035ZUYGPuxtpOAoI6lz2dyrrASi7KUdbnJLJfn8HkG2WzitfIa9WJoW
	 4fJwWUF0u1DZ5OdPY+VeJ9h/75Y+JePKcYs3oQijLsy54C3qvzDh7BpfSEdYoXQWn06krSto64Vf
	 rUDC2vYMkIdq7zw9/tqfBPkHPqedVTvVVNICKyw5MVCfml2tMvZ8PpzbIXPY3XMsk7F1ldK24E99
	 fGeXB1JIyllK5pxgYBy/HCLseyMnPm8ImvWEwNwuSjdwMKfCk9+hLBV0hLj9631g5AlfbVBUvphk
	 gZs6gwi4cHEwOVyU7FYjVrbmH8ut/tx1bXDv4CEoc19hxY7HqhLwI36BSOLoQn18+f8ZBge8TRDf
	 sAXqHJxOodv+eAZKD+UQ5ya56Vn1Kyb9mZnvTbFaN0dBICsN6p+nhgVMUk/hpkhyanva2SYu6BXS
	 PIV8NIffQDElWgq9WSUzQP75DX0apPdK6h/+nA13MHJCgVkO2NhTbBQU+XhvA=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <32bb5be0-7eb0-4966-93bf-b9783e8fafa1@qq.com>
Date: Tue, 25 Aug 2026 17:08:42 +0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yilun.xu@intel.com, trix@redhat.com, mdf@kernel.org,
 linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] fpga: dfl: Fix NULL pointer dereference in
 dfl_fpga_feature_devs_enumerate()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The build_info struct (binfo) is zeroed by devm_kzalloc(), but its
sub_features list head is not initialized there; INIT_LIST_HEAD() is only
called later inside parse_feature_fiu().  If parsing ends without ever
reaching parse_feature_fiu() (for example, when every feature header in
the list is an unsupported type), binfo->sub_features is still all-zero
instead of a valid empty list head.

build_info_free() then runs list_for_each_entry_safe() over that list,
which reads head->next == NULL and dereferences a NULL pointer.

KASAN report:

    BUG: KASAN: null-ptr-deref in build_info_free drivers/fpga/dfl.c:950 [inline]
    BUG: KASAN: null-ptr-deref in dfl_fpga_feature_devs_enumerate+0x59ba/0x60d0 drivers/fpga/dfl.c:1611
    Read of size 8 at addr 0000000000000000 by task syz.0.2/1096

Initialize binfo->sub_features right after allocating binfo so that
build_info_free() and the other sub_features consumers always see a valid
list head.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
 drivers/fpga/dfl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4c63c7c8579b..6377304e4447 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1589,6 +1589,8 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
         goto unregister_region_exit;
     }
 
+    INIT_LIST_HEAD(&binfo->sub_features);
+
     binfo->type = DFL_ID_MAX;
     binfo->dev = info->dev;
     binfo->cdev = cdev;


