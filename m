Return-Path: <SRS0=wDjG=XV=analog.com=Nuno.Sa@kernel.org>
Return-Path: <SRS0=wDjG=XV=analog.com=Nuno.Sa@kernel.org>
From: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 1/3] include: fpga: adi-axi-common: Define version macros
Date: Thu, 26 Sep 2019 12:39:23 +0200
Message-ID: <20190926103925.194973-2-nuno.sa@analog.com>
In-Reply-To: <20190926103925.194973-1-nuno.sa@analog.com>
References: <20190926103925.194973-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-ID: <linux-fpga@vger.kernel.org>

Add commom macros to "parse" ADI HDL cores version, in terms of
major, minor and patch.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 include/linux/fpga/adi-axi-common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
index 7fc95d5c95bb..5bc5603e6bc8 100644
--- a/include/linux/fpga/adi-axi-common.h
+++ b/include/linux/fpga/adi-axi-common.h
@@ -16,4 +16,8 @@
 #define ADI_AXI_PCORE_VER(major, minor, patch)	\
 	(((major) << 16) | ((minor) << 8) | (patch))
 
+#define ADI_AXI_PCORE_VER_MAJOR(version)	(((version) >> 16) & 0xff)
+#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
+#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
+
 #endif /* ADI_AXI_COMMON_H_ */
-- 
2.23.0
