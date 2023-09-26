Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3939BE7E650
	for <linux-fpga@archiver.kernel.org>; Tue, 26 Sep 2023 16:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjIZQkE (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 26 Sep 2023 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjIZQkC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 26 Sep 2023 12:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF912A
        for <linux-fpga@vger.kernel.org>; Tue, 26 Sep 2023 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=837Kme305+Qcb4evSQsWQExwLiy1HV1fTxRz6UFoLMg=;
        b=NYJp9qGNC1qo2uaJUGVa95kQulteflqTUFc26Rconu3UeeM4br1ZuVx/+FuSYDWytbZL/o
        GAoVBKiJMT0jhAPRjNf2RtHd8gPQsdpnTMuFD1naHcsbN4R3T/MZTgDgdXQAtzQIeYXeKH
        JtzJSsb3idNAUc/+ADEs9Kmu6Zoz43M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-gCf_3iNGOiquqf-PFv4Dbg-1; Tue, 26 Sep 2023 12:39:17 -0400
X-MC-Unique: gCf_3iNGOiquqf-PFv4Dbg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-405917470e8so46201245e9.1
        for <linux-fpga@vger.kernel.org>; Tue, 26 Sep 2023 09:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746356; x=1696351156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=837Kme305+Qcb4evSQsWQExwLiy1HV1fTxRz6UFoLMg=;
        b=tGCyO+hDtGfY0PhQcvIQwupDLeByk076Hp2+ciVFN0IE1uvclXMGAyfgUdg2H/cvBb
         FErf6/QP2ZKccZ7e0efpT8tnjDPoWwKMDIONrFCW1C3ReGMj31vthh5q1VgD6DkcXE+o
         qjKyRiFKZJxT2jAfWwGCZ4TLcUrJaNcrXxsAvKznax3XTNfX691r1zK3ZZlwsyxbCElA
         1CArPw+lenhU4YA8xy2VkoNyjrkqNYnJuiq/fxF0KUw+U6YgaoFtJnnyvoIqy8uy4irS
         SLicboMN7WkLiEKtOyhkRYXCz0GVtrybkV3jOXvN/G0IbUYhMbJS3URXxRWBuHkkOryv
         J7YA==
X-Gm-Message-State: AOJu0Yy0OA6z673tfZRM6jjuPyfOlQSGh2jJvhbvqXkBTTTTweisrtd2
        7FQNWD3n76/oxkASoc6Uwu401rrcSgl/76INPJeQ7J8ycrQxTaSHr6dTxTgezaRU+Y86uYbFBk5
        Qr/mtOXjRNeRWO32H74VA
X-Received: by 2002:a05:600c:3658:b0:405:359e:ee43 with SMTP id y24-20020a05600c365800b00405359eee43mr8949386wmq.1.1695746356070;
        Tue, 26 Sep 2023 09:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDq2Y03ww54+pIYPefZxQl9NkeQGLGMHlVqfNsz/9UH8/RNnXfpZ1pegaFQwZZdpw6zGn82Q==
X-Received: by 2002:a05:600c:3658:b0:405:359e:ee43 with SMTP id y24-20020a05600c365800b00405359eee43mr8949366wmq.1.1695746355754;
        Tue, 26 Sep 2023 09:39:15 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0031fba0a746bsm15171803wrl.9.2023.09.26.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:39:15 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH 0/4] fpga: add platform drivers to the FPGA KUnit test suites
Date:   Tue, 26 Sep 2023 18:39:07 +0200
Message-ID: <20230926163911.66114-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add and register minimal platform drivers associated with parent
platform devices used for testing to prevent a null-ptr-deref when
try_module_get() is called.

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

