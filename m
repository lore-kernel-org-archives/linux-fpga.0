Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC255C43217
	for <linux-fpga@archiver.kernel.org>; Mon, 16 May 2022 23:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349226AbiEPXtv (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 16 May 2022 19:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbiEPXtu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 16 May 2022 19:49:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182DC41632;
        Mon, 16 May 2022 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652744987; x=1684280987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C0wuLfmuidoelOjih+JbLTyUs/xz5Dgrdv22ImXK0X0=;
  b=MJ5M/NCs1oX0kqQ/jTe3V2SGRNmb9LcXc82h/cXodYired4V0sFFb73Y
   TYn4w6k8MuFciCxijZHjdcLM/ClkJCw/ilVBJgMQOdVSCzyrvxWseRdgi
   kbd675+1lCcrAyj1kZnfEh1Ltm484Kj7FYSHFU0s1oSOeTV8UhxzUpXEP
   mPJaWfqDmsvyL7iBnXXAnQSFung6O5nblaIdaFFFH1iXvsNRScZrtpb3J
   aClggCTVhmwD93472mcdJBwqRM3O7NRP6TVGI5Ynu3aGuRKU01Z/F7z5K
   H3ySF5WTRJlVtW/xRsHU6Fmn9i9SDaGdjk8j4xVT0zooOlP46jg6hqqJZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="357408345"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="357408345"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 16:49:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="522688208"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.36.153])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 16:49:46 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v20 1/5] mfd: intel-m10-bmc: Rename n3000bmc-secure driver
Date:   Mon, 16 May 2022 16:49:37 -0700
Message-Id: <20220516234941.592886-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516234941.592886-1-russell.h.weight@intel.com>
References: <20220516234941.592886-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The n3000bmc-secure driver has changed to n3000bmc-sec-update. Update
the name in the list of the intel-m10-bmc sub-drivers.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v20:
  - No change
v19:
  - No change
v18:
  - No change
v17:
  - This is a new patch to change in the name of the secure update
    driver.
---
 drivers/mfd/intel-m10-bmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 8db3bcf5fccc..f4d0d72573c8 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -26,7 +26,7 @@ static struct mfd_cell m10bmc_d5005_subdevs[] = {
 static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
 	{ .name = "n3000bmc-hwmon" },
 	{ .name = "n3000bmc-retimer" },
-	{ .name = "n3000bmc-secure" },
+	{ .name = "n3000bmc-sec-update" },
 };
 
 static struct mfd_cell m10bmc_n5010_subdevs[] = {
-- 
2.25.1

