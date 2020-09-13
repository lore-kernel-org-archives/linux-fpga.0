Return-Path: <SRS0=q52o=CW=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F996C433E2
	for <linux-fpga@archiver.kernel.org>; Sun, 13 Sep 2020 22:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB6720672
	for <linux-fpga@archiver.kernel.org>; Sun, 13 Sep 2020 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600037731;
	bh=5I9FAYGepIo4oLUpeHAoFVIwg81URMrAPHYDT0jAaMc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=N07xE5xBS4bx8jItgoPA0aJmPYuoHCsn4N3Ns7v/Va9fkl8suMHuLuVX3teWTCzAi
	 i3y0/4j7qkHoFR6RmQhnGfh9CzOdk4wjtrN/Go5op4vFp0VKisS+VbTLwueo5IlRlt
	 H98mzndgC2PUXqlo5DQmpWafAxoz6HX/iSwsjx8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgIMWza (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sun, 13 Sep 2020 18:55:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39158 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgIMWz3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Sep 2020 18:55:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id n14so10959242pff.6
        for <linux-fpga@vger.kernel.org>; Sun, 13 Sep 2020 15:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3vQEcWOUFnv90b4X3VXdMpxZImrbOiN/6e6MmvGcjwc=;
        b=Fg0JCLMovXh4kHlUrj5LJA/6YM+pk/eH/8kNrRDgi7YhHmuRC62r0+DN/pKb5qu3yy
         Q0e1ye6NCLLCYXAMdiZXnZXPqPIbugcUe7EYhocdR6bgtYcues91Z7k70FEQaGfnjt0h
         66MAs69QKSsGyXOka05pVPToAagqGL438alQ7iIchAngbPhRYM/J9n/MGxWb3A9pZVja
         cNQrwg8yWhe1hQMUsr/G6XZjCeDHaAq+pqp3RK4ILUS3gbP9tCSInjnm/z9DrBwkffNE
         OEg9aZgtIMtuR0t2yqSEbVPTy75Gk5A+68U/a5xjYXLyHeof2nQBhH7ilG+QECjh1wA2
         ObMg==
X-Gm-Message-State: AOAM530mYQyYWmbdqBIlSMx2auJTCjI5fYkxgws/lsKjdm9C7WkcrXM/
        xa54FMvMPl/ZbNQWbFzFfMQ=
X-Google-Smtp-Source: ABdhPJyGpwYWljSylYhwXqxv828b6htXOjmQ1mPACT5IURyJXZguk0TEJcqELWDHlkQQ/4QAfavuJA==
X-Received: by 2002:aa7:971a:: with SMTP id a26mr6126828pfg.0.1600037728848;
        Sun, 13 Sep 2020 15:55:28 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id h14sm8643729pfe.67.2020.09.13.15.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 15:55:28 -0700 (PDT)
Date:   Sun, 13 Sep 2020 15:55:26 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager changes for 5.10
Message-ID: <20200913225526.GA52103@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.10

for you to fetch changes up to 9ba3a0aa09fe505540a3bdd11f0da3b8e9d73055:

  fpga: dfl: create a dfl bus type to support DFL devices (2020-09-09 20:28:16 -0700)

----------------------------------------------------------------
Here is the first set of changes for the 5.10-rc1 merge window.

Xilinx:
- Luca's changes clean up the xilinx-spi driver and add better
  diagnostics on errors.

Core:
- I cleaned up a stray comment.
- Richard's change marks FPGA manager tasks un-interruptible.
- Tom has agreed to help out as Reviewer in the FPGA Manager subsystem.

DFL:
- Xu's changes  add a new bus that is the first part of a series to support
  adding devices via DFL (the other parts are still under review)

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Luca Ceresoli (5):
      fpga manager: xilinx-spi: remove stray comment
      fpga manager: xilinx-spi: remove final dot from dev_err() strings
      fpga manager: xilinx-spi: fix write_complete timeout handling
      fpga manager: xilinx-spi: add error checking after gpiod_get_value()
      fpga manager: xilinx-spi: provide better diagnostics on programming failure

Moritz Fischer (1):
      fpga: fpga-region: Cleanup an outdated comment

Richard Gong (1):
      fpga: stratix10-soc: make FPGA task un-interruptible

Tom Rix (1):
      MAINTAINERS: Add Tom Rix as fpga reviewer

Xu Yilun (3):
      fpga: dfl: change data type of feature id to u16
      fpga: dfl: map feature mmio resources in their own feature drivers
      fpga: dfl: create a dfl bus type to support DFL devices

 Documentation/ABI/testing/sysfs-bus-dfl |  15 +
 MAINTAINERS                             |   3 +
 drivers/fpga/dfl-fme-perf.c             |   2 +-
 drivers/fpga/dfl-pci.c                  |  24 +-
 drivers/fpga/dfl.c                      | 477 ++++++++++++++++++++++++++------
 drivers/fpga/dfl.h                      | 103 ++++++-
 drivers/fpga/fpga-region.c              |   2 +-
 drivers/fpga/stratix10-soc.c            |  23 +-
 drivers/fpga/xilinx-spi.c               |  77 ++++--
 9 files changed, 583 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
