Return-Path: <SRS0=wpTi=ET=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=wpTi=ET=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-by2nam03on0074.outbound.protection.outlook.com ([104.47.42.74]:50112
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750992AbeAXFWI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jan 2018 00:22:08 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] fpga: region: Release the bridge reference
Date: Wed, 24 Jan 2018 10:57:22 +0530
Message-ID: <1516771642-14551-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org, shubhrajyoti.datta@gmail.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

It is the caller responsibility to release the bridge handle.
In the program_fpga the put bridge is missed out fix the same.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/fpga/fpga-region.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index d9ab7c7..58789b9 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -273,6 +273,7 @@ static int fpga_region_program_fpga(struct fpga_region =
*region,
                goto err_put_br;
        }

+       fpga_bridges_put(&region->bridge_list);
        fpga_mgr_put(mgr);
        fpga_region_put(region);

--
2.1.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
