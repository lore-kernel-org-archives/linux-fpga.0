Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/1] patch for fpga
Date: Thu, 21 Sep 2017 09:52:40 -0500
Message-Id: <20170921145241.2869-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take this one small fix for fpga.

Thanks!
Alan

Bhumika Goyal (1):
  fpga: make xlnx_pr_decoupler_br_ops const

 drivers/fpga/xilinx-pr-decoupler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.11.0
