Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F4E34388F;
	Sun, 16 Aug 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786892870; cv=fail; b=YtXfZerKZV62x6U9Y+RzGrMz2MV25zBZs0NaZRkSFKsqR1ir5JIIZvko8CuwLhEWyODVk+MdQPppzMebuhDmpw/1rmc33hKmRGmc1a5ZM0qdwISznoruvoB+lBpE3DZxNlv+4L9cwOifIbx3jJ4AVAcoXlQ6+dhbAI3zqIiqb/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786892870; c=relaxed/simple;
	bh=KiggJWWOTGAYulj+WhwtlvobhwNpZUyXyOqCLfIjrM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TK+X1/4ClWmxPbYj3RX3ivk33Eor6VAMkFJk3MK2Kk/dqSO/kWnb8Z0Wnm0SdRFpx6qc66DGcn0WCAZ8Q3J9HyTfYQwCH2KcpbhkvKh76bkv6Q8WD4h4cduQGFJRPcU+srOcMMCLcXA1Z+syyMlks2jupcimeR+B8HgFUsjrq3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=znKnSbFP; arc=fail smtp.client-ip=52.101.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="znKnSbFP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQFKaKly0PjQpBIivzaQE3rbI/CJbfhoicdQLFVKjFu9SJJ6z53x9OZpO9awiHZMgLnaKYOG7Sq9Q1bcRGPKVp2RvgDqhVKrS0Tdl0rgsrBToI3uHZA8kuM7aKNHlfO7c6QEaVKrGvmsO6lCIgwGdcXY72xSBA2Oorpj3Cms4AE05+p/2SaZ9zt+4vKUlAzIqjvTxgNxPvBnPMYwC/AoNM4HJ32d6WWSY7tb/sHG1aqD68uukl8idTLTkDXa5NCndyYW70RKvBydVNB7zMP4/A150qafxxA0skdeUPHiO54eOEpdJ5XBMxAdVU8qzrV7Bx9/iv+mOHC0SSTh9loI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn6SMwsM0Q8V0fp4EcGeoF+ud56vhGz4Ohhd1TbaYKM=;
 b=flCKG02ztNdebRQKkO7bHWWcs7UNHxlT0rst3I7Cw3OtSC9E0TxUWbS7FA8bV/aH7m5iGLabdmjM4DbTIB9kQl7hgNvMaOJTliCOa3GVTr+KbPC9Yc+/A2x0FUC9Fin8U+/uSWD+L2Qlxf7PYDPl2mwxxSTa/FXc6zlWt12MfWy+SX3GcDaKBMVEZ3N6Svpm/zWQhuWTlS0glufNTpG4gltyN4127nz6NC0T4u2is1ocWWqS/5JxXg6WIbmy4737HFUDNKx34OnhTCNnC64juAkOkohfeIZaxulRQbXwwG/vnhLjReT4lfWkPkKpJ8Px7AzVg7/JZpqKZ+y++YSDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn6SMwsM0Q8V0fp4EcGeoF+ud56vhGz4Ohhd1TbaYKM=;
 b=znKnSbFPPVRimDywPaJokqEVry/Kf4LoXiRrtyleJ4B6yid4sTxAmFJTjNYIU8jeYzTY4ozB3/5ecPXP7amfuxfD3dxGvXFRaQ98dhmg5naL3rTJFSsR2uq2HXLvrjCQXs4ksLHVWN3qQX8vkllsIg+OhmDxiTMEx8ixo516UmY=
