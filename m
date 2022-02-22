Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7142FC433EF
	for <linux-fpga@archiver.kernel.org>; Tue, 22 Feb 2022 16:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiBVQoh (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiBVQof (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Feb 2022 11:44:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA4E1168D6
        for <linux-fpga@vger.kernel.org>; Tue, 22 Feb 2022 08:44:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B655B60F03
        for <linux-fpga@vger.kernel.org>; Tue, 22 Feb 2022 16:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD770C340E8;
        Tue, 22 Feb 2022 16:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645548249;
        bh=qBpRBz4d1S+ECBgYEzQmaUp431R/xprJcjVMCQMPt6M=;
        h=From:To:Cc:Subject:Date:From;
        b=ueB6kPDFwmsCA/9jcRBJaqW/bpj/XXu1tqMHV5YebwkBx3rF1aqN53cJn/oVfVsTP
         pm4ECU49vIxMA6I5dqkNhtbujUIS1KT9FLaMuVldqS+ly891lJ8gNL95tuz1o7M9EH
         LVQfUogUNI5p0XDlXDycKvr0uWSqnpkSQCP+IEsy/JrW9izwprKu8Q06Jehy3DcZ+j
         LQ7dmqXPQoTsxgcD9Bhjit3MZNe+RDoCpSZAHh4KjfWi7cwCLOpzuQQticzR2mSG6d
         AoPjCptitqeKBRwgY0i+yYxhuNPrc/r/35Htqs9rHc9Cs/Go5/gUj7d0ahHFha2umt
         u9VHdoDNwbNCg==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-fpga@vger.kernel.org
Subject: [GIT PULL] firmware: stratix10: updates for v5.18
Date:   Tue, 22 Feb 2022 10:44:07 -0600
Message-Id: <20220222164407.386381-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/stratix10_svc_updates_for_v5.18

for you to fetch changes up to 91e50169b52ed59272e675d0c1ea107a36c843da:

  firmware: stratix10-svc: extend SVC driver to get the firmware version (2022-02-17 06:20:43 -0600)

----------------------------------------------------------------
Stratix10 Service Driver for v5.18
- Update MAINTAINER's entry to include a git address
- Add feature to get firmware version

----------------------------------------------------------------
Dinh Nguyen (1):
      MAINTAINERS: add a git repo for the Stratix10 Service driver

Richard Gong (1):
      firmware: stratix10-svc: extend SVC driver to get the firmware version

 MAINTAINERS                                         |  1 +
 drivers/firmware/stratix10-svc.c                    |  9 ++++++++-
 include/linux/firmware/intel/stratix10-smc.h        | 21 +++++++++++++++++++--
 include/linux/firmware/intel/stratix10-svc-client.h |  4 ++++
 4 files changed, 32 insertions(+), 3 deletions(-)
