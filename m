Return-Path: <SRS0=Yrsi=RR=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=Yrsi=RR=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v4 0/6]dt-bindings: Firmware node binding for ZynqMP core
Date: Thu, 14 Mar 2019 19:31:16 +0530
Message-ID: <20190314140122.23372-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
To: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, nava.manne@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

Base firmware node and clock child node binding are part of mainline kernel.
This patchset adds documentation to describe rest of the firmware child node bindings. 

Complete firmware DT node example is shown below for ease of understanding:

firmware {
        zynqmp_firmware: zynqmp-firmware {
                compatible = "xlnx,zynqmp-firmware";
                method = "smc";
                #power-domain-cells = <1>;
                #reset-cells = <1>;

                zynqmp_clk: clock-controller {
                        #clock-cells = <1>;
                        compatible = "xlnx,zynqmp-clk";
                        clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
                        clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
                };

                zynqmp_power: zynqmp-power {
                        compatible = "xlnx,zynqmp-power";
                        interrupts = <0 35 4>;
                };

                zynqmp_reset: reset-controller {
                        compatible = "xlnx,zynqmp-reset";
                        #reset-cells = <1>;
                };

                nvmem_firmware {
                        compatible = "xlnx,zynqmp-nvmem-fw";
                        #address-cells = <1>;
                        #size-cells = <1>;

                        /* Data cells */
                        soc_revision: soc_revision {
                                reg = <0x0 0x4>;
                        };
                };

                pinctrl0: pinctrl@ff180000 {
                        compatible = "xlnx,zynqmp-pinctrl";

                        pinctrl_uart1_default: uart1-default {
                                mux {
                                        groups = "uart0_4_grp";
                                        function = "uart0";
                                };

                                conf {
                                        groups = "uart0_4_grp";
                                        slew-rate = <SLEW_RATE_SLOW>;
                                        io-standard = <IO_STANDARD_LVCMOS18>;
                                };

                                conf-rx {
                                        pins = "MIO18";
                                        bias-high-impedance;
                                };

                                conf-tx {
                                        pins = "MIO19";
                                        bias-disable;
                                        schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
                                };
                        };
                };
        };
};
Nava kishore Manne (3):
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver

Rajan Vaja (3):
  dt-bindings: power: Add ZynqMP power domain bindings
  dt-bindings: soc: Add ZynqMP PM bindings
  dt-bindings: pinctrl: Add ZynqMP pin controller bindings

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  11 +
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      |  47 +++
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt  | 275 ++++++++++++++++++
 .../power/reset/xlnx,zynqmp-power.txt         |  25 ++
 .../bindings/power/xlnx,zynqmp-genpd.txt      |  34 +++
 .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 ++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |  39 +++
 .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 +++++++++
 8 files changed, 613 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h

-- 
2.18.0
