Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37CDC64E7A
	for <linux-fpga@archiver.kernel.org>; Tue, 24 Nov 2020 15:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747D5206FA
	for <linux-fpga@archiver.kernel.org>; Tue, 24 Nov 2020 15:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbgKXPzt (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:55:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:48016 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389934AbgKXPzt (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 24 Nov 2020 10:55:49 -0500
IronPort-SDR: Hg3YCddKYDxXMjGAHbOqoamFE5167ZvFT0n/hnR7F2I2EOdaSakruv3TzJBS82yOBdcc997jRs
 1Um9p8bxXJ1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159009676"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="159009676"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 07:55:43 -0800
IronPort-SDR: dgUbOEgPz8fFz6GulRm6TvgDxeQwc+GMEHe4GtKMrz7Vd5UIGU5RqTI4H48P+i7wQ2o1BpOhhO
 X5wxo90C1J2A==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="365051339"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 07:55:43 -0800
From:   matthew.gerlach@linux.intel.com
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 0/2] fpga: dfl: optional VSEC for start of dfl
Date:   Tue, 24 Nov 2020 07:56:56 -0800
Message-Id: <20201124155658.700976-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

The start of a Device Feature List (DFL) is currently assumed to be at
Bar0/Offset 0 on the PCIe bus by drivers/fpga/dfl-pci.c.  This patchset
adds support for the start one or more DFLs to be specified in a
Vendor-Specific Capability (VSEC) structure in PCIe config space.  If no
such VSEC structure exists, then the start is assumed to be
Bar0/Offset 0 for backward compatibility.

Matthew Gerlach (2):
  fpga: dfl: refactor cci_enumerate_feature_devs()
  fpga: dfl: look for vendor specific capability

 Documentation/fpga/dfl.rst |  25 ++++++
 drivers/fpga/dfl-pci.c     | 169 +++++++++++++++++++++++++++++--------
 2 files changed, 159 insertions(+), 35 deletions(-)

-- 
2.25.2