Received: from SJ2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:a03:505::18)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Sun, 16 Aug
 2026 15:07:45 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::3) by SJ2PR07CA0006.outlook.office365.com
 (2603:10b6:a03:505::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Sun,
 16 Aug 2026 15:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 15:07:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 10:07:43 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 16 Aug 2026 10:07:40 -0500
From: Aravind Thokala <aravind.thokala@amd.com>
To: <mdf@kernel.org>, <yilun.xu@intel.com>, <trix@redhat.com>,
	<sumit.semwal@linaro.org>, <christian.koenig@amd.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-doc@vger.kernel.org>, <git@amd.com>,
	<aravind.thokala@amd.com>, <nava.kishore.manne@amd.com>
Subject: [PATCH 0/2] fpga: add dma-buf based FPGA programming interface
Date: Sun, 16 Aug 2026 20:37:32 +0530
Message-ID: <20260816150734.2092802-1-aravind.thokala@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aca5568-5e79-403b-9d1a-08defba8209e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|7416014|10067099003|56012099006|6133799003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Z//76FKIr9CmO2nBArMdgueG3pTt5ydEy3EClmu1jCkhhINLaimB6+rQuKacziTpaTUqP/0DcD68U6GnK/4P60k873fihwNyGDKXjiGTx7aB1/cakd1doJiRi5qLL179HnJk0KYPyY4dpmhVwsK1eK6maPAPWlSVn/hIM0hLLQv+sEn7yAtH5JdWmpKkCxp/crWoSNQVA1z703YoHXb+TRfveSOc+XplpPq8JW3jCR8Nt0/kYGxOuyje8lErSEvlAmngPuoeCRkd5SBl0KNr+AR19ycbR0JtGsVXDr0AyPKNEIHc3kxVSR2+Li+WXzzdfFidkBbhOLuMof+IHQHcidscuy7e6w+m9IOeLPmf8PwzGPWXy99gADSspNfsrhN0WvQHCF/HOCyuQb/2fVDn87+wGaT10sAv1lLiV1XpUIlVMn9NlLhiuUWwe9HQhZB7mMiGcnTeJs6C06R0hcOk8wXpVGH/05DDpOZK/c1qaenaAZIJTYLq00od2MdSPqujFeTd48lnaJit04USJdeAzOspyqeKegrT655hrNdJIQWRpbwK67wyv+L1pN8Yhrv6EmLM5dUJrNPunVR/cTBiK+VPhxvtR0bAhGPxpjZbgDhDKwWQ9/R99p76eXU1PaNLsnXplkk2YwvnWiyoIwjrj37aMUfNvAk67UhXkvH5jpQeRrowR6hbx57XK1d1uACP2s2q3b/Is+APIyT7HfYsrw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(7416014)(10067099003)(56012099006)(6133799003)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	43MCLv6Kz2NG04h24Fu4vbv6onSVrdbRavVy5+v31ToNSSlQEdJSupDjxhRluW+V9ud0JwHaYgh3F4nzs/yjg/TEgRVYn6dGj7o91zRw/p48XDquftRMpVOpUmvxzPF/7wXqwe83kz3coKc8ulICbZfE24RB3Q5dPRhKiAniAOcVs/cZaDbfwzgqZUKXuaQBBK59xj3Fx7O8wV96AtGBGg2LOeDb6GLihffs+69HdLNdgkyWWgGoAtYNWFKX3bZYX8a7kpNQWmqhp7tQpJWwep9ERDEeJSZ8UT9HrjHhxDMsoHFHJn2XLGw/BlcON/oIHBvx4cBWWMmIz1P4qDvBr1kaa7tEHSyiCDSzxJb6jtWWGm1KiwJ1xeXW6s5KrdGfb66QAA52h/nGBCLPkY3cukgJN0dioTDKlaXTv78capXkAWVBQjPshgb/Y9fPk9ko
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 15:07:45.2760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aca5568-5e79-403b-9d1a-08defba8209e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430

Some systems need to load large FPGA configuration images. The FPGA
subsystem allows loading images from the filesystem, but this requires
the entire image to be loaded into kernel memory first. For drivers
that need a DMA-capable buffer for programming, the data is then
copied again into DMA memory. This creates needless memory pressure
and delays due to the extra copy.

This series adds dma-buf support that allows userspace to allocate a
buffer directly from a DMA heap, write the FPGA image into it, and
pass the file descriptor to the kernel via ioctl — skipping the
intermediate kernel buffer entirely.

Userspace flow:
  1. Allocate buffer from /dev/dma_heap/ (e.g., CMA heap)
  2. mmap the buffer and write the FPGA image into it
  3. ioctl(/dev/fpgaX, FPGA_IOCTL_LOAD_DMA_BUF, &dmabuf_fd)

The dma-buf logic is implemented as a separate layer on top of the
FPGA manager, keeping buffer management separate from the write path.
Individual FPGA drivers opt in by calling fpga_dmabuf_register().
---
This work is based on the approach discussed in [1].

[1] https://lore.kernel.org/all/20231122053035.3758124-1-nava.kishore.manne@amd.com/
---
Aravind Thokala (2):
  fpga: Add dma-buf interface for FPGA programming
  fpga: versal: add dma-buf programming support

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/fpga-dmabuf.c                    | 198 ++++++++++++++++++
 drivers/fpga/versal-fpga.c                    |  33 ++-
 include/linux/fpga/fpga-dmabuf.h              |  22 ++
 include/linux/fpga/fpga-mgr.h                 |   1 +
 include/uapi/linux/fpga.h                     |  15 ++
 9 files changed, 281 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fpga/fpga-dmabuf.c
 create mode 100644 include/linux/fpga/fpga-dmabuf.h
 create mode 100644 include/uapi/linux/fpga.h

-- 
2.34.1

