Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 2/4] fpga: Add flag to indicate bitstream needs decrypting
Date: Mon, 27 Feb 2017 09:19:00 -0600
Message-Id: <20170227151902.3403-3-atull@kernel.org>
In-Reply-To: <20170227151902.3403-1-atull@kernel.org>
References: <20170227151902.3403-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

Add a flag that is passed to the write_init() callback, indicating
that the bitstream is encrypted.

The low-level driver will deal with the flag, or return an error,
if encrypted bitstreams are not supported.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 include/linux/fpga/fpga-mgr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 57beb5d..e2ef94f 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -70,6 +70,7 @@ enum fpga_mgr_states {
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
+#define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.7.4
