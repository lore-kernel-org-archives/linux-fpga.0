Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB4227B94
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230905; cv=none; b=UUMcSCl1ufAfpjxQMAjLfetqlbxVdie5c+W3l0pqudn8/u1GSGkJy8vO67dlfMr5ux79tH9mg+jpXVDwRxPVHIZUDb+3IF9q7bjgpjPzUoIB7F4jZD8LT2Fuvp1oOlDBCavqHlI2VFFTVtvqjyy8X76VeMcGI9+Go9I1T+4zplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230905; c=relaxed/simple;
	bh=DcXRlt171JGbuJjlPztdgWcwKxWTeoWbtUiwkXQpQqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rS2ZAqbS1aTWRSkBKBb117mFNW3ZuUC1fZ88HW6kGAdhbilpu79ZvlIeyM/xezxBkKjV2hUnK2M2iYt7ImQYZIX+/ohgGoAL/mLC782SqYOaSb9dcOiOnhQXfeyztAifTutTXlR/AmaQ7fm8XhOXe33Gsx6FbseNKi1uNgKL7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQTB8zRw; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQTB8zRw"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4159957eec.1
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230902; x=1774835702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPoVYlhKSTxPQorecgbDpnVbncz+dhf8Hr/jKiyeXpk=;
        b=YQTB8zRwPAB4QpBiAR72NGwqYgz7yRnzGtpKefhsQLbAj13ZIA+Aj0yO+kjlG+okzf
         YXcUNWs38uleasMsCZubgf1NIC0s98u4bXjE5dEaedt2TEvKcsIJ1dgx5AGGQTjlbamB
         qXNyTwRRBGi0ErQttPHZCuVQTZWXrmOS6ui4YQS54qb/vC1I6Sc9I1o9GwO0UkR+QSke
         P/7yfkeoCkWGAMjAotnwhvwzY9x60uTpTaGf0WoFunIzVlzgSu4UP+RG1mkt6XVCmaUR
         9Eln+0KL7RpNFZVk5/gDXv0irmYvq3xW+0pC7hKYovjebsnfeqPP38CpQAGRQb+rBOve
         Fo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230902; x=1774835702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QPoVYlhKSTxPQorecgbDpnVbncz+dhf8Hr/jKiyeXpk=;
        b=fLoGkY7Ruso3/8dApy8eeXcMH7js883OQZqYuF2Su1rVMOtgBwfDAg/puuwTqBH5rx
         MffPBLGIjeMXmrIu40dGUP5UutvvbGwKHppa7JZSJ95RYfEOIB8zaLQghvcrvBcfbs/S
         pazCXTlO21bZE7KY3h8TGWpyOLk+29PPxq1L7JLVN2AuSw65CYIMZFqSTMeVMDdq07Wr
         X6KnwTP8mluKfSryE/mBv63Rq3UhgcTY7pdSpL69iBpD2Y+RVQOAec10brmr8XAC72iX
         V36uyo7tz4KeGTlTqphaJRYfVg4islf70sgztbFAgC+SB2aU4mfZWfoPy96ZEOSgApOZ
         Bfvw==
X-Forwarded-Encrypted: i=1; AJvYcCXpHTiQjtRI67LAKgcraZnIYe3QOVZ26za20NRnrjqzUmfMx6lKRERgDYnRR+GcE7pQ7fzaVEFGre+T@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/w/7OTfKHezdQZq0Q8Yo05RhJ3wehNKp297SneQcx/wuNRAY
	qAYVoBfXn+06pWDnrV7zCyivshKiM5tnnpj+jljqNsWdfwuVD4Q8pMnH
X-Gm-Gg: ATEYQzzA5VdNWE8jlbKW9jU3QIa0IvY/ljEx4vIHoKJ+uNILFU0P5bO19mOVWXCX6SL
	mgdhoD0K3lCW2ln1JM2XvwOmkhblff88DERRoRuv6Ccpv1kuefQmMndQ9Uim3KJkhpUQkvjonN/
	nSgxwW79D6aFLvjXWi0G7kZVc1ZhCz87HnX1ayxRfRB8E5YCzLvKvY+uZb2GqbO2wolwjIFGL2t
	dQyNAOfQjfHNik9qOEuBiWQfhMm8psBdLi89/S277QP4MPXNfSr65onMzWervr3XCv2S3IKkJR9
	Dq0Zr6sOsxlGpL3fuuJW1wKBHQ4suMEH+UozxI/PXARmekZ5kDLmaj71Gkpl13LfZ3kBR6F3zYz
	U9EeHh6lf/b64iPHj6cgzp+A7BFqpBeohjlf+D1MjSElwd5Q5cDSonqSI4yOQKJnG4aW04IDw0i
	TG9r7X6K0dBbLYwz5YKCIIDB4FdqvcvLM1YoodTnOiN3E1aNMxPq9HtYL3DvXM7s3RO1/8BKf9u
	XyplkRUakn+rTI=
X-Received: by 2002:a05:7301:3d1a:b0:2ba:6978:2b4 with SMTP id 5a478bee46e88-2c1097533admr4453382eec.20.1774230902218;
        Sun, 22 Mar 2026 18:55:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:55:01 -0700 (PDT)
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
Subject: [PATCH 10/10] driver core: class: remove class_find_device_by_of_node()
Date: Sun, 22 Mar 2026 18:54:28 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-10-b72eb22a1215@gmail.com>
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

All users of class_find_device_by_of_node() have been converted to
using class_find_device_by_fwnode(). Remove the former.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/device/class.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 2079239a5aa5..e6ad009ce70b 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -107,18 +107,6 @@ static inline struct device *class_find_device_by_name(const struct class *class
 	return class_find_device(class, NULL, name, device_match_name);
 }
 
-/**
- * class_find_device_by_of_node : device iterator for locating a particular device
- * matching the of_node.
- * @class: class type
- * @np: of_node of the device to match.
- */
-static inline struct device *class_find_device_by_of_node(const struct class *class,
-							  const struct device_node *np)
-{
-	return class_find_device(class, NULL, np, device_match_of_node);
-}
-
 /**
  * class_find_device_by_fwnode : device iterator for locating a particular device
  * matching the fwnode.

-- 
2.53.0.959.g497ff81fa9-goog

