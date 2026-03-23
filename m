Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B112153D8
	for <linux-fpga@vger.kernel.org>; Mon, 23 Mar 2026 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230880; cv=none; b=rk8ZVhsMyYafY+AVJscZaQAUKdz+57QIUyjS23S8hZrT5/MO31Ax8rJTdCUAl8ik9+wou5vY7yrDZ33DY4d2VJqkAuSgjEHCnBpKCTP/yD7sHGlH3IZzad+Iyn/W7xlnFTv+qBTvB6uw27H4OFZfMpWb33gsugP0Wa4ObDlWeJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230880; c=relaxed/simple;
	bh=JUqh9KjJr81PA08LAGWLpc/TnqC1KKCJHttSUso4Mis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBQq2DX8Rr4h6JKR40DxzLSlPgNe4c33Go9/11nH/TTx/y286Zpb/0SxwghPmO7eHzAIJm4njoUTcnps+lTJeJrXlq86AnM/9qDffo27upvoJu88Nurg+iE5pDdx+yDyQsH0PwVl2Qp4lq9cA9qsYzEHHjZAM8txdFA0t3gW9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZihrLDn; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZihrLDn"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso2856516eec.0
        for <linux-fpga@vger.kernel.org>; Sun, 22 Mar 2026 18:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230878; x=1774835678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFNqFKHYHzU+/IYMzEM9SYl6am5Pz+NCaLhPwszpQBw=;
        b=iZihrLDn3uemS80BJaK0ZbnZyZPK2nOhEbJEKP9Ll6ZnR//Egc8auBEu1gY8L7f5cE
         vGvkiZtql2gdyP16RHs2zH7kzoNOG7ofXC1iRXWSmSKsMyYNdGKTIolRt7xdondUtWAV
         BzjD/cMkNClaTXZfnu4Z4TliktptCHKPofnbghtnSwTPk+HJZnI8ZGovdU41MDyZqlGl
         ZhKPuG1YF0fHUflmZwL5ltOscujQ8xhH/ZXK+Qk6sMFvlSvfNudRUSFwNbCiOnkbxgQx
         XAVg0mXyudvTdU6egJD+nS/ZZstD/tcd7Pq3pSfv2CP+pCaS9NUQdfrM5BQmCjDdSSfg
         yuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230878; x=1774835678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFNqFKHYHzU+/IYMzEM9SYl6am5Pz+NCaLhPwszpQBw=;
        b=XDpnyoZA0HRu/JS6X9lzeygJV86rm3QwPwwRjGLGhi1bw3gKzhM6ZzNtmnP1Veqzam
         86nF1aVKqZJs0bwpeMO5V5yFJmY5WF1s7+NDAJOF3Mh0CRM9dohV05Vy2kgqH2kryp/2
         +PoCHNK5D6pX1tOiKmU/TL1e/+PAjajiqBfzPfWjIAromV2QGiV/vh8cQNPoy+CpB/su
         1lCvUdbjuq7oKZOKnRfgLbEYHCaZy6uGpM/jwpKpb2nqUwUesh4UL6+6bNjN0X4ffgc7
         59SMDTFrke9AinPTCIPv3HhQV+lMoqNB2+dbG+fC5YpK/4fWcjr+CbOVBIlOdV92OlFW
         N6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVO5v8DJRp1EgYkImywopPwRN3c+T8aT/bBi7GNPuwL5mdldNdpBI/bHt6vU0UdFjngm5aLYYgD2pJA@vger.kernel.org
X-Gm-Message-State: AOJu0YzmtuE5aul2LnGIcGobNtOjDyEPp1BYT0zCTbGxOKoC8Sy/5Cv+
	vyjMzXjsMiQXcgU3ME+pklwXf57sFR4J+SIQDJpTLjTozdOd0IeghgGw
