Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B87C433F5
	for <linux-fpga@archiver.kernel.org>; Tue, 22 Feb 2022 16:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiBVQ2a (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiBVQ23 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Feb 2022 11:28:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6621314A6FF
        for <linux-fpga@vger.kernel.org>; Tue, 22 Feb 2022 08:28:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 026B46097C
        for <linux-fpga@vger.kernel.org>; Tue, 22 Feb 2022 16:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6A5C340E8;
        Tue, 22 Feb 2022 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547283;
        bh=7Dn758XtAJt5e4rHtmcsorNbZls2k19V3H/zn/fERBI=;
        h=From:To:Cc:Subject:Date:From;
        b=CfpbTHuN6Atgwacf++FJP6DYqNOLJYg1BFoFpgqS0HvzX3bfCht93bE2kxSwSXbPB
         q+Is1q8H/3VtLVSNorREpoqb7+otCxP/tWAwz0UCTFOEFwpJ4+xJeM1LsRhYoGnghm
         HhgGuhtrwD14yy6lQN11i8mIpKMjNxqWYTPrc61XZ1xLk3Qd76NPzkQTZ6uf6w4jrj
         mXixbQprb+MZHRvFEk/2NjP1cMeubVVy05kbDf3QrLzcXnfDAFndMC+TKFQ3Kkfoye
         KF/xbi81lFuwa+vqtMb8Ly+FIKcIwlamgwwj8J4fyrqTwv2tLgD9CLZjvzEOHoFdS7
         snoEKbgwispRQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-fpga@vger.kernel.org
Subject: [GIT PULL] firmware: stratix10: fix for v5.17
Date:   Tue, 22 Feb 2022 10:28:01 -0600
Message-Id: <20220222162801.385838-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/stratix10_svc_fix_v5.17

for you to fetch changes up to 41a069ab421a9540f75314d3e1bfe5fec6bfdf9f:

  firmware: stratix10-svc: add missing callback parameter on RSU (2022-02-17 06:05:42 -0600)

----------------------------------------------------------------
Stratix10 Service Driver fix for v5.17
- Add a missing callback parameter

----------------------------------------------------------------
Ang Tien Sung (1):
      firmware: stratix10-svc: add missing callback parameter on RSU

 drivers/firmware/stratix10-svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
