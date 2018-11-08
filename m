Return-Path: <SRS0=W2pA=NU=gmail.com=capetry.dev@kernel.org>
Return-Path: <SRS0=W2pA=NU=gmail.com=capetry.dev@kernel.org>
From: capetry.dev@gmail.com
Subject: [PATCH 1/2] fpga: altera-cvp: Insert SPDX-License-Identifier
Date: Wed,  7 Nov 2018 23:13:11 -0200
Message-Id: <20181108011312.29587-2-capetry.dev@gmail.com>
In-Reply-To: <20181108011312.29587-1-capetry.dev@gmail.com>
References: <20181108011312.29587-1-capetry.dev@gmail.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Carlos A Petry <capetry.dev@gmail.com>

Fix the following checkpatch warning:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Signed-off-by: Carlos A Petry <capetry.dev@gmail.com>

---
 drivers/fpga/altera-cvp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 610a1558e..45b7c8c0b 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA Manager Driver for Altera Arria/Cyclone/Stratix CvP
  *
-- 
2.17.1
