Return-Path: <SRS0=aa2N=QA=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=aa2N=QA=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfAXUp5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Jan 2019 15:45:57 -0500
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/3] patches for FPGA
Date: Thu, 24 Jan 2019 14:45:51 -0600
Message-Id: <20190124204554.5438-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org

Hi Greg,

Please take these patches for fpga.  They have been reviewed on
the mailing list and apply cleanly on current linux-next.

The "fpga: stratix10-soc: fix wrong of_node_put() in init function"
is a bug fix, sorry it's late.  It will only affect the
Stratix10 platform.

The other two can go in whenever is appropriate.

Thanks,
Alan

Alan Tull (1):
  fpga: altera_freeze_bridge: remove restriction to socfpga

Colin Ian King (1):
  fpga: mgr: altera-ps-spi: make array dummy static, shrinks object size

Nicolas Saenz Julienne (1):
  fpga: stratix10-soc: fix wrong of_node_put() in init function

 drivers/fpga/Kconfig         | 2 +-
 drivers/fpga/altera-ps-spi.c | 2 +-
 drivers/fpga/stratix10-soc.c | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.7.4
