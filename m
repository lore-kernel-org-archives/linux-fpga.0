Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AD221F1C
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230905; cv=none; b=u+NhpBRXJWj6J7+sLhWl0f6jD3zfRMrPVQmZMPykCoWo2eZeRX7NR567PlqWvsAOeXrk8VljITCd9g2YY/585nR3R5p7I23iLD3SQizX9HY2Gs2QoGQM3g4cIdru7cmfIne+K5Q9jp3UOZA4WLlFKpe33F2CrnGikvvIqtGi9Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230905; c=relaxed/simple;
	bh=1sqhnylLI7gkJzELxLCPnxHxDOb4FadriLVIc1k6lys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnk7PnemZh36IPZPuj+8lgOYMYfdYbeezX9Asnc4yBJcWm8fHyxiZ707VZN/seGUsIfTk5tkf21Pt981eNgHyaev71RScXjB7Ixedn1AB6xhZkTjqOkKOTho+OkfD3O5ibMHLU1a5c0VtAU4t1gLbgNPlTLuPfH029LvrKEOd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4v770mx; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4v770mx"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c1092cc08cso1024481eec.1
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230897; x=1774835697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV33ceOiC1VxLFfbHMOp1tzZ4L73tAWczcXKydNsu3s=;
        b=i4v770mxNtlkmshGGyiFSKID4u7qwSzVxZ0aHffRAJqTLaK3xUBJB3uw1gjfnb+ELV
         jy2p9XKszW+G7miQ9O/XnTDUWHl536kvNqF6+l8r9HC6oW1Llre/Lfxuy0aMH/uWZohU
         ZKbrdLlQmvSYrWK7Hj3O2I/CQN45iUQeUHEgO/TR2Ww7P7sSJcsAZg82Gd2QE11SVta9
         yB7gvu93oYeBxMwn1r7Kzvz79f7lNSQlkI3AVVzX/AC/3Hugvd2RS8KEUkpof+TAl5WB
         hMISvVs092UW7y56xc/AF/B17M+zYubYC0BRHR1fYc/GIuiV1tZ0poj18g0XCpyLjYDG
         T+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230897; x=1774835697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JV33ceOiC1VxLFfbHMOp1tzZ4L73tAWczcXKydNsu3s=;
        b=U1boIBpj/heHogzgG0EKpbYYJeU8WpRRacScL73oAyEC/PfSs2V1eTPC8Nich5wl3v
         1Pfg9LZu4zFfwpotMUiMtxz0mxvWUr1Keg6C4tvSK9InO400qi+GPkfSWM+TiqGZb8nZ
         Ya9lkyWVb/f6mgeQI9Mb65zxZxgstTtzog3ZKh6EZux+0sysJtc8EEn5FfyEEbtKcMTq
         lTvWDajdYPicUmWm+tA4vKI1ZM/ZTgoq5GVRXpYeJXTMpLiO9YpF/4A12qpqJ7PqCBED
         Lnmi7VnSHbp4XkULKIpRbVDYDT6qgDHuYQqXaatrvkZ3tvN2HYB+TT+x9MCoQcTx4W/e
         vnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2UxGbz7agwqMMeO6gQdWwnLwK40YEWrVVQl4VThwQtd8a9gONPWW7SQ5H42DFH/q/yYcZPbgammFy@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7yHmNbE96FVJtdt900ZJrsLzV9Rk5pNVnkMGuq1HGCUJxIrS
	amRZVP9GkdbmToDX+L1uq6A0bjlWtZGOlhOfdmsSjvufUaTXe8PBYXNe
X-Gm-Gg: ATEYQzz5Amzb0wq/MJN7InTpdwrFeREhJZus9X4WnvH1FWfwzCXIBciDNLKTVWD4dim
	fYECn2ocgFHH3QCP/PFyi88NFwDSES67tZKV1aplFfv8SXo2/BadJiAyL/fd0A0TViAKMw8gbKS
	+/STiZGXXS+4orX7V0FDvtmp5KhZGVkqBUEikiRNbiDRt4kZKbSYVh8dTl2+6UHvQ1ynS1p3Hbj
	/j4C1mGcO+PLw+2rk3HV1MN4jlPkdNTj8SItvD+0dAv22wZYGxKht4/y/8xAZzvTU9RHuhrdPXV
	+b2xBRm0xJnJ3tvWX23qlpjrL/2i8JIjfMbLHP3nrL+EiH23z3CMHs1sucGoWvEU7k7VgsuWF36
	X972uxyIT79ziF9FtPVxtNjySyG/wY5CttURXy45ZNrT/BK4AlxrFUXiSUV4oRRIxUM2U8l8cNe
	n61j8JAExT0Wmrx84QVw5etVwwx31UaBhT8CBdamxH6jnFANa02d/gjGx4xE04ZTptOu6CE1x/+
	8xWvu0Zgl4TDhY=
X-Received: by 2002:a05:7300:e2cc:b0:2c1:27c:75a6 with SMTP id 5a478bee46e88-2c1095fbaa9mr4810786eec.10.1774230897161;
        Sun, 22 Mar 2026 18:54:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:56 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH 08/10] fpga: bridge: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:26 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-8-b72eb22a1215@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
In-Reply-To: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6826
Content-Transfer-Encoding: 8bit

In preparation to class_find_device_by_of_node() going away switch to
using class_find_device_by_fwnode().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/fpga/fpga-bridge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 8c275bd48a0d..3e04bb4341c7 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -9,6 +9,7 @@
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -94,7 +95,8 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 	struct fpga_bridge *bridge;
 	struct device *bridge_dev;
 
-	bridge_dev = class_find_device_by_of_node(&fpga_bridge_class, np);
+	bridge_dev = class_find_device_by_fwnode(&fpga_bridge_class,
+						 of_fwnode_handle(np));
 	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 

-- 
2.53.0.959.g497ff81fa9-goog

