Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0826E6F0
	for <linux-fpga@vger.kernel.org>; Fri, 19 Dec 2025 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766179720; cv=none; b=jwc/aPO5yzsPcQU7Raa5Q8yGu+T0TlQ6TyG8awARoYFat1c9wwcun6T6USCHLDrr8kIj4Hs00m5i4iEV1s4Ae2rVPlkuOlri9wQqX+FUllRFV7ZcGQ8wWzHv1t/FjUi0asQeNF+TW/qJzl9T5bNqQWKQvVYxkBCNUjomCY4oZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766179720; c=relaxed/simple;
	bh=77ejVWm3RqaunBnqTtyiE17J+Kn+MrZpFgEM6nArHDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWrYmNewxdamfNNIbk8pm0iHMcOhhRDE8LWnUNd8tPxtYKL2XJSp84Eb7UpZ3FGN1AulRs/GmG/ked1HAJFcZXMxcone5bZElbX0sAQXtPOO5ongjiEOf874e/8Rzn6ucdz73w3eMPlcvHvLqWxuCvfJlhG8b+2Th9pLJQ8UUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BViSY9zM; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BViSY9zM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766179702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bNA3ZpqetyMD8oFtPWDLnd8bAEY7gRxY838rg7405uM=;
	b=BViSY9zM6CzTMYekxUWokjOi/6ArBj7NLgKlrUSlps69Lvtcb3IMqAoatoVSHhE56WLLrn
	Y1RM4DVKPKFKJ0yEq2Yh4QaIbFrQpml8vyHl+A6ANLBaL5PVn1e4LRovJg0ktbN2hYre/7
	ziLHcWeKsynl9+JAVIoUNXTLC5kxDJo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] fpga: bridge: Use str_enabled_disabled helper in state_show
Date: Fri, 19 Dec 2025 22:27:12 +0100
Message-ID: <20251219212711.71227-2-thorsten.blum@linux.dev>
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

