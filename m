Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E22BE625;
	Wed, 17 Dec 2025 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951154; cv=fail; b=SBaTT4FZhjytZbqCvD3MCL+wXWWCbyJFImjHEd8sgLkyhVAQ9GR4eLtMP6RTDzYSCGdLxkiZtOj3Ai4FYPh1PUxtFYwPIXP9Hgi3Eb+Ufeo88MTAMmrxKK6bcq+pt47HEukqKt5F9LImF6zQ1IX0su7zwJ4s9Fz0n88KDrPb71A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951154; c=relaxed/simple;
	bh=yURq3HxgBHsm8RHjxPSkNeOR4baBemb+NmXzfL5A0OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RizdUIPUChgrxy3Zy1+jSF5rOO5E5XOFMKiW9k2QvURdW8VyFifdxtu+s6m6kRMR5g+MTgO05YKN8cQpd/HZDDFEk/ljd2iY7tqr4W3Gv3hJkuD8AsvThko61+E34Zrf/U/tm7p7/LppkwhvJdEELkHty7RWr+6PmTHmZrYC9y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=A8TJ4L75; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="A8TJ4L75"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqYVULCW8CBzMeA2KUrFCCa1i0ElErjuu9RhWoktoFrqanmzjK7eH2oYKYeYeBX0RxcM4bEReaTyk6EVYXR8M/3+bW2TlufqqS+j3tRwLsHSeKvfWwh0vXyHeiPkO2qqTjpe1nQ99B5HjP8BBWkvPrpd0c/zA0ATDpZXMHivP4PSRltbmGnxeTVDeeIxoKwZu3aPqazP4e/ddzNdxZHviOTCfD6e63A+wDoOmurQZWQL2/apL0wzjGGp/u8Lug0E5Ei4dkF/+63xPluuNDcnrcl5oEfnfnuS7VvF0Y9cPM3TGQNbmQ/g62PO3g5UAxUo5jK1exCsFTk4xpG4qMR8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ozqk7f/Wew7xMqgFlWX9SX5/uGfB6gskwYbMhqKrg0=;
 b=wC5KvMi4taatpeQWpOXNQfkE3siXSlsNsNwLd9YSoe/Vwm+WqeGJhZOMQzrf0WLKq01lPkiWOTl6dBeCP90h88G+54vTXcYJ83wm5t1b3aOE7KCskXwcHWcQcfHuC5ydoXHb/VMnK0QNKvwk34QFIbrjua8xC21jKfSHtVL2ytLpTXKQwwgy4ANrOLgZbQJ6WKvxO+M+5JCmqCUPTKBOXj5NC+TipZxzj09KXVhHQB9AjIdLgFLWvXVEfB267khQObb2/ALTma+uPDijKPDTnYWWzkgnC6RiZKOMAo25I9Wda4O1kvBEdVLnHk+h+QttF13cJfh9UorvJjQHYJJ/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ozqk7f/Wew7xMqgFlWX9SX5/uGfB6gskwYbMhqKrg0=;
 b=A8TJ4L75sQ8QcfPVf7YJnVSGMz+5VPqBCHoQHL65R9Xmp/DTalG8JukvYMzfUa5ERly3WMi9RQbZLXgIY7Vk6bMJ4n606VYPqFj5j1iHa2T7oo78giKplYWoQSVYUAydNGWD0P/05eZetmB8lQ+aod1DMmoFI/cOez4UGINyDC4/+5aLS/bx2LdW9nzE+UDTOxoh3tKu6pCzaAFACTG1ekV2K+thP0hq7m6s5rj8F+GDd3P0Y0esrYwQVcRc9WRHs4LIfofgSt3++CkOBTAQgmPaajF225b7nrno+g9v2n22/fnLYRDCr57j/6N5N8JCiIny/OqjgAe/n92IpSi22g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16)
 by DS0PR03MB7582.namprd03.prod.outlook.com (2603:10b6:8:1f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 05:59:10 +0000
Received: from PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030]) by PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 05:59:10 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 1/2] firmware: stratix10-svc: Add SMMU support for Agilex5
Date: Wed, 17 Dec 2025 13:56:31 +0800
Message-ID: <20251217055632.1776206-2-adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20251217055632.1776206-1-adrianhoyin.ng@altera.com>
References: <20251217055632.1776206-1-adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::30) To PH0PR03MB6235.namprd03.prod.outlook.com
 (2603:10b6:510:ed::16)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6235:EE_|DS0PR03MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: c05e039e-a038-4e8c-a112-08de3d3165ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzdWWWtWQno4azc2RHVWaHlWV2Fab01ZSlYrOW8zQWplVHluaTQyeXMyOWov?=
 =?utf-8?B?SzBWRlZ4RFNvY1hpRWtuUHpYTHZGaERlaXBUVDc3WGR2dTgxUG1HdUk0Nll5?=
 =?utf-8?B?eHUyeStPV29MdlkrejRMV3hlTnkyTUlOcW5aejJsQTg1a0N4Z3p5eHFJcDV0?=
 =?utf-8?B?QUEvWFZRNCtYTWZtWi91VUtDMlJOTGVMbjdDOGVWbjRhbFRuYm10R3U1R3dv?=
 =?utf-8?B?S3I5bUVKaDRzRDhuRTZlYzN0Mklaa01yWjM0RlA5U1lxL3dUK0FWSmJibmpP?=
 =?utf-8?B?Y3BjU0RjRGtZeVd1R0UwaVVScjlBNVZGNmszNDhMYmR5Q2tDd09Uc1lpL1c2?=
 =?utf-8?B?SXd6dC8vWlQ2bVpmWU1GanhraTlIRWNDdWNxMTM4cG9YaERXd0hjUFdJSCtl?=
 =?utf-8?B?dTUraUEvOVphUW1lSytqR2RTcUExYWkzNXJJZ0hYcjB6QVZoWlV5YzMwQTdK?=
 =?utf-8?B?LzZFd2VxbGYvOHhickhOckJ0NGF3eHJNSmR4VWI4cWNOOTBKYTNMd21iZXRo?=
 =?utf-8?B?Mm9FWUk1NUdrcEgzSDBCSkdHMVFpOENFMUo5enM4ZHBaUGJjSm90VEF3OUxi?=
 =?utf-8?B?WGtmNThFUEdvemgvVklkZUhmMmtDUEw4VEpSSjJQOUVmUVR4cjU1RXV5UGUz?=
 =?utf-8?B?aCtqNHBPRUk1MjBXMDBPRjgraGRFaXQ4T2trSmtMdHVTYlJ3dFNPUVpSaTNs?=
 =?utf-8?B?d3dhbzZkdDJvN3Z6ZkhkcGpKQjg4eDBqMExxc1R1d1hGVnlEc3FUTjB5QUpp?=
 =?utf-8?B?aW1qREJKUVpoaEdmQXk4d0NwT3pETURuVm1nc3gxNmFqVzJueWhNRXF2c1JV?=
 =?utf-8?B?eGs3WWFXZWhTSnB5a3dLQUtkMG1FMXV4WUJCYkRtYndSdnNvMjBrOENXNlBY?=
 =?utf-8?B?MFZkZ1FxUUp3WCtjMVJibUREeUJPaWdwU1FsaHNNTUJZSXlaVHBObzFWdlBj?=
 =?utf-8?B?RHZQdUQ0L2M0R29BaGRVVFlhWGUxQ0hNY1kydVpITjlPNFFRcGluSEtvV3V5?=
 =?utf-8?B?aDBOZ3NGdUF0VSt6SFh2VTZaSzFsdmFsNzdkSlV0ZHVjSjh1R2NPUGY4dWtp?=
 =?utf-8?B?VXR3NE15aGpmYkhwNWZnK1VtdXlYNzhzQUtLZUlsVEsxTlRQNjN6Yysycnpl?=
 =?utf-8?B?TWt2UFR6cDdGajFibjVlY1hNMWl6ZklqTUthOGxCYXFSTjV0OTZLWDllQVdh?=
 =?utf-8?B?bWtDSWtSNlJtZE9BZ1lXTFQvRmtOUEVGbGhDQy9heFRYazN4QWZRMmxkb0ZE?=
 =?utf-8?B?OTB0aVh2M0N2d0dqMVkzMWQrWTE4TnhEVW41RTBpS0dNd2lHcGd5OHM5NHVx?=
 =?utf-8?B?d0VYeEpPUDkrNjB5RFJsMFdOZVEzWXhuOUxVN09IWm9mQmdPQTBQOEtzTTdq?=
 =?utf-8?B?c3ZYYXQ2bHREaU13RGpQVkVDTTdaTnYzVmg4RjdyNHlWLzFJYlBKcXhHRzlm?=
 =?utf-8?B?bUZqZGdqMExtb2tGM2RUdlFvNnpSbDFmWTRrVmMycjBCeWpoaEg4b0paUWcw?=
 =?utf-8?B?eTVndlpNMzVYZ3I2YzVtYUk1VFNJckdsb3VadU9td1JZV2ppMURFdXU4cE90?=
 =?utf-8?B?bWNTY2VIS0pjSGJnbjA2clcrNFYrTDN1eDBybHFTN0Z4RGRHWVJ1WE9JeVBG?=
 =?utf-8?B?SVVIa1p5MFdyTUE3eWJLa1JvNG42bEpSMTh6S2U5RFVWbnVaNk5LUkxLVVhR?=
 =?utf-8?B?WEVCQk9yMll5SllMUnhnSEY4QjNnUDY2UktYRUxVVjhPcVdESWdCT0FtSkow?=
 =?utf-8?B?MjVmMzUxdGZuU0VjMHRuSVRhQWJSMEdLZks5RWhGbU10dUY5OGVLSzZKbGFQ?=
 =?utf-8?B?NlVydDdKbUhmUk1yckRPcUh4S3VLVlpLU3FDSWxUUkg4MlVIVnZib2UrZnNu?=
 =?utf-8?B?SFFPckFGTUt3b2pBdzJncHcyTmpKV0VuOGpPSHhsM0FSdnFlMDdiOFdLVi9x?=
 =?utf-8?Q?KddkKfFiNVhd6r0iyiF8CuvFN/nNxQfz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6235.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3plUTRMK2pqalM4NVpMbXgwK1R4Sk1Pd0E2VW9YVm4rTXE4WkhIVGNQR3ZL?=
 =?utf-8?B?S1VjeGFnNlhES3FRK0RFMzcreXBNZzMyTE5wMkIyYkNKNHNrN0JKT25mNStQ?=
 =?utf-8?B?RFlHMk84dVpvRjUxUWRxOEE0aTUzWHdpcGRFL3ZoSG5PTlF2UFhhQk1KS01z?=
 =?utf-8?B?ejZQZXpIbkQ5QmtrWEpNR3FUQnZNSHU1L2plR0RpMFdFWG54eHJiVGJpYkw4?=
 =?utf-8?B?bi9OaW1uUkFCa0JybVAzV1lDVXV2K2Z6bmNsR3lITFQ2ZDBMZEtiU3RVS29k?=
 =?utf-8?B?cSs5dWhBNU4rREdDbXdkVXMzRTBVbU1INXVMM2RRVTMwalVENTN5Q1NQTUU4?=
 =?utf-8?B?Qkl5am10ZVQzbmtzSk9Ec2kyOVFsMDkycFJoM3hkMW9weXVHcmJmVzIyRHVF?=
 =?utf-8?B?ZGJiL2ovcEF3YndZNWhvZm1oaUZmd1dqMkpCemY0NXl0ZmI3aFJmQWVSd1Bj?=
 =?utf-8?B?cEZiQ3dteTYzOVVNTDFwTHA4U1N3ajB6TUxKdGt2ODhnbFk4ejZWcGc4eGw0?=
 =?utf-8?B?NVdabDB3T1pSQmZHc1JLQ3FENW1LdndtVVJTRTYrblk4dm5uMzh6QnVTQlN6?=
 =?utf-8?B?ZEg0SVN6VlJxS0VWNGlXempCb3k5ck9UazFMTm1BQlZBKytFeGlqS2YzNWJW?=
 =?utf-8?B?MlIvZzR3RUpuK0s5WTRkeEZqVmdqd0ZtQ3BLTXdiOGNMSXVtOUY4RlBuSS9y?=
 =?utf-8?B?b2Z0S0VzbU1iUEZpRmFnaUdrNHRWVjF4dTBOTGdhS3hSc2liV2JrQm1pYlBj?=
 =?utf-8?B?YTd0Q1cwWkJ6NXQrQVpjYWV6dHQ5UFFlRXI0Wk1TM3ZpdExBNThTR09nWFIx?=
 =?utf-8?B?Z1ZZU29SYjR6UUV6S1VBcnpYbi9SeUVYaEFBZUJlRHZJem1SOHp0UStKa01i?=
 =?utf-8?B?QURiZVY1TG9CN3ZMajFDMERPRzVYOFAvOXdsYmcrVk5BdWRrRVRsUTJYRUEx?=
 =?utf-8?B?WUczTy9oTituajE2aStTTTFaL0dkRUZmOHZzNE00L3N2UGZyQjV4a1B0a3Ru?=
 =?utf-8?B?R0liS3BNOXBXVXJ2di9ZdUFFNUFFeHRNTTRCNldHdmF0dk1mZE9iNW9YeFZS?=
 =?utf-8?B?eXlGcHVmdWlTZDd6NkNFa0FMMWg5ZDloUXJKL0U3d0RvSlhTTmpxL1EzR1J1?=
 =?utf-8?B?R3ZBVG5ZZ2g3T1p0c1lJMjh2eTVGUTBXbFNKMmZnWERqT1FBREE0MjVUa2Fr?=
 =?utf-8?B?YUVYQWtJUWJ1TEd4YUtsQll4bzMybDhpZDJSMkZMc0pPTElRbC9DRlpOMytk?=
 =?utf-8?B?MTZYT2d6N1NSemp4ejhKSmpBUnVsTmJSWnBsTEwzK21KeUpRVHNmejFSdTlq?=
 =?utf-8?B?ZzlVRThmQS91S2cyOXR0NHdNcTF0eWpZTHY0UHp5SnhTWS9adVFvaEVTNkll?=
 =?utf-8?B?blZTSmNhQlVZR1JMUDExU1hLZS9iZ1EwbnBpd3dZbVdFMkdvTlg1bFc5UmFK?=
 =?utf-8?B?YlNlb3dTakNBOFNQVVg1MjhmNUJhT1QyUThud09qazFsamtVenM1VXJqWXky?=
 =?utf-8?B?dHBwRHBVQ2tCSXk5bitlekp2MlMySWFlR091aVpXWFZ1aTVLN2xURENzdWlj?=
 =?utf-8?B?d0pVQWdNdWJTekZCVURMWjR0UDYwdWV4dWhKUlFXdXZ2R1J5bFc2Wjl5MXhQ?=
 =?utf-8?B?bTBxTzNhbkgzNzU2bVhycDNTRk1tRW1tZGZhQ21SakRFK3NvSjBOVjhhNDRx?=
 =?utf-8?B?d25mRU1hbzJPenZhNSsyd0M0K2lzZVFUYzhwZEhMeEcvYk5aSWhVb3ZaYStw?=
 =?utf-8?B?QjNuRTh6aUlabDNkbmJEM05UQzI3N2JUcTFtUytOYzhkb2h3Q0JSNjJLeU1U?=
 =?utf-8?B?c2FOTURId2c3NXk3REErY1diK1VBMlppelcxdUVuL05mdzhkVWtqQUNmcW4y?=
 =?utf-8?B?TXBXa2RCU1NXL1ZrT205NmJrTitkRzdOOUYrS2ZIaDhmVVBhakxpK0Q2WU51?=
 =?utf-8?B?UzRsbldVT24vOHk1dCtYTUhNa0ExTTZYMldDRXhaRHFFV1lFVVJERlhkdEox?=
 =?utf-8?B?VGN6RjVlR2JPMXJka0h2M3lOaVhkZElnRzRPWmpjSFRYVXh1eE5iMExjTzMz?=
 =?utf-8?B?aXErNzNsZWZOY2IzRnRYaDgwaDN3VE8yd1hRanpJeThsNFV1aDg1WFpEdHd0?=
 =?utf-8?B?ZVBVVjFJSlpBK3hwV21EUGc3KzZXaVNqa0gxekJycTNZa0NlTjJDbXg1Um5F?=
 =?utf-8?B?bVJpYlJYdmRQSEwyaWtYNktEcHVVeEVWWGJnRHZQTzZwMWV1ejMzUTdRVlFw?=
 =?utf-8?B?aXBxSUJ4STBkSDhDd2dmT05nNDllUjNuMmdEQlUzNGhkVmh2Smw4TzhHTlZ5?=
 =?utf-8?B?b2lRL1VzMlNJeWZQaFhKbkVQcmVKb0kwcnBtUXdxMlFKZkZQV3FrWlhzTGp3?=
 =?utf-8?Q?pxvlP7B/yMTEmiKc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05e039e-a038-4e8c-a112-08de3d3165ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6235.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 05:59:10.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6+LWyVK9NxN9/yv4RuybmoYDfyn5UmaBdXypKzbWepF6MuKJh2RgVyTQjShi6xB+umS696tP/n6BWTNV5pvg7hkRNcO7g81dguNBSjn4zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7582

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add SMMU support to the Stratix10 Service Layer driver for Agilex5
platforms.

