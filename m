Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755749E130
	for <linux-fpga@vger.kernel.org>; Mon, 21 Sep 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996746; cv=none; b=r0msgIWxq76lMostWnL3zaBtFmSGqhCTlgDlHVoG+whMQNVv522k1NuFDFxvatDmrc0VoGn8RxKuoNknZVs8iBLtYyaXfnV2M+Sxv3H3SR8EZffi5Hww4ZBgyyIG+UtM5Gp4hm4syn/JrTdpm55bRykLDUuvRjUcEtOiU8yV0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996746; c=relaxed/simple;
	bh=+I2BolBUioXjtWJBg+bex5SMVHjpHt/tnYuBkI/f4jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bx9y5RXAneqmOxZpD+lr8rEst9X/ZjKA5L0X5ojZHhzdc1h9gS6auRW4av6fF+asK8xy6gwJNW8+gwxLHsVM0Awobu4bEJWpENz8tZuinRR/1K5Wy3nqff2TuGeXHwl7bnR2ndLxYBWXi82FGjbpYOXvtEUrGuaVMkpUp1COWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNbSL8bA; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNbSL8bA"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-869ce628b69so150667b3a.0
        for <linux-fpga@vger.kernel.org>; Mon, 21 Sep 2026 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789996744; x=1790601544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhcu3imKwpmuJ1Tju1r9h/N7S7nL7GpOkubpL/2zJc8=;
        b=jNbSL8bAg8TXQBseJrOj/c+k5sMQSmXnqa62rIOKz00DesqS1pEUcp+0z6z4H+EL63
         1+704VhP8+zs8YMvp9lYx4J7p2ghkSbNfxl/ij3/1g3745Mtz3Q5Fyz7p2PL07nAEGul
         OMwKJ04cdYnm2YmS2beFKDbWWo0B9/rYxIs8UrQux06WODzH2qhSNwtie9+V22ZysfJ9
         j6c+LsloIyMKfB9sVMJOOCGi9bS8yzknd9KQDUa8RxrE+OQX54QygDi4UUTI869q38m5
         m9y8IjWaLLODa0sVXwuH6fiYTABVdvpuIit23o07i9eeSid979V5xmmAtjOZP5XtTb6u
         /+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996744; x=1790601544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhcu3imKwpmuJ1Tju1r9h/N7S7nL7GpOkubpL/2zJc8=;
        b=SNwDE5joo6ACclP7+EmjKVj2od3qKVQH6P5C42F92l3nJAwJ235UNh0lx1Bije2EiT
         t7ZVusfh6nXRGmtZf/qyDSv0HsOXZaT9bGd+psy38e7bX1GXOZlwBeLv3zxdL3vnUW4N
         B91dF6TyfHKs79z6XEU0xuxG+6x7UpjpnpRZv/wVyW/JkPpQz2wqbSeuak7mKr48dIsf
         741fE2AcQhucewOzARdlSfA9CgTTbNF6ueCKwDxA3dx1vY+bBVwxe7vZrBi7fC/ABXLj
         EhZAsKvgUq7TJo03tg2LENCBOsbZfFDBJVZEa83DkCLSESWL8Oi987qEx53Ts8cVjR6Q
         xKyQ==
X-Forwarded-Encrypted: i=1; AKwUvByaoxU6AxNTC8BV0wSWd4CWOs/Hrit9A32Y9C3zWVYBVJXxqsYOvkER6CDlWugEVeaHukN/RN7v9bgw@vger.kernel.org
X-Gm-Message-State: AFuF++lh7JCuPVku0onMLc3aqMR5qdzRucH9+6UQDHdvNS64UDn8bMEh
	o61YtGYAMmjczH46qwduGm+d2axXJwa67aKkrmtyBtZ7/dIQ/ZK08dda
X-Gm-Gg: AYBFou1AkumpwiQfKKauIrre/LrSyKJpNbrFjTSzn2v4xC0o+SOn4OIaPPYJWBRmuSD
	PQ2RTazKRI3jLd7b8+ddOBr0ZLfxZvc1T3Hsg/y0AJMGBQxaHQ82MAmEY+tWVCO/66JATTt5noT
	OduiC2wfAKHgrvG7IHy69fABYsuE6ZSimL1xLu+7diSJkwf5HI2ct6XDAVtw7jUzPyMuwrjXzrs
	yu1ygwfeOSwRqPIpxDYzNSH3ZRWW7D3deWft40lgC8CrVrERj3J33NbFeu+kZMeCkYC8h+rDHT1
	p3RtKjUTQlAcynkh3U8AkuLKNzoWiPTgZNmEGK8nLkO14Ut1Zb8HPuNS+yWcg9ZXD9KITRGdxHd
	NBEFeW0CNmL+FNyf8b6CVDCAYibJia+KtBPEnY1AEDCxZ/YWpoLbAuVnfzOou4c+nGfe4njzlPY
	fdpmqES4YWUANHORBKCFasXcDfFcBWq8uyQYC7jeJolCqbpAPIsl7pLs4cVTk5hh0q0SENmF+bk
	zFX1OA=
X-Received: by 2002:a05:6a20:b08d:b0:3bf:a638:4384 with SMTP id adf61e73a8af0-3dd90047fe0mr20291394637.2.1789996744162;
        Mon, 21 Sep 2026 06:19:04 -0700 (PDT)
Received: from LSSP.an0.nb ([2001:da8:7001:22:8c7c:99fb:5511:9fa5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6bec901sm3196607b3a.4.2026.09.21.06.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:19:03 -0700 (PDT)
From: Guanxin Li <bruceli20040604@gmail.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Alan Tull <atull@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guanxin Li <bruceli20040604@gmail.com>
Subject: [PATCH] fpga: region: depopulate child devices on remove
Date: Mon, 21 Sep 2026 21:18:57 +0800
Message-ID: <20260921131857.3619997-1-bruceli20040604@gmail.com>
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

