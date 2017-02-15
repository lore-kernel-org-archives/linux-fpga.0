Return-Path: <mdf@kernel.org>
Return-Path: <mdf@kernel.org>
From: mdf@kernel.org
Subject: [PATCH 1/2] fpga: Add flag to indicate bitstream needs decrypting
Date: Tue, 14 Feb 2017 16:31:29 -0800
Message-Id: <1487118690-21166-1-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-fpga@vger.kernel.org
Cc: mdf@kernel.org, Moritz Fischer <moritz.fischer@ettus.com>, Alan Tull <atull@kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Moritz Fischer <moritz.fischer@ettus.com>

Add a flag that is passed to the write_init() callback, indicating
that the bitstream is encrypted.

The low-level driver will deal with the flag, or return an error,
if encrypted bitstreams are not supported.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Alan Tull <atull@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org
---
 include/linux/fpga/fpga-mgr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 57beb5d..1355d8a 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -70,6 +70,7 @@ enum fpga_mgr_states {
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
+#define FPGA_MGR_DECRYPT_BITSTREAM	BIT(2)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.7.4
