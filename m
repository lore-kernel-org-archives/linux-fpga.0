Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9AFC433E0
	for <linux-fpga@archiver.kernel.org>; Tue, 29 Dec 2020 02:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68162084D
	for <linux-fpga@archiver.kernel.org>; Tue, 29 Dec 2020 02:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgL2CsO (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 28 Dec 2020 21:48:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:65037 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgL2CsN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Dec 2020 21:48:13 -0500
IronPort-SDR: aDJ8DeEnIfLqplRLEmwTX9BUQf0LMXM2YYtdWKzHXn4ZEmk5zjcb/IHkDvTio3y0vxLrCfFwOU
 noai0X8pOlEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="261201854"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="261201854"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 18:47:33 -0800
IronPort-SDR: XmuIRH8sqgoJX1lt3JlZpu6BB7NAQXI3yiYSsVeiOz/Kx76z5vcyOC5pTi6zS56Oc0Okf5BPzl
 HmX4MIp/dtOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="343925934"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2020 18:47:31 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v4 0/2] UIO support for dfl devices
Date:   Tue, 29 Dec 2020 10:42:54 +0800
Message-Id: <1609209776-7296-1-git-send-email-yilun.xu@intel.com>
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

Xu Yilun (2):
  fpga: dfl: add the userspace I/O device support for DFL devices
  Documentation: fpga: dfl: Add description for DFL UIO support

 Documentation/fpga/dfl.rst  |  24 +++++++++++
 drivers/fpga/Kconfig        |  10 +++++
 drivers/fpga/Makefile       |   1 +
 drivers/fpga/dfl-uio-pdev.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

-- 
2.7.4

