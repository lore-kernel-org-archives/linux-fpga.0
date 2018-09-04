Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v2 8/8] docs: fpga: document programming fpgas using regions
Date: Tue,  4 Sep 2018 16:22:37 -0500
Message-Id: <20180904212237.3078-9-atull@kernel.org>
In-Reply-To: <20180904212237.3078-1-atull@kernel.org>
References: <20180904212237.3078-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Clarify the intention that interfaces and upper layers use
regions rather than managers directly.

Rearrange API documentation to better group the API functions
used to create FPGA mgr/bridge/regions and the API used for
programming FPGAs.

Signed-off-by: Alan Tull <atull@kernel.org>
Suggested-by: Federico Vaga <federico.vaga@cern.ch>
---
v2: Add suggested-by
    s/a FPGA/an FPGA/
    document freeing the fpga_mgr_info on success path
    minor formatting fixes and suggested edits
---
 Documentation/driver-api/fpga/fpga-bridge.rst      |  38 ++-----
 Documentation/driver-api/fpga/fpga-mgr.rst         | 117 ++-------------------
 Documentation/driver-api/fpga/fpga-programming.rst | 107 +++++++++++++++++++
 Documentation/driver-api/fpga/fpga-region.rst      |  92 ++++++++--------
 Documentation/driver-api/fpga/index.rst            |   2 +
 Documentation/driver-api/fpga/intro.rst            |   2 +-
 6 files changed, 171 insertions(+), 187 deletions(-)
 create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index ebbcbde..71c5a40 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -4,6 +4,12 @@ FPGA Bridge
 API to implement a new FPGA bridge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+* struct :c:type:`fpga_bridge` — The FPGA Bridge structure
+* struct :c:type:`fpga_bridge_ops` — Low level Bridge driver ops
+* :c:func:`devm_fpga_bridge_create()` — Allocate and init a bridge struct
+* :c:func:`fpga_bridge_register()` — Register a bridge
+* :c:func:`fpga_bridge_unregister()` — Unregister a bridge
+
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge
 
@@ -14,39 +20,7 @@ API to implement a new FPGA bridge
    :functions: devm_fpga_bridge_create
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_create
-
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_free
-
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
    :functions: fpga_bridge_register
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
    :functions: fpga_bridge_unregister
-
-API to control an FPGA bridge
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You probably won't need these directly.  FPGA regions should handle this.
-
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: of_fpga_bridge_get
-
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_get
-
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_put
-
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_get_to_list
-
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: of_fpga_bridge_get_to_list
-
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_enable
-
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_disable
diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index db8885e..576f194 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -98,67 +98,19 @@ The ops include a .state function which will determine the state the FPGA is in
 and return a code of type enum fpga_mgr_states.  It doesn't result in a change
 in state.
 
-How to write an image buffer to a supported FPGA
-------------------------------------------------
-
-Some sample code::
-
-	#include <linux/fpga/fpga-mgr.h>
-
-	struct fpga_manager *mgr;
-	struct fpga_image_info *info;
-	int ret;
-
-	/*
-	 * Get a reference to FPGA manager.  The manager is not locked, so you can
-	 * hold onto this reference without it preventing programming.
-	 *
-	 * This example uses the device node of the manager.  Alternatively, use
-	 * fpga_mgr_get(dev) instead if you have the device.
-	 */
-	mgr = of_fpga_mgr_get(mgr_node);
-
-	/* struct with information about the FPGA image to program. */
-	info = fpga_image_info_alloc(dev);
-
-	/* flags indicates whether to do full or partial reconfiguration */
-	info->flags = FPGA_MGR_PARTIAL_RECONFIG;
-
-	/*
-	 * At this point, indicate where the image is. This is pseudo-code; you're
-	 * going to use one of these three.
-	 */
-	if (image is in a scatter gather table) {
-
-		info->sgt = [your scatter gather table]
-
-	} else if (image is in a buffer) {
-
-		info->buf = [your image buffer]
-		info->count = [image buffer size]
-
-	} else if (image is in a firmware file) {
-
-		info->firmware_name = devm_kstrdup(dev, firmware_name, GFP_KERNEL);
-
-	}
-
-	/* Get exclusive control of FPGA manager */
-	ret = fpga_mgr_lock(mgr);
-
-	/* Load the buffer to the FPGA */
-	ret = fpga_mgr_buf_load(mgr, &info, buf, count);
-
-	/* Release the FPGA manager */
-	fpga_mgr_unlock(mgr);
-	fpga_mgr_put(mgr);
-
-	/* Deallocate the image info if you're done with it */
-	fpga_image_info_free(info);
-
 API for implementing a new FPGA Manager driver
 ----------------------------------------------
 
