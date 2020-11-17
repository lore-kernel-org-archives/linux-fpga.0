Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F29C64E75
	for <linux-fpga@archiver.kernel.org>; Tue, 17 Nov 2020 01:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A8524692
	for <linux-fpga@archiver.kernel.org>; Tue, 17 Nov 2020 01:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgKQBYm (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:24:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:34910 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbgKQBYl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 20:24:41 -0500
IronPort-SDR: 0Ey+jwTV14flv/wZALKcnX1xVr71KKOZTazLM2srUy6feXlh+bwZGCm4HBZD2xBHvYfZerIy2q
 TUTQiTsbd6Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="234994417"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="234994417"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 17:24:36 -0800
IronPort-SDR: eq8Jk1xxVewgG/mOeWuAVxYJH+D6addsIAIPYPO9H9kkgKj+yejwZzQVpZJl9bxAOzKgll9GbJ
 ulNiGxk9SVOw==
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="310060646"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 17:24:36 -0800
From:   matthew.gerlach@linux.intel.com
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 0/2] fpga: dfl: optional VSEC for start of dfl
Date:   Mon, 16 Nov 2020 17:25:50 -0800
Message-Id: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

The start of a Device Feature List (DFL) is currently assumed to be at
Bar0/Offset 0 on the PCIe bus by drivers/fpga/dfl-pci.c.  This patchset
adds support for the start of one or more DFLs to be specified in a
Vendor-Specific Capability (VSEC) structure in PCIe config space.  If no
such VSEC structure exists, then the start of the DFL is assumed to be 
Bar0/Offset 0 for backward compatibility.

Matthew Gerlach (2):
  fpga: dfl: refactor cci_enumerate_feature_devs()
  fpga: dfl: look for vendor specific capability

 Documentation/fpga/dfl.rst |  10 +++
 drivers/fpga/dfl-pci.c     | 168 +++++++++++++++++++++++++++++--------
 2 files changed, 143 insertions(+), 35 deletions(-)

-- 
2.25.2