X-Gm-Gg: ATEYQzxityE5Dp+7zW1XeP8CqIGDkMyhlhUxbwxu8xsD5M2rWJd/2KgXViJ5DVW7apY
	2szqz474KMagndhVmccjdsvcHuGjiKzJGi7aLAIno4OeIlvtwLdf2+e0GnNSeY1KFcXEyL2Mn1l
	G7RqlTH90SXt+6U4hn4zdyVZm0TWbOiCTwBsQmMmqV+PCuoKqIit3ud67c4oJt9sn+fWcG+vOBr
	I1ZCk+hS2WzmPMjQ8KEgVZzDhXeXxvyu9mMjsqA0hZSJSiZ+OEJeD74V7zgDkOOSxohe/wp8OQe
	aZT7Pz6Bl+9NIx3sXxzCRHeLUa4w8juK72HmbeRZonxnEwfKHZD3HPAPKTvDd0uaDTW4lIepqX/
	/Hl1YarAWxJgbhReXXejzHUTRtI4clIbPoezstcKVBb7HJLgZexe44zE31xeERMx9duuzBDTVKh
	SDVV4ersP4Z30Qw/r5cdMO7oBGyIKbbGbb3mnj9Kgvcn0cIZbNmajKnT+h2VMBBdgs1ToS+yznz
	bxuSuj6uiWT5Yg=
X-Received: by 2002:a05:7300:571e:b0:2ba:a1a6:c73 with SMTP id 5a478bee46e88-2c10974ccb6mr3875035eec.6.1774230877711;
        Sun, 22 Mar 2026 18:54:37 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:37 -0700 (PDT)
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
Subject: [PATCH 00/10] Remove class_find_device_by_of_node in favor of
 finding by firmware node
Date: Sun, 22 Mar 2026 18:54:18 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260220-remove-device-find-by-of-node-077784fa109c
X-Mailer: b4 0.15-dev-a6826
Content-Transfer-Encoding: quoted-printable

Firmware nodes are generalization of OF device nodes and generic APIs=0D
should offer only fwnode variants instead of providing firmware-specific=0D
handlers.=0D
=0D
This series switches all users of class_find_device_by_of_node() to=0D
class_find_device_by_fwnode() and removes the OF variant.=0D
=0D
I believe this can be applied through individual subsystems and then the=0D
last patch can go into the driver core.=0D
=0D
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>=0D
---=0D
Dmitry Torokhov (10):=0D
      net: wan: framer: switch to using class_find_device_by_fwnode()=0D
      phy: core: switch to using class_find_device_by_fwnode()=0D
      spi: switch to using class_find_device_by_fwnode()=0D
      regulator: of: switch to using class_find_device_by_fwnode()=0D
      leds: led-class: switch to using class_find_device_by_fwnode()=0D
      mux: switch to using class_find_device_by_fwnode()=0D
      net: phy: switch to using class_find_device_by_fwnode()=0D
      fpga: bridge: switch to using class_find_device_by_fwnode()=0D
      fpga: manager: switch to using class_find_device_by_fwnode()=0D
      driver core: class: remove class_find_device_by_of_node()=0D
=0D
 drivers/fpga/fpga-bridge.c           |  4 +++-=0D
 drivers/fpga/fpga-mgr.c              |  3 ++-=0D
 drivers/leds/led-class.c             |  2 +-=0D
 drivers/mux/core.c                   |  2 +-=0D
 drivers/net/phy/mdio_bus_provider.c  |  4 +++-=0D
 drivers/net/wan/framer/framer-core.c |  2 +-=0D
 drivers/phy/phy-core.c               |  3 ++-=0D
 drivers/regulator/of_regulator.c     |  2 +-=0D
 drivers/spi/spi.c                    |  6 ++++--=0D
 include/linux/device/class.h         | 12 ------------=0D
 10 files changed, 18 insertions(+), 22 deletions(-)=0D
---=0D
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e=0D
change-id: 20260220-remove-device-find-by-of-node-077784fa109c=0D
=0D
Thanks.=0D
=0D
-- =0D
Dmitry=0D
=0D