+* ``fpga_mgr_states`` —  Values for :c:member:`fpga_manager->state`.
+* struct :c:type:`fpga_manager` —  the FPGA manager struct
+* struct :c:type:`fpga_manager_ops` —  Low level FPGA manager driver ops
+* :c:func:`devm_fpga_mgr_create` —  Allocate and init a manager struct
+* :c:func:`fpga_mgr_register` —  Register an FPGA manager
+* :c:func:`fpga_mgr_unregister` —  Unregister an FPGA manager
+
+.. kernel-doc:: include/linux/fpga/fpga-mgr.h
+   :functions: fpga_mgr_states
+
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_manager
 
@@ -169,56 +121,7 @@ API for implementing a new FPGA Manager driver
    :functions: devm_fpga_mgr_create
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_create
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_free
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
-
-API for programming an FPGA
----------------------------
-
-FPGA Manager flags
-
-.. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :doc: FPGA Manager flags
-
-.. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_image_info
-
-.. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_mgr_states
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_image_info_alloc
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_image_info_free
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: of_fpga_mgr_get
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_get
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_put
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_lock
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_unlock
-
-.. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_mgr_states
-
-Note - use :c:func:`fpga_region_program_fpga()` instead of :c:func:`fpga_mgr_load()`
-
-.. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_load
diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
new file mode 100644
index 0000000..b5484df
--- /dev/null
+++ b/Documentation/driver-api/fpga/fpga-programming.rst
@@ -0,0 +1,107 @@
+In-kernel API for FPGA Programming
+==================================
+
+Overview
+--------
+
+The in-kernel API for FPGA programming is a combination of APIs from
+FPGA manager, bridge, and regions.  The actual function used to
+trigger FPGA programming is :c:func:`fpga_region_program_fpga()`.
+
+:c:func:`fpga_region_program_fpga()` uses functionality supplied by
+the FPGA manager and bridges.  It will:
+
+ * lock the region's mutex
+ * lock the mutex of the region's FPGA manager
+ * build a list of FPGA bridges if a method has been specified to do so
+ * disable the bridges
+ * program the FPGA using info passed in :c:member:`fpga_region->info`.
+ * re-enable the bridges
+ * release the locks
+
+The struct fpga_image_info specifies what FPGA image to program.  It is
+allocated/freed by :c:func:`fpga_image_info_alloc()` and freed with
+:c:func:`fpga_image_info_free()`
+
+How to program an FPGA using a region
+-------------------------------------
+
+When the FPGA region driver probed, it was given a pointer to an FPGA manager
+driver so it knows which manager to use.  The region also either has a list of
+bridges to control during programming or it has a pointer to a function that
+will generate that list.  Here's some sample code of what to do next::
+
+	#include <linux/fpga/fpga-mgr.h>
+	#include <linux/fpga/fpga-region.h>
+
+	struct fpga_image_info *info;
+	int ret;
+
+	/*
+	 * First, alloc the struct with information about the FPGA image to
+	 * program.
+	 */
+	info = fpga_image_info_alloc(dev);
+	if (!info)
+		return -ENOMEM;
+
+	/* Set flags as needed, such as: */
+	info->flags = FPGA_MGR_PARTIAL_RECONFIG;
+
+	/*
+	 * Indicate where the FPGA image is. This is pseudo-code; you're
+	 * going to use one of these three.
+	 */
+	if (image is in a scatter gather table) {
+
+		info->sgt = [your scatter gather table]
+
+	} else if (image is in a buffer) {
+
+		info->buf = [your image buffer]
+		info->count = [image buffer size]
+
+	} else if (image is in a firmware file) {
+
+		info->firmware_name = devm_kstrdup(dev, firmware_name,
+						   GFP_KERNEL);
+
+	}
+
+	/* Add info to region and do the programming */
+	region->info = info;
+	ret = fpga_region_program_fpga(region);
+
+	/* Deallocate the image info if you're done with it */
+	region->info = NULL;
+	fpga_image_info_free(info);
+
+	if (ret)
+		return ret;
+
+	/* Now enumerate whatever hardware has appeared in the FPGA. */
+
+API for programming an FPGA
+---------------------------
+
+* :c:func:`fpga_region_program_fpga` —  Program an FPGA
+* :c:type:`fpga_image_info` —  Specifies what FPGA image to program
+* :c:func:`fpga_image_info_alloc()` —  Allocate an FPGA image info struct
+* :c:func:`fpga_image_info_free()` —  Free an FPGA image info struct
+
+.. kernel-doc:: drivers/fpga/fpga-region.c
+   :functions: fpga_region_program_fpga
+
+FPGA Manager flags
+
+.. kernel-doc:: include/linux/fpga/fpga-mgr.h
+   :doc: FPGA Manager flags
+
+.. kernel-doc:: include/linux/fpga/fpga-mgr.h
+   :functions: fpga_image_info
+
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: fpga_image_info_alloc
+
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: fpga_image_info_free
diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index dc9f75c..0529b2d 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -34,41 +34,6 @@ fpga_image_info including:
  * flags indicating specifics such as whether the image is for partial
    reconfiguration.
 
