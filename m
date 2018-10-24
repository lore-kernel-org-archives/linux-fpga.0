Return-Path: <SRS0=5rKg=NE=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=5rKg=NE=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from atl4mhob11.registeredsite.com ([209.17.115.49]:59758 "EHLO
        atl4mhob11.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727639AbeJXQUO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Oct 2018 12:20:14 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail03pod0.registeredsite.com [10.30.71.205])
        by atl4mhob11.registeredsite.com (8.14.4/8.14.4) with ESMTP id w9O7rAUZ027158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-fpga@vger.kernel.org>; Wed, 24 Oct 2018 03:53:10 -0400
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2] zynq-fpga: Only route PR via PCAP when required
Date: Wed, 24 Oct 2018 09:53:03 +0200
Message-Id: <1540367583-5413-1-git-send-email-mike.looijmans@topic.nl>
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, mdf@kernel.org, atull@kernel.org, git@xilinx.com, Mike Looijmans <mike.looijmans@topic.nl>

The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
it impossible to use the ICAP interface for partial reconfiguration.

This patch changes the driver to only activate PR over PCAP while the
device is actively being accessed by the driver for programming.

This allows both PCAP and ICAP interfaces to be used for PR.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
---
v2: Move the register setting in between the clock enable/disable

 drivers/fpga/zynq-fpga.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 3110e00..ff3a427 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -501,6 +501,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
 	if (err)
 		return err;
 
+	/* Release 'PR' control back to the ICAP */
+	zynq_fpga_write(priv, CTRL_OFFSET,
+		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
+
 	err = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, intr_status,
 				     intr_status & IXR_PCFG_DONE_MASK,
 				     INIT_POLL_DELAY,
-- 
1.9.1
