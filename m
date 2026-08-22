Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20693B8945
	for <linux-fpga@vger.kernel.org>; Sat, 22 Aug 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407550; cv=none; b=HqCKyM+q6vv09D05n91GPGhXKTj6OnBT3jMSVD5mZzNDeVL2N91jLhXMbcI1ibvgmLx1c0G/ooO/wUVw/uxB4InSC8qAFSWfS9NWsbQxuVSW4MubAvColI3DbcJSF5E/f0j49qx3J3kSMdOvLLV3wRzDvpMkCG/kNVxYYGVEmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407550; c=relaxed/simple;
	bh=fV4yC6UPtyBNkpQEvdWokpXmNni7AJdSNYyNvZf732E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M9iSLeUW8+iMWPYmxXFFCZQA8kK/e4URXU9tbHwnZIaupPvjUyB49zn785pcBobXhaBNWFEW6cXucCHS7uTLv0yPglSclg5Lo4AmwxOo04oCo6rQ3cBv55psmmxpH+utX7Vfqp+5AyekcZ6pHk4nnzXOCBl1JpqkoSIHi9JWoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QTwsuL8I; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QTwsuL8I"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so224309866b.0
        for <linux-fpga@vger.kernel.org>; Sat, 22 Aug 2026 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787407544; x=1788012344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uz+YsBfBOHmca08bbB7L1JnutOFUCZKGXh2Nxf/YNec=;
        b=QTwsuL8I/rlrK+/iG3SumbxKXkpY3PAHRE3mr+I204HQqg+MaVPlZykxdAv4I1oBXw
         +JOQ20L/PyFzefuy7soV1CoSIB1vQ+1j6Um3JwddrXllM3+tkF/RsoeGsaQKpdvCnBQJ
         vKOXB8hlKDaqSqH7L+AR5YqAmYtsiqpo+jSfvLhS/dLYD+HAf1BuIDnu/2/wZhNHisyf
         J7smRJ0QPals3/vJanKHKuvQu5ZQEHkp0SXp/QzO6GgSKj5THj7voxSJYkGnmqUjC1I5
         Et4or14mnndtN3nK2iqcszqr9fnhhD7QaedMe4SlNl5oUdbSvaaBK1tjIuhWZXFEJXMO
         ajyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787407544; x=1788012344;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uz+YsBfBOHmca08bbB7L1JnutOFUCZKGXh2Nxf/YNec=;
        b=rFTBIonnIm5ULZ3oFy+2V0h/weljWDMifVnHBiA0Vb1dlSJlPuXXvvRZoVH0NszZ4n
         u/EgC0yIzMS1X+t7G8KSuF8tDSAjvRSFQOElJIKNSpy/2ivxsrNb7uQ0mcT+Kcil30sd
         KGhcBA0dlc9N3ttdxlpLRXWE7Hj3JKsgf06ra3voqP2mjueMv1koL0BtN0zmiqaXaxSC
         9CyP37Qt9KlRxDUjslOJoD4lvH3WhZsBGTL62kACQReEzfK0vX/XcCM9vsF6hPsKG57C
         gcBoVWMCvTtjOjMJ0qzAwqq+RdFFl4za0cE1t0VkLdhKYO4Aa24RW5e2toEYgXFmvouy
         OgIw==
X-Forwarded-Encrypted: i=1; AHgh+RoiSFuO8uw/MVHYwtCRYVAFwvcrI0huiIQsECRyXghfr1FKtlSHnCWY89dRiVRd9gTkirvWGByqREhn@vger.kernel.org
X-Gm-Message-State: AFuF++nT/97W+zD4CyhJX99aI6DOdv1hbw4vyrBR5T2ubM5oLr/HhD0n
	fifsiow4TL+CeFHHyBY0HFdKZ3M3BcR0onHD8Dph9VwRKkG5hlxKbxVa3H1io9+JVfSIZqMr+aA
	m6TW0Dug=
X-Gm-Gg: AR+sD11bkq/OgLDtonFKNHgk+xSVZmKRdnBV8VMIZJQF3LrXcFJHUbaCW7Qene6Keel
	UJo4GsCkXnRht04U8tA2zFrP2LVxYVGK4wwdB/V4Ez7Lgt/qH6V4OFyVEkrI1w0InVZuoFT4Sv9
	24PDCaRBqaaYE5O8i/655pMFM7HNN+y7m4xQ3SKfK8SIbDLcbyMrYzCSEfqpOmciSjJVxE6b6v2
	okaVE1yge5yRDoGX6ZQdtTkxp6LQGeg1bMzvr9qWYHIEXqOYeCmSZcdFlGWyo/TDGaFAlz371ZK
	8d53cL53JXdOnTwZAdiP36kbMwcCenD5B+D25eOn2P9I8ZLcXS8vcrOX1bB+2n8HEHAPEQq3NHd
	UU16ycPd0dXL7EnyWaKsj+OlD5JZAnLOyFZbsnNWi6OVmHNv6tzhrUbK1a2tMSXz8sJwcHYMXm8
	anJpcHmS93kbh0U0hM9y4rorF+mVFamdhXaUc5anG0nG35ScN0IJkK7tGWe7X81YZ19V2zbRlAf
	VmP
X-Received: by 2002:a17:907:7243:b0:c20:5797:162c with SMTP id a640c23a62f3a-c246a62888cmr1393968866b.16.1787407544242;
        Sat, 22 Aug 2026 07:05:44 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c24966f9cbcsm383160166b.29.2026.08.22.07.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 07:05:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Xu Yilun <yilun.xu@intel.com>,
	Moritz Fischer <mdf@kernel.org>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] fpga: dfl: Drop #include for <linux/mod_devicetable.h>
Date: Sat, 22 Aug 2026 16:05:35 +0200
Message-ID:  <799c3ffa64d758ffb74f84da492d978a517ff1ba.1787407491.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=fV4yC6UPtyBNkpQEvdWokpXmNni7AJdSNYyNvZf732E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqiaywrhQjFM5xyLgW0s2nbBAjk4BV5zkFkD6yH c3qAme2dPKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaomssAAKCRCPgPtYfRL+ TrnZB/9ZlYjtDOK08jWnS43XsgWzvO0ZNIHSwpM6f44A4+sgSQLZajtdsiCT0teixurRb7CcZu1 7qUI8vJzXoQow4ooLe/Rn++QjUs/ksbi23ZdfrxNHngaBxaYJysvz964sqbOyt1W/usVA56EQng 853yGRcnt/XmVNW9qHER/NeqXEx4L71Cfv5D6tcDALO2j3QAZAw2oB1xNcNXXXED19e20RWVdOv H2cqKIvZlLJmfd8s9mokf+2IETmf3AL+wiO9UFeuXp+FmjO3B68wacXm4N0T7IifhgW137vOv0Q mkRPI84uwWZHeCi8WlQ7+26m+cIipBa0hlFCkRkTLiCaTIaY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

None of the c files that #include drivers/fpga/dfl.h (either directly or
via drivers/fpga/dfl-afu.h) actually need <linux/mod_devicetable.h>.

There is drivers/fpga/dfl-pci.c using pci_device_id, which is provided
by <linux/pci.h> and drivers/fpga/dfl.c using dfl_device_id which is
already provided by <linux/dfl.h>. No other structs traditionally
defined in <linux/mod_devicetable.h> are used by these drivers.

So the #include can just be dropped.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/fpga/dfl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 9549f63b00eb..9a65617bb870 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -23,7 +23,6 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>

base-commit: 903c1cf6dff9964e71eda98a39e2e5d442050472
-- 
2.55.0.11.g153666a7d9bb

