Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A939EC48BDF
	for <linux-fpga@archiver.kernel.org>; Fri, 18 Jun 2021 22:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8689361287
	for <linux-fpga@archiver.kernel.org>; Fri, 18 Jun 2021 22:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFRWsh (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:48:37 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:41749 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhFRWsg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Jun 2021 18:48:36 -0400
Received: by mail-pg1-f179.google.com with SMTP id u190so5215583pgd.8;
        Fri, 18 Jun 2021 15:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyk0m331SzyCY0qmdzyivTVyPifLLHmM9to/9j0QGhU=;
        b=AT0ksK1jtTKczwLGPjzuHXzoomqcfQRkSsPWYFzDw6WztJQeayi7Gky9HORFl/UFaa
         XtLi67MjBjv7RN3Ttt6P2nm1DIHXM3dqlyqMykwrSWlh9FqD0XeShid5mBdUFqmkJT+e
         Ip5Lp2WkwG7eI5Iy2WYeTAyD4UXJGAmA2rZQNVe3ZIS/OILl74h/XllBVfXR3NmGpZey
         1aTeD4OI28iaSHGwyXwXmE9w39U7EOm9fJIvRZAHtrS521AoTSz3KJVchuwcGr9Pmx5K
         n1jv8VYOk2ZlWBVLy9w5JQzdrWHLTXkoxrY8qzS+ty3WeMAuNV9iN1Z2wFc8/4Jcx4kq
         aezg==
X-Gm-Message-State: AOAM531tNmLYe8TjSAxJE2e5oGRAIaEsS58TwiqvtbkMHHBhJEaJdEyW
        Y/Cz5YuXgvUrq2RSJIW+PTG747mnyCyXyg==
X-Google-Smtp-Source: ABdhPJytVrp3HqR0qqc6CcucrfRb/siW0NQUlHepEpNsW0dWQr3cccE62AvgDE/SXW1KI3CCViVlDQ==
X-Received: by 2002:a63:34a:: with SMTP id 71mr7801632pgd.305.1624056385206;
        Fri, 18 Jun 2021 15:46:25 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id h20sm8964015pfq.83.2021.06.18.15.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:46:24 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] fpga: machxo2-spi: Address warning about unused variable
Date:   Fri, 18 Jun 2021 15:46:18 -0700
Message-Id: <20210618224618.1487323-1-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Address warning about unused variable in case CONFIG_OF is not set.

warning: unused variable 'of_match' [-Wunused-const-variable]
    static const struct of_device_id of_match[] = {

Fixes: 88fb3a002330 ("fpga: lattice machxo2: Add Lattice MachXO2
support")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tom Rix <trix@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/machxo2-spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 114a64d2b7a4..1afb41aa20d7 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -374,11 +374,13 @@ static int machxo2_spi_probe(struct spi_device *spi)
 	return devm_fpga_mgr_register(dev, mgr);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id of_match[] = {
 	{ .compatible = "lattice,machxo2-slave-spi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_match);
+#endif
 
 static const struct spi_device_id lattice_ids[] = {
 	{ "machxo2-slave-spi", 0 },
-- 
2.32.0

