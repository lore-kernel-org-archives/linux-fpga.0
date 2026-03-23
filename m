Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48BB221F1C
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230888; cv=none; b=dLLByBvj/0317qaowP865QdCQJr+AP2kqEB6EPA4k++jM1VhZUvd1ed5vrpd20nlP8G6XxhXU05SZGM7ZrTj9eD5dGEuA37zk5R6GomMHtMuautup6/2crGVGlUdc/1j7o72p7tEhddLb8Umj98yt0bdMVN/TNgx+1wTv6uuTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230888; c=relaxed/simple;
	bh=xYIn8ABDkpyr0YTUtgQcAiZf9GrzpDD84nxgrE/YbUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dakzZ8+hp0Om0rbC7S94rmE+NiKu3Jceiw7DBwQoOQyWU98XSgXn5sTGwAIr73c9kallOXsgrDBAcNyh7KaWerm/mNa7/8uqI9rxm6IYURoWPYwSQlO6PEB4sUrNb5SVPf2PxwyCjGwuhFHyBNg2Fi1qcwFwnsuy61GdwFOaspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuH0ewt6; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuH0ewt6"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c1092cc08cso1024281eec.1
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230886; x=1774835686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAxXxv6aPc5DTLbEJ2x2im/U0EJHM/Tk3mhYybeVkPQ=;
        b=UuH0ewt6j9doYzRgftaipYEooiTTIkDnwEeL664oX3BBapBISM72bytNNZxMAa4h0v
         smKp+BAMqQWX3Sb+cN3IAx1jyosIzqncLh5td1Q9uOwjBJ90T/rjLttujrT8V1XKlDT0
         uvj2KTy0eGCzCSWlgmzXzSDF+9XDCFr/2FkOqoaayc4xcFv4J3c/r6gV3IwQ5PSTV09M
         pbS+v333WMk01T3Xzm62pIMmp8j1NPCA1fQyT5heASGjKBHsP7b7Hp/aKiugs8PBmfqy
         OkFLzXNcpf8kU0KlAgEoMS1MJ7X8wAWB1uQWR69fdgcEdV3a96R/zx2MHWpHqimVjv5O
         EPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230886; x=1774835686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HAxXxv6aPc5DTLbEJ2x2im/U0EJHM/Tk3mhYybeVkPQ=;
        b=a9HeMEJDSFvfsgLTwmkSYM9ZEvE71LyB177iPLojfHgVZf9RgfGwQ8/C++uLQxCjfu
         GYbm4TJ3xTWsm8/+BQ0iF42eFtZyjpD62Tp3ffvg/yPFn7upDo1oCkS0wpO5QRSOYH+f
         7Ddtip4Z+aqDJeBT++Qqas3TFY4soNUHnmDwL3oJSE1EpSScZkpmFFgzfqO8rg2gcX7B
         TfkW8xYno2ISAxd/TrEOl9fwSqI7hXp+gbOUQX4Edriks4ALYHeLxQ8Yvhrg2S2o2GvD
         3HbhgUq/LBia66WMhHr2DOkoKxHqQvZ+BBgi5ttgwCwS4DjBTRk4/xAy183jlhBxmHGT
         zSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQBNc7V+J0+VEtN13O3g3C1hr2iU03zqzPf98yTLFxoK+MAt7vemmWbp1Gdz74UShbDs/K3jL1ftxW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7eDPpQg25NCl0AiQAYvs6IYJxK9WXtiScgkHb0GkmhqBXWvAQ
	4UgzP40fveJyyD+uxns2PS5v7vzrFR3xc/VT2iLDko1FnzlwxAgPaq4z
X-Gm-Gg: ATEYQzzGyHPbQ9c3V18bVKGJP3M0laacH3QLSdhPzFNWHrHqHmvy85Abwizs/eOIp/P
	BqGvJVwFBNY72vHSFgORE5MhmfECe5UB8d8DRgf2Z35LWR+BcQy0StbN/zbetxgZbGffDU8cUIB
	6sMd70PMxMfXfmPTZAde4f0OpF71OSfsTxsFnSviYbBvmNUwF8lJUaRlAprlIGE6b/+fnT/LEig
	JbBZkTsNFnxQeA/NKX9SVphrToJSqtR4m/cJTykjGw85wjeiYLAuTRnU5xJaLSnJefEFplY2be1
	7rKJmn+AkRUmIvq5LEysdvMkcBfdIUubMznNrTdYFyf2LVOVjA7rL8RY74adoU9+u+MjI8z4iJU
	byOmrXtcTjr+3+WXgzTXpFinp2Ghvp2gue78FLzZnIRR/eOu7J67sxy7e9wovz+e7tcTWbcWDlW
	NssIE1Xq/61M89yTQ0wye22M79M5Jp8e8jCmgtllfh0pGU12uPa8hzrrtf5Uc+1v1dzPoDUrat3
	ga2+3NC21sn3rZ15D0UjeEttw==
X-Received: by 2002:a05:7301:3f07:b0:2b8:30b8:58cf with SMTP id 5a478bee46e88-2c1095f867cmr4580068eec.8.1774230885998;
        Sun, 22 Mar 2026 18:54:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:45 -0700 (PDT)
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
Subject: [PATCH 04/10] regulator: of: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:22 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
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
 drivers/regulator/of_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c0cc6cc0afd8..43ec0845c940 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -637,7 +637,7 @@ static struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&regulator_class, np);
+	dev = class_find_device_by_fwnode(&regulator_class, of_fwnode_handle(np));
 
 	return dev ? dev_to_rdev(dev) : NULL;
 }

-- 
2.53.0.959.g497ff81fa9-goog

