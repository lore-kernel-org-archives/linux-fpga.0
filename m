Return-Path: <SRS0=MjaN=5E=embeddedor.com=gustavo@kernel.org>
Return-Path: <SRS0=MjaN=5E=embeddedor.com=gustavo@kernel.org>
Date: Thu, 19 Mar 2020 16:21:53 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] fpga: dfl.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200319212153.GA5093@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-fpga@vger.kernel.org>

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/fpga/dfl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 4a9a33cd9979..74784d3cfe7c 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -235,7 +235,7 @@ struct dfl_feature_platform_data {
 	int open_count;
 	void *private;
 	int num;
-	struct dfl_feature features[0];
+	struct dfl_feature features[];
 };
 
 static inline
-- 
2.23.0
