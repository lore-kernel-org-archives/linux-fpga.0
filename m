Return-Path: <SRS0=Vlpq=RK=metux.net=info@kernel.org>
Return-Path: <SRS0=Vlpq=RK=metux.net=info@kernel.org>
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2] drivers: fpga: Kconfig: pedantic cleanups
Date: Thu,  7 Mar 2019 02:25:50 +0100
Message-Id: <1551921950-28695-1-git-send-email-info@metux.net>
In-Reply-To: <1551896937-31066-1-git-send-email-info@metux.net>
References: <1551896937-31066-1-git-send-email-info@metux.net>
To: linux-kernel@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/fpga/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0bb7b5c..d6562df 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -25,9 +25,9 @@ config FPGA_MGR_SOCFPGA_A10
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
1.9.1
