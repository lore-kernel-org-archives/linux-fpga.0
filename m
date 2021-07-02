Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCD3C11F68
	for <linux-fpga@archiver.kernel.org>; Fri,  2 Jul 2021 03:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C19E613DC
	for <linux-fpga@archiver.kernel.org>; Fri,  2 Jul 2021 03:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhGBD5C (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 1 Jul 2021 23:57:02 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46684 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhGBD5B (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Jul 2021 23:57:01 -0400
Received: by mail-pg1-f182.google.com with SMTP id w15so8298025pgk.13;
        Thu, 01 Jul 2021 20:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3Q/oGarGE0OSC3blf6lQh6A8ZkcZCt6LuU3JGX2w/I=;
        b=g3dv2r2Uc3LfUWeIlSfeRQomsWAkVPCb1K9xLiYn25TwCnlYixjNk4an5Oj6DOLgNR
         //0ERS5oRaQv+Dv4aEFIdIhfTGpxOqWG/pMnoyLG1k1UaWMkxwexDEWqbY3ASykbPelb
         UTPx1l9W0+ffnD5ygrrv8OwVyUZsHv63bptgvROW6KN3JQoxHNw1U/Jz9iU3PqQ8hArj
         JGCgmD8w80b7LlH6UYjbNWGc8KW6wJJyO+HgqiwrnGNJ5HcEttttZJuMGrLTQbJvlGzI
         O3QnA5u7wgCldEAZyy9GcL9q9io6fFn32BjcTEciqCqYUnQ4aIoGNPtCLsVeRtLcQmx5
         0naA==
X-Gm-Message-State: AOAM532qS3X6VpG418z7TmcFnUS0C9XrtwFJqOlvXL4wNyF+9pmbAkbL
        PCgpyakflnNXJ2G9vM+tbbydFlUcs6Y6YQ==
X-Google-Smtp-Source: ABdhPJzt9qQULkxRxnWdLovQ1UYLg7t7NW2BMvxecVNL7v6qikcmHyNtS3gA94AmyrpCaLy2jc4Q+A==
X-Received: by 2002:a63:5b02:: with SMTP id p2mr471312pgb.161.1625198069936;
        Thu, 01 Jul 2021 20:54:29 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u7sm920859pgl.30.2021.07.01.20.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 20:54:29 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 2/4] fpga: xiilnx-spi: Address warning about unused variable
Date:   Thu,  1 Jul 2021 20:54:02 -0700
Message-Id: <20210702035404.397853-3-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702035404.397853-1-mdf@kernel.org>
References: <20210702035404.397853-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

warning: ‘xlnx_spi_of_match’ defined but not used
 [-Wunused-const-variable]
  static const struct of_device_id xlnx_spi_of_match[] = {

Fixes: 061c97d13f1a ("fpga manager: Add Xilinx slave serial SPI driver")
Cc: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/xilinx-spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index fee4d0abf6bf..b6bcf1d9233d 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -256,11 +256,13 @@ static int xilinx_spi_probe(struct spi_device *spi)
 	return devm_fpga_mgr_register(&spi->dev, mgr);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id xlnx_spi_of_match[] = {
 	{ .compatible = "xlnx,fpga-slave-serial", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, xlnx_spi_of_match);
+#endif
 
 static struct spi_driver xilinx_slave_spi_driver = {
 	.driver = {
-- 
2.32.0

