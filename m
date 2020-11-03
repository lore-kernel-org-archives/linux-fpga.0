Return-Path: <SRS0=+SIS=EJ=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D516C2D0A3
	for <linux-fpga@archiver.kernel.org>; Tue,  3 Nov 2020 07:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29846223AB
	for <linux-fpga@archiver.kernel.org>; Tue,  3 Nov 2020 07:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604387663;
	bh=Juae7LCq45js6ajSp4+eHEOGFaoSr/8mPwSXI6dYVmM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=p6lg4l6zzeVqEpZZwAtvhlU835p555N2l+XA+49800lb6M6Lv/bHlEeGQvBIWSITG
	 FDLd4GTsyOQBMm2wGHjzTF6EldxCombChfQQtPh5/gLxnrPjp3WRoBTGhsVgA/Ban5
	 xpxaIha+qOr91ir6ALzCbB2eMHGORwWfQS7Pt8H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCHOW (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 3 Nov 2020 02:14:22 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:37928 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHOW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:22 -0500
Received: by mail-pf1-f175.google.com with SMTP id 10so13403539pfp.5
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwoiBsxdwhMxqeJfY+/kzbJPbrZcWeLLnwtCbiCVNBU=;
        b=AkPiIXHJOGNiNSXEIbXqMEXgcKSN/jVXTYhqUtTKWxHpr0Ik47uGjA1njPHC5rRCYc
         c52XeV+e4gSK8rFdBjeArsMHdrM4+kmcD+49AUbQW283QsjR/AvZlHI6rLTokLgRv2XK
         i4pUv7TW6qmlhqDNW7FPkTxYC1duXjJgTsSO4f6NRIj+tbQycS02bljo/qbAd0htyayJ
         ZTusnl+F3c3zhWHZczPi6CdRi2FC90FxlczEn2c+KQBysH7HU5PFvvcful1pj49R7DHO
         ZprXvgnluILKtPYw+lDefvkD4iHYu8g0T+GHrOJ061fODV/aGX+DK7GAVoSgL90r8cXd
         5PMg==
X-Gm-Message-State: AOAM533JDOhTw0p5dyRO+whEh8Kq1MI5GMmctnY5Y1976+ZJ5+NCy2T0
        RiAFqKp6+oQDWozXE/2C+TrqgNQKrA8=
X-Google-Smtp-Source: ABdhPJxcER/icAJg/3oHS7KcUEtvE7ZA3GzQ0ho8UXKEzwzMRpiKmBpkY7k/LZ+AmNnMuzReoRq3RQ==
X-Received: by 2002:a17:90a:f0c7:: with SMTP id fa7mr2438050pjb.3.1604387661917;
        Mon, 02 Nov 2020 23:14:21 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id w63sm17192689pfw.0.2020.11.02.23.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:21 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 00/10] Introduce devm_fpga_mgr_register() API
Date:   Mon,  2 Nov 2020 23:14:01 -0800
Message-Id: <20201103071411.11997-1-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

as requested this time as patchset.

This series introduces a new API that uses devres to simplify the
registration of FPGA Manager drivers and gets rid of the boilerplate
that gets repeated in every single driver.

Moritz Fischer (10):
  fpga: fpga-mgr: Add devm_fpga_mgr_register() API
  fpga: fpga-mgr: altera-ps-spi: Simplify registration
  fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
  fpga: fpga-mgr: ice40-spi: Simplify registration
  fpga: fpga-mgr: machxo2-spi: Simplify registration
  fpga: fpga-mgr: socfpga: Simplify registration
  fpga: fpga-mgr: ts73xx: Simplify registration
  fpga: fpga-mgr: xilinx-spi: Simplify registration
  fpga: fpga-mgr: zynqmp: Simplify registration
  fpga: fpga-mgr: altera-pr-ip: Simplify registration

 drivers/fpga/altera-pr-ip-core-plat.c | 10 ----
 drivers/fpga/altera-pr-ip-core.c      |  4 +-
 drivers/fpga/altera-ps-spi.c          | 14 +----
 drivers/fpga/dfl-fme-mgr.c            | 13 +----
 drivers/fpga/fpga-mgr.c               | 81 +++++++++++++++++++++++----
 drivers/fpga/ice40-spi.c              | 14 +----
 drivers/fpga/machxo2-spi.c            | 14 +----
 drivers/fpga/socfpga.c                | 14 +----
 drivers/fpga/ts73xx-fpga.c            | 14 +----
 drivers/fpga/xilinx-spi.c             | 14 +----
 drivers/fpga/zynqmp-fpga.c            | 21 +------
 include/linux/fpga/fpga-mgr.h         |  2 +
 12 files changed, 80 insertions(+), 135 deletions(-)

-- 
2.29.2

