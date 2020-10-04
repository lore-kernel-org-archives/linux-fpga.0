Return-Path: <SRS0=Q6nU=DL=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD563C4727D
	for <linux-fpga@archiver.kernel.org>; Sun,  4 Oct 2020 05:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C00206DD
	for <linux-fpga@archiver.kernel.org>; Sun,  4 Oct 2020 05:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601788508;
	bh=hl9/Vlz0IhknUFLHFYxD/tIyDrJA6JyrOa4kBFuagFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GcyOjU0eVstqVgBwjWu5h5M63BtWeXqHRGvY8M3TzGqNQI8iGZur63VGv0MvgXJaA
	 /RzLnLXJ8ta0m1O8naTaJN7fjmdPBcL5OeEXMT9cgVm/MtG1dULh6jlAptvZgCc0wp
	 Bl3N68EuhU6OKMnmWjL6EFFgwdtYQlWjvIIa6Qts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgJDFPH (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sun, 4 Oct 2020 01:15:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40898 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJDFO7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id q18so3611843pgk.7;
        Sat, 03 Oct 2020 22:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0sL7ADN3Hq+42GWHoUqJqayEjL3b9dF3MMfLH2Y9NQ=;
        b=PATbyoXhYorfgAaoW8mhSBodjDeQNLFjr5yoL5BT8gJRMVQE+ANAgrB++A6xjkiQIG
         99pUIaEbhpO0vqB+IulDqZHqUJ52ntMb6fQQdXFmoLFO/0zGgsK/4n8Ac4RZZlv1Hh4S
         Tr00q5B1Jm9oTkVTHGSQFTdlnZ/pj3JA0jmKdI943b4OomoUcPLh+HkK++Q02o9BX0b6
         mOXn+/+BmjnMADHkhN4ALqx3oh58duC+5tUBlTgkHH6BFD35xW82jMGdoC5rklWNSgjf
         SUyYMa6exx5OgjQSKURlzubR+VGSPuRB3CNBAUuuP6qGpzjyhtb5VPdW0O8EQKu+hAsA
         AV7w==
X-Gm-Message-State: AOAM532oJ0Sc7fO6Vn51G722VRFfXUwOwc2ximJ/NnfkjuNnsn9UbiAL
        0yrxxFGQBLFbaLuzjNAIH3gSd9qNRaY=
X-Google-Smtp-Source: ABdhPJzFayjCJtOlCCDp1euNS+8aBlvXNaFrFBJ5JLikW0r8Gujg+MhK1dPOtDj2wkEnQuwZAH6iVA==
X-Received: by 2002:a63:1958:: with SMTP id 24mr8687000pgz.326.1601788498162;
        Sat, 03 Oct 2020 22:14:58 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x6sm6145100pjp.25.2020.10.03.22.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:57 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 09/10] fpga: fpga-mgr: zynqmp: Simplify registration
Date:   Sat,  3 Oct 2020 22:14:22 -0700
Message-Id: <20201004051423.75879-10-mdf@kernel.org>
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
 drivers/fpga/zynqmp-fpga.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 4a1139e05280..125743c9797f 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -95,7 +95,6 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct zynqmp_fpga_priv *priv;
 	struct fpga_manager *mgr;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -108,24 +107,7 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 	if (!mgr)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, mgr);
-
-	ret = fpga_mgr_register(mgr);
-	if (ret) {
-		dev_err(dev, "unable to register FPGA manager");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int zynqmp_fpga_remove(struct platform_device *pdev)
-{
-	struct fpga_manager *mgr = platform_get_drvdata(pdev);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 static const struct of_device_id zynqmp_fpga_of_match[] = {
@@ -137,7 +119,6 @@ MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
 
 static struct platform_driver zynqmp_fpga_driver = {
 	.probe = zynqmp_fpga_probe,
-	.remove = zynqmp_fpga_remove,
 	.driver = {
 		.name = "zynqmp_fpga_manager",
 		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
-- 
2.28.0

