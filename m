Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE6AC433ED
	for <linux-fpga@archiver.kernel.org>; Fri, 21 May 2021 01:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59719613AE
	for <linux-fpga@archiver.kernel.org>; Fri, 21 May 2021 01:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhEUBFa (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 20 May 2021 21:05:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:8071 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234754AbhEUBFa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 21:05:30 -0400
IronPort-SDR: 5Gvjak9R317aY0z+vOK9gjSLqgIAmzKTqwtZvoyOEV7K3R1DIF6HCDyi5bnsYmo9y8IwoqHbxf
 IMTvqRlqPQxg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="265286808"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="265286808"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 18:04:07 -0700
IronPort-SDR: LT6WZ0G985tf2QKgG7ftzmk9cw4TZzXXFREpujtH01leyDn7uz/RPtu1rR7U7PoSVgH4YyWCUQ
 tjUsiK5YfcXQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395120270"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.50.218])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 18:04:07 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 0/3] fpga: Use standard class dev_release function
Date:   Thu, 20 May 2021 18:03:56 -0700
Message-Id: <20210521010359.635717-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA framework has a convention of using managed resource
functions to allow parent drivers to manage the data structures
allocated by the class drivers. They use an empty *_dev_release()
function to satisfy the class driver.

This is inconsistent with linux driver model.

These changes remove the managed resource functions and populate
the class dev_release callback functions. They also merge the
create and register functions into a single register function for
each of the fpga-mgr, fpga-region, and fpga-bridge class drivers.

For more context, refer to this email thread:

https://marc.info/?l=linux-fpga&m=162127412218557&w=2

I turned on the configs assocated with each of the modified files,
but I must have been missing some dependencies, because not all
of them compiled. I did a run-time test specifically with the
dfl-fme infrastructure. This would have exercised the region,
bridge, and fpga-mgr frameworks.

- Russ

Russ Weight (3):
  fpga: mgr: Use standard dev_release for class driver
  fpga: bridge: Use standard dev_release for class driver
  fpga: region: Use standard dev_release for class driver

 drivers/fpga/altera-cvp.c           |  12 +-
 drivers/fpga/altera-fpga2sdram.c    |  12 +-
 drivers/fpga/altera-freeze-bridge.c |  10 +-
 drivers/fpga/altera-hps2fpga.c      |  12 +-
 drivers/fpga/altera-pr-ip-core.c    |   6 +-
 drivers/fpga/altera-ps-spi.c        |   8 +-
 drivers/fpga/dfl-fme-br.c           |  10 +-
 drivers/fpga/dfl-fme-mgr.c          |  10 +-
 drivers/fpga/dfl-fme-region.c       |  10 +-
 drivers/fpga/dfl.c                  |  10 +-
 drivers/fpga/fpga-bridge.c          | 113 ++++--------------
 drivers/fpga/fpga-mgr.c             | 177 ++++------------------------
 drivers/fpga/fpga-region.c          |  97 +++------------
 drivers/fpga/ice40-spi.c            |   8 +-
 drivers/fpga/machxo2-spi.c          |   8 +-
 drivers/fpga/of-fpga-region.c       |  10 +-
 drivers/fpga/socfpga-a10.c          |  16 +--
 drivers/fpga/socfpga.c              |   8 +-
 drivers/fpga/stratix10-soc.c        |  15 +--
 drivers/fpga/ts73xx-fpga.c          |   8 +-
 drivers/fpga/xilinx-pr-decoupler.c  |  17 +--
 drivers/fpga/xilinx-spi.c           |  10 +-
 drivers/fpga/zynq-fpga.c            |  16 +--
 drivers/fpga/zynqmp-fpga.c          |   8 +-
 include/linux/fpga/fpga-bridge.h    |  12 +-
 include/linux/fpga/fpga-mgr.h       |  14 +--
 include/linux/fpga/fpga-region.h    |  12 +-
 27 files changed, 150 insertions(+), 499 deletions(-)

-- 
2.25.1

