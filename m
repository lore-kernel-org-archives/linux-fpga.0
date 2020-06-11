Return-Path: <SRS0=YXtk=7Y=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=YXtk=7Y=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42095 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbgFKTil (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Jun 2020 15:38:41 -0400
Received: by mail-qk1-f200.google.com with SMTP id d190so5999268qkc.20
        for <linux-fpga@vger.kernel.org>; Thu, 11 Jun 2020 12:38:38 -0700 (PDT)
From: trix@redhat.com
Subject: [PATCH v2 1/1] selftests: fpga: dfl: A test for afu interrupt support
Date: Thu, 11 Jun 2020 12:38:27 -0700
Message-Id: <20200611193827.8302-2-trix@redhat.com>
In-Reply-To: <20200611193827.8302-1-trix@redhat.com>
References: <20200611193827.8302-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
an expected result.

Tested on vf device 0xbcc1

Sample run with
 # make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
 ...
 # selftests: drivers/fpga: afu_intr
 # # Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
 ok 1 selftests: drivers/fpga: afu_intr

Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 33 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1195bd85af38..4c6eda659125 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += clone3
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
+TARGETS += drivers/fpga
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
new file mode 100644
index 000000000000..0a472e8c67c5
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -I../../../../../usr/include/
+CFLAGS += -I../../../../../include/uapi/
+
+TEST_GEN_PROGS := afu_intr
+
+top_srcdir ?=../../../../..
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/fpga/afu_intr.c b/tools/testing/selftests/drivers/fpga/afu_intr.c
new file mode 100644
index 000000000000..e4ef3fac764d
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/afu_intr.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <linux/fcntl.h>
+#include <linux/fpga-dfl.h>
+
+#include "../../kselftest.h"
+
+int main(int argc, char *argv[])
+{
+	int devfd, status;
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num;
+
+	devfd = open("/dev/dfl-port.0", O_RDONLY);
+	if (devfd < 0)
+		ksft_exit_skip("no fpga afu device 0\n");
+
+	/*
+	 * From fpga-dl.h :
+	 * Currently hardware supports up to 1 irq.
+	 * Return: 0 on success, -errno on failure.
+	 */
+	irq_num = -1;
+	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
+	if (status != 0 || irq_num > 255)
+		ksft_exit_fail_msg("Could not get the number of afu error irqs\n");
+
+	close(devfd);
+	ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
new file mode 100644
index 000000000000..e2111b81d8d7
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/config
@@ -0,0 +1 @@
+CONFIG_FPGA_DFL_AFU=m
-- 
2.18.1
