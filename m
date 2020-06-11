Return-Path: <SRS0=YXtk=7Y=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=YXtk=7Y=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726134AbgFKTin (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Jun 2020 15:38:43 -0400
Received: by mail-qk1-f199.google.com with SMTP id m29so6003951qkm.17
        for <linux-fpga@vger.kernel.org>; Thu, 11 Jun 2020 12:38:35 -0700 (PDT)
From: trix@redhat.com
Subject: [PATCH v2 0/1]  selftests: fpga: dfl: A test for afu interrupt support
Date: Thu, 11 Jun 2020 12:38:26 -0700
Message-Id: <20200611193827.8302-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200611

Start applying selftests to drivers/fpga.

While testing out this upcoming change on linux-fpga
'Add interrupt support to FPGA DFL drivers'

I did not see any existing fpga tests.
So I added one.

Change from v1
Use ksft_* functions for reporting

Tom Rix (1):
  selftests: fpga: dfl: A test for afu interrupt support

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 33 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

-- 
2.18.1
