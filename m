Return-Path: <SRS0=wDjG=XV=analog.com=Nuno.Sa@kernel.org>
Return-Path: <SRS0=wDjG=XV=analog.com=Nuno.Sa@kernel.org>
From: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 0/3] Support AXI FAN Control IP core
Date: Thu, 26 Sep 2019 12:39:22 +0200
Message-ID: <20190926103925.194973-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-ID: <linux-fpga@vger.kernel.org>

This series adds support for the ADI AXI FAN Control IP core. The first
patch adds some new definitions to the adi-axi-common header file. This
new `#defines` will be then used by the new hwmon driver. The rest of the
series is the usual stuff for a new device driver.

Nuno Sá (3):
  include: fpga: adi-axi-common: Define version macros
  hwmon: Support ADI Fan Control IP
  dt-bindings: hwmon: Add AXI FAN Control documentation

 .../bindings/hwmon/adi,axi-fan-control.yaml   |  58 +++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |   9 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/axi-fan-control.c               | 452 ++++++++++++++++++
 include/linux/fpga/adi-axi-common.h           |   4 +
 6 files changed, 532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 create mode 100644 drivers/hwmon/axi-fan-control.c

-- 
2.23.0
