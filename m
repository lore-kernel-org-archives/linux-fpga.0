Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BC221FD4
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230898; cv=none; b=iRMDDtWEx4VrWw7JKx67efxtthhqd+9N3udtpWUdCKk2E/QVWJcym85/nNdwkEb3WJNyz8XJUEKbjB8IE/2rnIpi/vqYz14J+wXQmUHRmnZJWDTKBRamcL8pBkmr0saAspQh7lX3lgOX8TNUHAADwmZkgyAINH2LO1awsMcNh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230898; c=relaxed/simple;
	bh=I5fS+FwbEw0P5vASCqinmGTcQr2XqJ+MU7isqg4KgEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0RGqnYnHCGXs5GSqABQF6cCdcfB5uCjYal915R0pvg9vOD190Gt3gM+rRkiwuu6i7CW3ECNnxBD/45foFQqy7ESCWTruj/0YnruXTZV289TSIKfzCHdks+167xPXTJPU3uatJ8mQDZqkoqTq/dxTG6AFOqadz1K9zRpiIpBPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Secbzmgi; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Secbzmgi"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a71ade78cso2804613c88.0
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230895; x=1774835695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfkDMRyvNYwOzv0q3wBq2OUYpD97VO+f6771zL+oLTY=;
        b=Secbzmgi7FroaLb8xUHxJ3ELfo+qQW50YJN5LWVovKu0WNnW7nDa0O+BGf4+xaGS1e
         kqrKUjisgWI5BSxWmT2Ehq7RV5hHqHqLiF2xkY+ehbrkgQf6DganeDhT50esg4bb4jMN
         tI578Ui9XmqBrOTg+b3gAqG4O2px40fpv0eEb0W64hVfs4MZXo2ldAxN1oyf3s0/fxe3
         oNabLBfyrbu+7lciY2xzfYmjvWUupfnDLSWlSboP6hTK7lGxPqoWalLXpm0et3y2RbY8
         AbAtMbtLoKYOOg/IUNvTk0vFR+TcalivVeq6THQszgdUKZ82qPnAz43pcdGV4P/dPapf
         HSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230895; x=1774835695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mfkDMRyvNYwOzv0q3wBq2OUYpD97VO+f6771zL+oLTY=;
        b=EK9N8vZFF1aqFLtD3fOG+RadmUwm1Y5uB3iW6gMq5hjNnTXsfLY4/UE7Yn/kY/oT7s
         G/jtaIEg/dLxtC4Ax+yBPdd8BC+BXwaHSvqxaMFmeFZdtukOfe/JoB8r+Vu+9UpBEERM
         ICjQXZgR1uF4lNEhQgnBucmvc0pJbnjDBavbhxcXFc8dYss26RLicx8wK1LH1Oy9FtWv
         jIIAiCw2Ju4aoT4+PA2t7NxYFsJb2T9yB+hdC59er9qcHI97jrQjtNZ9NOm8XNBmXVm+
         hslZajVxXOE36pGLXUd0VFDJcxbcqeAqgMSjfKNbqN5evmW+6/vwWTnW6ZawbNJZaomp
         TnwA==
X-Forwarded-Encrypted: i=1; AJvYcCWbOInjj4U065sr+d7ny+rldEz9hDSJCyw41XSBcO+J+3IGUYDvvZ8z3+StjwSjHpFXhOTr33xS1s/0@vger.kernel.org
X-Gm-Message-State: AOJu0YxNqDZT0Byh+MPruxrUJ098PQn7Wm6Rz8ZDA8gFHDwX+ANPyqcc
	f0TbXzP1R9Q7kzFR9CrYFa1sKxbTlFP2aptQBKDu0C0ztJ7ZjLlnn50B
X-Gm-Gg: ATEYQzy/QUQ5pgeW+gy8UezRkaJsM8GuDsdiPCpRS0ovLAHfGElP/x2M6qV5GJcb11T
	M7A8zZ5PMh3vUIMJQMDlRq6zj6ThhbV+1eYyV746QQgxDVgHE37iHn3gngQ4T1w336XQmyYiMLJ
	koLe1XEQ3oOoIECjvRvPSpJMXp8J2WDwghzXQbIaee6TELp2Mu7tj3Z5THWyKva/3zze0rCeCDB
	s2Dd4ND84snuKu1uTFihFQD/bU+WdquLczLiVNh9+VaLzPtbjwTGT/g/5l4tGA616WFHicZf1kv
	WODyYoTfi4ynt3EMkmv7CpB6s/Z2YvJ2nwlr7+NuFTxasBgaC9yOEUmlO01qmq2K5nY4xtAs9Hz
	KR+x/FTQHX8hs5MPECFza7duCi5zCe3AKh3R3UNTN8gDhvzIZ7okkV+ZsTiygNnC9azuiI9fSQQ
	rbPdAReGY1UGPWSZsGwpxQRRv7S8TATbh6mUE68fEsVmOI+lxtE2Cjms6VgrGutF/XVoQ6VeORU
	2caPcNTmh09s5E=
X-Received: by 2002:a05:7022:3846:b0:12a:6b99:1ad4 with SMTP id a92af1059eb24-12a72684aa1mr4380934c88.11.1774230895127;
        Sun, 22 Mar 2026 18:54:55 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:54 -0700 (PDT)
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
Subject: [PATCH net-next 07/10] net: phy: switch to using
 class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:25 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
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
Content-Transfer-Encoding: quoted-printable

In preparation to class_find_device_by_of_node() going away switch to=0D
using class_find_device_by_fwnode().=0D
=0D
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>=0D
---=0D
 drivers/net/phy/mdio_bus_provider.c | 4 +++-=0D
 1 file changed, 3 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus=
_provider.c=0D
index 041576eba47a..ed3cd9a37c67 100644=0D
--- a/drivers/net/phy/mdio_bus_provider.c=0D
+++ b/drivers/net/phy/mdio_bus_provider.c=0D
@@ -21,6 +21,7 @@=0D
 #include <linux/mii.h>=0D
 #include <linux/mm.h>=0D
 #include <linux/netdevice.h>=0D
+#include <linux/of.h>=0D
 #include <linux/of_device.h>=0D
 #include <linux/of_mdio.h>=0D
 #include <linux/phy.h>=0D
@@ -754,7 +755,8 @@ struct mii_bus *of_mdio_find_bus(struct device_node *md=
io_bus_np)=0D
 	if (!mdio_bus_np)=0D
 		return NULL;=0D
 =0D
-	d =3D class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);=0D
+	d =3D class_find_device_by_fwnode(&mdio_bus_class,=0D
+					of_fwnode_handle(mdio_bus_np));=0D
 	return d ? to_mii_bus(d) : NULL;=0D
 }=0D
 EXPORT_SYMBOL(of_mdio_find_bus);=0D
=0D
-- =0D
2.53.0.959.g497ff81fa9-goog=0D
=0D
