Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B738C64E7B
	for <linux-fpga@archiver.kernel.org>; Thu,  3 Dec 2020 06:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310AA206E3
	for <linux-fpga@archiver.kernel.org>; Thu,  3 Dec 2020 06:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgLCGlX (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:41:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:46312 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgLCGlX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Dec 2020 01:41:23 -0500
IronPort-SDR: bCdap78Xbr+fHfg8VquTNeTcehaqtWno6P3oLoROHM2sCK+cR/jV7BFocqCe9kj8RLt2skQFzp
 PzYKrzH4m+0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="234748790"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="234748790"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 22:40:42 -0800
IronPort-SDR: VyPsy8gNtGe5iohE1rzVvopMSTYfcqUjKQz6RmomRvB9OaZKifBmCtpXeTu/EFHdTtbQHG+leF
 1QW6jyrVU+Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="335842245"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2020 22:40:39 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [RESEND PATCH v13 0/6] add DFL bus support to MODULE_DEVICE_TABLE()
Date:   Thu,  3 Dec 2020 14:35:54 +0800
Message-Id: <1606977360-4421-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Main changes from v1:
- A new patch (Patch #3) to fix the description.
- Rename the dfl-bus.h to dfl.h
- Updated the MAINTAINERS under FPGA DFL DRIVERS.
- Improve comments and minor fixes.

Main changes from v2:
- Change the bus name from "dfl" to "fpga-dfl", also rename related
  variables, functions ...
- Changes the data type of fpga_dfl_device_id.type from u8 to u16
- Explicitly defines the values of enum fpga_dfl_id_type
- Delete the comments for the valid bits of type & feature_id
- changes MODALIAS format for fpga dfl devices

Main changes from v3:
- Change the bus name back to "dfl".
- Add 2 patches (#5, 6) for dfl drivers.
- Delete the retimer FEC mode configuration via module_parameter for
  Patch #5
- Merge the patch "Make m10_n3000_info static" (https://lore.kernel.org/linux-fpga/52d8411e-13d8-1e91-756d-131802f5f445@huawei.com/T/#t)
  into Patch #5
- Add static prefix for emif attributes macro for Patch #6

Main changes from v9:
- Add the description for struct dfl_device_id in mod_devicetable.h
- Move the dfl.h from include/linux/fpga to include/linux
- some code refactor and minor fixes for dfl-n3000-nios

Main changes from v10:
- use sysfs_emit instead of sprintf for both patches
- rebase to 5.10-rc1

Main changes from v11:
- Fix the type of driver_data from unsigned long to kernel_ulong_t
- Fixed up header guards to match filename by Moritz
- move the MODULE_DEVICE_TABLE() right after its definition

Main changes from v12:
- For patch #5, fix the wrong use of logical'||', should use '|'

Xu Yilun (6):
  fpga: dfl: fix the definitions of type & feature_id for dfl devices
  fpga: dfl: move dfl_device_id to mod_devicetable.h
  fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
  fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
  fpga: dfl: add support for N3000 Nios private feature
  memory: dfl-emif: add the DFL EMIF private feature driver

 .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
 MAINTAINERS                                        |   3 +-
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
 drivers/fpga/dfl.c                                 |   4 +-
 drivers/fpga/dfl.h                                 |  85 +--
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   2 +
 drivers/memory/dfl-emif.c                          | 207 ++++++++
 include/linux/dfl.h                                |  86 +++
 include/linux/mod_devicetable.h                    |  24 +
 scripts/mod/devicetable-offsets.c                  |   4 +
 scripts/mod/file2alias.c                           |  13 +
 15 files changed, 1023 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 drivers/fpga/dfl-n3000-nios.c
 create mode 100644 drivers/memory/dfl-emif.c
 create mode 100644 include/linux/dfl.h

-- 
2.7.4

