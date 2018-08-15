Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/2] fpga: doc: documentation for FPGA debugfs
Date: Wed, 15 Aug 2018 17:09:57 -0500
Message-Id: <20180815220958.3606-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: Appana Durga Kedareswara Rao <appanad@xilinx.com>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>, Alan Tull <atull@opensource.altera.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Alan Tull <atull@opensource.altera.com>

This patch depends on my recently submitted documentation changes
("docs: fpga: document programming fpgas using regions")

Document the DebugFS interface for the core FPGA Manager
framework.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 Documentation/driver-api/fpga/fpga-mgr.rst | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 576f194..d7ca320 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -125,3 +125,41 @@ API for implementing a new FPGA Manager driver
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
+
+FPGA Manager DebugFS
+--------------------
+
+This interface allows the user to program an FPGA from userspace.  However,
+bridges and soft IP device driver loading/unloading are not handled.  This makes
+it really easy to mess things up by doing things like reprogramming the hardware
+out from under a driver or reprogramming while a bridge is enabled, causing gunk
+to go out on a CPU bus.  It should go without saying that this interface is for
+debug and development only.  Not intended for production use.
+
+Each FPGA gets its own directory such as <debugfs>/fpga_manager/fpga0 and the
+files described below.  To program the FPGA, write the ``flags`` and/or
+``config_complete_timeout_us`` files (as needed), then use either the
+``firmware_name`` or ``image`` file to program.
+
+* ``flags`` - [RW] flags as defined in fpga-mgr.h.  For example::
+
+   $ echo 1 > /sys/kernel/debug/fpga_manager/fpga0/flags
+
+* ``config_complete_timeout_us`` - [RW] time out in microseconds to wait for the
+  FPGA to go to operating state after region has been programmed.  Not all
+  low level drivers use this.  For example::
+
+   $ echo 4 > /sys/kernel/debug/fpga_manager/fpga0/config_complete_timeout_us
+
+* ``firmware_name`` - [RW] Name of an FPGA image firmware file.  Writing
+  initiates an FPGA programming cycle.  Note that the image file must be in a
+  directory on the firmware search path such as /lib/firmware::
+
+   $ echo image.rbf > /sys/kernel/debug/fpga_manager/fpga0/firmware_name
+
+* ``image`` - [WO] Raw FPGA image data.  Writing the FPGA image data will
+  initiate an FPGA programming cycle.  Data must be written in one chunk, for
+  example::
+
+   $ dd bs=10M if=./image.rbf of=/sys/kernel/debug/fpga_manager/fpga0/image
+    (where image.rbf < 10M)
-- 
2.7.4