On Stratix10 and Agilex7, the SDM accesses a reserved buffer located in
the first 32 MB of DDR, which starts at physical address 0x0. Agilex5
differs in that DDR begins at 0x8000_0000. Because the SDM address bus is
limited to 24 bits, it can only reach the 0–512 MB range and therefore
cannot directly access DDR on Agilex5.

Agilex5 platforms rely on SMMU translation to make DDR reachable to the
SDM. This patch enables SMMU usage when the driver is probed with the
new `"intel,agilex5-svc"` compatible. A carveout IOVA domain is created,
and allocated buffers are mapped through the SMMU so that the SDM can
access them via an IOVA that falls within its accessible range.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/firmware/stratix10-svc.c | 160 ++++++++++++++++++++++++++++---
 1 file changed, 146 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index dbed404a71fc..c20afb666646 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -11,6 +11,8 @@
 #include <linux/hashtable.h>
 #include <linux/idr.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/iova.h>
 #include <linux/kfifo.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
@@ -36,12 +38,24 @@
  * FPGA_CONFIG_STATUS_TIMEOUT_SEC - poll the FPGA configuration status,
  * service layer will return error to FPGA manager when timeout occurs,
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
+ *
+ * IOMMU_LIMIT_ADDR - Define the maximum addressable range that can be
+ * accessed by the Secure Device Manager(SDM).
+ *
+ * IOMMU_STARTING_ADDR - Define the starting address that can be accessed
+ * by the Secure Device Manager(SDM).
+ *
+ * AGILEX5_SDM_DMA_ADDR_OFFSET - Define the starting address of the DDR
+ * memory for Agilex5.
  */
 #define SVC_NUM_DATA_IN_FIFO			32
 #define SVC_NUM_CHANNEL				4
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
-#define BYTE_TO_WORD_SIZE              4
+#define BYTE_TO_WORD_SIZE			4
+#define IOMMU_LIMIT_ADDR			0x20000000
+#define IOMMU_STARTING_ADDR			0x0
+#define AGILEX5_SDM_DMA_ADDR_OFFSET	0x80000000
 
 /* stratix10 service layer clients */
 #define STRATIX10_RSU				"stratix10-rsu"
