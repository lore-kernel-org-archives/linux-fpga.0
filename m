Return-Path: <SRS0=NSwu=7V=redhat.com=trix@kernel.org>
Return-Path: <SRS0=NSwu=7V=redhat.com=trix@kernel.org>
From: trix@redhat.com
Subject: [PATCH v2 0/2] fpga: Fix dead store
Date: Mon,  8 Jun 2020 05:54:44 -0700
Message-Id: <20200608125446.23311-1-trix@redhat.com>
Content-Type: text/plain; charset=US-ASCII
To: mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200608

A couple of fixes for dead stores found by clang's sa tool scan-build

Main changes from v1:
Split single patch into two patch

Tom Rix (2):
  fpga: Fix dead store fpga-mgr.c
  fpga: Fix dead store in fpga-bridge.c

 drivers/fpga/fpga-bridge.c | 6 ++----
 drivers/fpga/fpga-mgr.c    | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.26.0
