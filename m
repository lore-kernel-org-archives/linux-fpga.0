Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BF23182D
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230906; cv=none; b=h0oJLuAUsoOzWRoqzbIlawd/oFx1VFiz6ZJD4ouUDTxKMHQUdZniEQ4XMhznsmJ35xeOgf+b7mNTLQnGrYU/RIuRpYzEPOpR4S4nluYnb17X/hMhcRe7jzbU74oeUyCoSBFYUz2OQRlzeo88Z+3JNx+sKYFi3uGD6bmGkXWdmUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230906; c=relaxed/simple;
	bh=oa2EwaUUG59FtphzeTYHy1LbWnpif4xM00zY4CiwrfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNOzQn5b/EWdRZ0QkKVa2lPmFKiz/0UmFE/FsSYiEZxR3uubVJ9mINTHG4YC16zsph6YgJOECsfa5LSjDyeA4lWlKezepig0I1mqXnlHqfBqpihEYFnf6kpYxaD+hyxioZqIkxhrGX2qrDFvh8bHxj9+R57r9SZvbe1qbFxmdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGsqHg9u; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGsqHg9u"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c107ef474fso4398631eec.0
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230900; x=1774835700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBYbOsFewxAK/zyXErJyI2wWdOZnO5pIFOiKOKYi888=;
        b=DGsqHg9u8PZBheqZmCbwCygye4QFZ5ls7ZTjLNcDdLc8lNWsLUAb7+azOoGrE2fxsZ
         pirnDYbzR3NgIV3X8c7NDwwT3bxsIalIYolIyIkEEVthhG4uEbhiwSJsF4LQoRqBsjWt
         NcPXkgrxG6p8YnvyQOQHlZiJfDqBZvFiNhUbSzVyanppF9lwjCwF37UDljU+sho4aXdc
         kA1QVEc5rNVpmEbfjh4WITCnjpp8qF0r2pOO47PSRdqVjeKbivsv7cOYAzTNJuix2XbZ
         MZmVcH/ZGGbzlAfOMtW1PWao0skp1Z40jqbSpnhHqzzjDYHyjwK+yDjQujbW4A4oNgSV
         dq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230900; x=1774835700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uBYbOsFewxAK/zyXErJyI2wWdOZnO5pIFOiKOKYi888=;
        b=SCBUH3Mw7p463fNgBDW9lb9+k+JGCTzrbwB8fY0Eb8xv2JV1b+lSW/6l4/eCmGi8Z4
         hcqxJzGWx2/VwWztOpPFJ/jr+Hzfk01xHjmHCPQO/k09Wfh+5JxZ3yfmlNGEQdi7Xj91
         FsVXZgihHXkYcE/PZ35b+hXywPT/tIh5LHmg3NsDdkLBph3GryLDc1wn2Ja6U0gwQCpW
         U4yPY7oGL+vkve6HtzUnMnu5vFyBxsWIEbzQgIvgXDbij96FtyLA08PlZ2ni2LrluJhp
         xXb8QDzZJd+yC14QK+dc5/4Iuola9lqzKOIhRKUjzMI+9xrs+tUxEX5YVAM2T7hRuWv2
         VNKw==
X-Forwarded-Encrypted: i=1; AJvYcCVgrWTukO++Qhdtv//vQe25+q37fICux1J4uBqYs6a5HSX0dJyCC8iGL7qCsd2i+YrfIAIcNDoYHykc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7VLgrvCp1sG3em/byr80i185e51K+85zkNmXXfldfSiRGIl0T
	BCgCUIZ7CUrn46Bzf0TGqKbFR1V7ECerq2Ej/lQ6KfuPaSefMdZNYlNO
X-Gm-Gg: ATEYQzzuG9ERDlDldf/JS3h911supkGNycMbfegbckxAzvQnIwZtU4aqKlYtbvo0Z8b
	u8Q9kEpsZ3C87/hppTnG6ZtErNfncaF0pYK1Cm5hXSUIOvtSNA9gw1Sircc9iTlRGTMNI873iJS
	le2v8EaU8xDp3AsaiE9Z9dyuTP0x18g4nF83ULGR5f9QKquXD45dnF6Vv2OwkCD+ffUK09ojP3T
	n91j/CT7xXOGthS0UtqVXkT4lKG2mwCnlXO4BoRCwEzei1N10lmTX5y7t8N8OqRajVUSQ3kf7U1
	WEF5taS7SR2v03vilNOeOPl6/r+qHGl1Wzab5BPCweOvxyV8W0qVdarj3s6l2nkan7ar/mPRDHa
	SV9OB0HPV/Z+eu7c8mJUGFbGDSq89GUUnRYtHw59OwG5tujiJXFUrVHIbcLNmcaVNlkzz410PKn
	41AUuPJ3dVAPL6a3Bzr+/fITO7WWeaB39xv6jgZbpGbNqCHU6IF4ioGWy/apjemGOwgCk+fkc2Q
	dRlhIf0BmsGN94=
X-Received: by 2002:a05:693c:2b06:b0:2bd:c8a2:954 with SMTP id 5a478bee46e88-2c1097b8ae8mr5509864eec.24.1774230900153;
        Sun, 22 Mar 2026 18:55:00 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:59 -0700 (PDT)
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
Subject: [PATCH 09/10] fpga: manager: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:27 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-9-b72eb22a1215@gmail.com>
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
 drivers/fpga/fpga-mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 2672070ced02..1e7585a4608a 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -716,7 +716,8 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 	struct fpga_manager *mgr;
 	struct device *mgr_dev;
 
-	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
+	mgr_dev = class_find_device_by_fwnode(&fpga_mgr_class,
+					      of_fwnode_handle(node));
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 

-- 
2.53.0.959.g497ff81fa9-goog

