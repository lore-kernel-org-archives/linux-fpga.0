Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792482592;
	b=E+BaM13zvdpc5VRCs1S39lOAWcBOpLMoTbJ87fsFYAVDmfUK/3J+YC7t3cIPWCXyaZO9
	 ASfVQ7BwTLFztoCuweHxZUl6BfLwo76mrKh3EzI4g2eQYu56nXBYzrmwhVq0LzU4WaCg4
	 554QwfCdskF9/gjdNIDY3NEFX5xITKhEuCGYWsuouEBruKeMwt/ExGPer+axoiMnLEtKD
	 DARK8ZJkgJPedKrb0tqhc1SeiQebPUwSYEs6/eHNBy9G/3dRn6tAR7ddf4flDtAHghZno
	 1p+D9sXXQKulXJSAzmw6/szTkxbr/j7f9IzJduB6/QjDiESxkpvFKm29P7yFXf5Em1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482592;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=plr7qL9FvT/YoFc4+nNl8hHinMXCkDk9JmQDa1Sp3g0=;
	b=DjHxpfT4gLLLBeHDt4iTt8yhdmHjnb9OuEoUsE12Da1kaFsvW8MpAj0V0B9FfXbV+mnW
	 WQmvAkbVvzuKj7m1I4+/40ptD7o7Kw/HjH/DEHLuL3/ERy16gmXDDMEvEJyltgvcf3/4u
	 +QoHJet0HB0GNmS3Hb/7cTyWb4ZkGh7FYikfOGjCgGCAnCloxsOIme51bRHdyBq3apaMt
	 evtBxXilOWh++igaOYKgTigDLHYNNJcV0Z/9edj3Ucuwc9x+RoEt5raNqRBGvJfZnBWWL
	 KdwiVBeZCrxgicfC4a5lyM5HsTczz3dkhnFNgsHGok/uPiSktCuMa74a1E2P0+GeMkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=PT1yxDcw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.29
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598C606A321;
	Tue, 20 Oct 2026 07:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3598C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=PT1yxDcw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQxyS/FwAchHOm0+YEZTuFmY1YbQn9tRpefmFXgPfw0Bq5hqsHicB+lI/HhWjYpgWvnqOMJs/B7Cu8k6QjgEyHNWRMAyIs5HoYCXTTXMqA00JTdtZ7MzltpigqabfB143BK+aEnkNH95SzoBcFHOLuYYvih0JEkNxKUl0oUNXe4sdmDtDLHb31BD4JRYK1N5xv0Lp+KlLb6/0vTXxGBlDCM+KDerWoTxDZ7kmVY77/RLo9YHBVcOi9I7s62vEqFt25GfPgHsoNM/DmCAdEXvjKRQb0DWYNcQGEH7lYneODvuEBC++cmpQbvO8rE9KlaeII2MA3TRkmFQ2c1B0y4Fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plr7qL9FvT/YoFc4+nNl8hHinMXCkDk9JmQDa1Sp3g0=;
 b=oECM7/Sp784kc8FtQbTp1t/FtbP59iCY7WCUv7eZcK8obGeCBtv+dgH2Pz16MQkfclX3gsWbpVShnFo5BfxPJguCa0b6Zwyu06PPG8es20babSn6L7wEGpyNNXk1sK/RrwHAJ8vqYXIKIUGMUfra9hPQXCK0kSi9jIhEqvfV/M5h0JXwOGYNSLRvWTa67qaSXZovftn0IV5b88O5bLwXCBvVJqs9mIXT5tVsvpQn2Mqw+Py9iGYF1nxxbApbsFjXGhyaX/DICgrUoBqMBW5Ec3b/wx6bEjJ8uwzQRVCKgnTJLpQ7wNeGuU1k6kT0jETvBenoeRvMWVTUOCILUL4zcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plr7qL9FvT/YoFc4+nNl8hHinMXCkDk9JmQDa1Sp3g0=;
 b=PT1yxDcwmTorFMRHg732cRoJfbZdgxd4nt1tYjKxTHrr3KBV+tz5mUcOxGNXlhl00zR0nK5v5dkEVQpdZamZNYVkwgT1L+ULVP2i4OZKbque+e6LQCOvrZImbmW4Tk54F4KxdwPZCQkmBzH3Aw6BFWTYmTuWbYVOWPWm0EG7wQorzOV362aPUexfrFyNe+3C8OQ00eWpKZs+YNaWWHwTxqbaq5CdUQiay0qBAmC7AuKnENOqsw9gHf1W9VQMnFxwZMZHYwUNgtQ9BGzAEi8re/8sHW5VxnB9RynEUP4ceG0R7e8uZK1HWSUB2ucMPRorkbaBReav77JRmDW1U3xswA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by DS7PR03MB5382.namprd03.prod.outlook.com (2603:10b6:5:2c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:49:50 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:49:50 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: mdf@kernel.org,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH v3 3/3] fpga: stratix10-soc: add SVC wait helper and prefer ERROR
