Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv1 0/7] Add compatible value to Intel Stratix10 FPGA manager and service layer
Date: Fri, 14 Feb 2020 10:00:45 -0600
Message-Id: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
To: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add a compatible property value so we can reuse Intel Stratix10 FPGA
manager and service layer drivers on Intel Agilex SoC platform. 

Richard Gong (7):
  dt-bindings: fpga: add compatible value to Stratix10 SoC FPGA manager
    binding
  arm64: dts: agilex: correct FPGA manager driver's compatible value
  fpga: stratix10-soc: add compatible property value for intel agilex
  dt-bindings, firmware: add compatible value Intel Stratix10 service
    layer binding
  arm64: dts: agilex: correct service layer driver's compatible value
  firmware: stratix10-svc: add the compatible value for intel agilex
  firmware: intel_stratix10_service: add depend on agilex

 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt    | 2 +-
 .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt         | 3 ++-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi                         | 4 ++--
 drivers/firmware/Kconfig                                              | 2 +-
 drivers/firmware/stratix10-svc.c                                      | 1 +
 drivers/fpga/stratix10-soc.c                                          | 3 ++-
 6 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.7.4
