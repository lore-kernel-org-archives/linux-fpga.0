Return-Path: <SRS0=Q6nU=DL=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99E1C4727E
	for <linux-fpga@archiver.kernel.org>; Sun,  4 Oct 2020 05:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EF82068E
	for <linux-fpga@archiver.kernel.org>; Sun,  4 Oct 2020 05:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601788517;
	bh=OLf9nj5gslxc5Y9rFE28gpvcy5T2xrJo9wj+ufRFRNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PHBrgRPQG5jqysZHiIkt8InxxO7Iz+ObUSRCvw8McfzOALO8ZnRJYXV0ubm7SFnYS
	 aWi6hTVCA784nukxB1h+l0j8s4HGn63hNHSDmRTAhUDvldUIpgha8AsZjiUNqpGb5B
	 w3fzWiYXiB2nnKma+yeTufMVCgpNKOHJLFVo7sVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJDFPH (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sun, 4 Oct 2020 01:15:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37470 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgJDFO7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id h6so2939041pgk.4;
        Sat, 03 Oct 2020 22:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47sHf0OnbQAgrjSXH2UeNqKvTmvp8QgcUk98MlVaxRo=;
        b=lq74pZvFQlb+ayPtSk8QvjDtRmHy72G3lNtpV29wTEK8sOuW353HJOHLB6umHdyr6s
         YwqJ6fLX5AFAkyvoXPtcAt2IiJ8+d9D43j6KPTO+gDxMiECRsBcYjXM/JVt0R2/N1SVe
         whzneBilB7ZCglKcx6O038R+wO0c3aOIq+hn+ox2cyPPNTjdVnMDnE07BOsPfIZpxduN
         j/Y6mdZTkaCtVEInYw51LOI91iZo5vmnmMzdrCqysM7m0U2OMVm2b35KZ1pnkmvBeoVi
         sUIb6hgAVQmUSiM/3yAYdqb+BlUbP0RgGjDyy8WkqeaOf4LfOR1z6/ZBMk31to0ASde9
         FyXg==
X-Gm-Message-State: AOAM531LR6L8zN3EBi6ClK2Oq6uzaEcwNQDPQBrJaf3zfDnm6ynSf9FV
        PnCHyx/WFRX2LPdlk7YaORPAPzWyMec=
X-Google-Smtp-Source: ABdhPJwvB3KaWGtsz2s+wyqr5IaazCnC6zzrFStHbeGJ/MYzvM7nhhvGhl36qlG0BApYbR1ts1mxsg==
X-Received: by 2002:a62:1d06:0:b029:152:1b07:7e3b with SMTP id d6-20020a621d060000b02901521b077e3bmr10594286pfd.30.1601788496952;
        Sat, 03 Oct 2020 22:14:56 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 5sm4505745pfg.152.2020.10.03.22.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:56 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 08/10] fpga: fpga-mgr: xilinx-spi: Simplify registration
Date:   Sat,  3 Oct 2020 22:14:21 -0700
Message-Id: <20201004051423.75879-9-mdf@kernel.org>
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
 drivers/fpga/xilinx-spi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 824abbbd631e..27defa98092d 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -259,18 +259,7 @@ static int xilinx_spi_probe(struct spi_device *spi)
 	if (!mgr)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int xilinx_spi_remove(struct spi_device *spi)
-{
-	struct fpga_manager *mgr = spi_get_drvdata(spi);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(&spi->dev, mgr);
 }
 
 static const struct of_device_id xlnx_spi_of_match[] = {
@@ -285,7 +274,6 @@ static struct spi_driver xilinx_slave_spi_driver = {
 		.of_match_table = of_match_ptr(xlnx_spi_of_match),
 	},
 	.probe = xilinx_spi_probe,
-	.remove = xilinx_spi_remove,
 };
 
 module_spi_driver(xilinx_slave_spi_driver)
-- 
2.28.0

