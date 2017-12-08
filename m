Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH] patch for FPGA
Date: Fri,  8 Dec 2017 11:36:59 -0600
Message-Id: <1512754620-3723-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take this one small fix for fpga.  It's been reviewed on
the mailing list.  It applies cleanly on linux-next/master.

Thanks,
Alan

Alexey Khoroshilov (1):
  fpga: socfpga-a10: disable clk on error in socfpga_a10_fpga_probe()

 drivers/fpga/socfpga-a10.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.7.4
