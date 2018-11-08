Return-Path: <SRS0=C43o=NU=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=C43o=NU=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42033 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeKJIUt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 10 Nov 2018 03:20:49 -0500
From: capetry.dev@gmail.com
Subject: [PATCH 0/2] fpga: altera-cvp: clean checkpatch faults
Date: Wed,  7 Nov 2018 23:13:10 -0200
Message-Id: <20181108011312.29587-1-capetry.dev@gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org

From: Carlos A Petry <capetry.dev@gmail.com>

Insert missing or malformed SPDX-License-Identifier tag
    WARNING: Missing or malformed SPDX-License-Identifier tag
Fix function definition argument 'struct altera_cvp_conf *'
    WARNING: function definition argument 'struct altera_cvp_conf *'

Run checkpatch and all problem was fixed in the file.
This is my first contribution to the Kernel Project, 
please let me know if something is wrong, thanks.

Carlos A Petry (2):
  fpga: altera-cvp: Insert SPDX-License-Identifier
  fpga: altera-cvp: Fix function definition argument

 drivers/fpga/altera-cvp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1
