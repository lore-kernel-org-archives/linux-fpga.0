Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 7/8] docs: fpga: document fpga manager flags
Date: Tue, 14 Aug 2018 14:15:25 -0500
Message-Id: <20180814191526.3247-8-atull@kernel.org>
In-Reply-To: <20180814191526.3247-1-atull@kernel.org>
References: <20180814191526.3247-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Add flags #defines to kerneldoc documentation in a
useful place.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++++
 include/linux/fpga/fpga-mgr.h              | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 431556d..db8885e 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -183,6 +183,11 @@ API for implementing a new FPGA Manager driver
 API for programming an FPGA
 ---------------------------
 
+FPGA Manager flags
+
+.. kernel-doc:: include/linux/fpga/fpga-mgr.h
+   :doc: FPGA Manager flags
+
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_image_info
 
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 1ca02ce..777c502 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -53,12 +53,18 @@ enum fpga_mgr_states {
 	FPGA_MGR_STATE_OPERATING,
 };
 
-/*
- * FPGA Manager flags
- * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
- * FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
- * FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
- * FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+/**
+ * DOC: FPGA Manager flags
+ *
+ * Flags used in the &fpga_image_info->flags field
+ *
+ * %FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
+ *
+ * %FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
+ *
+ * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
+ *
+ * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
-- 
2.7.4
