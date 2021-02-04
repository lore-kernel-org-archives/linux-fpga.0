Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC97C433E0
	for <linux-fpga@archiver.kernel.org>; Thu,  4 Feb 2021 02:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72D264F60
	for <linux-fpga@archiver.kernel.org>; Thu,  4 Feb 2021 02:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhBDCFd (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Wed, 3 Feb 2021 21:05:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:31705 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232681AbhBDCFc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Feb 2021 21:05:32 -0500
IronPort-SDR: RFg7UnBno2j87gagdrHVhTiVS9bejdk1w1ZPJv5E8VRSd2kCnLQnGg4O6K0sAzp7HLMb4oc93i
 OUt5ZmFwnqmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168264080"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="168264080"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 18:04:39 -0800
IronPort-SDR: hfJ4ju+Fbv0i6dyLtmH7og+UUv1OyTsUKdRIwTmI2r9MjSuhZqVoeNQg0YMFZ0N8+Shy11HE2K
 CNsnoEf4znzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="433713730"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2021 18:04:37 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v11 0/2] UIO support for dfl devices
Date:   Thu,  4 Feb 2021 09:59:29 +0800
Message-Id: <1612403971-13291-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset supports some dfl device drivers written in userspace.

In the patchset v1, the "driver_override" interface should be used to bind
the DFL UIO driver to DFL devices. But there is concern that the 
"driver_override" interface is not OK itself.

In v2, we use a new matching algorithem. The "driver_override" interface
is abandoned, the DFL UIO driver matches any DFL device which could not be
handled by other DFL drivers. So the DFL UIO driver could be used for new 
DFL devices which are not supported by kernel. The concern is the UIO may 
not be suitable as a default/generic driver for all dfl features, such as
features with multiple interrupts.

In v4, we specify each matching device in the id_table of the UIO driver,
just the same as other dfl drivers do. Now the UIO driver supports Ether
Group feature. To support more DFL features, their feature ids should be
added to the driver's id_table.

Before v9, we create a "uio_pdrv_genirq" platform device using DFL devices'
resources. Then we leverage the uio_pdrv_genirq driver for UIO support. It
is suggested that we implement a driver in drivers/uio that directly calls
UIO framework APIs. So we implement the uio_dfl driver in v9. The driver
now only binds the ether group feature, which has no irq. So the irq 
support is not implemented yet.


Main changes from v1:
- switch to the new matching algorithem. It matches DFL devices which could
  not be handled by other DFL drivers.
- refacor the code about device resources filling.
- add the documentation.

Main changes from v2:
- split the match ops changes in dfl.c to an independent patch.
- move the declarations needed for dfl-uio-pdev from include/linux/dfl.h
  to driver/fpga/dfl.h
- some minor fixes.

Main changes from v3:
- switch to specifying each matching device in the driver's id_table.
- refactor the irq handling code.

Main changes from v4:
- refactor the irq handling code.

Main changes from v5:
- fix the res[] zero initialization issue.
- improve the return code for probe().
- some doc improvement.

Main changes from v6:
- use platform_device_register_resndata() for pdev creation.

Main changes from v7:
- some doc fixes.

Main changes from v8:
- switch to add a uio driver in drivers/uio

Main changes from v9:
- add this source file in MAINTAINERS
- improve the Kconfig, add more descriptive Kconfig header, add detailed
  path for opae uio example in Kconfig.

Main changes from v10:
- add description in doc that interrupt support is not implemented yet.


Xu Yilun (2):
  uio: uio_dfl: add userspace i/o driver for DFL bus
  Documentation: fpga: dfl: Add description for DFL UIO support

 Documentation/fpga/dfl.rst | 26 ++++++++++++++++++
 MAINTAINERS                |  1 +
 drivers/uio/Kconfig        | 17 ++++++++++++
 drivers/uio/Makefile       |  1 +
 drivers/uio/uio_dfl.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+)
 create mode 100644 drivers/uio/uio_dfl.c

-- 
2.7.4

