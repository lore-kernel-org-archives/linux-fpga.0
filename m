Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/1] one fix for FPGA
Date: Thu, 30 May 2019 09:52:58 -0500
Message-Id: <20190530145259.4189-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take this FPGA fix.  It have been reviewed on
the mailing list and applies cleanly on current
linux-next and char-misc-testing.

Thanks,
Alan

Moritz Fischer (1):
  fpga: zynqmp-fpga: Correctly handle error pointer

 drivers/fpga/zynqmp-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.21.0
