Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A432248AF
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230884; cv=none; b=NR/3LMnJziYAmgs5kb+GGMZ2Zh7SEfph8aCcSUBIxdTbDLzbiGbbRoomsfkYicFZKAla0QxKkp2UJiz8kuTIyBjRxhGreBxL0F0RjFfEsuFN5jukGTBPOPQnGM7fLkUXt2isHtoqZll7tMazjAcNkVebC4dpZTuzBW0pc8BS8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230884; c=relaxed/simple;
	bh=hPCCh7wVY1yv/Ut8yT6oomhgehBamoMfqj/l4kLk6Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pta9ucknFZFgud/vWUslpYFoH5nTU7NYC+VUGcbCTsnoAhkMyY8zjEnp7oF4A4sjVmHxSuLhBC91mWShpB46Zh2yKLOmZEEBMvRefA/+20mkEk5Yb/NPk1N+0/gUvncZCGQp2gJBDmFbiTVeuMzb8TtCSEpbpnOIwYRzlnXMGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTWnSGf7; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTWnSGf7"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c1092cc08cso1024178eec.1
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230882; x=1774835682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X8icAi5hW5PHcS4B3NheItH86dqdd76W8IY0AZdTSQ=;
        b=VTWnSGf71UerOR0ORdlnUklY8mLDZYkVyhF1hvFRsIpiSRgbnv0X58ocqWFWzR1OaM
         UEBodOHXlK+jo99NJyUP8Ot7gYnLmPeh7xijqhcoQ/Njlouu4sSIRA9frNjdwSkV5i3y
         xP93ajn9lna/yYGtj3EHYQK2e8UaqJhgKtw1ByLYOUQmILwYOY+HJTlZKf2UfL0w7lwK
         eqUC+EnI26ev4Jmehk5pI9WvWGIdjiPTX2iaCZCKgqIWm+O3tPi13cQ2fE7Rx5YPlO/H
         S8zVLChQTmaBkDKTo40imaxQajQe+ZzyKJR1R37bWBMN4aOcYCKIpqWHEkDZose861XR
         MUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230882; x=1774835682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7X8icAi5hW5PHcS4B3NheItH86dqdd76W8IY0AZdTSQ=;
        b=sTLboG4aciIl3zSKbmU97jrxLTO8oE9t1a5PtI6nrwmuRxZ1KDJvARKouIrGGhpzsm
         eKGjPGo4vtN5gOa7W+ZUdTFAd4e5vtUOxnj8l20XFRF8nTYy3ij1OuosxtywGIzD5qSq
         p/rZ6fkz88zwUSI+Q6y1oNvvi91svafsJhOhapGIi6xKrs3JxKppHOh0agWoTmnLE5IZ
         Hh/i8S/IgPUY40LpQEqGlWELwSYI8/TOFqr3PVyhjJjdbHEMuLzIpY8aWS93n2hzw8Lt
         HxOVy35Tc+pAvrDzgYqIEDrfujtAVQj2AfSd6ypOdBMVMdusLze+j0eABLDtriOUrlht
         D9jw==
X-Forwarded-Encrypted: i=1; AJvYcCWT3WE1VCxvzvUl+HU8c9yEO9uifJqOLXcQ9EaLCZMuVgrGQjxc7B8uJWKkS4PR5Gwdtgiv2z+U3T5U@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9JfU6ksavRUNCguVcGLwv6w9qvtauYKdyegS9p2017b03gpTc
	cEGlL7JCIsoLwkCdkpHHR44ChRlK6uGTsjr3UHu6xXV9lYjerxVh2Fch
X-Gm-Gg: ATEYQzyArbsX0GVej6loJFV8URlUvh1O0VKasTeVpT7H7L+mEh6nV3PBhDF9nfOXZmu
	UmrHFmCIhHlMBa2Tyt2H/r+rKmYmTJBr5js0o81HA4kyiDv/r/5b26FYJhzNMxC5MC9U71snVLl
	PG7zeWk72e+QnqvKz3Yyb7HUTlR2fLcIVNoqeBPsovuIDPOKBzlNDHBl3t+jFlFnoxgqeA9bqT6
	Yl0qt+czzKw/RRxoFNrxqnwXIHo4cqOMzba6j8CqluDlDgCQgHl7SdNX0YGLCc6qTa6t2A4bGOJ
	+vY30lhL0xOpN0yvuTU7QlA450WPfIt2oQDccbMRdPbjJvARb48heyNTYgRpBdhy54k1ifvfC1y
	KnyJD4HoqX0i86sL7Iil51K3pPeLo8w7cMcRBtZ8ImXlAHelUDZf/Lkhxn1hHmPmtLOCSyWZGvR
	EQRANFHIWPHlRJnqw8tZmmyuCJ39tk2SSLNoXoxQeQSoZntKpvZI+6SIQqd0mm2qYyzIDe1kI1I
	MyhG+On3Ubm8Wo=
X-Received: by 2002:a05:7300:e7ac:b0:2be:9d3:c8c5 with SMTP id 5a478bee46e88-2c109816b87mr4889998eec.34.1774230881836;
        Sun, 22 Mar 2026 18:54:41 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:41 -0700 (PDT)
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
Subject: [PATCH 02/10] phy: core: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:20 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-2-b72eb22a1215@gmail.com>
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
 drivers/phy/phy-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53..57bce6b63a31 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -761,7 +761,8 @@ struct phy *of_phy_simple_xlate(struct device *dev,
 {
 	struct device *target_dev;
 
-	target_dev = class_find_device_by_of_node(&phy_class, args->np);
+	target_dev = class_find_device_by_fwnode(&phy_class,
+						 of_fwnode_handle(args->np));
 	if (!target_dev)
 		return ERR_PTR(-ENODEV);
 

-- 
2.53.0.959.g497ff81fa9-goog

