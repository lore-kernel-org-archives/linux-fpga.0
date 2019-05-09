Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/4] patches for FPGA
Date: Thu,  9 May 2019 16:08:25 -0500
Message-Id: <20190509210829.31815-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these four fpga fixes patches.  They
have been reviewed on the mailing list and apply
cleanly on current linux-next and char-misc-testing.

Thanks,
Alan

Chengguang Xu (1):
  fpga: dfl: expand minor range when registering chrdev region

Scott Wood (2):
  fpga: dfl: afu: Pass the correct device to dma_mapping_error()
  fpga: dfl: Add lockdep classes for pdata->lock

Wen Yang (1):
  fpga: stratix10-soc: fix use-after-free on s10_init()

 drivers/fpga/dfl-afu-dma-region.c |  2 +-
 drivers/fpga/dfl.c                | 22 ++++++++++++++++++----
 drivers/fpga/stratix10-soc.c      |  6 +++++-
 3 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.21.0
