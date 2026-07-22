Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1692D3EEB;
	Wed, 22 Jul 2026 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703277; cv=fail; b=ZEKtj2LR1DpXjl56ov67vf/K7OCIcNpr+M0tgY6NNYtLJsfT+R72JTfN2ORjhYmcFSxw06OQHuw49vN/ExbsJ6GwwXE24YX3GcF+KAL2GcA6aYT+g4dd6L6Z3GS45ZmoepdBOp6umN5TFLV5ah6W4rpxFdrpCHgFoOITcqy0PLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703277; c=relaxed/simple;
	bh=AzbSTVmFlaS0picWO+Y1WpAPa8zH1z2FQCY4Yqg6QyM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SZJdeDXsKJWGelxR7v4CJpUWzNkanAlLAS4LTUJjllizHQ0CnbVwNyFZWN/WCTN/s+7BOmkaSI2mHFNz9K+th7Q2c/C+og5Y0lGUQx8p1E1A65C1uPui+u3Zt0yr1Ag8X7d7RQei9PuupsMeEApzS+R9QX7HviJ8+aPIpPxUIDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=eiFsGoP+; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="eiFsGoP+"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M50Lu1323061;
	Wed, 22 Jul 2026 06:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=9Gz6AMHwg
	4l/Y/oo0LahofPQEeZyqCLsTl3VckTqKvQ=; b=eiFsGoP+TqI5xAnpCA7V3JCxN
	Mpn/2rUlGkpLY6UUYFOmau1OuXNTjE8Ds5hg5+e3Lz9LpL7JkJsf/SqOOLPJzupz
	RX9Pnlpi83poiTwDLlu3ED6+LeGqKox4aBiQzZDtjNKDZqlMXMD9qXNpT6ry6j+e
	tz3m//dauq4aZiqElctWePWTXP1Uv9P1HyrfyJdq4ddtvRZws5sqNipkZbCULxJV
	cg66RdL4+Gdx3j/smsiKmtr2Bd99MQqKq38Yq7udR3ale6ci9XvuRd3FDKGjQE57
	r7klnvxCYqJ243UYPJSHFdd9CU+GG41ITfqv1ACX36w1XHl9RoDWusuzuw+vQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fga8x7636-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 06:53:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eay5+0UUYq9+QAHWUtYe5n+ctF9EeKq0mXD3CDKSdxwF4w28LCvOd6FKYJh3qVHUVj5lxGuUSLFUr9kXkh+2ulmxVHMh9XW+BADwyblv9ColgSKdo9Zsv53veoKCdCzPrt7o6H2ekYw0OQk6WUuloeWsVr6IVbCpWiyGgAlkXyN70uFIlWwpeWi7ybhx0d4rHj8UjOBf8MlYN+S/eTk7yjD4id0zi9tRsfqOIBlKjQOzKYpOYpubWrVNkHTAW8GzZKq8MUXnHVi4jB1WBXw0eRrI6+CVuDi6ZEMqVOpcsHi/VaFwBd9tzjoL0IZC2/8JoBep+i/J85ig4j05Kl3n6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Gz6AMHwg4l/Y/oo0LahofPQEeZyqCLsTl3VckTqKvQ=;
 b=TTH/TzMJKshkGaxesn2XRawACFvcmWrtRA8YOiSjSDn9rQf8TN6/0rTtZza5oT64L3S8w3AJc3BhbClmeKUqyeF0FKKpRWNyJof0mlshHZ/ufx63EaAhQIQkBRd1fAUr2ZMwMYRJ6igTDb7ywLnoR+fXX6agUc/6V5nrAmd3ZUltVOB6pM7fxyAiCh5UqAXwWDmSBkoKmzRSqTXtdwohDZjLdoz1g0Sx/i6763ylFD/3UH1ompuVaKtmJbkcMCBk3Fo5fKWW5FszW1/3q/JjQuAHJiTqZJLq2r9DPX5FpSrGG28LZuV2suYIO/HRA4Eha99H4qWUrOZs62X14dea1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH0PR11MB7422.namprd11.prod.outlook.com (2603:10b6:510:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Wed, 22 Jul
 2026 06:53:51 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 06:53:50 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: linux-fpga@vger.kernel.org
Cc: Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Ilpo =?UTF-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Russ Weight <russ.weight@linux.dev>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tianfei Zhang <tianfei.zhang@intel.com>, linux-kernel@vger.kernel.org
Subject: Survey: anyone running a fully functional in-tree DFL stack (6.18.x/7.0.x) with Intel N3000 PAC?
Date: Wed, 22 Jul 2026 09:53:28 +0300
Message-ID: <20260722065335.9517-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA1PEPF00005B8B.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::63c) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH0PR11MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: dad7f7a8-c136-428f-2f88-08dee7bdfc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|10070799003|366016|1800799024|3023799007|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z1HymdMQPiOpfCXlW9yzZaFGazFPt1pjypZZF0rN/YLzJA0YwAfwHueOOZr6Pqo2EpRi6yzKlbtHRQXwT98lABujxrbNzvf0BQhVRf+Dy4Zj/FfTjPmvuUfZbgR7bUwOuJ0wlNVKmaZo8ozgiZ/Vq64uRBe1jPmStDT4o1Z/2GssGNd5EmAFoz9E/+7rBmTpTbr9JtPIWl6kbg7PeUH6K1lIX4YlWuQ0DZ80QVX8E9e3MVTC7UeV5TMywWEGPMXiKTQke3kTSb8EGtJGxVUPlpKiBX4O1AONcFiHrfOFQTOk6zy4xFtxMQniRbYnLRlUZpOidVYxQ4/i+qiQaj8/aHSHcw7q9JOOqfKF6T8ZAWrTAC4B2TIYzI+Wr3EzyB9dZ8cHiT8qXPZGIHrXVBcEaX3/2yYm4g9R7+GxI+6iCs8yI4Z/lS18neoCj/2f+ulEUgG9RESlhiEwujW7ZGbe3ADYyS7JHsGrAjJR6Io43wkNWDA113vgWQ5WdGiYcO+YzEJrKcmficw8wg+u8K+pRnVfUggP7Szeb8tQ+08+GYibBqZpoMiTpQLeDYx85oydf7lC+LCvlExN7NOFLLPt0X3qiBkYP218VO6MgwEUC4Vbz7f9RWDlHZr1oSW23Wn/NQ8+wQ5188Rm/3jDxZp0hn+BRyNE3H3CNRKQJivw5kk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(10070799003)(366016)(1800799024)(3023799007)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3DjGhRXUexj5ourCaky2DP7rOKzxZ5szFRdXe9AI0AcERFZxeVLzA4R6k8th?=
 =?us-ascii?Q?CNA9tB8kWXU0OZR7A0iAYO+M+Hfa/R4EYeeM5lUa8fji/CdHg4xNEuPUoE3m?=
 =?us-ascii?Q?EPSI4WY4AMbopemlcp9ZCji/jzsoT6Ur2MzvKKOlYTWD7S60IKgfbgpreWMK?=
 =?us-ascii?Q?IM9cejiDY1ycvzDIg4ucRagS3neIodWVeOzCFlg4PQ+y0jNp4xueHM7hQY7N?=
 =?us-ascii?Q?/hEc+b97zPlvjq04Do+QihSq8xNGfqDxKvyXCsrMwJbqyt4kSFh1aG94zOGa?=
 =?us-ascii?Q?n9CuEA7CPUnRPzf7pi1Tu6vlvMrMT6+GcuqPrNEwVm9SVzo2kvDR1rtqTumB?=
 =?us-ascii?Q?NNJCgYXJaLB07Pa3ZZgmYRKNwhsLHJcB+2OnCTomqwpi0FEfHLVqNAXsPLn+?=
 =?us-ascii?Q?3xyQgaIt39ECazmnuZPK/iCK+BhTbBVSWFsWF9dUSFrxoA4yhamVoyePxIzt?=
 =?us-ascii?Q?8pc2U1AWqjEIjAwRZI8SDSLL7vnuVyW+VhSlHWqlvsLBMhu2vFK1x1LGnbAw?=
 =?us-ascii?Q?qzAgp2yXL2nq7oXgEVx2XMzMzhNCRsIO6WikKNx/QItIo8poEztiHxDMoqRU?=
 =?us-ascii?Q?adIFoiYMDXO6CFH6cHSLHw0EupN8P1cMpyzoYw9Rq7u8alwAhs+fSKotYxC+?=
 =?us-ascii?Q?TRBUpk+GJsa5qpasx26UunLZ92s/dJCzXs183YeR3CaxPEWpK1nJHJxbTO2u?=
 =?us-ascii?Q?wg7Hs7crsLUf7xNpc3WoMMN8++5pxIvQM0wn2n2t0+dOnlyExJtc8wMTcpts?=
 =?us-ascii?Q?HoZe1xQzPOfruLxVbrhdhW9GcGfQGXUjj0eeJ/tC1IdGo7vBAcQ2OD7h9U4s?=
 =?us-ascii?Q?bjfEwpVheAKqtVxpUDPo4+xZx4DvvUunK59GtEBe/MpbaSZfkK4/l81+jwPs?=
 =?us-ascii?Q?QHqte6L0zOEoYerUZTvPN/lPqoiwUrYHH763+Rll62JmL7Uhw5zhY6t4qkv5?=
 =?us-ascii?Q?GKb0lBGLl16azGb0mdJa6FMPA/Ltbua0f/67G72Y2BGvkIKPhP8UpQNQTtwU?=
 =?us-ascii?Q?nxPixCfma2Z2Bqh9gwAhTrdmkbPASpsNIsnc1TSUsTn3VfXgYoqp85JDEH5Q?=
 =?us-ascii?Q?rTV0A8n3cMCyTtS8GuSLKLnOp68C5W2RRqu+R7s4wGBX5DHrs9rFfs3BrPaq?=
 =?us-ascii?Q?T8tL3Q0qXsDYiWF6jiHLdqL2z0x5lN0jiukq33t7TMZDpVO6RbHHpDhIeJ4P?=
 =?us-ascii?Q?OMN3YUdXI4gUx7FyOYy9Ljhiss4mUReY3+qJUFL0QBDZzRrsKVj4VU0Xco3v?=
 =?us-ascii?Q?24HnTNB15Hl05a1hLj3BLBveI768Ops0UNUF45kWChj9OZBWgJTaoB1sUqFH?=
 =?us-ascii?Q?+pn4SkTu/W0WkjUwfh09Lj4+xuX7FGreW8dZ9YbVo2mDTX1z/gx9ltZaevgD?=
 =?us-ascii?Q?JZKDulJFWVwFKxvRHZxUk5DrYInA/IohevS4yI5IEVgqRlN0IlpeQ1wzx/tX?=
 =?us-ascii?Q?VQtaAllN3pO0XW9MPv8uuAQWIo4AT9TuPt3P2LmnnsbPZgb6SGv3kdPavf1W?=
 =?us-ascii?Q?d1hiG7T3rNlw/ppGqwjjSqpoYyg00MzDpGzCec2NyChkKApz265WwjL3+HjR?=
 =?us-ascii?Q?yHAQDbVAddYOLsqUfVGY4BbBMS1u7wsPtygIGbC5u0YsrCCqssIAppP4rH9y?=
 =?us-ascii?Q?7NBbYo/7CtXweyXmtfZ1sJCFuPSce6o4sdh9kB9cIzQ7KUsmIGd52NantqD5?=
 =?us-ascii?Q?1UhlvrtS/CVXHKcUslwX1DnEbvPAz/IV2vfvrDXSPu8KbvcmKs0lsUW22W8l?=
 =?us-ascii?Q?u5+D0iasw3VEs95AOx54/Ip9a0fl6wMYF+Hkmh4RwjoWvENyBrqyxuhA5VVJ?=
