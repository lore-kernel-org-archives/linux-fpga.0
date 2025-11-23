Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2A72627
	for <linux-fpga@vger.kernel.org>; Sun, 23 Nov 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763922182; cv=none; b=c1NpxQcB6qXvTIUGEuZYyhsrrJqpq2fj4CbW3aLHeOO/GQqmPOmn8qRJ3dtIaeUsDISw5DCGCMIZ5XNrwYS7szzqjVQ3mj1BiIU28DnNQhqzDZX2c+R64g8bGmTVRMU2Mf7yU/NDWgSEs/wDcjkcPQhZ41U2wxyYFqWoJqnVYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763922182; c=relaxed/simple;
	bh=JaI8oTFLtHXHJskyt8S+qrkKbVxFjuUOpVtsDYlQM8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/uGt0GvJkWYcz/yeMiF9RWwWVsQLZC1kLwJEH29pQH0vI7WldB4HlqxYY8MX2uLvTiTorLw/LHzBanu1/Vc+O+4OxAyo9DV4MJR+KYm9+yqdmsN9/UjqqujN6+/ke7cu2g+a55aKqx5iH/tbqOf8nK9O/NAaatzze0dx26HHPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VquvGUND; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VquvGUND"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763922177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tjQ/FBAF6bL7gtXJHF/IGxqUKePjaj3FklPddEYIzmg=;
	b=VquvGUNDfEFVM4ww7Dqcucxll2RElUutsb3RTLgp4o81J2+BE6DueqnBRYtLhi1NkNXvuo
	MpXYE2PRvUW15boRMzAWsXG51evQau2xeMtLVRhPk206T2rgZVwKmtEnuY4r5WliJDZgix
	HoHSr0H7S9CsvsDstugBH6LVtiyhNqU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: bridge: Use str_enabled_disabled helper in state_show
Date: Sun, 23 Nov 2025 19:22:22 +0100
Message-ID: <20251123182222.548247-2-thorsten.blum@linux.dev>
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
2.51.1

