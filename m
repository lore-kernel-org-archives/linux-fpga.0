Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD08386576
	for <linux-fpga@vger.kernel.org>; Fri, 27 Mar 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612133; cv=none; b=B9wYiIlaUgfMBi30zDNWGrbJiX6puveePITk2KRGoFvrn3rnOwIjrojwKvPtJJV/UxaYyLjelXFBcm6iwa65uueA6LFw4WkT8OM3NBfd2+lzF4t6twAcWPqildVITu1Nzru3woY+TYkfQWLcp3C80Xf7yFUbIZu/yWtIleMT2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612133; c=relaxed/simple;
	bh=Dd3x4WBKvhqfMwm6I/iaCaqL9LzIkZkFwPA0xsebKOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwDO/Eq3JsfNTNGnQwYJnMo5PoNtx4PDlY45omaoRXurI2ls+8ab1oqGTrAG1I5YmgfO0WbxNutZlNL6Fe31uD1c6JG3QtI4EHnNYVBvNTXM/QF3I8uWoKiCR7gTp47jm+zakfxZwGC9aOr0wyjPELP58BNudHrm4H9xlX6m0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlmseoMS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlmseoMS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48704db565eso28963525e9.1
        for <linux-fpga@vger.kernel.org>; Fri, 27 Mar 2026 04:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774612130; x=1775216930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlDICnktaJaM8Uj3TXIg53Glb9nXu0vfJwdqBVHvmvg=;
        b=AlmseoMS9EOPtt8zjmdimJUMNfBM6/teHhLrvQusdX9lZtVfXrflsWCNu63T8zEAJJ
         9BNsODWkS23rnwDXXGPfL9dEoau5V1BMpICRuWnTKO7gzhb3UuHu0Csicqgv6oR3NhZF
         JSBZ6E7YURtKwEm4uC96s45Kh5a8hhQZ9+bHO8LS59la4mdrrkh0x1NBVO1dwwxYUQ5R
         h7J9UcLUmr6er3doxJjPgrG0rg88Z9515UjiHgivWDjc3ZY3BHrsJbHpx2G8gHoozv4U
         lb45SKkSKrYfrOr9g93vixSh0u9ZyO/HlVrO96Vbu4azSsxLvyU7hcA4yzcjbb+TuiFk
         MEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612130; x=1775216930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SlDICnktaJaM8Uj3TXIg53Glb9nXu0vfJwdqBVHvmvg=;
        b=aDPyOA28P7yxxTzqeGIJCbiU3vz94buePN/uYH4ZnPfqw7V997FH1lE0Oe+UFj4GZA
         NpRqXakdhymtKp9v8Am6xbhNd2lSnGU07Rs5KJasnvmb65se9YMIpFEZwQ+wJFguyRg6
         PPWtzsiFvTAAWZ7uRpfcMw/LDgzmSRjDq8ERO5PfX90WWmkQGSr9+A1jlymAiXgedVPq
         /hITN6IMJZK5vCaXZn1YIHIMPNAC8Am8A3S1OcqglybTUHWyGfxjYfojfgV0OEITVwu5
         /Sg/cIkJFXFtdCzJhk/rk1gKKVbr+JuXzr9xsGO0kaqIYZdAVljnLfZMjN4GhqMmu3Zi
         qdTg==
X-Gm-Message-State: AOJu0Yyumnwu1cqE9mQD+b2+ZytaUwL3SCkBW76A1/j5O43KKorK0nYC
	j34QV+kuzOufuxRsHwIBftBLf23PocyYLHGRzqwySSDZ2ELIoFggn9fu7Ne+PfiW
X-Gm-Gg: ATEYQzwvh4pK3vpJWyrDBMJVeydbKX5UfnjVL0lgp94uSVAgTA0QC6dckEnWM1bE1MJ
	Dty4qRJLeqyIgZ+h/rpqDiCbbaXQ9UJWeVP5VT9rYnPZApxbjXpsFviBNV/vhpbucnQKh1w1eTw
	fwmKyueNM2FpOaoPfuhyEHBNd3Q8xwZZwG15dGBTHxVgMB3JIF3v05nz9O1LJOrg4BJa5ZT1Mr5
	eP7nbTAEA9b0o+yrpRcxIbldzeRaZ55yVnGdzVkMq/ZKfkf/Znc05LfURp4ziJX8C6U9RRtg+1I
	PmdO43JQBZEacW0c6AIsKzBonuf9rT9pJu38Q5/EKq3LnjFD4To355eFrTdWAOP/jxITF94OJPM
	GrsNx6gneMEmVPRnrijDnli/A81OdZFaSbdFKJxMowt4FdMiKMjFmariJvNeBEYW6YbtD2PXWAu
	iNjovH/CWLQ2Fctk8Rgq+NT3rJ+TpqvibnMafzWNaiL1zqYXeuA2EujFWWV1Utw63LYorXHz1Aa
	esFccmt/FQ2LAHvnsr4IjDdqQ==
X-Received: by 2002:a05:600c:c8f:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-48727d45a8emr36404505e9.5.1774612129939;
        Fri, 27 Mar 2026 04:48:49 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f28a7005a7787565d4257d0.dip0.t-ipconnect.de. [2003:eb:5f28:a700:5a77:8756:5d42:57d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d49c18sm90506115e9.14.2026.03.27.04.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 04:48:49 -0700 (PDT)
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
Subject: [PATCH v6 1/3] dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
Date: Fri, 27 Mar 2026 12:48:39 +0100
Message-ID: <20260327114842.1300284-2-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327114842.1300284-1-iansdannapel@gmail.com>
References: <20260327114842.1300284-1-iansdannapel@gmail.com>
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
index ee7fd3cfe203..dd3837500915 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -481,6 +481,8 @@ patternProperties:
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

