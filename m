Return-Path: <SRS0=2aEQ=SS=bombadil.infradead.org=mchehab@kernel.org>
Return-Path: <SRS0=2aEQ=SS=bombadil.infradead.org=mchehab@kernel.org>
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 14/57] docs: fpga: convert it to ReST
Date: Mon, 15 Apr 2019 23:55:39 -0300
Message-Id: <b66aa91ff5b9b3477d21094d3111c1006c59bd42.1555382110.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@bombadil.infradead.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The dfl.txt file is almost there. It needs just a few
adjustments to be properly parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/fpga/dfl.txt | 58 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/Documentation/fpga/dfl.txt b/Documentation/fpga/dfl.txt
index 6df4621c3f2a..2f125abd777f 100644
--- a/Documentation/fpga/dfl.txt
+++ b/Documentation/fpga/dfl.txt
@@ -1,9 +1,12 @@
-===============================================================================
-              FPGA Device Feature List (DFL) Framework Overview
--------------------------------------------------------------------------------
-                Enno Luebbers <enno.luebbers@intel.com>
-                Xiao Guangrong <guangrong.xiao@linux.intel.com>
-                Wu Hao <hao.wu@intel.com>
+=================================================
+FPGA Device Feature List (DFL) Framework Overview
+=================================================
+
+Authors:
+
+- Enno Luebbers <enno.luebbers@intel.com>
+- Xiao Guangrong <guangrong.xiao@linux.intel.com>
+- Wu Hao <hao.wu@intel.com>
 
 The Device Feature List (DFL) FPGA framework (and drivers according to this
 this framework) hides the very details of low layer hardwares and provides
@@ -19,7 +22,7 @@ Device Feature List (DFL) defines a linked list of feature headers within the
 device MMIO space to provide an extensible way of adding features. Software can
 walk through these predefined data structures to enumerate FPGA features:
 FPGA Interface Unit (FIU), Accelerated Function Unit (AFU) and Private Features,
-as illustrated below:
+as illustrated below::
 
     Header            Header            Header            Header
  +----------+  +-->+----------+  +-->+----------+  +-->+----------+
@@ -81,9 +84,9 @@ and release it using close().
 
 The following functions are exposed through ioctls:
 
- Get driver API version (DFL_FPGA_GET_API_VERSION)
- Check for extensions (DFL_FPGA_CHECK_EXTENSION)
- Program bitstream (DFL_FPGA_FME_PORT_PR)
+- Get driver API version (DFL_FPGA_GET_API_VERSION)
+- Check for extensions (DFL_FPGA_CHECK_EXTENSION)
+- Program bitstream (DFL_FPGA_FME_PORT_PR)
 
 More functions are exposed through sysfs
 (/sys/class/fpga_region/regionX/dfl-fme.n/):
@@ -118,18 +121,19 @@ port by using open() on the port device node and release it using close().
 
 The following functions are exposed through ioctls:
 
- Get driver API version (DFL_FPGA_GET_API_VERSION)
- Check for extensions (DFL_FPGA_CHECK_EXTENSION)
- Get port info (DFL_FPGA_PORT_GET_INFO)
- Get MMIO region info (DFL_FPGA_PORT_GET_REGION_INFO)
- Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
- Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
- Reset AFU (*DFL_FPGA_PORT_RESET)
+- Get driver API version (DFL_FPGA_GET_API_VERSION)
+- Check for extensions (DFL_FPGA_CHECK_EXTENSION)
+- Get port info (DFL_FPGA_PORT_GET_INFO)
+- Get MMIO region info (DFL_FPGA_PORT_GET_REGION_INFO)
+- Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
+- Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
+- Reset AFU (DFL_FPGA_PORT_RESET)
 
-*DFL_FPGA_PORT_RESET: reset the FPGA Port and its AFU. Userspace can do Port
-reset at any time, e.g. during DMA or Partial Reconfiguration. But it should
-never cause any system level issue, only functional failure (e.g. DMA or PR
-operation failure) and be recoverable from the failure.
+DFL_FPGA_PORT_RESET:
+  reset the FPGA Port and its AFU. Userspace can do Port
+  reset at any time, e.g. during DMA or Partial Reconfiguration. But it should
+  never cause any system level issue, only functional failure (e.g. DMA or PR
+  operation failure) and be recoverable from the failure.
 
 User-space applications can also mmap() accelerator MMIO regions.
 
@@ -143,6 +147,8 @@ More functions are exposed through sysfs:
 DFL Framework Overview
 ======================
 
+::
+
          +----------+    +--------+ +--------+ +--------+
          |   FME    |    |  AFU   | |  AFU   | |  AFU   |
          |  Module  |    | Module | | Module | | Module |
@@ -151,7 +157,7 @@ DFL Framework Overview
                  | FPGA Container Device |    Device Feature List
                  |  (FPGA Base Region)   |         Framework
                  +-----------------------+
---------------------------------------------------------------------
+  ------------------------------------------------------------------
                +----------------------------+
                |   FPGA DFL Device Module   |
                | (e.g. PCIE/Platform Device)|
@@ -220,7 +226,7 @@ the sysfs hierarchy under /sys/class/fpga_region.
 In the example below, two DFL based FPGA devices are installed in the host. Each
 fpga device has one FME and two ports (AFUs).
 
-FPGA regions are created under /sys/class/fpga_region/
+FPGA regions are created under /sys/class/fpga_region/::
 
 	/sys/class/fpga_region/region0
 	/sys/class/fpga_region/region1
@@ -231,7 +237,7 @@ Application needs to search each regionX folder, if feature device is found,
 (e.g. "dfl-port.n" or "dfl-fme.m" is found), then it's the base
 fpga region which represents the FPGA device.
 
-Each base region has one FME and two ports (AFUs) as child devices:
+Each base region has one FME and two ports (AFUs) as child devices::
 
 	/sys/class/fpga_region/region0/dfl-fme.0
 	/sys/class/fpga_region/region0/dfl-port.0
@@ -243,7 +249,7 @@ Each base region has one FME and two ports (AFUs) as child devices:
 	/sys/class/fpga_region/region3/dfl-port.3
 	...
 
-In general, the FME/AFU sysfs interfaces are named as follows:
+In general, the FME/AFU sysfs interfaces are named as follows::
 
 	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/
 	/sys/class/fpga_region/<regionX>/<dfl-port.m>/
@@ -251,7 +257,7 @@ In general, the FME/AFU sysfs interfaces are named as follows:
 with 'n' consecutively numbering all FMEs and 'm' consecutively numbering all
 ports.
 
-The device nodes used for ioctl() or mmap() can be referenced through:
+The device nodes used for ioctl() or mmap() can be referenced through::
 
 	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/dev
 	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
-- 
2.20.1
