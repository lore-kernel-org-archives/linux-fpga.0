Return-Path: <SRS0=XHe7=IL=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=XHe7=IL=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv5 7/8] defconfig: enable fpga and service layer
Date: Thu, 24 May 2018 11:33:19 -0500
Message-Id: <1527179600-26441-8-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1527179600-26441-1-git-send-email-richard.gong@linux.intel.com>
References: <1527179600-26441-1-git-send-email-richard.gong@linux.intel.com>
To: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@linux.intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Enable fpga framework, Stratix 10 SoC FPGA manager and Stratix10
Service Layer

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
v3: no change
v4: s/CONFIG_INTEL_SERVICE/CONFIG_STRATIX10_SERVICE/
    add CONFIG_OF_FPGA_REGION=y
    s/Intel/Stratix10/ in subject line
v5: no change
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..5f7a9b7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -180,6 +180,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_NVME=m
+CONFIG_STRATIX10_SERVICE=y
 CONFIG_SRAM=y
 CONFIG_EEPROM_AT25=m
 # CONFIG_SCSI_PROC_FS is not set
@@ -595,6 +596,11 @@ CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
 CONFIG_MESON_EFUSE=m
+CONFIG_FPGA=y
+CONFIG_FPGA_MGR_STRATIX10_SOC=y
+CONFIG_FPGA_REGION=y
+CONFIG_FPGA_BRIDGE=y
+CONFIG_OF_FPGA_REGION=y
 CONFIG_QCOM_QFPROM=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_TEE=y
-- 
2.7.4
