Return-Path: <SRS0=NSwu=7V=redhat.com=trix@kernel.org>
Return-Path: <SRS0=NSwu=7V=redhat.com=trix@kernel.org>
From: trix@redhat.com
Subject: [PATCH v2 1/2] fpga: Fix dead store fpga-mgr.c
Date: Mon,  8 Jun 2020 05:54:45 -0700
Message-Id: <20200608125446.23311-2-trix@redhat.com>
In-Reply-To: <20200608125446.23311-1-trix@redhat.com>
References: <20200608125446.23311-1-trix@redhat.com>
Content-Type: text/plain; charset=US-ASCII
To: mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Tom Rix <trix@redhat.com>

Using clang's scan-build/view this issue was flagged in fpga-mgr.c

  drivers/fpga/fpga-mgr.c:585:3: warning: Value stored to 'ret' is never read [deadcode.DeadStores]
                  ret = id;

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index e05104f5e40c..f38bab01432e 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -581,10 +581,8 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
+	if (id < 0)
 		goto error_kfree;
-	}
 
 	mutex_init(&mgr->ref_mutex);
 
-- 
2.18.2
