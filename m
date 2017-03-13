Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 3/5] doc: fpga-mgr: separate getting/locking FPGA manager
Date: Mon, 13 Mar 2017 16:53:31 -0500
Message-Id: <20170313215333.3008-4-atull@kernel.org>
In-Reply-To: <20170313215333.3008-1-atull@kernel.org>
References: <20170313215333.3008-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Document that getting a reference to a FPGA Manager has been
separated from locking the FPGA Mangager for use.

fpga_mgr_lock/unlock functions get/release mutex.

of_fpga_mgr_get, fpga_mgr_get, and fpga_mgr_put no longer lock
the FPGA manager mutex.

This makes it more straigtforward to save a reference to
a FPGA manager and only attempting to lock it when programming
the FPGA.

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v1: fixed some nits
---
 Documentation/fpga/fpga-mgr.txt | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-mgr.txt
index 78f197f..0240caf 100644
--- a/Documentation/fpga/fpga-mgr.txt
+++ b/Documentation/fpga/fpga-mgr.txt
@@ -53,13 +53,26 @@ To get/put a reference to a FPGA manager:
 	struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
 	struct fpga_manager *fpga_mgr_get(struct device *dev);
 
-Given a DT node or device, get an exclusive reference to a FPGA manager.
+Given a DT node or device, get a reference to a FPGA manager.  This pointer
+can be saved until you are ready to program the FPGA.
 
 	void fpga_mgr_put(struct fpga_manager *mgr);
 
 Release the reference.
 
 
+To get exclusive control of a FPGA manager:
+-------------------------------------------
+
+	int fpga_mgr_lock(struct fpga_magager *mgr);
+
+Call fpga_mgr_lock and verify that it returns 0 before attempting to
+program the FPGA.
+
+	void fpga_mgr_unlock(struct fpga_magager *mgr);
+
+Call fpga_mgr_unlock when done programming the FPGA.
+
 To register or unregister the low level FPGA-specific driver:
 -------------------------------------------------------------
 
@@ -95,11 +108,13 @@ int ret;
 
 /* Get exclusive control of FPGA manager */
 struct fpga_manager *mgr = of_fpga_mgr_get(mgr_node);
+ret = fpga_mgr_lock(mgr);
 
 /* Load the buffer to the FPGA */
 ret = fpga_mgr_buf_load(mgr, &info, buf, count);
 
 /* Release the FPGA manager */
+fpga_mgr_unlock(mgr);
 fpga_mgr_put(mgr);
 
 
@@ -124,11 +139,13 @@ int ret;
 
 /* Get exclusive control of FPGA manager */
 struct fpga_manager *mgr = of_fpga_mgr_get(mgr_node);
+ret = fpga_mgr_lock(mgr);
 
 /* Get the firmware image (path) and load it to the FPGA */
 ret = fpga_mgr_firmware_load(mgr, &info, path);
 
 /* Release the FPGA manager */
+fpga_mgr_unlock(mgr);
 fpga_mgr_put(mgr);
 
 
-- 
2.7.4
