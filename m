Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C66C11F67
	for <linux-fpga@archiver.kernel.org>; Tue, 29 Jun 2021 12:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC1E61D6E
	for <linux-fpga@archiver.kernel.org>; Tue, 29 Jun 2021 12:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhF2MO4 (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:14:56 -0400
Received: from first.geanix.com ([116.203.34.67]:56670 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232664AbhF2MO4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 08:14:56 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 738DD4C4646;
        Tue, 29 Jun 2021 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1624968745; bh=Ieku/xMW8rPVVbFGGisxb1nVKfATkxSaMnG/t2yjU8U=;
        h=From:To:Cc:Subject:Date;
        b=jkZnFmH56PDmNbVgkWnhz/CHkIfnF2BU9pexiMj87nn0GIXXT239rVNfk+dhB51gm
         zMqVcv4zKd7wN1DuBhVY6hQZS93BVtaJgzXEHlau3hWQU3SNj/5qdbIAx6Rh7eLsLl
         ALyemIyOSgZu94HVq/8HELV3zTDCXO4hSDrOimypJKxS2+rMieWk9ZibSPTEGQOz8o
         hMfatzLkbZgyVkZfxVEJM1IijBlxgtPORithFmsQnTB+A1x/fBCndx3aonNNqpW1dz
         ywRmITZ0tBtCuGdMoX8Q6e4cUgu7chfzx1EaFszg/3EjEDk0wdsMtEkROBzR3Pbldf
         07PAv+1KdzH6w==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 0/4] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC
Date:   Tue, 29 Jun 2021 14:12:10 +0200
Message-Id: <20210629121214.988036-1-martin@geanix.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Martin Hundebøll <mhu@silicom.dk>

This is an initial set of patches for the Silciom N5010 programmable
accelerated card adding support for reading out sensors.

Based on v5.13

Changes since v2:
 * Removed patch 1/5 from v2 already in fpga/for-next
 * Reworded commit message in patch 1/4 as per Hao's suggestion
 * Added Yilun's Reviewed-by to patch 3/4 and 4/4
 * Added Moritz' Acked-by to patch 3/4
 * Added Moritz' Reviewed-by to patch 4/4
 * Added Guenter's Reviewed-by to patch 4/4

Changes since v1:
 * Commit message in patch 1 is updated with card description
 * Added Hao's Acked-by to patch 1
 * Patch 2 is replaced with a new patch to carry feature revision info
   in struct dfl_device
 * Patch 3 is updated to use feature revision from struct dfl_device
 * Patch 4 from v0 is split into separate patches for hwmon and mfd

Martin Hundebøll (4):
  fpga: dfl: expose feature revision from struct dfl_device
  spi: spi-altera-dfl: support n5010 feature revision
  mfd: intel-m10-bmc: add n5010 variant
  hwmon: intel-m10-bmc-hwmon: add n5010 sensors

 drivers/fpga/dfl.c                  |  27 ++++---
 drivers/fpga/dfl.h                  |   1 +
 drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c         |  12 ++-
 drivers/spi/spi-altera-dfl.c        |  15 +++-
 include/linux/dfl.h                 |   1 +
 6 files changed, 159 insertions(+), 13 deletions(-)

-- 
2.31.0

