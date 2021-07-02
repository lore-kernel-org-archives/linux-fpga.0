Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E06C11F68
	for <linux-fpga@archiver.kernel.org>; Fri,  2 Jul 2021 03:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7055B613DC
	for <linux-fpga@archiver.kernel.org>; Fri,  2 Jul 2021 03:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhGBD5A (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 1 Jul 2021 23:57:00 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:43652 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhGBD47 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Jul 2021 23:56:59 -0400
Received: by mail-pj1-f43.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso5322316pjp.2;
        Thu, 01 Jul 2021 20:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5CA1i7yw1a1ABa+ibcYBfFgYiicSGZeFE2pafaaN5g=;
        b=siYyTJluULJrwarYyLkqak1QAv7iLM2kHJ910zBQ2jnR/MNyhoHzmfReN9ws1vnJWK
         l1ignKT/qVwqILprErGUqvEeSG64cCAfqIpPllAsjxACwQejCo5XwTc02FNmrISFHN6S
         zOoDA0VGK/IoeX4RXbPDcLytFrKhcsTQ6dL/cOtm9uOc1dUklSOsRvwLraWxzcNkFaFf
         TqPmd80R5uYPjnsTU7HWgJkzZbUy62+bfTD+o8SApmH/hpozihCeOnM6nWiaEI/Ow/L1
         WD8eiubGgCQxTwpfUVfjpc2t8/i3snsUHiSFMOKQRiRuYuJNq79gPJrNx75dRbfeLoYc
         r0aA==
X-Gm-Message-State: AOAM530vsxoXJqr9HbhlExVTyt1EBBmtiHKm9iOTVOuRjIGFMjz0uluX
        BXTwFs2Zydd3qke9WmJ+Iwq6pU9D0T58vg==
X-Google-Smtp-Source: ABdhPJwaaFI+oPipvWs706BwSy/WiashZHKW04k5g6bxVI2DQIK1Z9AERm6PAT4otnTWLy5EuWHqrw==
X-Received: by 2002:a17:90a:7f02:: with SMTP id k2mr2852120pjl.134.1625198066375;
        Thu, 01 Jul 2021 20:54:26 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 10sm326632pjc.41.2021.07.01.20.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 20:54:25 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/4] FPGA Manager address unused variable warnings
Date:   Thu,  1 Jul 2021 20:54:00 -0700
Message-Id: <20210702035404.397853-1-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset addresses a handful of warnings as result of_match_ids
being not properly wrapped in #ifdef CONFIG_OF.

Moritz Fischer (4):
  fpga: altera-freeze-bridge: Address warning about unused variable
  fpga: xiilnx-spi: Address warning about unused variable
  fpga: xilinx-pr-decoupler: Address warning about unused variable
  fpga: zynqmp-fpga: Address warning about unused variable

 drivers/fpga/altera-freeze-bridge.c | 2 ++
 drivers/fpga/xilinx-pr-decoupler.c  | 2 ++
 drivers/fpga/xilinx-spi.c           | 2 ++
 drivers/fpga/zynqmp-fpga.c          | 3 ++-
 4 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.32.0

