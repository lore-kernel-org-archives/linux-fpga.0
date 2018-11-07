Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 4/4] zynq-fpga: Only route PR via PCAP when required
Date: Wed,  7 Nov 2018 11:51:48 -0600
Message-Id: <1541613108-29660-5-git-send-email-atull@kernel.org>
In-Reply-To: <1541613108-29660-1-git-send-email-atull@kernel.org>
References: <1541613108-29660-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
List-ID: <linux-fpga@vger.kernel.org>

From: Mike Looijmans <mike.looijmans@topic.nl>

The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
it impossible to use the ICAP interface for partial reconfiguration.

This patch changes the driver to only activate PR over PCAP while the
device is actively being accessed by the driver for programming.

This allows both PCAP and ICAP interfaces to be used for PR.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/zynq-fpga.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index bb82efe..57b0e67 100644
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
2.7.4
