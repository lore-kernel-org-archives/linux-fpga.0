Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700B2C433FE
	for <linux-fpga@archiver.kernel.org>; Thu, 10 Dec 2020 16:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C70221E3
	for <linux-fpga@archiver.kernel.org>; Thu, 10 Dec 2020 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392368AbgLJQ7F (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 10 Dec 2020 11:59:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38505 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392087AbgLJQ64 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Dec 2020 11:58:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id d2so4665555pfq.5
        for <linux-fpga@vger.kernel.org>; Thu, 10 Dec 2020 08:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNydWKaKuUuSwCwEbp8L1L8WddzPHJ6xq9pqLxMcY28=;
        b=mmfilsOiE5o5f0GVrtjR6vjGzUNZxwuC4YqIK8LVjs88C0JrKhE9i5GQkX9t9Lqn2u
         k981CYq/wT2qLtLJiGkkK6WNaSbEYa+J6LAmAR8KY2JaMkvNhBufuO7AM6NQ92EXmVCl
         rlrIA2eF1k9+yu6okHgr045vkGzN63UII9hxy5dhRKcuLiTCfBlK/4VCGCTWh7IjOiVK
         KGK9TsvvEleImoJvGFgWQseYztWvRWgb6mCJbB4ncf9CaQQsbf2h5pgCUVr5x9LvHDQc
         82Xzmd03r1SJ/krkIJEg9Z6Oc96/Iq51ZP7LVC/pwVd9gIOhIqC3GmxXKwHz53x6SAzd
         s7tQ==
X-Gm-Message-State: AOAM532KqR03Rt2/mouWOa4JPShUMu1hVcXh4rcisxGTFtX08ycFKMmJ
        jwSJbU5c6BlKZZrac5W5mFFVJZnTfTwosQ==
X-Google-Smtp-Source: ABdhPJxcylxFjKxhvA7f+NF5IaTDa5QDLlgjkAu0zo+jEtkuWwB1VE7WUHoGDwoU+3TEy/m4yB4thQ==
X-Received: by 2002:a63:e150:: with SMTP id h16mr7560857pgk.390.1607619495618;
        Thu, 10 Dec 2020 08:58:15 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id x1sm7150367pfj.95.2020.12.10.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:58:14 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/8] FPGA DFL Changes for 5.11
Date:   Thu, 10 Dec 2020 08:57:56 -0800
Message-Id: <20201210165804.44234-1-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

here are some (late) changes for DFL for 5.11.

Matthew's set adds support for locating DFL lists using a vendor
specific extended capability (similar to MSIX bar indicators).

Xu's set now hopefully addressed the outstanding comments to support
DFL as a bus. The first user is the dfl-emif driver that was ack'd by
Krzysztof already (he suggested to take it through DFL tree).

Thanks,
Moritz

Matthew Gerlach (2):
  fpga: dfl: refactor cci_enumerate_feature_devs()
  fpga: dfl-pci: locate DFLs by PCIe vendor specific capability

Xu Yilun (6):
  fpga: dfl: fix the definitions of type & feature_id for dfl devices
  fpga: dfl: move dfl_device_id to mod_devicetable.h
  fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
  fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
  fpga: dfl: add support for N3000 Nios private feature
  memory: dfl-emif: add the DFL EMIF private feature driver

 .../ABI/testing/sysfs-bus-dfl-devices-emif    |  25 +
 .../testing/sysfs-bus-dfl-devices-n3000-nios  |  47 ++
 Documentation/fpga/dfl.rst                    |  27 +
 MAINTAINERS                                   |   3 +-
 drivers/fpga/Kconfig                          |  11 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/dfl-n3000-nios.c                 | 588 ++++++++++++++++++
 drivers/fpga/dfl-pci.c                        | 165 +++--
 drivers/fpga/dfl.c                            |   4 +-
 drivers/fpga/dfl.h                            |  85 +--
 drivers/memory/Kconfig                        |   9 +
 drivers/memory/Makefile                       |   2 +
 drivers/memory/dfl-emif.c                     | 207 ++++++
 include/linux/dfl.h                           |  86 +++
 include/linux/mod_devicetable.h               |  24 +
 scripts/mod/devicetable-offsets.c             |   4 +
 scripts/mod/file2alias.c                      |  13 +
 17 files changed, 1180 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 drivers/fpga/dfl-n3000-nios.c
 create mode 100644 drivers/memory/dfl-emif.c
 create mode 100644 include/linux/dfl.h

-- 
2.29.2

