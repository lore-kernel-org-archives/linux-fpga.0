Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/4] patches for FPGA
Date: Wed,  7 Nov 2018 11:51:44 -0600
Message-Id: <1541613108-29660-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these four small fpga fixes patches.  They
have been reviewed on the mailing list and apply
cleanly on current linux-next and char-misc-testing.

Thanks,
Alan

Anatolij Gustschin (1):
  fpga: altera-cvp: fix 'bad IO access' on x86_64

Andreas Puhm (1):
  fpga: altera-cvp: Fix registration for CvP incapable devices

Mike Looijmans (1):
  zynq-fpga: Only route PR via PCAP when required

YueHaibing (1):
  fpga: dfl: fme: remove set but not used variable 'priv'

 drivers/fpga/altera-cvp.c | 15 +++++++++++++--
 drivers/fpga/dfl-fme-pr.c |  2 --
 drivers/fpga/zynq-fpga.c  |  4 ++++
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.7.4
