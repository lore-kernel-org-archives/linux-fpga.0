Return-Path: <SRS0=KYGM=BU=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D212C433E3
	for <linux-fpga@archiver.kernel.org>; Mon, 10 Aug 2020 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABF420729
	for <linux-fpga@archiver.kernel.org>; Mon, 10 Aug 2020 13:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHJNmn (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:42:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60874 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbgHJNmC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 Aug 2020 09:42:02 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07ADdu5e004656;
        Mon, 10 Aug 2020 09:42:00 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32snw56v3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 09:42:00 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07ADfwqf061546
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Aug 2020 09:41:59 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 10 Aug
 2020 06:41:57 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Aug 2020 06:41:57 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07ADfY3m030109;
        Mon, 10 Aug 2020 09:41:54 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/6] clk: axi-clkgen: add support for ZynqMP (UltraScale)
Date:   Mon, 10 Aug 2020 16:42:49 +0300
Message-ID: <20200810134252.68614-11-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810134252.68614-1-alexandru.ardelean@analog.com>
References: <20200810134252.68614-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_09:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=675 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100102
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

This IP core also works and is supported on the Xilinx ZynqMP (UltraScale)
FPGA boards.
This patch enables the driver to be available on these platforms as well.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 69934c0c3dd8..eaabc758a7e4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -240,7 +240,7 @@ config CLK_TWL6040
 
 config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || MICROBLAZE || COMPILE_TEST
 	help
 	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
-- 
2.17.1

