Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B02248AF
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230886; cv=none; b=ghUh8UNS5j0P/FbHmi6hQp8RENYxHa4iMh2F3BYg1wjpO1b9Ff2YFko/TbG68OpncHdGoYnz7dKs+IUfoqkl0IL/aHQwGaLGGlJwrJI43uPj+JZNAxTzVPjQyt425YFV1wRUhuH/BvBYxuCmq/qle2IdjLcotwy7RXBSUfaaCIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230886; c=relaxed/simple;
	bh=vhx5QpoROnyh2q914MrL5geRu8AVJM0r0udOxsoTw6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhjCZc44JRxwQNN3bNybhipU1w8NtRWJPbl1D0wL4hrytdYwjyrbLhrWhzT5OaoA3N+Fd8j9XFuQuTSVnAdDxwz8E2aI2DJmQH6HLMlD+0FhEiqWSG0ZP7/KdBJWC4MyX192ri1Biwz+HN6fVJw8Zx+TljvzDiEIGXSIYd3stW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK1KsAcb; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK1KsAcb"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2165287eec.1
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230884; x=1774835684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFZooOyb7hfKDEpM9yx+Ztfv9BY6tuw4luVBl13uVrY=;
        b=VK1KsAcbFk0ksbY+/+vt6XBw+4QjtQuHRNv2SEHPfOltUX5iNis2R33+Du5wZHsRqr
         WrIvRasmCEwSh7fqmeugCo6feE8XtxjYVAWVs/aJTax+83KN+3yRpRiZCmHHN41kGc2E
         76E2GGvW0zof2A8SVr/BVlPkGidLkiOUt0hgfTa+VgwSDTvrIJY6IurRqy40KFb+FtEB
         wko5608F7xyI/q7h8A/GWDyJCZ0HJ7yB298qb2dIQbetqQ8w+Pcud+IFZJPxpS6mn9WL
         8sIGtXhR2VICewq97fNB6oQcilgCg1aGpsGvaPbSi+wk7JHrmVt562VfDZYB8cq9XLjF
         K0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230884; x=1774835684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFZooOyb7hfKDEpM9yx+Ztfv9BY6tuw4luVBl13uVrY=;
        b=r5hompEfPzvGnDjA/qW2wEZNV//hgy4Cu/ZxJftYQuEyGOzLhwijHFHbcfbHvzRGJF
         lwWU+wKGQYcc2S6EmH3ti3zfbcWUk76I+35rvbW6CNHkKfFu9D/ke71/yOEZHWbwRHij
         XejegRc80bNc5dEzTJDNPxqO0z8tTrh9nwTQHGpGcf8u+8ThDzvW/dj2pQfHqzqh1uJo
         Bbl3pl8y/hY6ISHrSBAb/z2f+hIc2ifZ+J/xkydy6Qu+9N7hcWqgsWV6VzFErmHk7Z/Z
         8an02iv4SNuoHeeCUGCc+EmQ7Ugc804uDLYlBpvcQp7t3MDnCJNI3ThM29iUGz+QQLX3
         WJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzOgc6qR1fWi2H3y4o0XbplYbTG+YWREkvHk+rkCXXc+GsaICpfZEXOGJWbIPiqt4Fg4DglMVFpx/z@vger.kernel.org
X-Gm-Message-State: AOJu0YxWv3nvhY4db21ZJLbEHYoqDDvdyYSjyQz/YaAEqK8hs+BrpOLA
	Hf3DyGqYVs4KDSNILE8bPN4/I0CreNavevzQaNCrH7OmWNWc90kbtvuM
X-Gm-Gg: ATEYQzzpwApw9L2tzME/U5QjCKd/njZMAM8obN8IUgZjF8ChjfGv59RyZLLoUZSLgbq
	fyj81uSRcrVnAvS8dErxH+WLfsSkBoJpGdjkzRbSvQ+Jjv1Nyan2jyiH3slffrCvz2xV6llI3kq
	Op9bZCgl7XuIaIzbFmXmYzuSFI5YCY1i7G35uNGwOdOu8tx7h4Cyc1h8kWizmxXZmt31kONdUpJ
	P8hLTsqHrf+a2vuEt7/t8+9s1dIyGvf7CCTeyfLH+TqEAiLAi1Efa/1ntpW8JOMcfLmbQNwEqMt
	0kSHN6ecmCQSs4nb10oMnYrE5mmAVCsaQb0WtnNioJ7nhYE/y+EBrso9nk+wLvxAnTWtN1t/gi3
	u1NTRyrUg0qNcpaEprrAClmag20XyVa/qTyqszdYa3acqmmGSBxdwCYebQK5hmBaIobgRnB4W1q
	zhpwc+EQXj6IuhT5K8cogSPj1GICNs0zkNE8yP6tg2HIxZR+ft/fZw+SMyAhNk/+/YfI1I7Aqv+
	O1zJGZEod81u/Y=
X-Received: by 2002:a05:7300:d517:b0:2be:1cb2:3a6 with SMTP id 5a478bee46e88-2c10980a523mr4129993eec.33.1774230883846;
        Sun, 22 Mar 2026 18:54:43 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:43 -0700 (PDT)
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
Subject: [PATCH 03/10] spi: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:21 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
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
 drivers/spi/spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bf1df365f795..071a9ffdb59d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -21,6 +21,7 @@
 #include <linux/kthread.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
@@ -4948,11 +4949,12 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 /* The spi controllers are not using spi_bus, so we find it with another way */
 struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
+	struct fwnode_handle *fwnode = of_fwnode_handle(node);
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&spi_controller_class, node);
+	dev = class_find_device_by_fwnode(&spi_controller_class, fwnode);
 	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device_by_of_node(&spi_target_class, node);
+		dev = class_find_device_by_fwnode(&spi_target_class, fwnode);
 	if (!dev)
 		return NULL;
 

-- 
2.53.0.959.g497ff81fa9-goog