@@ -258,6 +272,10 @@ struct stratix10_async_ctrl {
  * @invoke_fn: function to issue secure monitor call or hypervisor call
  * @svc: manages the list of client svc drivers
  * @actrl: async control structure
+ * @domain: IOMMU domain for service controller
+ * @is_smmu_enabled: Boolean flag IOMMU enablement
+ * @sdm_dma_addr_offset: Address offset sent to SDM for DMA ops
+ * @carveout: IOVA carveout for IOVA address allocation
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
@@ -276,6 +294,14 @@ struct stratix10_svc_controller {
 	svc_invoke_fn *invoke_fn;
 	struct stratix10_svc *svc;
 	struct stratix10_async_ctrl actrl;
+	struct iommu_domain *domain;
+	bool is_smmu_enabled;
+	dma_addr_t sdm_dma_addr_offset;
+	struct {
+		struct iova_domain domain;
+		unsigned long shift;
+		unsigned long limit;
+	} carveout;
 };
 
 /**
@@ -1727,6 +1753,14 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 			if (p_mem->vaddr == p_msg->payload) {
 				p_data->paddr = p_mem->paddr;
 				p_data->size = p_msg->payload_length;
+				/* ATF have addr range check for to ensure data is
+				 * within actual physical address range of DDR. Adding
+				 * offset which will be stripped off by ATF prior to
+				 * sending to SDM.
+				 */
+				if (p_msg->command == COMMAND_RECONFIG_DATA_SUBMIT &&
+				    chan->ctrl->is_smmu_enabled)
+					p_data->paddr += chan->ctrl->sdm_dma_addr_offset;
 				break;
 			}
 		if (p_msg->payload_output) {
@@ -1796,25 +1830,62 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 				    size_t size)
 {
 	struct stratix10_svc_data_mem *pmem;
-	unsigned long va;
+	unsigned long va_gen_pool;
 	phys_addr_t pa;
 	struct gen_pool *genpool = chan->ctrl->genpool;
-	size_t s = roundup(size, 1 << genpool->min_alloc_order);
+	size_t s;
+	void *va;
+	int ret;
+	struct iova *alloc;
+	dma_addr_t dma_addr;
 
 	pmem = devm_kzalloc(chan->ctrl->dev, sizeof(*pmem), GFP_KERNEL);
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
 	guard(mutex)(&svc_mem_lock);
-	va = gen_pool_alloc(genpool, s);
-	if (!va)
-		return ERR_PTR(-ENOMEM);
+	if (chan->ctrl->is_smmu_enabled) {
+		s = PAGE_ALIGN(size);
+		va = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO | __GFP_DMA, get_order(s));
+		if (!va) {
+			pr_debug("%s get_free_pages_failes\n", __func__);
+			return ERR_PTR(-ENOMEM);
+		}
 
-	memset((void *)va, 0, s);
-	pa = gen_pool_virt_to_phys(genpool, va);
+		alloc = alloc_iova(&chan->ctrl->carveout.domain,
+				   s >> chan->ctrl->carveout.shift,
+				   chan->ctrl->carveout.limit >> chan->ctrl->carveout.shift,
+				   true);
+
+		dma_addr = iova_dma_addr(&chan->ctrl->carveout.domain, alloc);
+
+		ret = iommu_map(chan->ctrl->domain, dma_addr, virt_to_phys(va),
+				s, IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO | IOMMU_CACHE,
+				GFP_KERNEL);
+		if (ret < 0) {
+			pr_debug("%s IOMMU map failed\n", __func__);
+			free_iova(&chan->ctrl->carveout.domain,
+				  iova_pfn(&chan->ctrl->carveout.domain,
+					   dma_addr));
+			free_pages((unsigned long)va, get_order(size));
+			return ERR_PTR(-ENOMEM);
+		}
+
+		pmem->paddr = dma_addr;
+	} else {
+		s = roundup(size, 1 << genpool->min_alloc_order);
+		va_gen_pool = gen_pool_alloc(genpool, s);
+		if (!va_gen_pool)
+			return ERR_PTR(-ENOMEM);
+
+		va = (void *)va_gen_pool;
+
+		memset((void *)va, 0, s);
+		pa = gen_pool_virt_to_phys(genpool, va_gen_pool);
+		pmem->paddr = pa;
+	}
 
