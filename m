Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/2] fpga: Document when fpga_blah_free functions should be used
Date: Wed, 25 Jul 2018 13:15:13 -0500
Message-Id: <20180725181514.3501-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Federico Vaga <federico.vaga@cern.ch>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Clarify when fpga_(mgr|bridge|region)_free functions should be used.
The class's dev_release will handle cleanup when the device is released
so once the mgr/brige/region has been successfully registered, it
would be a bug to call fpga_(mgr|bridge|region)_free.

Signed-off-by: Alan Tull <atull@kernel.org>
Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
Suggested-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/fpga/fpga-bridge.c | 10 +++++++++-
 drivers/fpga/fpga-mgr.c    | 10 +++++++++-
 drivers/fpga/fpga-region.c | 10 +++++++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 24b8f98..528d2149 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -379,7 +379,11 @@ EXPORT_SYMBOL_GPL(fpga_bridge_create);
 
 /**
  * fpga_bridge_free - free a fpga bridge and its id
- * @bridge:	FPGA bridge struct created by fpga_bridge_create
+ * @bridge:	FPGA bridge struct created by fpga_bridge_create()
+ *
+ * Free a FPGA bridge.  This function should only be called for
+ * freeing a bridge that has not been registered yet (such as in error
+ * paths in a probe function).
  */
 void fpga_bridge_free(struct fpga_bridge *bridge)
 {
@@ -414,6 +418,10 @@ EXPORT_SYMBOL_GPL(fpga_bridge_register);
 /**
  * fpga_bridge_unregister - unregister and free a fpga bridge
  * @bridge:	FPGA bridge struct created by fpga_bridge_create
+ *
+ * Unregister the bridge device.  The class's dev_release will handle
+ * freeing the bridge struct when the device is released so don't
+ * call fpga_bridge_free() after calling fpga_bridge_unregister().
  */
 void fpga_bridge_unregister(struct fpga_bridge *bridge)
 {
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a41b07e..9632cbd 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -619,7 +619,11 @@ EXPORT_SYMBOL_GPL(fpga_mgr_create);
 
 /**
  * fpga_mgr_free - deallocate a FPGA manager
- * @mgr:	fpga manager struct created by fpga_mgr_create
+ * @mgr:	fpga manager struct created by fpga_mgr_create()
+ *
+ * Free a FPGA manager struct.  This function should only be called
+ * for freeing a manager that has not been registered yet (such as in
+ * error paths in a probe function).
  */
 void fpga_mgr_free(struct fpga_manager *mgr)
 {
@@ -663,6 +667,10 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register);
 /**
  * fpga_mgr_unregister - unregister and free a FPGA manager
  * @mgr:	fpga manager struct
+ *
+ * Unregister the manager device.  The class's dev_release will handle
+ * freeing the manager struct when the device is released so don't
+ * call fpga_mgr_free() after calling fpga_mgr_unregister().
  */
 void fpga_mgr_unregister(struct fpga_manager *mgr)
 {
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 0d65220..7335fa9 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -231,7 +231,11 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
 
 /**
  * fpga_region_free - free a struct fpga_region
- * @region: FPGA region created by fpga_region_create
+ * @region:  FPGA region created by fpga_region_create()
+ *
+ * Free a FPGA region struct.  This function should only be called for
+ * freeing a region that has not been registered yet (such as in error
+ * paths in a probe function).
  */
 void fpga_region_free(struct fpga_region *region)
 {
@@ -255,6 +259,10 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
 /**
  * fpga_region_unregister - unregister and free a FPGA region
  * @region: FPGA region
+ *
+ * Unregister the region device.  The class's dev_release will handle
+ * freeing the region so don't call fpga_region_free() after calling
+ * fpga_region_unregister().
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
-- 
2.7.4
