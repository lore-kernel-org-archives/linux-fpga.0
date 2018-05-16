Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 13/14] fpga: clarify that unregister functions also free
Date: Wed, 16 May 2018 18:50:06 -0500
Message-Id: <20180516235007.3951-14-atull@kernel.org>
In-Reply-To: <20180516235007.3951-1-atull@kernel.org>
References: <20180516235007.3951-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

The following functions also free the struct.  Add that
fact to the function documentation.
 - fpga_mgr_free
 - fpga_bridge_free
 - fpga_region_free

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 2 +-
 drivers/fpga/fpga-mgr.c    | 2 +-
 drivers/fpga/fpga-region.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 4b207a7..24b8f98 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -412,7 +412,7 @@ int fpga_bridge_register(struct fpga_bridge *bridge)
 EXPORT_SYMBOL_GPL(fpga_bridge_register);
 
 /**
- * fpga_bridge_unregister - unregister a fpga bridge driver
+ * fpga_bridge_unregister - unregister and free a fpga bridge
  * @bridge:	FPGA bridge struct created by fpga_bridge_create
  */
 void fpga_bridge_unregister(struct fpga_bridge *bridge)
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 5fffeef..c1564cf 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -633,7 +633,7 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
 /**
- * fpga_mgr_unregister - unregister a FPGA manager
+ * fpga_mgr_unregister - unregister and free a FPGA manager
  * @mgr:	fpga manager struct
  */
 void fpga_mgr_unregister(struct fpga_manager *mgr)
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 112fa3a..6d214d7 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -232,7 +232,7 @@ int fpga_region_register(struct fpga_region *region)
 EXPORT_SYMBOL_GPL(fpga_region_register);
 
 /**
- * fpga_region_unregister - unregister a FPGA region
+ * fpga_region_unregister - unregister and free a FPGA region
  * @region: FPGA region
  */
 void fpga_region_unregister(struct fpga_region *region)
-- 
2.7.4
