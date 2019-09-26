Return-Path: <SRS0=wDjG=XV=analog.com=Nuno.Sa@kernel.org>
Return-Path: <SRS0=wDjG=XV=analog.com=Nuno.Sa@kernel.org>
From: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 3/3] dt-bindings: hwmon: Add AXI FAN Control documentation
Date: Thu, 26 Sep 2019 12:39:25 +0200
Message-ID: <20190926103925.194973-4-nuno.sa@analog.com>
In-Reply-To: <20190926103925.194973-1-nuno.sa@analog.com>
References: <20190926103925.194973-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-ID: <linux-fpga@vger.kernel.org>

Document the AXI FAN Control IP core devicetree bindings.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../bindings/hwmon/adi,axi-fan-control.yaml   | 58 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
new file mode 100644
index 000000000000..03948d09f600
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/hwmon/adi,axi-fan-control.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI FAN Control Device Tree Bindings
+
+maintainers:
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |+
+  Bindings for the Analog Devices AXI FAN Control driver. Spefications of the
+  core can be found in:
+
+  https://wiki.analog.com/resources/fpga/docs/axi_fan_control
+
+properties:
+  compatible:
+    enum:
+        - adi,axi-fan-control-1.00.a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  adi,pulses-per-revolution:
+    description: Value specifying the number of pulses per revolution of the controlled FAN.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - adi,pulses-per-revolution
+
+examples:
+  - |
+    fpga_axi: fpga-axi@0 {
+            #address-cells = <0x2>;
+            #size-cells = <0x1>;
+
+            axi_fan_control: axi-fan-control@80000000 {
+                    compatible = "adi,axi-pulse-capture-1.00.a";
+                    reg = <0x0 0x80000000 0x10000>;
+                    clocks = <&clk 71>;
+                    interrupts = <0 110 0>;
+                    adi,pulses-per-revolution = <2>;
+            };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d775c923d23b..ecef8dc5f0b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2859,6 +2859,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	drivers/hwmon/axi-fan-control.c
+F:	Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
-- 
2.23.0