Date: Tue, 20 Oct 2026 15:49:32 +0800
Message-ID: <3d9d44565b20fa23286dc64c5f7ffd6a21dd27f8.1792480395.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1792480395.git.adrian.ho.yin.ng@altera.com>
References: <cover.1790090287.git.adrian.ho.yin.ng@altera.com> <cover.1792480395.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:295::11) To SJ0PR03MB6581.namprd03.prod.outlook.com
 (2603:10b6:a03:393::12)
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6581:EE_|DS7PR03MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0ffd62-3030-42ed-bb51-08df2e7eb845
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	XrZnNaKz2Do8i7d5lupoUQhgiaNrThzRuSDKa9hNJtPDF070IwS9y3OW0pcwoOVhuzdyWYyaJBwjaH/COTj5YH1OQxnF+6R1eRxUEdejCzEgYaHIufVgikAcH4aX/81KQmSHukHKJv4Gtrlki72kZ3QQvG+1WQhwxuEH5RhJoFObZ4K7NS3GT9HFK4wR2bkYtiuCFACeBvPyOlzbi4dMOZEo0WzvagGkJj2PblR3G75zK78qd3uUvmuq8UhJdoVh26aPp4u9fu0GnwdElas8GLXHM6E2C0YI/wONQGXWr3Jzkgof+EFxjNjPd3eWTHVoAYqAhO/F0Y1aSJ+J2YsWnAY+3ooQNL9zWRI4SyaTQUaTTR2n6SZgC4quAYIkFBuD5heGnUzqOe+uq/84uGk25wZg0zrJxNJS4L184IIYrt9LY0DxMX+TPjMKA+MX2D5XusPb7fR82GDQBimZa7Ya/gUy8E+WX85BGZZpTAXfllbaHIyQKW1hjdK8Ga9Iel6Me7LTm7j8VlPs2Z7j2D7A4F2JZhfqgu9rsGm51osMv6CXCO6vvMU9n8z7Yfn/abEzONiWKL7TO+s2ZBVdOhuslvjayp0uR54xS/gPYGnfGHR0VVBN+nwc0o6zREvZjfZPI2UyKB4Kx68biA3dgROYnvSJoCglbpKDTkgWy8SHzd8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RaZNO5qqBFP+K0E5TC+nPKE1zt+8tYhrWdfnl9mMCqOLeMSZibD+7F8Msmgz?=
 =?us-ascii?Q?NMxvQ3ZUzaoZT3Bu9xngf+hE92wJS5vcmtGyjAPW4S+OW1jJvwj6pD9aZiPP?=
 =?us-ascii?Q?Hr5QvWFvCnCmbRinFQBDnL9/qQlZpstcyWUhd9B9EyeLMgGoxm2CIpzKeC0h?=
 =?us-ascii?Q?PMsb8wJNmWFJENrz5fK94Ft/BcKs3YlTlGJLnwThNYvjjE94t5DXnBQeomZ+?=
 =?us-ascii?Q?E3NSVvixaAyy05JyKkvcHdbgOc78mE4EHl9tvGJL2nLVxpyINy2pGuYMfe0x?=
 =?us-ascii?Q?UduQOpSIUNvoL8Xm3oPat2n/GoERg7u4DpwXOVmQ3LoY5rC1H4qHvXCOKV5Z?=
 =?us-ascii?Q?cG+pP+1W5mr6mZQ/Trnu+xrGJ+JiEDS46uspybOMOA/df4rq1SYB8s62/Wt0?=
 =?us-ascii?Q?4qTy1KJH37wzhgTFr5xvyyzUiWj94yj93u4DMQTi24HTE8mM56TqvEdcAgjT?=
 =?us-ascii?Q?xTRzC0WO/F6u+EjrBikkoOyvOifJagkMvdCoA05YnANWft2/v8k70h6Vvm4L?=
 =?us-ascii?Q?OeCv8hQNxLb00ka+VUipBeb3oXronQv6y+2nI2xdPYCOPqycZmGrLUN/kCMg?=
 =?us-ascii?Q?USsNHBbkWUq6eHh9TCdXYnj8/amexCJUFUpkKGDg2tFHJFr/Iq+JZd+zsKB+?=
 =?us-ascii?Q?aYSdysOtcnL+vVwz1VQcpGy8U/3fXpWPNQlWIsCJZS7EIY1cSuXGZtqwLhMC?=
 =?us-ascii?Q?IIl2/biXlw++D8o0JmixlptBpJ9Yx3BqO35dfICV2gcDOF+T4RBQ1pKxraa9?=
 =?us-ascii?Q?IiM24BhH1HnEopnVDkGVDfWHR91Vp5DUwSRXpGXohxMDlPGxg9V8kAVU2eu/?=
 =?us-ascii?Q?hQy1YE6Hk7TdAH3tMwHPR3TTT2FNkDZYCuqIsWxgBPhKkictV/RuWM60EnNV?=
 =?us-ascii?Q?n+QfJgg4VM7t+2rmtCrIP2wBSOrixXmepfOWHJCKZuGqgVAUhFjs+LEr5/Bx?=
 =?us-ascii?Q?Hl+wDXcAX6HyMwwyuFzAejvNJAnHvL8twDvnEigCIBIGz9WZsnc22PyUCv+Q?=
 =?us-ascii?Q?ErpuyoQZd8Qe+qwJe6wAn7CY3A4EOnV3Ad2Nd8TDsCAJcKC15gZ1qLnj0fDe?=
 =?us-ascii?Q?mKQtxDb5MvXTOqeAY7BAG8EpOMKZArw93c/XDm+mpRF6lxZei5eoKHhWshPz?=
 =?us-ascii?Q?elDb1y+jkCl899ktksfc3kX8nR7VgaGteKrONVnVg8GwLmPthACG9Jl5dMvD?=
 =?us-ascii?Q?Z3/vkWApfc1z7aGfEtTA12auvefAr3TaINFieKATJxB4aqKN0I1fO9XfTERC?=
 =?us-ascii?Q?/SXZ+LBUypP2x2qKmBnkkVD1NoyiL06C+OJwFYNW9Tn/NzJik5i0MTf84GrF?=
 =?us-ascii?Q?f2vHumrVec2fqTJcJtU3YLvqNkJoiZ8277K8IE+wAiWyQgpRCuvTPVHfO09w?=
 =?us-ascii?Q?0f2mfFIj69gQPjfuo0CtOb40aVBVXmXLCWQx7MIaiGB+WxbPqifgoP3lq8nV?=
 =?us-ascii?Q?lrJPocrrg/NwN9REzeLQmCEkAXA8c8EnImS3EK9RptfNFT/n8fk1InhIjrwX?=
 =?us-ascii?Q?4IaiTUtGA1i4/W9vqtr8iDYsS/9oSNgD9msnAGo2zC450B6JpvDy+2rDIvIy?=
 =?us-ascii?Q?poiPOPE7FFYDI9CQqakQbolx0FfPW50woBWDNelYVefVoczxi5A5qmgyFEVq?=
 =?us-ascii?Q?ypVWhpro+R1TwZ3Y5lJ7GBHDUDuQLSmWKOF2I6I/3JKhHiLONQpxUIvhg+Vm?=
 =?us-ascii?Q?UKwvsmHhy3wE80JjJTOcVIY4lwMwCz4igpTPakmnKTXudb0EYi7bsRUrpVAb?=
 =?us-ascii?Q?Qt7oG5yDaAeIX4RlFMkyfFbtxfcEUFk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0ffd62-3030-42ed-bb51-08df2e7eb845
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:49:50.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+Bv352KJ/pfXT3igbimwuhpq2HfeG+63MD2/ZAGJkkcE+aVieLHSFwYmE09bCMPaJ02+IzUu5ysMdxTbPaaq50UN1bkhbRxZt7r0p3olbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5382

