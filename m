Return-Path: <SRS0=Q6nU=DL=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C132C4727E
	for <linux-fpga@archiver.kernel.org>; Sun,  4 Oct 2020 05:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427692078D
	for <linux-fpga@archiver.kernel.org>; Sun,  4 Oct 2020 05:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601788507;
	bh=w+DCU3v7ZQ+fY0fqyn1JqTk9eyfjaPhmDjap4vVvBZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PYoT5k/TBIPCzpzqHD//H6qnf0In7R38mSI8rSlEDaP8hKiTUHJfM2/sAjUJ7vZx0
	 aHFz16BLpgCLQsbQAHVHaElhdnFdzQOF6uasfNf+7KjJs3jZZ2H9qcMxWTESurpj7a
	 yfdXKMJIflh0xRdxQuZQY4gpIh5pKM8+zY7ojm5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgJDFPD (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sun, 4 Oct 2020 01:15:03 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55943 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJDFO4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:56 -0400
Received: by mail-pj1-f65.google.com with SMTP id ds1so350079pjb.5;
        Sat, 03 Oct 2020 22:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaAVNF3/AlS92Q3NEttM+dWDO+XxWPGiLzHX02RqSVo=;
        b=WHB4R0Fzb64rlVnpgJU8xAFtKHn2sdWQUBmRATZrcWm2cy98OKa4dDp8JaB3E0rWuv
         NBEb7sLZY+ezfwFFwiu/qC/8bui/OhXelD8FBsTbi6SyH52/Suowgz4QF519EJMPjQNc
         1p6KrjmkINQbtiXQRoByW5IisPqWCVCoaCQbXuJJj5WrSovaQqQ3YyIMojba+cIftK+T
         V3vcvdb+0IxIF5kvjD6+WCX6aiw3eATknvl8qmyoDhCVUzxpcTFgdA1UjU/Bm4xxA6K1
         FNzw+VoFI69Gn0NkQ7isb5ZzzP+D6NJcajZVP5z7nB3Ir/pAo5G55A/lPgXTu2HtTmKh
         gXRg==
X-Gm-Message-State: AOAM530jvGNHmH6adXqdo/ZpRUBtLPq3CwJ2jUb0+sJDQliJk8QFd3UX
        Fd9RbTgWNXXywc4ghWQdccaIpKr8glM=
X-Google-Smtp-Source: ABdhPJwNlr6JI0F4V2li4qN9l3534sjOYx5SocCCZjzYxaKbo6UgCuL2JAYmNNUb2HAmJgoHrgbflw==
X-Received: by 2002:a17:90b:4d0d:: with SMTP id mw13mr10418192pjb.192.1601788495740;
        Sat, 03 Oct 2020 22:14:55 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id i62sm7782184pfe.140.2020.10.03.22.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:55 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 07/10] fpga: fpga-mgr: ts73xx: Simplify registration
Date:   Sat,  3 Oct 2020 22:14:20 -0700
Message-Id: <20201004051423.75879-8-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004051423.75879-1-mdf@kernel.org>
References: <20201004051423.75879-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

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

