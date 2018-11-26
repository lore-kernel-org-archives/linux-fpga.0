Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/2] patches for FPGA
Date: Mon, 26 Nov 2018 11:35:26 -0600
Message-Id: <1543253728-26542-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these two fpga fixes patches.  They have been reviewed
on the mailing list and apply cleanly on current linux-next.

Thanks,
Alan

Anatolij Gustschin (2):
  fpga: altera-cvp: fix probing for multiple FPGAs on the bus
  fpga: mgr: altera-ps-spi: enable usage on non-dt platforms

 drivers/fpga/altera-cvp.c    | 34 ++++++++++++++++++++++++----------
 drivers/fpga/altera-ps-spi.c | 40 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 15 deletions(-)

-- 
2.7.4