write_init, write and write_complete each open-code the same sequence:
reinit the completion, send a service layer command, wait for the reply,
then test status bits. The order of the status tests differs between the
call sites.

The receive callback ORs each reply's status into priv->status, so bits
from more than one reply can be pending when a caller tests them (for
example several BUFFER_DONE callbacks for one RECONFIG_DATA_CLAIM, or a
reply that arrived after an earlier wait gave up). write() and
write_complete() test a success bit before SVC_STATUS_ERROR, so a status
word holding BUFFER_DONE | ERROR or COMPLETED | ERROR is treated as
success. write_init() ignores ERROR when OK is also set.

Add s10_svc_wait(), which waits for a reply and decodes priv->status with
SVC_STATUS_ERROR taking precedence over the caller's success bits, and
s10_svc_send_and_wait(), which also reinitialises the completion and
sends the command. write_init and write_complete use
s10_svc_send_and_wait(); write() sends either a data buffer or a claim
request and uses s10_svc_wait(). The helpers return 0, -EFAULT, -EBUSY
(SVC_STATUS_BUSY), -ETIMEDOUT, or -EAGAIN for a wake-up that carried
none of those bits. The status word is read and cleared in one step with
xchg().

The callback unlocks the returned buffers before it calls complete(), so
write() can finish while the completion of its last claim callback is
still pending, and that completion can then wake write_complete() before
the RECONFIG_STATUS reply. write_complete() therefore keeps waiting on
-EAGAIN and only re-sends RECONFIG_STATUS, bounded by the deadline, on
an actual BUSY reply.