X-MS-Exchange-AntiSpam-MessageData-1: ijFKZJ+1DRY4lA/NKxi8xRfTpogoKH4qNGs=
X-Exchange-RoutingPolicyChecked:
	KulAW7TeKbwcPK5uUeQLoRMwe2kTcnyzGRaw9x6f3RTrJWuIXmeGRJaO5N1TNESGiHIli6YlUmh1hUY34jEa6Zd1apMUGDCbpudFMyxYHLZQioti9fCcuvFeiqpJZbCXej/jkWfNY68kmv9c+rO2BjTFxvSGbncaH6ruF1tJe1h2QH7Epwhcy1fFnzo9irMv0ebseeosYIVAJxotL5+pDXx38T5o8jlTpTV3tbVoavWR67H9LAvQCqzD9DeT8fom16mT4Bm1z3373OChVx6FJYsps2APDatwiub+1Z9JoAYAswyf4o0HTFh1zrerUgywTi+jPK9JuL2LbIvi/ihxHA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad7f7a8-c136-428f-2f88-08dee7bdfc56
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 06:53:50.3855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyIFwzRj7WHdt/3a1CCwFeq5d6uG+kGikUa+/hxaXQ0meEXQ27pWv50ZXYx+JAr+5rEzTGoZPYLRmWGgjNf6wj5VSNXPB5MAwSQi1/eB440=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7422
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MiBTYWx0ZWRfX1oeDnj9/cV1/
 jJl5A1dYzXZF6D2rsH8BCuEjJotFqJbwHOseD/jY+WjwgqPKpEcgbomHVNCqLzzx1mEGk46nS4J
 cxMlkaZkRjG7rC63nDexXn7fMKxx8rObbvnlkYYQYjJJLPy1TIQj