-	pmem->vaddr = (void *)va;
-	pmem->paddr = pa;
+	pmem->vaddr = va;
 	pmem->size = s;
 	list_add_tail(&pmem->node, &svc_data_mem);
 	pr_debug("%s: va=%p, pa=0x%016x\n", __func__,
@@ -1838,10 +1909,17 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->vaddr == kaddr) {
-			gen_pool_free(chan->ctrl->genpool,
-				       (unsigned long)kaddr, pmem->size);
-			pmem->vaddr = NULL;
-			list_del(&pmem->node);
+			if (chan->ctrl->is_smmu_enabled) {
+				iommu_unmap(chan->ctrl->domain, pmem->paddr, pmem->size);
+				free_iova(&chan->ctrl->carveout.domain,
+					  iova_pfn(&chan->ctrl->carveout.domain,
+						   pmem->paddr));
+				free_pages((unsigned long)pmem->vaddr, get_order(pmem->size));
+			} else {
+				gen_pool_free(chan->ctrl->genpool,
+					      (unsigned long)kaddr, pmem->size);
+					      pmem->vaddr = NULL;
+			}
 			return;
 		}
 
@@ -1852,6 +1930,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
 static const struct of_device_id stratix10_svc_drv_match[] = {
 	{.compatible = "intel,stratix10-svc"},
 	{.compatible = "intel,agilex-svc"},
+	{.compatible = "intel,agilex5-svc"},
 	{},
 };
 
