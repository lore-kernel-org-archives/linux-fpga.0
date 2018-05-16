Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 11/14] documentation: fpga: add bridge document to driver-api
Date: Wed, 16 May 2018 18:50:04 -0500
Message-Id: <20180516235007.3951-12-atull@kernel.org>
In-Reply-To: <20180516235007.3951-1-atull@kernel.org>
References: <20180516235007.3951-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Add a new document to driver-api/fpga that documents the
fpga bridge API and add it to driver-api/fpga/index.rst

Signed-off-by: Alan Tull <atull@kernel.org>
---
 Documentation/driver-api/fpga/fpga-bridge.rst | 49 +++++++++++++++++++++++++++
 Documentation/driver-api/fpga/index.rst       |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/driver-api/fpga/fpga-bridge.rst

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
new file mode 100644
index 0000000..2c2aaca
--- /dev/null
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -0,0 +1,49 @@
+FPGA Bridge
+===========
+
+API to implement a new FPGA bridge
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/fpga/fpga-bridge.h
+   :functions: fpga_bridge
+
+.. kernel-doc:: include/linux/fpga/fpga-bridge.h
+   :functions: fpga_bridge_ops
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_create
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_free
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_register
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_unregister
+
+API to control an FPGA bridge
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You probably won't need these directly.  FPGA regions should handle this.
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: of_fpga_bridge_get
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_get
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_put
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_get_to_list
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: of_fpga_bridge_get_to_list
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_enable
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: fpga_bridge_disable
diff --git a/Documentation/driver-api/fpga/index.rst b/Documentation/driver-api/fpga/index.rst
index 34b2075..968bbbf 100644
--- a/Documentation/driver-api/fpga/index.rst
+++ b/Documentation/driver-api/fpga/index.rst
@@ -9,3 +9,4 @@ FPGA Subsystem
 
    intro
    fpga-mgr
+   fpga-bridge
-- 
2.7.4
