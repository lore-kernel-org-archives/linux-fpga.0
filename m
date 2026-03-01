Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1624A076;
	Sun,  1 Mar 2026 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327904; cv=none; b=dfbZQ0tOUN4m2yWeFCbgoNpI8bajqvh5BH4JRi/9YgeOhXmiQOeO0ht/a0hZEAVjS48Hai9uRC/g+X+g8jXLY2TixOeGEuprdxVVhjdZ53Hk3F+7CmDcEiUQyxHTkQs3hX13GifOgzCJ/C236glagtKivsvYKKmzw2jaaFReg30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327904; c=relaxed/simple;
	bh=3zKUrE/vHBUeIhCMnEFd7jZtXYP8p+8hg/wX0O8Uo2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9Oj708/w1qQ6/hwWM8N3Zi9PIB2vmLQtg2mKDtlsH4KYi+l4wKRivKtxSmjCNnY7ZZb/ZpJaNlL80kWHLPUCljlZf0bBJ0dylTTPr663QAAZR4soQEYWoy0AK/X5E8e9DyCd7dVAxNbj8XncsyuqfHl77j9iYPfUuJf9GgABUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBTptKNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBTptKNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83491C19421;
	Sun,  1 Mar 2026 01:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327904;
	bh=3zKUrE/vHBUeIhCMnEFd7jZtXYP8p+8hg/wX0O8Uo2g=;
	h=From:To:Cc:Subject:Date:From;
	b=kBTptKNvxW5RJmDR71B0TMStXA1zIyJeJdH+MQjgdYLW7UsaprI84RUwbov926gvx
	 iPblNMoUTFpllCaOoVPj8npqurKln/5dQ0+9N6S4Syho57zrsDVigNaupdIL/nXi/f
	 TTwuqQzygpZUnUcf/hmhNj4HFqDHqFa3IrKUgqUu0Imu7BYqsslphcYzlR7vp9BCoW
	 Y1SK2dP3C6NUHkJQXL7YnUhUks4+ke9N0O/yJlq9yNiZwwgEcUySbtrkz3Ed0ZoH6z
	 RMMdRrARVw6ixLmEdHDIRzEFPLBCdyHAnor7r9bt9hscKvLyzyBgnaGhhslxnRZ/yY
	 xhhgb1qZSGX5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cascardo@igalia.com
Cc: Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linux-fpga@vger.kernel.org
Subject: FAILED: Patch "fpga: dfl: use subsys_initcall to allow built-in drivers to be added" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:18:22 -0500
Message-ID: <20260301011822.1672726-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
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




