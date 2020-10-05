Return-Path: <SRS0=w+Fh=DM=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F32C4727D
	for <linux-fpga@archiver.kernel.org>; Mon,  5 Oct 2020 17:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D61F207EA
	for <linux-fpga@archiver.kernel.org>; Mon,  5 Oct 2020 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601919506;
	bh=zfSk9qK/d/pG8UF1gaa2i4asbpvVe42srkJj3+OgDQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=exd0IhAm00uAcrdGaaFOJfAUBsMoqTfMN/tVKzvH/o6xggNeiVm+FA576HWTRU36N
	 61WGIjQCr7qz+vleg+kPPM4yxAShG/5dT2A45hgM1oPBqT1dSc3ND+M3Fzl67eKM4x
	 CJ+Y7uYkbTij0Rb9R7plvPCaq9bwUAgCRtqGQQ+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgJERiN (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 5 Oct 2020 13:38:13 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:35652 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgJERhw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:52 -0400
Received: by mail-pj1-f49.google.com with SMTP id x2so219115pjk.0;
        Mon, 05 Oct 2020 10:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6D4+DnleUV85fmaN7MdBVnGTrFax41kLnobja/AhDw=;
        b=tYkhVSC12DcfCYwHq8jHqw1wOXqRcyZ5Cgxcfi37kVzkoDC4lkmaqilvX4viytsiAJ
         j/aJwOo2lXGvTHIbK3M9LR3/zLS+b9t/YXiCDqoqNvwmjcLOi83v+Saz2vIWmbdEampL
         GW7lfulWgF33SJKmQk38MI5WYWUdCBHgBs06XZPo9/6+i+ZSDCUQhIr1u5zenBlj/dSS
         54FUEbLuYstEKvehXq5RDUyKkMNt+GMBLINwyEhPCa7yRZDkyG7l/jp3cWDkkeDySNEA
         8FI15QJ69FcCCmtkeBZeG1Dd4RKQ9/yipyWuWxMX/B8gCvBP7M0okwdkKKe9WTvWC6MW
         2elw==
X-Gm-Message-State: AOAM533NE586VHN0/MRQTmZkc4ptPuLNuXMZoBiCKdrBY8BvF8QBwNKY
        kNaWORLFW8tcwL+vp3MFPDn4ZvaH1YU=
X-Google-Smtp-Source: ABdhPJxCACUo/RF7tmZdJ2UVUvDmOhvyynY18dFOWxStNR0l0MYGcBAjTIB5fTRyGhPf6lUf8jWKig==
X-Received: by 2002:a17:90a:a512:: with SMTP id a18mr549922pjq.30.1601919471028;
        Mon, 05 Oct 2020 10:37:51 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id g9sm225383pgm.79.2020.10.05.10.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:50 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 06/10] fpga: fpga-mgr: socfpga: Simplify registration
Date:   Mon,  5 Oct 2020 10:37:31 -0700
Message-Id: <20201005173735.162408-7-mdf@kernel.org>
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
 drivers/fpga/socfpga.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 4a8a2fcd4e6c..1f467173fc1f 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -576,18 +576,7 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	if (!mgr)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int socfpga_fpga_remove(struct platform_device *pdev)
-{
-	struct fpga_manager *mgr = platform_get_drvdata(pdev);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 #ifdef CONFIG_OF
@@ -601,7 +590,6 @@ MODULE_DEVICE_TABLE(of, socfpga_fpga_of_match);
 
 static struct platform_driver socfpga_fpga_driver = {
 	.probe = socfpga_fpga_probe,
-	.remove = socfpga_fpga_remove,
 	.driver = {
 		.name	= "socfpga_fpga_manager",
 		.of_match_table = of_match_ptr(socfpga_fpga_of_match),
-- 
2.28.0