X-Proofpoint-GUID: HGXkXQvne-W693EZQ9nsmNNBtJYQOZbq
X-Proofpoint-ORIG-GUID: HGXkXQvne-W693EZQ9nsmNNBtJYQOZbq
X-Authority-Analysis: v=2.4 cv=XdO5Co55 c=1 sm=1 tr=0 ts=6a606901 cx=c_pps
 a=CcIcsZDwO3wB2ho3dvPJ0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=jfuG_7YRbuOuYcqkwy0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MiBTYWx0ZWRfX199KUcqhUMZ9
 xcvK8UbA41kM1wwdZy+LJ4gRZQMq/74nRa60M3uBRw4ZwbljxOnq5jbavf00eAu2mCJqBp+jHvC
 w0vodMl4R15l3pRdUe9CV6UhQBMeni2J5mzCLiXMqhuOQ2AWBO6UKApDkxqIVx6oGN6zKZ5uxza
 7U2MSkHOwqG1iti/nJLTXKp7ke0wwkVuc0yCur/A721jutxWZqFhtMwElOh/sxuvgrAsGYVa+WQ
 FQQUcsyNzFOshX8g6lsuxOUFSkD+IUo6++TZUAXxBtRKlwK8ZQhDF/53oNLYJbICuhum0gM3X46
 IspzJ5n998+TVRqbN51s0SAsvkE74qMUUuyt7mw4Y0FMXBcGzEJnF6j6nnfJwj7qbgP/Ig5Re4f
 SxTG9j1pnqN8UXt7xEvrKmoinI7M2hFXj3FtwqOUO9DCbI+hHG6zUYiVGMibwUY9v/wmMg0ZtGy
 zMs1DD9QBugYC4NM62g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 phishscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220062