As in the existing write() loop, status bits are honoured even when the
wait times out. Visible changes: write_init() now returns -EFAULT on
SVC_STATUS_ERROR and -EAGAIN for a reply without OK, where it returned
-ETIMEDOUT for both, and write_init() and write_complete() accept a
success bit that is set when their wait times out.

Also clear priv->status at the start of write_init so that bits set by a
late reply to an aborted previous write do not affect the new request.

stratix10_svc_done() is left at the call sites since it ends the whole
reconfiguration sequence rather than a single command.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---

Notes:
    Changes in v3:
    - Replaces "prefer ERROR over BUFFER_DONE". Add s10_svc_wait() and
      s10_svc_send_and_wait(); write_init and write_complete use
      s10_svc_send_and_wait(), write() uses s10_svc_wait() after its
      data/claim send (Xu Yilun).
    - ERROR now also wins over COMPLETED and over OK (Xu Yilun).
    - write_complete ignores a stray wake-up from the last claim callback
      instead of counting it against the deadline.

 drivers/fpga/stratix10-soc.c | 163 ++++++++++++++++++++---------------
 1 file changed, 94 insertions(+), 69 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index a69f63f0236b..074a99fc3a4b 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -72,6 +72,69 @@ static int s10_svc_send_msg(struct s10_priv *priv,
 	return ret;
 }
 
