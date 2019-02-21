Return-Path: <SRS0=yNA6=Q4=gmx.com=cgxu519@kernel.org>
Return-Path: <SRS0=yNA6=Q4=gmx.com=cgxu519@kernel.org>
From: Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2] fpga: dfl: expand minor range when registering chrdev region
Date: Thu, 21 Feb 2019 15:46:49 +0800
Message-Id: <20190221074649.28988-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: hao.wu@intel.com, atull@kernel.org, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
List-ID: <linux-fpga@vger.kernel.org>

Actually, total amount of available minor number
for a single major is MINORMASK + 1. So expand
minor range when registering chrdev region.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
v1->v2:
- Fix typo in subject.

 drivers/fpga/dfl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 2c09e502e721..02fff566be46 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -315,7 +315,7 @@ static void dfl_chardev_uinit(void)
 	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++)
 		if (MAJOR(dfl_chrdevs[i].devt)) {
 			unregister_chrdev_region(dfl_chrdevs[i].devt,
-						 MINORMASK);
+						 MINORMASK + 1);
 			dfl_chrdevs[i].devt = MKDEV(0, 0);
 		}
 }
@@ -325,8 +325,8 @@ static int dfl_chardev_init(void)
 	int i, ret;
 
 	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++) {
-		ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0, MINORMASK,
-					  dfl_chrdevs[i].name);
+		ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0,
+					  MINORMASK + 1, dfl_chrdevs[i].name);
 		if (ret)
 			goto exit;
 	}
-- 
2.20.1