@@ -1863,10 +1942,12 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	struct gen_pool *genpool;
 	struct stratix10_svc_sh_memory *sh_memory;
 	struct stratix10_svc *svc;
+	struct device_node *node = pdev->dev.of_node;
 
 	svc_invoke_fn *invoke_fn;
 	size_t fifo_size;
 	int ret;
+	unsigned long order;
 
 	/* get SMC or HVC function */
 	invoke_fn = get_invoke_func(dev);
@@ -1907,8 +1988,52 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	controller->genpool = genpool;
 	controller->task = NULL;
 	controller->invoke_fn = invoke_fn;
+	controller->is_smmu_enabled = false;
+	controller->sdm_dma_addr_offset = 0x0;
 	init_completion(&controller->complete_status);
 
+	if (of_device_is_compatible(node, "intel,agilex5-svc")) {
+		if (device_iommu_mapped(&pdev->dev)) {
+			controller->is_smmu_enabled = true;
+			controller->sdm_dma_addr_offset = AGILEX5_SDM_DMA_ADDR_OFFSET;
+			pr_debug("Intel Service Layer Driver: IOMMU Present\n");
+			controller->domain = iommu_get_dma_domain(dev);
+
+			if (!controller->domain) {
+				pr_warn("Intel Service Layer Driver: Error IOMMU domain\n");
+				ret = -ENODEV;
+				goto err_destroy_pool;
+			} else {
+				ret = iova_cache_get();
+				if (ret < 0) {
+					pr_warn("Intel Service Layer Driver: IOVA cache failed\n");
+					iommu_domain_free(controller->domain);
+					ret = -ENODEV;
+					goto err_destroy_pool;
+				}
+				ret = iommu_attach_device(controller->domain, dev);
+				if (ret) {
+					pr_warn("Intel Service Layer Driver: Error IOMMU attach failed\n");
+					iova_cache_put();
+					iommu_domain_free(controller->domain);
+					ret = -ENODEV;
+					goto err_destroy_pool;
+				}
+			}
+
+			order = __ffs(controller->domain->pgsize_bitmap);
+			init_iova_domain(&controller->carveout.domain, 1UL << order,
+					 IOMMU_STARTING_ADDR);
+
+			controller->carveout.shift = iova_shift(&controller->carveout.domain);
+			controller->carveout.limit = IOMMU_LIMIT_ADDR - PAGE_SIZE;
+		} else {
+			pr_warn("Intel Service Layer Driver: IOMMU Not Present\n");
+			ret = -ENODEV;
+			goto err_destroy_pool;
+		}
+	}
+
 	ret = stratix10_svc_async_init(controller);
 	if (ret) {
 		dev_dbg(dev, "Intel Service Layer Driver: Error on stratix10_svc_async_init %d\n",
@@ -2011,6 +2136,13 @@ static void stratix10_svc_drv_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(ctrl->dev);
 
+	if (ctrl->domain) {
+		put_iova_domain(&ctrl->carveout.domain);
+		iova_cache_put();
+		iommu_detach_device(ctrl->domain, &pdev->dev);
+		iommu_domain_free(ctrl->domain);
+	}
+
 	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
 
-- 
2.49.GIT

