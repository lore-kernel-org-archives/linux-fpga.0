Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/2] fpga: small fixes for 4.19
Date: Thu, 16 Aug 2018 14:42:12 -0500
Message-Id: <20180816194214.3462-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these two small fixes for FPGA.  They've been
reviewed on the mailing lists.  They apply cleanly on
linux-next/master.

Thanks,
Alan

Colin Ian King (1):
  drivers: fpga: fix two trivial spelling mistakes

Wei Yongjun (1):
  fpga: dfl: fme: fix return value check in in pr_mgmt_init()

 drivers/fpga/dfl-afu-dma-region.c | 2 +-
 drivers/fpga/dfl-fme-mgr.c        | 2 +-
 drivers/fpga/dfl-fme-pr.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
