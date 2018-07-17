Return-Path: <SRS0=zWsH=KB=canonical.com=colin.king@kernel.org>
Return-Path: <SRS0=zWsH=KB=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drivers: fpga: fix two trivial spelling mistakes
Date: Tue, 17 Jul 2018 10:21:38 +0100
Message-Id: <20180717092138.19010-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Jiri Kosina <trivial@kernel.org>, linux-fpga@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trival fix to two spellling mistakes
"execeeded" -> "exceeded"
"Invaild" -> "Invalid"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 2 +-
 drivers/fpga/dfl-fme-mgr.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 0e81d33af856..025aba3ea76c 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -70,7 +70,7 @@ static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
 	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
 		incr ? '+' : '-', npages << PAGE_SHIFT,
 		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
-		ret ? "- execeeded" : "");
+		ret ? "- exceeded" : "");
 
 	up_write(&current->mm->mmap_sem);
 
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index b5ef405b6d88..9f045d058cfd 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
 		}
 
 		if (count < 4) {
-			dev_err(dev, "Invaild PR bitstream size\n");
+			dev_err(dev, "Invalid PR bitstream size\n");
 			return -EINVAL;
 		}
 
-- 
2.17.1
