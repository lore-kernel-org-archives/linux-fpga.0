Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D4182D0
	for <linux-fpga@vger.kernel.org>; Mon, 26 Jan 2026 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769388479; cv=none; b=rliM6YEnMaYvoAKATOncMigAL9L7gTR+TArGZMRVrxMrLvws4z36K9UNFz/7cnvc+4veYP0rAwWh2tiikbWUzk3j/4C5kNsuFJAs0fRo/OHB/VZz3xYwWvWHg69YxjnwjnrQrWmMqvzSZ8GVqyDIACDtKonK2g6TJBp4W2mepOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769388479; c=relaxed/simple;
	bh=77ejVWm3RqaunBnqTtyiE17J+Kn+MrZpFgEM6nArHDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgbDP9i+5Fu54eB1ocJbZ8jJz5JDCER6egc4fRVZ5+W/FCkasFnOjI/xXRsNuPe7f6fpz285uxBtVbHWNWD8ant1rRkcqZigB3Ue+l2npE6S3ytn91Rf+3polGl3HA20gv584nnyBnzm9ARD8fHS0qJrF3F+3Zi56URIcuySNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bF1gj8Uq; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bF1gj8Uq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769388475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bNA3ZpqetyMD8oFtPWDLnd8bAEY7gRxY838rg7405uM=;
	b=bF1gj8Uq2tiscl8DvfjxIWhmnIALlj+1SVOex6JcKPn3J1SsOWXKgya7EifkSVxk+BPkc5
	AWajSdxL9QEBeEYfSylzhaMLiow4TvsLGLQssGbSUVrt0nj55Qe8eDGXZAq7NbdlJf0wfq
	iFFI8DAjgdP5vNYbRMvtfbJFRpKuHTc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] fpga: bridge: Use str_enabled_disabled helper in state_show
Date: Mon, 26 Jan 2026 01:47:48 +0100
Message-ID: <20260126004748.210857-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace hard-coded strings with the str_enabled_disabled() helper. This
unifies the output and helps the linker with deduplication, which can
result in a smaller binary.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/fpga/fpga-bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 8ef395b49bf8..0c54e415fa5a 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -12,6 +12,7 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 
 static DEFINE_IDA(fpga_bridge_ida);
 static const struct class fpga_bridge_class;
@@ -305,7 +306,7 @@ static ssize_t state_show(struct device *dev,
 			return state;
 	}
 
-	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(state));
 }
 
 static DEVICE_ATTR_RO(name);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

