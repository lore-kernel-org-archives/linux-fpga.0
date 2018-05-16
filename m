Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 12/14] documentation: fpga: move fpga-region.txt to driver-api
Date: Wed, 16 May 2018 18:50:05 -0500
Message-Id: <20180516235007.3951-13-atull@kernel.org>
In-Reply-To: <20180516235007.3951-1-atull@kernel.org>
References: <20180516235007.3951-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Move Documentation/fpga/fpga-region.txt to
driver-api/fpga/fpga-region.rst.  Including:
 - Add it to driver-api/fpga/index.rst
 - Formatting changes to build cleanly as ReST documentation
 - Some rewrites for better flow as a ReST doc such as moving
   API reference to the end of the doc
 - Rewrite API reference section to refer to kernel-doc
   documentation in fpga-region.c driver code

Signed-off-by: Alan Tull <atull@kernel.org>
---
 Documentation/driver-api/fpga/fpga-region.rst | 102 ++++++++++++++++++++++++++
 Documentation/driver-api/fpga/index.rst       |   1 +
 Documentation/fpga/fpga-region.txt            |  94 ------------------------
 3 files changed, 103 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/driver-api/fpga/fpga-region.rst
 delete mode 100644 Documentation/fpga/fpga-region.txt

diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
new file mode 100644
index 0000000..f89e4a3
--- /dev/null
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -0,0 +1,102 @@
+FPGA Region
+===========
+
+Overview
+--------
+
+This document is meant to be an brief overview of the FPGA region API usage.  A
+more conceptual look at regions can be found in the Device Tree binding
+document [#f1]_.
+
+For the purposes of this API document, let's just say that a region associates
+an FPGA Manager and a bridge (or bridges) with a reprogrammable region of an
+FPGA or the whole FPGA.  The API provides a way to register a region and to
+program a region.
+
+Currently the only layer above fpga-region.c in the kernel is the Device Tree
+support (of-fpga-region.c) described in [#f1]_.  The DT support layer uses regions
+to program the FPGA and then DT to handle enumeration.  The common region code
+is intended to be used by other schemes that have other ways of accomplishing
+enumeration after programming.
+
+An fpga-region can be set up to know the following things:
+
+ * which FPGA manager to use to do the programming
+
+ * which bridges to disable before programming and enable afterwards.
+
+Additional info needed to program the FPGA image is passed in the struct
+fpga_image_info including:
+
+ * pointers to the image as either a scatter-gather buffer, a contiguous
+   buffer, or the name of firmware file
+
+ * flags indicating specifics such as whether the image if for partial
+   reconfiguration.
+
+How to program a FPGA using a region
+------------------------------------
+
+First, allocate the info struct::
+
+	info = fpga_image_info_alloc(dev);
+	if (!info)
+		return -ENOMEM;
+
+Set flags as needed, i.e.::
+
+	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
+
+Point to your FPGA image, such as::
+
+	info->sgt = &sgt;
+
+Add info to region and do the programming::
+
+	region->info = info;
+	ret = fpga_region_program_fpga(region);
+
+:c:func:`fpga_region_program_fpga()` operates on info passed in the
+fpga_image_info (region->info).  This function will attempt to:
+
+ * lock the region's mutex
+ * lock the region's FPGA manager
+ * build a list of FPGA bridges if a method has been specified to do so
+ * disable the bridges
+ * program the FPGA
+ * re-enable the bridges
+ * release the locks
+
+Then you will want to enumerate whatever hardware has appeared in the FPGA.
+
+How to add a new FPGA region
+----------------------------
+
+An example of usage can be seen in the probe function of [#f2]_.
+
+.. [#f1] ../devicetree/bindings/fpga/fpga-region.txt
+.. [#f2] ../../drivers/fpga/of-fpga-region.c
+
+API to program a FGPA
+---------------------
+
+.. kernel-doc:: drivers/fpga/fpga-region.c
+   :functions: fpga_region_program_fpga
+
+API to add a new FPGA region
+----------------------------
+
+.. kernel-doc:: include/linux/fpga/fpga-region.h
+   :functions: fpga_region
+
+.. kernel-doc:: drivers/fpga/fpga-region.c
+   :functions: fpga_region_create
+
+.. kernel-doc:: drivers/fpga/fpga-region.c
+   :functions: fpga_region_free
+
+.. kernel-doc:: drivers/fpga/fpga-region.c
+   :functions: fpga_region_register
+
+.. kernel-doc:: drivers/fpga/fpga-region.c
+   :functions: fpga_region_unregister
diff --git a/Documentation/driver-api/fpga/index.rst b/Documentation/driver-api/fpga/index.rst
index 968bbbf..c51e5eb 100644
--- a/Documentation/driver-api/fpga/index.rst
+++ b/Documentation/driver-api/fpga/index.rst
@@ -10,3 +10,4 @@ FPGA Subsystem
    intro
    fpga-mgr
    fpga-bridge
+   fpga-region
diff --git a/Documentation/fpga/fpga-region.txt b/Documentation/fpga/fpga-region.txt
deleted file mode 100644
index d38fa3b..0000000
--- a/Documentation/fpga/fpga-region.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-FPGA Regions
-
-Alan Tull 2017
-
-CONTENTS
- - Introduction
- - The FPGA region API
- - Usage example
-
-Introduction
-============
-
-This document is meant to be an brief overview of the FPGA region API usage.  A
-more conceptual look at regions can be found in [1].
-
-For the purposes of this API document, let's just say that a region associates
-an FPGA Manager and a bridge (or bridges) with a reprogrammable region of an
-FPGA or the whole FPGA.  The API provides a way to register a region and to
-program a region.
-
-Currently the only layer above fpga-region.c in the kernel is the Device Tree
-support (of-fpga-region.c) described in [1].  The DT support layer uses regions
-to program the FPGA and then DT to handle enumeration.  The common region code
-is intended to be used by other schemes that have other ways of accomplishing
-enumeration after programming.
-
-An fpga-region can be set up to know the following things:
-* which FPGA manager to use to do the programming
-* which bridges to disable before programming and enable afterwards.
-
-Additional info needed to program the FPGA image is passed in the struct
-fpga_image_info [2] including:
-* pointers to the image as either a scatter-gather buffer, a contiguous
-  buffer, or the name of firmware file
-* flags indicating specifics such as whether the image if for partial
-  reconfiguration.
-
-===================
-The FPGA region API
-===================
-
-To register or unregister a region:
------------------------------------
-
-	int fpga_region_register(struct fpga_region *region);
-	int fpga_region_unregister(struct fpga_region *region);
-
-An example of usage can be seen in the probe function of [3]
-
-To program an FPGA:
--------------------
-	int fpga_region_program_fpga(struct fpga_region *region);
-
-This function operates on info passed in the fpga_image_info
-(region->info).
-
-This function will attempt to:
- * lock the region's mutex
- * lock the region's FPGA manager
- * build a list of FPGA bridges if a method has been specified to do so
- * disable the bridges
- * program the FPGA
- * re-enable the bridges
- * release the locks
-
-=============
-Usage example
-=============
-
-First, allocate the info struct:
-
-	info = fpga_image_info_alloc(dev);
-	if (!info)
-		return -ENOMEM;
-
-Set flags as needed, i.e.
-
-	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
-
-Point to your FPGA image, such as:
-
-	info->sgt = &sgt;
-
-Add info to region and do the programming:
-
-	region->info = info;
-	ret = fpga_region_program_fpga(region);
-
-Then enumerate whatever hardware has appeared in the FPGA.
-
---
-[1] ../devicetree/bindings/fpga/fpga-region.txt
-[2] ./fpga-mgr.txt
-[3] ../../drivers/fpga/of-fpga-region.c
-- 
2.7.4
