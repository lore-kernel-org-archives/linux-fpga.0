Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503DAC04A6A
	for <linux-fpga@archiver.kernel.org>; Tue,  8 Aug 2023 16:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjHHQYM (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHHQWw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Aug 2023 12:22:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94DA266
        for <linux-fpga@vger.kernel.org>; Tue,  8 Aug 2023 08:49:31 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKtz46Y1JztS0d;
        Tue,  8 Aug 2023 21:17:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 21:21:20 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <linux-fpga@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 0/2] fpga: Remove redundant of_match_ptr()
Date:   Tue, 8 Aug 2023 21:20:47 +0800
Message-ID: <20230808132049.4081910-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

It is not necessary for the drivers which depend on CONFIG_OF
to use of_match_ptr(), so remove them.

Changes in v2:
 - Add cover letter commit title prefix.

Ruan Jinjie (2):
  fpga: ice40-spi: Remove redundant of_match_ptr()
  fpga: fpga-region: Remove redundant of_match_ptr()

 drivers/fpga/ice40-spi.c      | 2 +-
 drivers/fpga/of-fpga-region.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

