Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/3] more patches for FPGA
Date: Wed, 15 Nov 2017 16:33:09 -0600
Message-Id: <1510785192-10123-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these three patches for FPGA.  They go on top of my
"[PATCH v6 00/18] patches for FPGA" patch set I sent earlier
today.  Sorry I didn't think of sending them all together at the
time.

These are fixes for FPGA that have been reviewed on
the mailing list.

I had to rebase the "fpga: region: release of_parse_phandle nodes
after use" patch to apply on top of my patchset.

Alan

Gustavo A. R. Silva (2):
  fpga: fpga-mgr: remove unnecessary code in __fpga_mgr_get
  fpga: fpga-bridge: remove unnecessary null check in of_fpga_bridge_get

Ian Abbott (1):
  fpga: region: release of_parse_phandle nodes after use

 drivers/fpga/fpga-bridge.c    |  2 --
 drivers/fpga/fpga-mgr.c       |  2 --
 drivers/fpga/of-fpga-region.c | 13 ++++++++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.7.4
