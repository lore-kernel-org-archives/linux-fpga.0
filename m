Return-Path: <SRS0=w+Fh=DM=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0F5C4363A
	for <linux-fpga@archiver.kernel.org>; Mon,  5 Oct 2020 17:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD44F207EA
	for <linux-fpga@archiver.kernel.org>; Mon,  5 Oct 2020 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601919489;
	bh=GGRWnIRMYVvbhIfOoLd98sNSsmoBZzxa9UW/3qZPpNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QxF/NrwitLNPUEF+KxAuJxiIJ7bDdxR9HooKHWsuivFeddvVqvtqzthwKhGxW6k7U
	 qqZdzgjqDpIv+JH9WWHlY/7KYJMOIJ062OJAaVtxUgX9dHoF9RD4L9jIp/N+Iq04Gm
	 54AB6fMPQvo0bmFHbCBuXLtObFnvnNVrNt75Nm9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgJERiJ (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 5 Oct 2020 13:38:09 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:56196 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgJERhx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:53 -0400
Received: by mail-pj1-f49.google.com with SMTP id ds1so185537pjb.5;
        Mon, 05 Oct 2020 10:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4TUUEH3mzxdF0JLPfTx+3VTCs6mAY0is3dcpH6g8XA=;
        b=unSrdQ+aau+N4XCVEHakL7yJddhR0UMzXbhjCaT1dKf1qf3omUqZbkxc0Mfn80cPUN
         7+XOlPFX6AiUtIkpxh5tBLvNDSdmzIPbNz75sBQl45QFXdxBIRIINMJp2ocCaCE97bwT
         FUf8qbQjXG6hYl0cScHgN77IbRK+yj0bKLTkYxFbAwXdvxURaTv03jJxiefaWjyud4uh
         6FWTW86EXtjSdL+AMRekKdXz8wo3CxJTqw/rnmUHDam4SK51NsTN4zgbFqvG8K8ujmeF
         +oOszVOVdhjClgnzN28wpnxUGoVs4EMzEUu0Iy/lmW2rGAdZ2WydoXHTg4+DzFxoT936
         zQqg==
X-Gm-Message-State: AOAM531cMB6nsfW5d5mD5hxYJMyWOdijsFuCTy8Izxnsx9Aiu/nbTozu
        7C2oZ4PaRQJzDm7kLZWbZFHqntEvqtk=
X-Google-Smtp-Source: ABdhPJx4xXhbH1MWDvuiwBaaC/6SkRVdBbdml4IF7pL/5w77qJGI1HZWaZKi64MmXkAUtT5IDwCo6w==
X-Received: by 2002:a17:90a:5588:: with SMTP id c8mr494907pji.224.1601919472219;
        Mon, 05 Oct 2020 10:37:52 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id v22sm497846pff.159.2020.10.05.10.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:51 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 07/10] fpga: fpga-mgr: ts73xx: Simplify registration
Date:   Mon,  5 Oct 2020 10:37:32 -0700
Message-Id: <20201005173735.162408-8-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005173735.162408-1-mdf@kernel.org>
References: <20201005173735.162408-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/ts73xx-fpga.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 2888ff000e4d..101f016c6ed8 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -127,18 +127,7 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 	if (!mgr)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int ts73xx_fpga_remove(struct platform_device *pdev)
-{
-	struct fpga_manager *mgr = platform_get_drvdata(pdev);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(kdev, mgr);
 }
 
 static struct platform_driver ts73xx_fpga_driver = {
@@ -146,7 +135,6 @@ static struct platform_driver ts73xx_fpga_driver = {
 		.name	= "ts73xx-fpga-mgr",
 	},
 	.probe	= ts73xx_fpga_probe,
-	.remove	= ts73xx_fpga_remove,
 };
 module_platform_driver(ts73xx_fpga_driver);
 
-- 
2.28.0

