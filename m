Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH] fpga: use SPDX
Date: Wed, 11 Apr 2018 09:21:14 -0500
Message-Id: <1523456474-4283-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Replace GPLv2 boilerplate with SPDX in FPGA code that came from me or
from Altera.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/altera-fpga2sdram.c       | 13 +------------
 drivers/fpga/altera-freeze-bridge.c    | 13 +------------
 drivers/fpga/altera-hps2fpga.c         | 13 +------------
 drivers/fpga/altera-pr-ip-core-plat.c  | 13 +------------
 drivers/fpga/altera-pr-ip-core.c       | 13 +------------
 drivers/fpga/fpga-bridge.c             | 13 +------------
 drivers/fpga/fpga-mgr.c                | 13 +------------
 drivers/fpga/fpga-region.c             | 14 +-------------
 drivers/fpga/of-fpga-region.c          | 14 +-------------
 drivers/fpga/socfpga-a10.c             | 14 +-------------
 drivers/fpga/socfpga.c                 | 13 +------------
 include/linux/fpga/altera-pr-ip-core.h | 13 +------------
 include/linux/fpga/fpga-mgr.h          | 13 +------------
 include/linux/fpga/fpga-region.h       |  2 ++
 14 files changed, 15 insertions(+), 159 deletions(-)

diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index d4eeb74..b490518 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA to SDRAM Bridge Driver for Altera SoCFPGA Devices
  *
  *  Copyright (C) 2013-2016 Altera Corporation, All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 6159cfcf..b7b1c4e 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA Freeze Bridge Controller
  *
  *  Copyright (C) 2016 Altera Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/delay.h>
 #include <linux/io.h>
diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index 406d2f1..c8db9b5 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA to/from HPS Bridge Driver for Altera SoCFPGA Devices
  *
@@ -6,18 +7,6 @@
  * Includes this patch from the mailing list:
  *   fpga: altera-hps2fpga: fix HPS2FPGA bridge visibility to L3 masters
  *   Signed-off-by: Anatolij Gustschin <agust@denx.de>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
index 8fb36b8..b293d83 100644
--- a/drivers/fpga/altera-pr-ip-core-plat.c
+++ b/drivers/fpga/altera-pr-ip-core-plat.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for Altera Partial Reconfiguration IP Core
  *
@@ -5,18 +6,6 @@
  *
  * Based on socfpga-a10.c Copyright (C) 2015-2016 Altera Corporation
  *  by Alan Tull <atull@opensource.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/fpga/altera-pr-ip-core.h>
 #include <linux/module.h>
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index a7b31f9..e3b013b 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for Altera Partial Reconfiguration IP Core
  *
@@ -5,18 +6,6 @@
  *
  * Based on socfpga-a10.c Copyright (C) 2015-2016 Altera Corporation
  *  by Alan Tull <atull@opensource.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/delay.h>
 #include <linux/fpga/altera-pr-ip-core.h>
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 31bd2c5..1f01f95 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA Bridge Framework Driver
  *
  *  Copyright (C) 2013-2016 Altera Corporation, All Rights Reserved.
  *  Copyright (C) 2017 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/idr.h>
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 9939d2c..5009d8a 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA Manager Core
  *
@@ -6,18 +7,6 @@
  *
  * With code from the mailing list:
  * Copyright (C) 2013 Xilinx, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/firmware.h>
 #include <linux/fpga/fpga-mgr.h>
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index edab2a2..13e16a1 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA Region - Device Tree support for FPGA programming under Linux
  *
  *  Copyright (C) 2013-2016 Altera Corporation
  *  Copyright (C) 2017 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 119ff75..222ad07 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA Region - Device Tree support for FPGA programming under Linux
  *
  *  Copyright (C) 2013-2016 Altera Corporation
  *  Copyright (C) 2017 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index a46e343..ed46d0f 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -1,21 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA Manager Driver for Altera Arria10 SoCFPGA
  *
  * Copyright (C) 2015-2016 Altera Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/delay.h>
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index b6672e6..78f6c8d 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA Manager Driver for Altera SOCFPGA
  *
  *  Copyright (C) 2013-2015 Altera Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/completion.h>
 #include <linux/delay.h>
diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
index 3810a90..7d46647 100644
--- a/include/linux/fpga/altera-pr-ip-core.h
+++ b/include/linux/fpga/altera-pr-ip-core.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for Altera Partial Reconfiguration IP Core
  *
@@ -5,18 +6,6 @@
  *
  * Based on socfpga-a10.c Copyright (C) 2015-2016 Altera Corporation
  *  by Alan Tull <atull@opensource.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _ALT_PR_IP_CORE_H
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 3c6de23..5a569e8 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -1,20 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * FPGA Framework
  *
  *  Copyright (C) 2013-2016 Altera Corporation
  *  Copyright (C) 2017 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #ifndef _LINUX_FPGA_MGR_H
 #define _LINUX_FPGA_MGR_H
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index b652031..4cdef08 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 #ifndef _FPGA_REGION_H
 #define _FPGA_REGION_H
 
-- 
2.7.4
