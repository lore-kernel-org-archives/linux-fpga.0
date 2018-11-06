Return-Path: <SRS0=qTBN=NR=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=qTBN=NR=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv10 7/8] Documentation: driver-api: add stratix10 service layer
Date: Tue,  6 Nov 2018 10:52:51 -0600
Message-Id: <1541523172-5171-8-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, todd.riffel@intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add new file stratix10-svc.rst
Add stratix10-svc.rst to driver-api/index.rst

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v5: this patch is added in patch set version 5
v6: no change
v7: no change
v8: no change
v9: no change
v10: add stratix10 service layer document to other firmware
     interface, and then remove stratix10-svc.rst file
---
 .../driver-api/firmware/other_interfaces.rst       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 36c47b1..a4ac54b 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -13,3 +13,33 @@ EDD Interfaces
 .. kernel-doc:: drivers/firmware/edd.c
    :internal:
 
+Intel Stratix10 SoC Service Layer
+---------------------------------
+Some features of the Intel Stratix10 SoC require a level of privilege
+higher than the kernel is granted. Such secure features include
+FPGA programming. In terms of the ARMv8 architecture, the kernel runs
+at Exception Level 1 (EL1), access to the features requires
+Exception Level 3 (EL3).
+
+The Intel Stratix10 SoC service layer provides an in kernel API for
+drivers to request access to the secure features. The requests are queued
+and processed one by one. ARM’s SMCCC is used to pass the execution
+of the requests on to a secure monitor (EL3).
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_command_code
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_client_msg
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_command_reconfig_payload
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_cb_data
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_client
+
+.. kernel-doc:: drivers/firmware/stratix10-svc.c
+   :export:
-- 
2.7.4