+/*
+ * s10_svc_wait - wait for a service layer reply and decode its status
+ * priv: private data
+ * done_bits: mask of SVC_STATUS_* bits that indicate success
+ * timeout: maximum time to wait for the reply, in jiffies
+ *
+ * Status bits accumulate in priv->status until they are consumed here, and
+ * SVC_STATUS_ERROR takes precedence over any success bit set alongside it.
+ * Returns 0 if a bit in done_bits was set, -EFAULT on SVC_STATUS_ERROR,
+ * -EBUSY on SVC_STATUS_BUSY, -ETIMEDOUT if no reply arrived, or -EAGAIN if
+ * the wake-up carried none of these bits (e.g. a late completion whose
+ * status bits were already consumed).
+ */
+static int s10_svc_wait(struct s10_priv *priv, unsigned long done_bits,
+			unsigned long timeout)
+{
+	struct device *dev = priv->client.dev;
+	unsigned long time_left, status;
+
+	time_left = wait_for_completion_timeout(&priv->status_return_completion,
+						timeout);
+	status = xchg(&priv->status, 0);
+
+	if (status & BIT(SVC_STATUS_ERROR)) {
+		dev_err(dev, "ERROR - giving up - SVC_STATUS_ERROR\n");
+		return -EFAULT;
+	}
+
+	if (status & done_bits)
+		return 0;
+
+	if (status & BIT(SVC_STATUS_BUSY))
+		return -EBUSY;
+
+	if (!time_left) {
+		dev_err(dev, "timeout waiting for service layer reply\n");
+		return -ETIMEDOUT;
+	}
+
+	return -EAGAIN;
+}
+
+/*
+ * s10_svc_send_and_wait - send a command and wait for its reply
+ * Returns a negative errno from s10_svc_send_msg(), otherwise the result of
+ * s10_svc_wait().
+ */
+static int s10_svc_send_and_wait(struct s10_priv *priv,
+				 enum stratix10_svc_command_code command,
+				 void *payload, u32 payload_length,
+				 unsigned long done_bits, unsigned long timeout)
+{
+	int ret;
+
+	reinit_completion(&priv->status_return_completion);
+
+	ret = s10_svc_send_msg(priv, command, payload, payload_length);
+	if (ret < 0)
+		return ret;
+
+	return s10_svc_wait(priv, done_bits, timeout);
+}
+
 /*
  * Free buffers allocated from the service layer's pool that are not in use.
  * Return true when all buffers are freed.
@@ -159,8 +222,8 @@ static void s10_receive_callback(struct stratix10_svc_client *client,
 	status = data->status;
 
 	/*
-	 * Here we set status bits as we receive them.  Elsewhere, we always use
-	 * test_and_clear_bit() to check status in priv->status
+	 * Here we set status bits as we receive them.  s10_svc_wait() consumes
+	 * them from priv->status.
 	 */
 	for (i = 0; i <= SVC_STATUS_ERROR; i++)
 		if (status & (1 << i))
@@ -190,6 +253,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	uint i;
 	int ret;
 
+	/* A reply to an aborted previous write may have left status bits. */
+	priv->status = 0;
+
 	ctype.flags = 0;
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
@@ -198,23 +264,11 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 		dev_dbg(dev, "Requesting full reconfiguration.\n");
 	}
 
-	reinit_completion(&priv->status_return_completion);
-	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
-			       &ctype, sizeof(ctype));
-	if (ret < 0)
-		goto init_error;
-
-	if (!wait_for_completion_timeout(&priv->status_return_completion,
-					 S10_RECONFIG_TIMEOUT)) {
-		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
-		ret = -ETIMEDOUT;
-		goto init_error;
-	}
-
-	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
-		ret = -ETIMEDOUT;
+	ret = s10_svc_send_and_wait(priv, COMMAND_RECONFIG,
+				    &ctype, sizeof(ctype),
+				    BIT(SVC_STATUS_OK), S10_RECONFIG_TIMEOUT);
+	if (ret)
 		goto init_error;
