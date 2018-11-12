Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [RESEND 0/2] fpga fixes for 4.20
Date: Mon, 12 Nov 2018 13:38:32 -0600
Message-Id: <1542051514-5205-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Here's a reposting of the two small fixes for fpga, please
take them in.  They've been reviewed on the mailing list
and apply cleanly on today's char-misc-test.

Thanks,
Alan

Moritz Fischer (2):
  fpga: of-fpga-region: Use platform_set_drvdata
  fpga: dfl-fme-region: Use platform_get_drvdata()

 drivers/fpga/dfl-fme-region.c | 2 +-
 drivers/fpga/of-fpga-region.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4
