Return-Path: <SRS0=JyFA=7W=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=JyFA=7W=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48978 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728126AbgFINCe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Jun 2020 09:02:34 -0400
Received: by mail-qk1-f198.google.com with SMTP id 140so16970197qko.23
        for <linux-fpga@vger.kernel.org>; Tue, 09 Jun 2020 06:02:30 -0700 (PDT)
From: trix@redhat.com
Subject: [PATCH 1/1] selftests: fpga: dfl: A test for afu interrupt support
Date: Tue,  9 Jun 2020 06:02:08 -0700
Message-Id: <20200609130208.27390-2-trix@redhat.com>
In-Reply-To: <20200609130208.27390-1-trix@redhat.com>
References: <20200609130208.27390-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
an expected result.

Tested on vf device 0xbcc1

Sample run with
$ sudo make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
...
ok 1 selftests: drivers/fpga: afu_intr

Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 38 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 49 insertions(+)
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
index 000000000000..aa1efba94605
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/afu_intr.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <linux/fcntl.h>
+#include <linux/fpga-dfl.h>
+
+#define TEST_PREFIX	"drivers/fpga/afu_intr"
+
+int main(int argc, char *argv[])
+{
+	int devfd, status;
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num;
+
+	devfd = open("/dev/dfl-port.0", O_RDONLY);
+	if (devfd < 0) {
+		printf("%s: [skip,no-ufpgaintr]\n", TEST_PREFIX);
+		exit(77);
+	}
+
+	/*
+	 * From fpga-dl.h :
+	 * Currently hardware supports up to 1 irq.
+	 * Return: 0 on success, -errno on failure.
+	 */
+	irq_num = -1;
+	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
+	if (status != 0 || irq_num > 255) {
+		printf("%s: [FAIL,err-get-irq-num]\n", TEST_PREFIX);
+		close(devfd);
+		exit(1);
+	}
+
+	close(devfd);
+	return 0;
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
