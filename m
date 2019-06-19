Return-Path: <moritz.fischer.private@gmail.com>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/1] drivers: fpga: Kconfig: pedantic cleanups
Date: Tue, 18 Jun 2019 21:24:39 -0700
Message-Id: <20190619042439.4705-2-mdf@kernel.org>
In-Reply-To: <20190619042439.4705-1-mdf@kernel.org>
References: <20190619042439.4705-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, atull@kernel.org, Enrico Weigelt <info@metux.net>, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Enrico Weigelt <info@metux.net>

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt <info@metux.net>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 8072c195d831..474f304ec109 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -26,9 +26,9 @@ config FPGA_MGR_SOCFPGA_A10
 	  FPGA manager driver support for Altera Arria10 SoCFPGA.
 
 config ALTERA_PR_IP_CORE
-        tristate "Altera Partial Reconfiguration IP Core"
-        help
-          Core driver support for Altera Partial Reconfiguration IP component
+	tristate "Altera Partial Reconfiguration IP Core"
+	help
+	  Core driver support for Altera Partial Reconfiguration IP component
 
 config ALTERA_PR_IP_CORE_PLAT
 	tristate "Platform support of Altera Partial Reconfiguration IP Core"
-- 
2.22.0