-	}
 
 	/* Allocate buffers from the service layer's pool. */
 	for (i = 0; i < NUM_SVC_BUFS; i++) {
@@ -287,7 +341,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 {
 	struct s10_priv *priv = mgr->priv;
 	struct device *dev = priv->client.dev;
-	long wait_status;
 	int sent = 0;
 	int ret = 0;
 
@@ -320,30 +373,15 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 		 * Always wait for the completion rather than skipping it when
 		 * priv->status is already set. The callback may have fired
 		 * between the CLAIM/SUBMIT send and here; if so, complete()
-		 * has already incremented the done counter and
-		 * wait_for_completion_timeout() returns immediately.
+		 * has already incremented the done counter and s10_svc_wait()
+		 * returns immediately.
 		 */
-		wait_status = wait_for_completion_timeout(
-			&priv->status_return_completion, S10_BUFFER_TIMEOUT);
-
-		if (test_and_clear_bit(SVC_STATUS_BUFFER_DONE, &priv->status) ||
-		    test_and_clear_bit(SVC_STATUS_BUFFER_SUBMITTED,
-				       &priv->status)) {
-			ret = 0;
-			continue;
-		}
-
-		if (test_and_clear_bit(SVC_STATUS_ERROR, &priv->status)) {
-			dev_err(dev, "ERROR - giving up - SVC_STATUS_ERROR\n");
-			ret = -EFAULT;
-			break;
-		}
-
-		if (!wait_status) {
-			dev_err(dev, "timeout waiting for svc layer buffers\n");
-			ret = -ETIMEDOUT;
+		ret = s10_svc_wait(priv, BIT(SVC_STATUS_BUFFER_SUBMITTED) |
+					 BIT(SVC_STATUS_BUFFER_DONE),
+				   S10_BUFFER_TIMEOUT);
+		if (ret == -EFAULT || ret == -ETIMEDOUT)
 			break;
-		}
+		ret = 0;
 	}
 
 	if (!s10_free_buffers(mgr))
@@ -366,35 +404,22 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 	deadline = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
 
 	do {
-		reinit_completion(&priv->status_return_completion);
-
-		ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_STATUS, NULL, 0);
-		if (ret < 0)
-			break;
-
-		if (!wait_for_completion_timeout(&priv->status_return_completion,
-						 S10_RECONFIG_STATUS_TIMEOUT)) {
-			dev_err(dev, "timeout waiting for RECONFIG_STATUS\n");
-			ret = -ETIMEDOUT;
-			break;
-		}
-
-		if (test_and_clear_bit(SVC_STATUS_COMPLETED, &priv->status))
-			break;
-
-		if (test_and_clear_bit(SVC_STATUS_ERROR, &priv->status)) {
-			dev_err(dev, "ERROR - giving up - SVC_STATUS_ERROR\n");
-			ret = -EFAULT;
-			break;
-		}
+		ret = s10_svc_send_and_wait(priv, COMMAND_RECONFIG_STATUS,
+					    NULL, 0, BIT(SVC_STATUS_COMPLETED),
+					    S10_RECONFIG_STATUS_TIMEOUT);
+		/*
+		 * A late completion from the last RECONFIG_DATA_CLAIM callback
+		 * can wake us before the reply to this request arrives.
+		 */
+		while (ret == -EAGAIN)
+			ret = s10_svc_wait(priv, BIT(SVC_STATUS_COMPLETED),
+					   S10_RECONFIG_STATUS_TIMEOUT);
+	} while (ret == -EBUSY && time_before(jiffies, deadline));
 
-		if (time_after_eq(jiffies, deadline)) {
-			dev_err(dev,
-				"timeout waiting for RECONFIG_COMPLETED\n");
-			ret = -ETIMEDOUT;
-			break;
-		}
-	} while (1);
+	if (ret == -EBUSY) {
+		dev_err(dev, "timeout waiting for RECONFIG_COMPLETED\n");
+		ret = -ETIMEDOUT;
+	}
 
 	stratix10_svc_done(priv->chan);
 
-- 
2.49.GIT

