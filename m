Return-Path: <SRS0=YJns=TC=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=YJns=TC=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:34598 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfEBHb5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 May 2019 03:31:57 -0400
Date: Thu, 2 May 2019 10:31:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] fpga manager: Adding FPGA Manager support for Xilinx
 zynqmp
Message-ID: <20190502073143.GA18363@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: nava.manne@xilinx.com
Cc: linux-fpga@vger.kernel.org

Hello Nava kishore Manne,

The patch c09f7471127e: "fpga manager: Adding FPGA Manager support
for Xilinx zynqmp" from Apr 15, 2019, leads to the following static
checker warning:

	drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
	error: 'eemi_ops' dereferencing possible ERR_PTR()

drivers/fpga/zynqmp-fpga.c
    40  static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
    41                                   const char *buf, size_t size)
    42  {
    43          const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
    44          struct zynqmp_fpga_priv *priv;
    45          dma_addr_t dma_addr;
    46          u32 eemi_flags = 0;
    47          char *kbuf;
    48          int ret;
    49  
    50          if (!eemi_ops || !eemi_ops->fpga_load)
                     ^^^^^^^^
This is an error pointer.  Possibly you want to handle EPROBE_DEFER in
a special way?

    51                  return -ENXIO;
    52  

See also:

drivers/fpga/zynqmp-fpga.c:84 zynqmp_fpga_ops_state() error: 'eemi_ops' dereferencing possible ERR_PTR()

regards,
dan carpenter
