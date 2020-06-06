Return-Path: <SRS0=CcLc=7T=redhat.com=trix@kernel.org>
Return-Path: <SRS0=CcLc=7T=redhat.com=trix@kernel.org>
From: trix@redhat.com
Subject: [PATCH 1/1] fpga: dfl: Fix dead store
Date: Sat,  6 Jun 2020 14:02:41 -0700
Message-Id: <20200606210241.7459-2-trix@redhat.com>
In-Reply-To: <20200606210241.7459-1-trix@redhat.com>
References: <20200606210241.7459-1-trix@redhat.com>
Content-Type: text/plain; charset=US-ASCII
To: mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Tom Rix <trix@redhat.com>

Using clang's scan-build/view this issue was flagged in fpga-mgr.c

  drivers/fpga/fpga-mgr.c:585:3: warning: Value stored to 'ret' is never read [deadcode.DeadStores]
                  ret = id;

A similar issue was flagged in fpga-bridge.

So remove the unused stores.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 6 ++----
 drivers/fpga/fpga-mgr.c    | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 4bab9028940a..2deccacc3aa7 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -328,7 +328,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 				       void *priv)
 {
 	struct fpga_bridge *bridge;
-	int id, ret = 0;
+	int id, ret;
 
 	if (!name || !strlen(name)) {
 		dev_err(dev, "Attempt to register with no name!\n");
@@ -340,10 +340,8 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
+	if (id < 0)
 		goto error_kfree;
-	}
 
 	mutex_init(&bridge->mutex);
 	INIT_LIST_HEAD(&bridge->node);
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
2.26.0