Hi all,

I would like to ask the wider linux-fpga community a practical question about
the state of the Intel FPGA PAC N3000 (SmartNIC card) on recent mainline
kernels.

Are there organisations, teams or community groups out there that currently
run - or have previously validated - a *complete and functional* N3000 stack
based solely on the in-tree DFL drivers on 6.18.x or 7.0.x, without carrying
the out-of-tree linux-dfl tree?

By "complete and functional" I mean roughly the following, and I would be
glad to hear about partial answers too:

  - DFL enumeration and FME/AFU access via dfl-pci / dfl-fme / dfl-afu
  - MAX10 BMC (intel-m10-bmc) with sensors, security/root-entry-hash sysfs
  - Secure update / RSU (intel-m10-bmc-sec-update) working end-to-end,
    including the card coming back cleanly after an RSU reset
  - PKVL retimer firmware handling
  - The i40e/i40evf side of the SmartNIC: PF bring-up plus SR-IOV VF
    allocation surviving a card re-enumeration
  - OPAE userspace (opae-sdk) working against the in-tree ABI

The reason I am asking: we are moving a product from 6.12 to 6.18, and while
6.12 behaved well, on 6.18.15 we see i40e sriov_configure() fail with -ENOMEM
("not enough MMIO resources for SR-IOV") after an RSU reset re-enumerates the
card. That looks related to the PCI resource-fitting rework in 6.15-6.18, and
we have a candidate set of setup-bus.c fixes queued for testing. Separately,
the in-tree m10bmc secure-update driver still lacks the control/image_load ABI
that linux-dfl carries, which I have proposed for mainline here:

  https://lore.kernel.org/lkml/20260715073854.26117-2-ionut.nechita@windriver.com/

Before we invest further, it would be very useful to know whether anyone else
is exercising this hardware on current mainline. Concretely:

  1. Is anyone running N3000 on 6.18.x or 7.0.x today, in production, CI or
     lab? If so, purely in-tree, or with linux-dfl / vendor patches on top?
  2. Has anyone seen the same post-RSU SR-IOV resource-allocation failure on
     6.15+, and is there a known fix or workaround beyond pci=realloc (which
     is a no-op on the rescan path)?
  3. Is there any regularly exercised test coverage for DFL-based cards on
     recent kernels that we could contribute to, rather than duplicating
     internally?
  4. Is the N3000 still considered actively supported in-tree, or is it now
     effectively in maintenance-only status with N6000/PMCI being the focus?

Any data point would be genuinely helpful - including "we gave up and stayed
on linux-dfl" or "we are still on an older kernel for exactly this reason".
If there is enough interest I will summarise the replies back to the list,
and I will of course report what we find on the PCI resource side.

Thanks in advance,
Ionut

--
Ionut Nechita
Wind River
ionut.nechita@windriver.com
