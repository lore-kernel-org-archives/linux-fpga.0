Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/5] patches for FPGA
Date: Tue,  1 Aug 2017 21:20:50 -0500
Message-Id: <1501640455-2719-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these patches for FPGA that have been reviewed on the
mailing lists.  All minor things including two bug fixes, an update to
MAINTAINERS, and a couple other minor patches.

Thanks,
Alan

Gustavo A. R. Silva (1):
  fpga: altera-hps2fpga: add NULL check on of_match_device() return
    value

Ian Abbott (1):
  fpga: altera-hps2fpga: fix multiple init of l3_remap_lock

Moritz Fischer (1):
  MAINTAINERS: fpga: Update email and add patchwork URL

Philipp Zabel (1):
  ARM: socfpga: explicitly request exclusive reset control

Rob Herring (1):
  fpga: Convert to using %pOF instead of full_name

 MAINTAINERS                    |  3 ++-
 drivers/fpga/altera-hps2fpga.c | 12 ++++++++----
 drivers/fpga/fpga-region.c     |  4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.7.4
