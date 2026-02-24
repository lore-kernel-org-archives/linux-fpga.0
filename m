Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610773A7851
	for <linux-fpga@vger.kernel.org>; Tue, 24 Feb 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949735; cv=none; b=hsdQH6PtuVT8OEdye/pLszLqnhsSFublf3dIPkDmGkK0jdMvyt1IF5ziCmeJ/f+droS24t+KTxPMmL5cWHhpAsWfGXkO/CSrP4khyFhySbsdmpJngV6tPnFyjD9o+eWINpv/MbDuVWRzjpigCHgSUgGK6QASoZ+OBx5pcClsADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949735; c=relaxed/simple;
	bh=up/VDASLpV67TzJIbyWtSfCTaJhHWlHnF40JNXgW+Po=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmppCb+cdBk+ZOisoyuBBW4VCJjrxIuz/LTg/OGsBCrLq1dvq+jPzZszCEsKuI8tvsoqNLEyGfNfKEJoWeMy6qMNckjUQtIj4DY8LB34OvSWc7yiYwWsPwVMkZOE8A18VqyoBhPFLy1zWDAayI3osW+I6KUeA+xRLX7AQmPHMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UxPyaBGv; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UxPyaBGv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771949721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uBC18I3VHeh2KMSGGB/EQnJkZhcLAtO1ly7p2nXG/FU=;
	b=UxPyaBGvrmglN0GFJefQmScnzdgIW8cKByN+Uivq6+ArSdXake/Mb4oCeKxvLwrDHCCzu2
	g7VU/7LbYHvMrzjPMdJKNXtbMHOkMjsnS5Jtg//snBpeMQu8ZozaT25gHR6oqAU+4ZJcHu
	2Jqpofo5kj1+S6UgtAfXNrq2nEoFnEQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] fpga: bridge: Use str_enabled_disabled helper in state_show
Date: Tue, 24 Feb 2026 17:15:03 +0100
Message-ID: <20260224161504.587562-1-thorsten.blum@linux.dev>
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
index ca68c38aa4a1..e8ff3e3bf2fc 100644
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

