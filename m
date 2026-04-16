Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B93E0C66
	for <linux-fpga@vger.kernel.org>; Thu, 16 Apr 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350566; cv=none; b=fk360/xxI2Ptp8D3wQLEYUkthgFhbEzQI+UlFa+Eo1sDijaXdw9t0DX2leCLDUkJAFcXr39NuCuPrKyOCmUTv16E7lHYfcw/lzFpisz1f0vboUlg17yYGrp2aI2GhPj4oQK/HZQPxP5Y20XCmN7XXX3fdbdnUQ9yKGlOuXPJ0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350566; c=relaxed/simple;
	bh=lNett6iejLsfwaJeQ80UJS5S0wekv6jUzKXG7ijjLbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myUtXmTtC7+d4jx05YiYPQrTRb+T4WCqKQIVYXhRXQE2mTvguN4vcC9HvIM+jLNHE6sl2Yna+jXbczCOnA90WUfSiLDX1lgCwcAshzbjEDGFar7FhaIc/OmvGjKbsfDxCIpO7Q5qKdRPXR+0Y92i1a+5Z+6KrEqmmBvkrvjaIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShEDho6o; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShEDho6o"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so1316426866b.0
        for <linux-fpga@vger.kernel.org>; Thu, 16 Apr 2026 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776350563; x=1776955363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dQoW9IEupnPf0vdvP3gC5QucYExC5rqYZAdJ429kig=;
        b=ShEDho6olUVEGBGJTjv3+w+BA5wC8srcrSKeNBKhnsFxynGAp6YsmeQI7Bk9O9O0iM
         9dYoJLB5Al0zxwad1/Z6FciSpvNcFpdj2FSI/B6H+dlmpP0zGGYdXv1vPKqw+Jiy4+Ti
         BmEd9/btKmDk2gERdxIKF5YaZsODlQEeZXqlWr9BkQlQtaqhE72SZmblRvDIRhgRVVD8
         R2/xav8sAvGhKQ1qbd2IlcNxKpdE4WL48SwEbUO47poXmDeJAtE/UtUPxrA/dAgRGKEQ
         4Zw0F9X88R1Vkf3p9lcO45c0pO+KSIL+jVaGDXmWndDu9kVdgEbmFQYFwYOL2o72aWNP
         CYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350563; x=1776955363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dQoW9IEupnPf0vdvP3gC5QucYExC5rqYZAdJ429kig=;
        b=SELFOLKFmPQRsT2PlhdVzY6fLBqFzozJX6E4ubsAnIdsMRnT2vWPrNa9r2m2YOIeBv
         ZHo85pKRlzII8Zag/2zPAWepmR1791dBOnEVvY4y4M4/OXo9r/K4UgwBd9UHvUL0D+0U
         lGX21ckFM+/RwSmOMTGDU5xgu0q0AeB2JVX3cT3CKJQ3Rlke0Mnaqzf/6YZNCV+amEx3
         LafREcZmXzbO3xSM7oWg7wlLIaXi875BonWs+KRIT95wA7sYbPOSOha4oaN4795Y3aEf
         XgS2vwDfDdY0fvi+o8mietDATt3+jQ/kO1dHgwzAltNSXa8/CQvDoqZILWjwvcEJd+9C
         bFCg==
X-Gm-Message-State: AOJu0YwjHxoGVAYpxXtgJnm6O7VqKlIVO6veqKH7c9yZ2SWH7bxot7MD
	mQb/YBSruPg7b+RMh/a/8ygaOG0QZnwQvCZbp0duWnC2VWZ45zWPgqXCfYzSXvmhaC0=
X-Gm-Gg: AeBDiesfDlzpIWeO5oudIsRtoGTleEwPwYag/mfmqJidOMkAB7oCPq3SGx4yOFyvYZe
	axqson7h3hl8MUvZLz2SHFt/SeN/Q9HQtdDkruYZ43tJDkjdbqLBUQePuCM8Rbyjg+Q24YV2Tme
	BilqM5ekY6hEBqYNbthLk01PNzovqqmr4eowk8C/4/bJ1Js80ri1tKjpx60TTb9jPleg+Zi5G0Q
	6KQZJc9Yo2Nx+Wtj/h0UqgMK/i+fkazmRUqMEwHxcImgw2kidAl/YuJv+FqoFFpVfxZylSxVuWF
	IJ051xngj662WLQLMDFbmUxkcIK3K9moS79OkEMCNUWEaHifvUjR7gWDn49QZj0taTRlfOcBL4o
	cqp5319t8GM1zZl0m14+xj8BFivXCt4v0fwb0pgFC+Np/JvB3MTT8Gmx50s9lmDTH5jAayYFsTW
	gWUaH+iLpm1mqXQbSC6mwD+n6uCVRzwGvoeYg5
X-Received: by 2002:a17:906:99d0:b0:b98:a49:a22e with SMTP id a640c23a62f3a-b9d727fcc57mr1457033066b.36.1776350563046;
        Thu, 16 Apr 2026 07:42:43 -0700 (PDT)
Received: from iris-Ian.. ([2a00:20:636a:3838:3bf9:3a9b:8000:4975])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba2a112cc9csm90502766b.40.2026.04.16.07.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:42:42 -0700 (PDT)
From: iansdannapel@gmail.com
To: linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	marex@nabladev.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	Ian Dannapel <iansdannapel@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexander Dahl <ada@thorsis.com>
Subject: [PATCH v7 1/3] dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
Date: Thu, 16 Apr 2026 16:42:34 +0200
Message-ID: <20260416144237.373852-2-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416144237.373852-1-iansdannapel@gmail.com>
References: <20260416144237.373852-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add entry for Efinix, Inc. (https://www.efinixinc.com/)

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Alexander Dahl <ada@thorsis.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 00bffb9c4469..9e20384ff624 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -485,6 +485,8 @@ patternProperties:
     description: Emtop Embedded Solutions
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
+  "^efinix,.*":
+    description: Efinix, Inc.
   "^egnite,.*":
     description: egnite GmbH
   "^einfochips,.*":
-- 
2.43.0

