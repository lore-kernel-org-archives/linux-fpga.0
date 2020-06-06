Return-Path: <SRS0=PJwp=7T=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=PJwp=7T=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727994AbgFFVCw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Jun 2020 17:02:52 -0400
Received: by mail-qv1-f72.google.com with SMTP id k35so10634385qva.18
        for <linux-fpga@vger.kernel.org>; Sat, 06 Jun 2020 14:02:49 -0700 (PDT)
From: trix@redhat.com
Subject: [PATCH 0/1] fpga: dfl: Fix dead store
Date: Sat,  6 Jun 2020 14:02:40 -0700
Message-Id: <20200606210241.7459-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

Repo linux-next
Tag next-20200605

A couple of fixes for dead stores found by clang's sa tool scan-build

Tom Rix (1):
  Fix dead store

 drivers/fpga/fpga-bridge.c | 6 ++----
 drivers/fpga/fpga-mgr.c    | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.26.0