-How to program an FPGA using a region
--------------------------------------
-
-First, allocate the info struct::
-
-	info = fpga_image_info_alloc(dev);
-	if (!info)
-		return -ENOMEM;
-
-Set flags as needed, i.e.::
-
-	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
-
-Point to your FPGA image, such as::
-
-	info->sgt = &sgt;
-
-Add info to region and do the programming::
-
-	region->info = info;
-	ret = fpga_region_program_fpga(region);
-
-:c:func:`fpga_region_program_fpga()` operates on info passed in the
-fpga_image_info (region->info).  This function will attempt to:
-
- * lock the region's mutex
- * lock the region's FPGA manager
- * build a list of FPGA bridges if a method has been specified to do so
- * disable the bridges
- * program the FPGA
- * re-enable the bridges
- * release the locks
-
-Then you will want to enumerate whatever hardware has appeared in the FPGA.
-
 How to add a new FPGA region
 ----------------------------
 
@@ -77,15 +42,36 @@ An example of usage can be seen in the probe function of [#f2]_.
 .. [#f1] ../devicetree/bindings/fpga/fpga-region.txt
 .. [#f2] ../../drivers/fpga/of-fpga-region.c
 
-API to program an FPGA
-----------------------
-
-.. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_program_fpga
-
 API to add a new FPGA region
 ----------------------------
 
+* struct :c:type:`fpga_region` — The FPGA region struct
+* :c:func:`devm_fpga_region_create` — Allocate and init a region struct
+* :c:func:`fpga_region_register` —  Register an FPGA region
+* :c:func:`fpga_region_unregister` —  Unregister an FPGA region
+
+The FPGA region's probe function will need to get a reference to the FPGA
+Manager it will be using to do the programming.  This usually would happen
+during the region's probe function.
+
+* :c:func:`fpga_mgr_get` — Get a reference to an FPGA manager, raise ref count
+* :c:func:`of_fpga_mgr_get` —  Get a reference to an FPGA manager, raise ref count,
+  given a device node.
+* :c:func:`fpga_mgr_put` — Put an FPGA manager
+
+The FPGA region will need to specify which bridges to control while programming
+the FPGA.  The region driver can build a list of bridges during probe time
+(:c:member:`fpga_region->bridge_list`) or it can have a function that creates
+the list of bridges to program just before programming
+(:c:member:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
+following APIs to handle building or tearing down that list.
+
+* :c:func:`fpga_bridge_get_to_list` — Get a ref of an FPGA bridge, add it to a
+  list
+* :c:func:`of_fpga_bridge_get_to_list` — Get a ref of an FPGA bridge, add it to a
+  list, given a device node
+* :c:func:`fpga_bridges_put` — Given a list of bridges, put them
+
 .. kernel-doc:: include/linux/fpga/fpga-region.h
    :functions: fpga_region
 
@@ -93,13 +79,25 @@ API to add a new FPGA region
    :functions: devm_fpga_region_create
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_create
-
-.. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_free
-
-.. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_register
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_unregister
+
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: fpga_mgr_get
+
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: of_fpga_mgr_get
+
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: fpga_mgr_put
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_get_to_list
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: of_fpga_bridge_get_to_list
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridges_put
diff --git a/Documentation/driver-api/fpga/index.rst b/Documentation/driver-api/fpga/index.rst
index c51e5eb..31a4773 100644
--- a/Documentation/driver-api/fpga/index.rst
+++ b/Documentation/driver-api/fpga/index.rst
@@ -11,3 +11,5 @@ FPGA Subsystem
    fpga-mgr
    fpga-bridge
    fpga-region
+   fpga-programming
+
diff --git a/Documentation/driver-api/fpga/intro.rst b/Documentation/driver-api/fpga/intro.rst
index 50d1cab..f54c7da 100644
--- a/Documentation/driver-api/fpga/intro.rst
+++ b/Documentation/driver-api/fpga/intro.rst
@@ -44,7 +44,7 @@ FPGA Region
 -----------
 
 If you are adding a new interface to the FPGA framework, add it on top
-of an FPGA region to allow the most reuse of your interface.
+of an FPGA region.
 
 The FPGA Region framework (fpga-region.c) associates managers and
 bridges as reconfigurable regions.  A region may refer to the whole
-- 
2.7.4
