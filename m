Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6805277C9D;
	Sun,  1 Mar 2026 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329209; cv=none; b=oDLPw/63TWP2Zoo89puD4HzZT1aBaucWm+panvcfV+K2NPfoEZw0ZqbuZ/gHH7kdr/QWJGtPcBxltxWs6X5xhkFsJWuHMYKFLVJwVkZMzf7aGwYJE/ZAGkDgQWPOyJDmWz6jJPeZ3sMwNKtnxFEOtjFx7M4QRG08bxJP0V/qlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329209; c=relaxed/simple;
	bh=z+wbmHhajM6Wa2I/w5E14et+MQ+hnFLEOhAwa/OS9UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjckuZfAzQtZO31xbcuBecWSIS5VFHbslKaPapeYYTCBCE/jDgIgu6+5wDRSwPC+crBSEV5SCjU9NsjS4iifPufR84vOS9Nh7AC38/yBXvmtf3Xs2JuQx+fEOJvD6XSfLs+8tEsZ/3uVKW45j1Cuv/cJdPXQlaf1exTlsak/IcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDNoyCQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDNoyCQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133F6C19421;
	Sun,  1 Mar 2026 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329209;
	bh=z+wbmHhajM6Wa2I/w5E14et+MQ+hnFLEOhAwa/OS9UE=;
	h=From:To:Cc:Subject:Date:From;
	b=CDNoyCQLUAgSa9GL82u2bCIiXPryHzWGIdVnhk+VfNROZTAI3TKVetpPkyu5aKgIV
	 V0W/nzsKVxTqdYfdZYCnzwPzsgP8vdkJ68TCzWSQ+sJtuQ1iZhgdXwveNcu8d0Zk9H
	 UClQbuz0iIhEeQrSlrqFPslRWHAUXe+BZUO3IEETrD9XQPSn12ZAUx1KIkYDroxgql
	 V0c6RMg8ZCFB/3KpQgrbmQWnn0EKW/EE1sYtkE3Az2kI+TkemJFjr8iNXI3+AwqdUY
	 xDwtfowC1NA6exxx4S/5W2hd8GxUeX34PYZqjFmCnCxLEdC9UlMmh9MJ1y6yZXsdFl
	 V99r+nd/lSD/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cascardo@igalia.com
Cc: Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linux-fpga@vger.kernel.org
Subject: FAILED: Patch "fpga: dfl: use subsys_initcall to allow built-in drivers to be added" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:40:07 -0500
Message-ID: <20260301014007.1701312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 267f53140c9d0bf270bbe0148082e9b8e5011273 Mon Sep 17 00:00:00 2001
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 15 Dec 2025 16:05:50 -0300
Subject: [PATCH] fpga: dfl: use subsys_initcall to allow built-in drivers to
 be added

The dfl code adds a bus. If it is built-in and there is a built-in driver
as well, the dfl module_init may be called after the driver module_init,
leading to a failure to register the driver as the bus has not been added
yet.

Use subsys_initcall, which guarantees it will be called before the drivers
init code.

Without the fix, we see failures like this:

[    0.479475] Driver 'intel-m10-bmc' was unable to register with bus_type 'dfl' because the bus was not initialized.

Cc: stable@vger.kernel.org
Fixes: 9ba3a0aa09fe ("fpga: dfl: create a dfl bus type to support DFL devices")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Link: https://lore.kernel.org/r/20251215-dfl_subsys-v1-1-21807bad6b10@igalia.com
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/fpga/dfl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 7022657243c0a..449c3a082e232 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -2018,7 +2018,7 @@ static void __exit dfl_fpga_exit(void)
 	bus_unregister(&dfl_bus_type);
 }
 
-module_init(dfl_fpga_init);
+subsys_initcall(dfl_fpga_init);
 module_exit(dfl_fpga_exit);
 
 MODULE_DESCRIPTION("FPGA Device Feature List (DFL) Support");
-- 
2.51.0




