Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB7217F33
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230900; cv=none; b=LLaLNIJyMTUW3pVScUF+ACRxD9Pwbq+aaBkTwUaQfTBvo2P6RgIxS8KOTUlLFb5zZ2ebPD31Ygq2ZlmlYC2phefZeLaRaR3IvKb3fV2FySIek1C1EOFH89rVOF97ECZUcxnD3CeLfMKOXaQSa0LnRe8K3n3tN+vo7dNnJShlMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230900; c=relaxed/simple;
	bh=08I0o88gE8cy/+U/o+AKavzx0eRFU5y0gnDfFw+/PXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=An6mt3ymqAli8tRDzHNQSLU+f7bjx7vO+buog0k2Uq42VMy7wgk3q6RXj5spcqWImfx9DxXsLqjnYD3g3j7d3X40Sc9gvawz9fAzBVi57gzg5nNIes/ZK7yzvz+uRwzqr5hU6MYMS2xy7WdUlQ29QwTXbE5JPjdangaThie3IlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDI0A2gm; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDI0A2gm"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4b77adso3523267c88.1
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230892; x=1774835692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0G/uhHXfu21xXv3gnOSiW9nh+0t2XQiNOcz2tPqgk4=;
        b=nDI0A2gmNtS5LgvEVUluvkAX/FWGS575ISd1L4zyGn3fEXrltN5j8VtfW5tCiieWY8
         41nfkoGX88hpgDBQGSDxasP1DdMXRadW7Gi3bWTbS4Yu9FV3Sktl3u50jpSLlO0rYKft
         wuvu/1zVyMnCtN4FkmZVDcRnaso/zar3v5dJ2l8besyL7/GtuN6r2q3Y34jRbJXwA1XD
         EhI1xHP0sRUhMKgdha3XVByYFwiiM8YkVuJaA9mc0VZf208/yBqed+wLu7FcbDqOMJMz
         en5Nd/G2nUaWODtuYeYkxOipEBkqfu14gl6Kt+ii6vqY2P5VoB4zSfmNLnfenZ74Kh6d
         gi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230892; x=1774835692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0G/uhHXfu21xXv3gnOSiW9nh+0t2XQiNOcz2tPqgk4=;
        b=Ako+LfhMuAdSpdhbClghCD9JS8K3SrsHVgi8LiiVZxHfEuNHQYUhIliTFHlxewPZy4
         VlvQ+iXf+i9/J5NhOb16v999gZm/ASsovmdRC819EX/AoGgtiwmYY9Fg6KG3MeOLriAy
         OlwgKCQLT78c+IoMtSnk8iFpWj+bwb0vhWLOsThMtLM2DzkyK/NQXtW8HZH2IFoxWE8d
         rDU7AgLpF7hiHWnL93LnL3wM4xUeQsr8TcNYv2top1A1TqMXRVW+89XbXrzqeAIDWuwk
         OpZYtf65TdRv76BzzNEhZV/5tLANlm00M1U9Do8WBv4+SS7QtJ0gSoJvd7nHNCgj+b0U
         yX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNPOl84e4XtKZS/QntFWdsJu6lDRHQHQVljg3aKqX+/QkNRTv8qEzH7IWAj9EFeqTuNmw/LlzqhDB0@vger.kernel.org
X-Gm-Message-State: AOJu0YwAi5anZxDE/cd55hclAYokbljUt1Htk//ng6qBNWE/wH7KMHhG
	tqBNwYvrJgoBjDAt9eYyaRBjNCGwC/f362Uj53dS29TEsgz6ZjenTZZx
X-Gm-Gg: ATEYQzwkuCv0M9dGtqtjSuLMl3EQs59dpJzk/dEpTHySuhOpmjzw+FbPVBZrty/D8EP
	71xTTW++v4SMjiCG84zZeto1K+IVgmVKrnZKl7jEGsPAj/ZsS84dyVt21ScBw597VTSyEWw+52w
	lmaxd8WbZwsR9KYaXGTrCrup2FJyooCe5Va+Tvf0Q6vticL++9L5NMsEg0WotV3TV7NiZdBzp8h
	z8RISsM1AN+NE72dc33CPPknZ9ifEm2u8BugjUEVK6ZKneupl6lreH1y7dF4EVbO5gZOunAG8kx
	c4yp1Jdaaf9OGTj8PfWQOjBfG2ri7zN/5NYFCnVErFQ1xCNRa3NYURKOUAwwjogTR3VUrZai0Ag
	mwHeCSfS48rEfvmDSWKGIWxsFhQmcAOTDcaqL5LxBNjfsqXsLrBm1L6F2nH8sUEkeJ89UyiJk/o
	uoiSU9bEV6DH9sTnthZQe5s4Af0NjB68BVitKd7wRue3pNfFHvalCEachk8SRMRUnO0gkQITR0r
	CDF8F9sncTRob8=
X-Received: by 2002:a05:7022:eac8:b0:128:d3de:c9e4 with SMTP id a92af1059eb24-12a726db2ffmr4311793c88.30.1774230892088;
        Sun, 22 Mar 2026 18:54:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:50 -0700 (PDT)
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
Subject: [PATCH 06/10] mux: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:24 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-6-b72eb22a1215@gmail.com>
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
 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 23538de2c91b..774d4cc67cc1 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -521,7 +521,7 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&mux_class, np);
+	dev = class_find_device_by_fwnode(&mux_class, of_fwnode_handle(np));
 
 	return dev ? to_mux_chip(dev) : NULL;
 }

-- 
2.53.0.959.g497ff81fa9-goog

