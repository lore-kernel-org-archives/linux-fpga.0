Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB06494A0E
	for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123220; cv=none; b=nz0Dwx2TvYGxBCIUAcclxuDUPl+TC2Wdvxy2x9GWICFEwy3dHtbgOR3frE+7Z1eOxPS17/oeAebIsv/2HK++rCO2G87GWbPfK/VAv9eIjQ/GV3xDg6boRFZ/HYn7d2uQQAfH//Xo96uw4U9ztJekftCqLGsN3Qz9ibnoG2+KgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123220; c=relaxed/simple;
	bh=x6fSzNzW8Htmx7JzIRVC3kL/nANgg4e8FJZlKdc/5Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/RIqKnzahZkujvjl65wYqOEbG7xkFPDqT3+LclmIW7tPoAKuHMQJ7eCuEH4a6jWmEbEJ9Tr3TFtDQm0aWSjoLJZaz3gAJlzEDD45m78xSKqYCUKp/GPbgMLXUpGIigBcO8+to6eA44pyaT4EHGn919Kgi77OT0u/ZyE8C+ZjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nig/8IGO; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nig/8IGO"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7c58e6eb2c8so19125227b3.1
        for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123216; x=1779728016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPQzlCozb0IWzuM5HxK9k54cI0UTN22+Y8fkzM1tXUE=;
        b=nig/8IGO7fNS4r6cyttyXqDDPnz0GjoUOxDXmCRPmCv/zCxNen/AcirH2lbJPekMLR
         iqWgcwtocFosAh55PdSXYlcj4b0KCLb6z9UYPpAhRmL1CAnu1BEG698iRkq15VLj6xrh
         HWsWNtNLbNzctVUX43gVY6bZHNTQuUiLf1c7n2A5FSmw3FgDR2scteXUaSMytvQ79QaV
         q591vdEonLRaV+1Kd/wQIzju8BycVILPPEgPSdVCsKVcih6q8ERKwdO4jmuU2yEZPEHw
         XLCgg6Mp++ospBAMpfPBdSQJFU7MVwrWve1HID4MGq1b+gbzhgyUB5pRuIbscyNC/81n
         AUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123216; x=1779728016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPQzlCozb0IWzuM5HxK9k54cI0UTN22+Y8fkzM1tXUE=;
        b=P0kafRTs7W155yGa8ZIYGK8atd6u7EC4rDAhOdVtVO5KWCbvYh5yb2vE5NOyqWfGmo
         nDJAXHOOj0nBF8lsJRfMYyoZ9IWntYSBj7yf+xGf60iGMi7lVL5FJH5A9yniPG2R2R6r
         2vNuUeDmh5KQd72bDMkXj7Dn90BOAtwbPu89B+FxbV5nXXIgtzPJYdQEuUieIlIsmDx9
         D92s/WHpNup8XLCwcHC1IDy4Rq3YvgKPrI03Jo0ozXvtvItk0XiXxlzLatjgJqtbLaJL
         uCSIl75WZLOsz7MFTP9aU+21dd3qGZtSclPqub1d34P4AL9A1dkr+ew6w4f9r9pklH56
         1z7A==
X-Gm-Message-State: AOJu0YzmcMNm0o0Vnq/8erR/dS49HQhfwed9JfMzORpMWqb7qGB2wN2j
	Q+HOe/Zkc3IfPu2WKAvGXaf/djaX8OCjywVFVoR5gx3/TrRF6hhFXhTK5mMzpDQ1
X-Gm-Gg: Acq92OEOQp+0gvugOxU9105pWUMO4C683GvZKyH38Y8hRPdSsfE3vXFkl9gumhhm3ty
	rfZF0dA7lVuS7GGWfcS38JusMq7SgIz016iONSrn7EiC075V81uE3xs4hRJyo5RS2Egq+SsIVOw
	zWIiBoMBJHo5YcW5jOpNowJmF15JtDPsaQy3CB407olCzu+WinLcoFfA3u7BbxAQNJP85iCl31G
	j6nIw6httaL5laqk8zLEAG8XuevHdWJ3GE7O2isIjEbrroWIAc5i33JA39lNFRbpWJ8r37Y2mEC
	KbRf4dx1bVb84dOaQjM9wy4pwIBgR2zIaljURIrB2bqaWYCMNUHA6NN2CeaBRelA3OJVIftHsPe
	M5OEWGN1OFdo17AWM6St7DgjMtcpAoNE0Qc2EGyPfcyCCNN9y71hM0K5irarPFw8QJAeRlGC3AS
	ybrJR/yGUJ+vA63ckhzxdy6E595s5Dsp/ISES/USEtTHwqvwwBQBDEpjyu4KJ0bHMEQRPyfNA23
	Yx57rt986LkSl/w
X-Received: by 2002:a05:690c:6811:b0:7b3:c611:7ef5 with SMTP id 00721157ae682-7c958ecab11mr178753267b3.6.1779123216105;
        Mon, 18 May 2026 09:53:36 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc965ab98dsm24232957b3.0.2026.05.18.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:53:35 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v7 3/3] fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()
Date: Mon, 18 May 2026 10:52:18 -0600
Message-ID: <20260518165218.35388-4-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518165218.35388-1-sebasjosue84@gmail.com>
References: <20260518165218.35388-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpf_ops_parse_header() reads header_size from the bitstream at
MPF_HEADER_SIZE_OFFSET (24). When header_size is zero, the expression
*(buf + header_size - 1) reads one byte before the buffer start.

Since initial_header_size is set to 71 in mpf_ops, the fpga-mgr core
guarantees the buffer is large enough to reach MPF_HEADER_SIZE_OFFSET.
The only real gap is the zero header_size case, which cannot be
resolved by providing a larger buffer, so return -EINVAL.

Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v7:
  - Correct the Fixes: tag commit hash and wrap commit message
    at 75 columns (checkpatch).
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Drop redundant count check since initial_header_size = 71 already
    guarantees the buffer covers MPF_HEADER_SIZE_OFFSET.
    Suggested by Xu Yilun.
---
 drivers/fpga/microchip-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea86..cc8f6d7bb 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -116,6 +116,9 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	}
 
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
+	if (!header_size)
+		return -EINVAL;
+
 	if (header_size > count) {
 		info->header_size = header_size;
 		return -EAGAIN;
-- 
2.43.0

