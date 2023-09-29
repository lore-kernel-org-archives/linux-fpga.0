Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2114FE71D4F
	for <linux-fpga@archiver.kernel.org>; Fri, 29 Sep 2023 15:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjI2PWB (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Fri, 29 Sep 2023 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjI2PWA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Sep 2023 11:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C56DE
        for <linux-fpga@vger.kernel.org>; Fri, 29 Sep 2023 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696000873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2RjG0vxzlp2XNSTnbZsP+fW84/NpvbH3AB72ShSUKnA=;
        b=YrzMu4JroeReKpcJLhGdun5HpNWfXD3sAZQV6Os3XWlK5iLctmzPwCGMOz5G5XycN1k0zl
        1XQEGu/+jA3ac4qKR1k1JIIcKDqEkyDu7Lv5I9gXszsumCfAjWk/qZB4yEqTeWx4Lj+mN5
        uMYKNDpwnIiHQ3+1H3ftUN1KjYp3dMw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-wGOjTUw_OrW72CGo6qzvrA-1; Fri, 29 Sep 2023 11:21:11 -0400
X-MC-Unique: wGOjTUw_OrW72CGo6qzvrA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4195a70269eso79192301cf.3
        for <linux-fpga@vger.kernel.org>; Fri, 29 Sep 2023 08:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000870; x=1696605670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RjG0vxzlp2XNSTnbZsP+fW84/NpvbH3AB72ShSUKnA=;
        b=c+tH552cq5we/kM2Ycv5jytQmo0amPcjItYQwpUVljf81lsJLIxbOi+NgAlc3chN/y
         /ECEXif9FdVpD9A6mnJov6+zz2pYQxvvLi16yJ707w14hJaw0wwG/M/X+Hvtjn2AQk+P
         2EBmrYtvJYAS6dVUNRn8gOhCqdf4HOpBuMahJbYKLKe4cpDl5KhycXS9bD/2eMFEG+so
         Ptczuutrm5WrC0ubek96KRs9FwnzFvMU6kcaTk5V7M9EMKSoWII1gTcGlu8J+MdEqXSE
         9QuhpZZx0jOXPr09MGmfVo3ShK52WoiC5qyKtrwAfOpFzO6AXjdnpXtxk1TEpUjcbbXk
         3C3g==
X-Gm-Message-State: AOJu0YxrXT0QcG2R4f430odMOmEelN+J3Jk3Su768VFEqBt7SiLF7Mwm
        mwLgYTiuoIP11ShtjtifdnHNGAWZ4qJ5vzOiIrtD3QFnew7pGVX6VtD9kVJAe38djY9utCE6jYC
        UjLKnubMAopu+FHv95wUK
X-Received: by 2002:ac8:57c7:0:b0:419:53ce:3fa9 with SMTP id w7-20020ac857c7000000b0041953ce3fa9mr5832303qta.53.1696000870691;
        Fri, 29 Sep 2023 08:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN1zu4gWKrOid0K633sP55/uvJCk4Eh5nH/sEFDbbakhFkC4oZ5JKl9fj1A+P1+6qWn8xKGw==
X-Received: by 2002:ac8:57c7:0:b0:419:53ce:3fa9 with SMTP id w7-20020ac857c7000000b0041953ce3fa9mr5832288qta.53.1696000870476;
        Fri, 29 Sep 2023 08:21:10 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05622a1c0e00b00419801b1094sm287053qtb.13.2023.09.29.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:21:10 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v2 0/4] fpga: add platform drivers to the FPGA KUnit test suites
Date:   Fri, 29 Sep 2023 17:20:53 +0200
Message-ID: <20230929152057.85047-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add and register minimal platform drivers associated with parent
platform devices used for testing to prevent a null-ptr-deref when
try_module_get() is called.

v2:
- Renamed include guard symbol in fpga-test-helpers.h

Marco Pagani (4):
  fpga: add helpers for the FPGA KUnit test suites.
  fpga: add a platform driver to the FPGA Manager test suite
  fpga: add a platform driver to the FPGA Bridge test suite
  fpga: add a platform driver to the FPGA Region test suite

 drivers/fpga/tests/fpga-bridge-test.c  | 18 +++++++++++++++-
 drivers/fpga/tests/fpga-mgr-test.c     | 18 +++++++++++++++-
 drivers/fpga/tests/fpga-region-test.c  | 26 ++++++++++++++++++-----
 drivers/fpga/tests/fpga-test-helpers.h | 29 ++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 7 deletions(-)
 create mode 100644 drivers/fpga/tests/fpga-test-helpers.h


base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.41.0

