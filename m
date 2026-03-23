Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A9221F26
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230894; cv=none; b=StiMcjTmVdcewXdivuFfQIQ0xsTb41V8HrWIMAvJfuBySYJfnFHZ/w+Tf4qdLGSQGsfqZQ81b9JOkX3kdazLeinYmxjKmtasbol3gJghDA6gO6XFJ/yozruMxR94Y2ZO9ObqkDAmz5G2PDcyAGjiv8hY5qqksAxS+w6LGIfJgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230894; c=relaxed/simple;
	bh=RqL0mTRKkF4hWJurWBewRbPofeTnIMHQam2gd97mUZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usvJCIDffSThyX/O+BfXKnNI67/f9H6RvKM+4fjaFGp48eLwGEq8p3wSE2AoXswC4EHOJoiClNhJVFrhvfZAkSXOWBe3Tp/hNPg4sRXIuq2WTdkLfPUtzT8MX+4AdYTFnip3A8PXqXbd1UdEaUzoSWMYM5DBrewVj14s34AKy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqZ8DMpb; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqZ8DMpb"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3471197eec.1
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230889; x=1774835689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQXLY86FxuKQON46KYMFrgiDaURA8SjvslLPqZRssqU=;
        b=RqZ8DMpbb0X5i5GNOEDtrcW3mRPokgfUOj+UjicWP2+P9aSKtHV1EpNICz9hjPr3Tk
         iyi/IWrJ25Koh2vjxA4VysTebsPVDPyB6DW24mihHcF+yHhq/fg74y722ODqj3RxrMjm
         jc/+N41+4+VXaukA/ZQCtSesjuB/buuj4RkpKh0OzAGpfP3Yx9FrbLdcRngwsAjQwii9
         w9+Urz5kDN9jJaQ1Zdugxr+oqbhvVwRH49BQLayYGY7Uk/8XpnbFdU5dJ2A7o8k8HdWZ
         m6vETI6scTyc4cZoUQRltOG4+c73fsDqQwQFt/ZXfL7ugewKbGA7Erx51Ta3jzkyaAME
         2Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230889; x=1774835689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQXLY86FxuKQON46KYMFrgiDaURA8SjvslLPqZRssqU=;
        b=Zi81AzW9CP3Xs/OlqJ8EqB5/9oskkG1YWJDZbBJfTiI4yzU9evtervss8Y07VzjaHo
         oEcZI1my8/LXAKc3vDEvOt+1bzxQR81n3S3+L+Wpxkh0LCyDc/UkJPrac/pJfXHJS+LS
         GgHaaBhwE5GGhV821WHzLsHCA3xKL/Ib3cH85xDi+QMlopjMH9uicD5kuF4dBOFWcODq
         4ykEm7JHiLbrfeA7eyAkbG3bhIWceNybLBHyAa/hKmw0CwkDi+o1E3O0MEaZJ+3aKolr
         BlFS9G/dmhq0NJf3SlH/utblvKChFUlKr0wPfWZFtpGYL1AvfbSdW4ami68QcRYS3jZW
         1gZg==
X-Forwarded-Encrypted: i=1; AJvYcCXYZX5G55eeVXSIGPCz6STXM8Z8neArxZokRU4mM4wEbMCd3V9YAi3svYsVm2ZhbLdiLVYNgJHMNq7C@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3GWx4VQ+h/I3jFlCDbQ1OzVLW1D6D7StgKI+gbnA3f7uSBoW
	cvSzkELSmHulaKV96JUjwxAIZNZxrMoR6DQbqI3Edhr7T3R8aNKGOiCy
X-Gm-Gg: ATEYQzwHvmE42tvB+qNPXbefgX4m9FkDs9PUE+zSlrVS2OgZO9mhmjvE88y47mh6YHW
	Td5cyw/QQ4gsGYz2nAdUCqi54skorLZbIVMgsMDdxNeWcViF6jacSml9q2oY2Pya2ajOOY2eHPx
	Chx4cGmA0443pY2UCuu1ZECaIeGmmnUer0QTvIEjprTFn30E0rw8hUgdavyAusGaSjZJcmp8nTT
	MqTO0vZz0WISuXM7IQs1Jh3Bb75SEAM/6qc0YMXEyA6BQ64HQgPEYHp0W/TbHACjy7aXx4/IDdA
	Uef7aymdUqXNnubHvF6L4sdE1Gdj27mZpL7gFgn1jOXHWUCfd6bq4aobN0lZayvLFVIi87a3Epv
	Y+rL55VeCC36xMbjd2Ea0Xj30bgWJX6BGbrMiJHOh0OVd0/WQACdSLVSvYpzcOV4mKtqB3/zzOP
	f2TaeFDxDH47siBhapPhi8x10xugn8WvdsNTP4Ny7JLkjK6IwPqvHeWjPjwd8fyg9GiugIhewEZ
	ZS+BkeYFMhpnxw=
X-Received: by 2002:a05:7300:572a:b0:2c0:bd6f:42a3 with SMTP id 5a478bee46e88-2c10974f0d6mr5302324eec.22.1774230888985;
        Sun, 22 Mar 2026 18:54:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:47 -0700 (PDT)
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
Subject: [PATCH 05/10] leds: led-class: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:23 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-5-b72eb22a1215@gmail.com>
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
 drivers/leds/led-class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index d34a19453560..8d7ec9ccb173 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -273,7 +273,7 @@ static struct led_classdev *of_led_get(struct device_node *np, int index,
 	if (!led_node)
 		return ERR_PTR(-ENOENT);
 
-	led_dev = class_find_device_by_of_node(&leds_class, led_node);
+	led_dev = class_find_device_by_fwnode(&leds_class, of_fwnode_handle(led_node));
 	of_node_put(led_node);
 
 	return led_module_get(led_dev);

-- 
2.53.0.959.g497ff81fa9-goog

