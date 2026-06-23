Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901BF367B8A;
	Tue, 23 Jun 2026 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208069; cv=fail; b=pSoOp+ZSh1p8SarKsx4B0N2qlJNg//R8lk0SoCjytqlVPzHX7T7J8PHXN0jiaWomqHWLSTuu06JfCIca79yPeINskZ56r59zB+z/iRgxURTgfEOZSmik9PiD58Z+ieH63ejlqfx+E4eUsDS92LeaeXLACr00kNHfs6RW37QjDLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208069; c=relaxed/simple;
	bh=6f0RD5+KuYM5vEbA4ObqizFyDwTshpAPno8B9hAWqy4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xcdn4AqGU11cPFE7/9YOvt3ErE+yo+VuR20txq8Fhn1Erg8uZnjns8+PKhdKGK82v6eXb30C34r9mIIKUSlSFs3DuFZ5Bcy4QYV7ITfS3d1RMVNoI/KKX/DMjfKqUaWUom/cWQwNi9PUhpyK8LRVs+jygfEsavYhlVw4dIS/u3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=N1eri/yV; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="N1eri/yV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpxF9N8D96jgVZC0JPKUrI6Y/2IhGA2o6WTbak4+tBhTHJpOuAunUhpzdQhDkhXHFhWUJMs3ObpS2mSKod2VURY3CmDuvVSr+mRGSieH43pv5QlkJjJwzZxddVo4peZHxheINawjFIgBKy7gP0yXhJ1Wf19J60+IEhpBCo8jGkL93xivr+3jRXSf/YOShSFohbadeiWJS0E4sQ32yRhiXpl/nd+4sIrMDXBS+efubT+RgEU1cO4/vbc9qvVq28Ko8ZCGhtxYVmB5ZTWChLeCi/l2hCyoGU5vnf1Hr0WEZBzJTVabb4rYVCZGG2xjMzZBTPKXe427iU1LpbbvyTkJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mnJwHJxVyMugmK4WkU7Dvrc3l66BFspDod6ZEBwd4M=;
 b=lEmhNB0mn6LgzcFgjeTutcOgK2OrHklRWjXp+fJ/ete/hRD4zZ6ULtgutyZvpt99WICZ+QMBHQG9t9TO1Tcm//mfoAkq7Z4O6fnRoFCUpvrJx+Abq1ebtsCMCXvP+/NjyYjjykcmkCDWyvrRhrD3lGUm4gOMH2D+Ui5n/D7Q2J2Z7ohKgWntoJ5KrGaoqKmg/bf6zZ64UTvL7bZxMSiAHQw6kUnAsFWxGu8CwEcuIPGjn3/ALClAEFk92jdK43zbIne13saRNogCONJ+oLSbFjSkRlbI9msaA4LI/Ql5URcpu9Q0FPXTg9rCesjxI6MrwJLWlQCblnOce/KnW0V8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mnJwHJxVyMugmK4WkU7Dvrc3l66BFspDod6ZEBwd4M=;
 b=N1eri/yVJEkHpmidR5Cb4Gl5O0DRu3u64DXOD3QZvITIX/O5lHYsNldpPen4gptMKd2ttVjF9g/GIEEYPaIll5yfgEM2Y4f3pdUJB4piKp3T4VMhElIJ8u0hJk5P8PuSkpIZ7y8+ArM7l2811TXEY7iV5tQ6J9jc1q5OyCsGeFf2XpU1cTSSrKXHQ0CBa+NoGSKbVSJYzLhTwVpwvI9J1kUWxJmKTrGAdq050WVSIHKianHOvwpjdXy+ljz5KVY4PEzwDL61kMZV0gwZq+ch8fX7U/5CLrV5xdvWGpyOKQqR14gDGprhgTJ/cXpT5hqfbGyof7+ZIog5nvGWh0hEJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by LV3PR03MB7681.namprd03.prod.outlook.com (2603:10b6:408:289::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:47:41 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:47:41 +0000
From: tze.yee.ng@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: stratix10-soc: Fix SVC mailbox handling during reconfiguration
Date: Tue, 23 Jun 2026 02:47:37 -0700
Message-ID: <3fb9ad8196d00860f7d4aa2e0394a271f5ad0cec.1782208001.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|LV3PR03MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e53a6f-abe3-40d5-66ff-08ded10c77c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	hM3Rm/f3zDC3gG8hvQS5NzWhNNrZXQRUtBNenkYyDPScKuH8MvFjgq7f+yiohL2ZwhOQs5a9qxZd4bm21Cza23YPyl6Xpn+MGlnPaA3/rUGiufuDtS7oQivTB4rNhtNTUVelgx1DORaE/R6d/ZYYDHa4fIQ7n1OV/KNXq0Fl9M88UOeVm75J1Kvenb+JLoUV8aRy+aaO+h3P/ybbdUzuhZPXbP3u3A49Qj0psrGn6Ehq94ONvMpal2prbh4yIZEs3oAMDo6xGcRcs+OiYdaHfJIszcCScE4ss5IGWq0K+/hbmDBqPhnml/pXEZcjxibuOLyuKHAtVyZlrxWAcsUzkYMV5qY1aprqyk/d8YQHdCHfZvG8DI3Ah0G9frlaIB+EVxeFTWN74K8WinQc9SsEfWtqPrlSxz0QZTiKCnSAfUp7TYHxIBh4S+nXATIyri7SRYyDsPzL/kq1MZKiop6nDpa0J+j2qydAEUELkBTuUVN0jQ3faZAMKtlKYFZlceALYFS/WKAnYvUj7r83IJOO8zR1Er/OmPVW4Pq3ceuy+8sFoOU57hq2hU1vQINYakifdhswbCZLoIkD1tHrUG/pprKua4zVoWb4jsx2buiYh6PGkdcCZQZGccI35eKzu3V62/JV3lyq073IXZ7WSQtQRXc8oRkxCo7w6+no5Y/hQm4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iO1yNFih4JZyOr332Z0tOv+KAZlxS9lWu8pmGRUBXLfK89zZX2pc/3+g6syT?=
 =?us-ascii?Q?C/8RfbZDjBjgx2BgB9rkE12snymIlfVvs7wXdsz3RXKLCYzhmlhkEdYFrCo0?=
 =?us-ascii?Q?FpJd9VOIt0HEcSj8Xg/HNjWay81VAV6BjeaoaPqbO7+ghtaiO0An+BDqXkuf?=
 =?us-ascii?Q?1U1uKfoYwp/YErssn+bNADtNvRS/RMftaeJttl2CNvgvTu03sZ+4uX+2RIJU?=
 =?us-ascii?Q?OSxl9PY8BTiPcXn7cr2K0tEFxwYzbngumEw+eGyVzsiE+pBlJwSk/saHj+an?=
 =?us-ascii?Q?dGQEc+1AbJumWt+zoCO7SoZ8yl93U6Ay43j8Rrj35kXb7U9LzinYRSb64A8U?=
 =?us-ascii?Q?6JqgEET2JqUVx74gXCQWURo1+QM7VO22NMBU+/zANj0/9+mgI1ylVx2EmqRv?=
 =?us-ascii?Q?lh9ldAFtyBAC2S3jcuZdvN+RxP53zu5jgmD7/EGu3VP1lV9gqH397wS1vi0K?=
 =?us-ascii?Q?IAXkBIpuxALqFy4h7KiENgJz95g6It4F5Ta8BqGaYMkp3ak4zIi+4e7EfuEh?=
 =?us-ascii?Q?XZd32oifUEYbBe3rYPyxTsWP02UdTem7gwNykzEroqPBWS/gDKxVwsPnaBWt?=
 =?us-ascii?Q?yUNp9z6n/WIKxFS8sNhx/hPody9Np8bTDDK09B2rjJMwrqTpyk94L/vN2YfN?=
 =?us-ascii?Q?7sN2phZa1qElt2xNgX2TwjAhYXpMXTVqFK3/6HHMRkicD/jDVwVfuYVKDK2l?=
 =?us-ascii?Q?iblxytb3ei64fvlVUXszIo/CGzasR7Ys1TrkPmyRLeLOPnHiaaYZ+wYUSoyF?=
 =?us-ascii?Q?S7lUnF0PaVxf//NLC+gS2DL2c4YSHSI9+NwfHzgC2XJYZFnrfxp6HjIVbiea?=
 =?us-ascii?Q?9E6eHdBXcMyaqMzwJhEiGUFUkcCfwucZBgDTCbjZWnVejIkpbzyZIp1K3pv9?=
 =?us-ascii?Q?jZ5B+rTyPytcLwQArPvNRbF23hWNd+366GakwRa/4yTV3KWaaZUNJk041K8m?=
 =?us-ascii?Q?KF6gU0XlGIpVOxydmZahj/HG7XdYrp9hpKXRBh2jZULY3/XbgWzfpvkoJ0uk?=
 =?us-ascii?Q?c3uLd3GpOqZY7744TiERzN1KZxLCJiYxndviLWSgVbKSpxhooZq8cCbSY1te?=
 =?us-ascii?Q?tFPAIFxDAIt78pbmdG3FKcpbudvn3QCKLip/XguSTPgcNB4sgfRDXhS7AqgF?=
 =?us-ascii?Q?jlt9mvdcJ9bgF59maMfZ+U6Zy7/qd9mX2iC7eyfs3uCdg5bNUD2bsR1TgVCI?=
 =?us-ascii?Q?uo8pxcUeqQS7KZa4NG+bwVnCuPAi77gmpQALk/OYZi/h6VTY+UDIbQZM8KQi?=
 =?us-ascii?Q?zaQR/6qqt/NvyZmduv2HT1YkF64b/s2NUdXC4BzNIEXdJmCDioIcIJ+aPkgM?=
 =?us-ascii?Q?eEv9eK5Rj2X3hEOo7wD5Bl2dZ15P+otzhnRYviVEPprKJeXzNQQyuyqLVUo7?=
 =?us-ascii?Q?vfrJKTBIoXCranfG34WcLhpr5l3xvrXREKOih3uHIxAJB7+mTrzORzUcyR5W?=
 =?us-ascii?Q?0SJ2HJQIb3LcvXz+WMqVHjqBtTdg7RcpOi4RcABKyheOnnMWHVoSZz4lMGJb?=
 =?us-ascii?Q?Q3fGv4p0ee5iwxsROd3E2W4dfk4GiJtDHJkOGWbQM++EyBWXKz1SldtwgACT?=
 =?us-ascii?Q?fv18cCMVT6ag+NQJAlkv9k3lj9IEPEecBePR8uUREdPi2fZI7l+J//iY/6a3?=
 =?us-ascii?Q?7av6xZc+BFaUCsllYfphA4YcdJoPPhIhuzO4y0+iTRbf7dXTcs1xOKCMb1ap?=
 =?us-ascii?Q?BX/UNggwF1NZBh0uipnvWdVQkLS+Xd5qiKqgMEO34uiAg+zehEWKvp1LP14i?=
 =?us-ascii?Q?MdKXDfIsuw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e53a6f-abe3-40d5-66ff-08ded10c77c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:47:41.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPaBQy/tXhJ8unqnUEAW1tOI+JI0ZgMfqx0AXfybS9eHsNrPfUjJzBJSsClt3RPXIaACAGrSF2YtvumBNdWh7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7681

From: Tien Sung Ang <tien.sung.ang@altera.com>

Fix incorrect stratix10_svc_done() usage during FPGA reconfiguration.

Do not call stratix10_svc_done() at the end of write_init() on success, so
the SVC session remains active through write() and write_complete(). Call
stratix10_svc_done() on failure in write_init() and write() so the shared
SVC mailbox is released when reconfiguration aborts, allowing coexistence
with other SVC clients such as soc64-hwmon.

Signed-off-by: Tien Sung Ang <tien.sung.ang@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/fpga/stratix10-soc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..0d07d303bad1 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -195,20 +195,20 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
 			       &ctype, sizeof(ctype));
 	if (ret < 0)
-		goto init_done;
+		goto init_error;
 
 	ret = wait_for_completion_timeout(
 		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
 	if (!ret) {
 		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
 		ret = -ETIMEDOUT;
-		goto init_done;
+		goto init_error;
 	}
 
 	ret = 0;
 	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
 		ret = -ETIMEDOUT;
-		goto init_done;
+		goto init_error;
 	}
 
 	/* Allocate buffers from the service layer's pool. */
@@ -216,16 +216,19 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
 		if (IS_ERR(kbuf)) {
 			s10_free_buffers(mgr);
-			ret = PTR_ERR(kbuf);
-			goto init_done;
+			ret = -ENOMEM;
+			goto init_error;
 		}
 
 		priv->svc_bufs[i].buf = kbuf;
 		priv->svc_bufs[i].lock = 0;
 	}
 
-init_done:
+	goto init_done;
+
+init_error:
 	stratix10_svc_done(priv->chan);
+init_done:
 	return ret;
 }
 
@@ -342,6 +345,9 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 	if (!s10_free_buffers(mgr))
 		dev_err(dev, "%s not all buffers were freed\n", __func__);
 
+	if (ret < 0)
+		stratix10_svc_done(priv->chan);
+
 	return ret;
 }
 
-- 
2.43.7

