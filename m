Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB73A3E60;
	Tue, 24 Mar 2026 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377496; cv=fail; b=M9V8qdZRqX1D3hEjqTX8Z02pFKpcyaGRNhcQmKvOAc9IWasp+bYmLzuCyjY2FdRy6vjs55Do9ioxLLlMsRVApupYgrg0bHI2kChMdxumQ+zfT4K1VGNJE8HSjhO+rxgzY89wapyeVsbMNID6mChMvHMiiaa1wBucmTMe5xyW9Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377496; c=relaxed/simple;
	bh=xnSZk1RtpxFiAqnmKSSE1lLePPVQJwvdmzTIJ9y/B60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=caZvfaWioy7C1jYhQC8dK9Aj79t0324hW9pN/tOxvWLW2YhULVljVnwG9fhayDSuIzB/RjACbFvN1PEyBlhMGH2Od5CTTEHStZd6BJcIxUZ5vc0y72jdlD3v46oLYynbl7nV0qHxgP3PMsxorEF/FuombQdp7EtTO0m+n9cpjX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SLpt7xwk reason="signature verification failed"; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SLpt7xwk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rz4jiEXbj4xNJbgePYtBpU1NxD2VWA0A2/lwB5vMynyI/nIU5VRwo9P0zZgPN1/eHTFchf+0IA53g5rSwM/iRI1VumHtTZ/DaC5bb4LlShmt8N93N8GB8qb/ohcMLkm1/E2YTCR0i8QOoJPsbNok0I8O1iuYTvZ4Q6YHXl3wUEobuWiE/WdBGCST084WTnROqIO1Tzt5UcpxOATvhjQ8Uy0ggcrjKgYLrYUTB6Bak+g6NVnslViV1DqasdUo+66ODKFPuwn5JdZQQIq388oxN8wZU6sT9amnXwAJB4HWrJVzxh+wz0GausfzmJJ1Wd1o1LtpZX4kS5I9/dgFdtZXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjglhRHEom3Ua5Hezv/IzfBjRrryjK2VlmqqVw1gudc=;
 b=PhDJBkuQNnBXnZZ22dbQyNoHVlslW9PwW/6mgVJqGM582F3l4lNfBMbZ8gff9gXt+oBtxOtYWRG5kOiVd0WjGfDYOq2225acj01SrjDuuY8MUunCAwY9p9NGDPoRbPIpLGR1vvqlam6prAYeMdB8HM8tFEOSqtcdu58XSBvuvHUOrx2hQ3FGxtdX/L2inKR3MKoKSWAaBMfHelgSPyiFHRQKjjG19dE03B5Na2teIpTzmcoaWUas9dYZUryhIikKnZVuD25eF5R+cjNiewB6pDHlom1FSDgBehqBhNQffbO6a+8JCKfuo/C+PV3V0GUxPmc4e6yT4dPI0KBnTHgQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjglhRHEom3Ua5Hezv/IzfBjRrryjK2VlmqqVw1gudc=;
 b=SLpt7xwkOwx5GA+kFZW+tOuKQIvjfEQ4+4S6i0TdL+26bCRxIttTO5u+JFlaZi68Dx/R2+pF1dl87MB8iQLwuEszH8dVzAMjwGlU/9keuwKclyXuuSpDlgov+nr6uigaeDTocglt80Iw0uod24DTTynqoUuzaD0KU3hJhYT5yKms5ijv+I/QWt/5Cy0jJEpEpLyEejSgQm1F7Dg+BHsr4hyNFjslwOvN3i89DJO187GfaPjWFV7NyJaGY4Kc8+LySo8rjp+qxmK+5KrAu9KiVsTe5Gl8EXve5yMgudhiIWIhNg8WT2QtwIN+hNgd+xxxvMAADrNuX0lmaIsiiz18/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 18:38:07 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 18:38:06 +0000
Date: Tue, 24 Mar 2026 14:38:04 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Suki K Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Xu Yilun <yilun.xu@intel.com>, Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5/5] fpga: m10bmc-sec: switch show_canceled_csk() to
 using sysfs_emit()
Message-ID: <acLaDFuCzt0d33Q_@yury>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <20260303200842.124996-6-ynorov@nvidia.com>
 <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BN9PR03CA0569.namprd03.prod.outlook.com
 (2603:10b6:408:138::34) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: bff9535a-2444-4c3b-7146-08de89d47d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CqtxLOwmXTq0NoVZpUgRCNRiOQiV1RlFUYk5XXM1CrmrMWbH6zl/b3mUh3gkQWRRPb+RmrIn8geUxA5+3GwkFjGDPCWrq3oSkPgNcyH42jPHKGwa9ebE2W3+8tOwpQwUQF6ooELWuiBEffMYq7YJo6tSRO6GvzT1s9BTV88zwcxypXB6fRPZOw+h4MIv5GhBUa5+LT68WpjdVh2yJ2MIIQTZPnpq971fT68xVLsSw9BsOjFquJyPfCelc8K1TELq5KQE5WzDtQbjNW+Emo8xp350x40YUrriKzOGi6pudikb8Vlfg/NwRvBkc9RGaLe4fuX8QlYf3/UGZ8QyTq2bNMvcWgEeY5bzIR2p/oOBaabPLfwEdkDRDGTTEcNMeDZgaaLU8iiZrm+79Fc8oZlmHr2qe/XMRG66uRlhLee4N20Nx+xvmcWdeWaIy2Jy+6obkE+Gf7tceyouU6omku/zMialv0n0wY1QL2SwzBW939WkgM/+yoRAcUQC+C+skxdm2gW3k1FUcWantFryyf4uks5jUNHJ/PrSYn97TRv3v+ASvsXKC6QDpovgb8OGBWke59Hr6B11+lspq8HC6HG+1uiz4bdL5PJJ8vc+OaTy4QhJoR5/wGw8Akw87iQC2S/vEK/y22sWd8O8cxIBsjOSUZWYc+ioXj9HScuYJO++ECSWxco9VCnNHOv5y9h7UdeJtmXJ68AjZwUwykbBIVDT++doN4nESfW57YU/qRxs7S8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?YvIpQjBz5kCRPnJB3kD0/KuDlNufbKJZj9gWxK3Z3M2dxeozye5lcFdPNk?=
 =?iso-8859-1?Q?B7uOpjE27XWp/xvvCdW3STLVQiI5kDhXfwlVBiCqpMxTU43BtSBRbovNik?=
 =?iso-8859-1?Q?hlKvkp+1PpHNMtBpWHhLVKVCNkV6URUVEmg0GB6mMLvQSY/PVnUZs3pgzx?=
 =?iso-8859-1?Q?K4jRsY2XT24NHDHORV+9t0R1+r62r89D1kGrjsqRoW8KQnGLR3Qbfe5cLC?=
 =?iso-8859-1?Q?3nm0RjuOD07zEE3lJeFaF7pnfTPTU/zrui2XtjFSc3aT9f/k08nsZuJO1I?=
 =?iso-8859-1?Q?V0qsfUglJphf5jG3zUU+jFuEzhh3qvpbcOXhk2MDudWmftDemVMfh3+qPl?=
 =?iso-8859-1?Q?Kmp8mc5hjZLWhKjdnb/Znv0CEJnGUKichOi4HXt2uN/J6//67tZWFU0dnz?=
 =?iso-8859-1?Q?02LCxZxNNJUeAxpZYeHFTpJ69qSDETEamV04N1F+WCJHCw+JOXhJax2ZDD?=
 =?iso-8859-1?Q?3aaxHxZfvrTMkoAlvP39B+fW+etFMUNeVeGZCvvEEvA+A3IeHbsvwgnb+D?=
 =?iso-8859-1?Q?EF3Yqo9RJCqrDvw/7jTDTVnqvPC89/2jzb5BU5oKZzahhp9nDtvMzbrsnT?=
 =?iso-8859-1?Q?R1M9RrgJziXdTcQA4AdBoNOUgLZ6rwZoKXNfXZt4GaUKqCMZdlrCO4P/IX?=
 =?iso-8859-1?Q?TrvjguJoyZaSoC7VSa2TAlXyGyJl8V8kfiSgQKILn+CqXDI3hEj3MIl9Gk?=
 =?iso-8859-1?Q?iGlm3ia41lsOJK7v1yHHwN+cOODEHHZl7FvKShHo+TMac0vV5n1pee/lvT?=
 =?iso-8859-1?Q?UQKWrETMY1FPXpfQYabLowZosfsrFcz0IlE+xvTRe555R0svwO6MJF2YTX?=
 =?iso-8859-1?Q?RRDGVSmVh1s1hbUQh4jRq5D4PyRxu5oIkr+Vz7PEbA9pJf9p91WDu+Gn3q?=
 =?iso-8859-1?Q?Wj5TKhK/mDbjFAqjwSnRapr6tqP6S08zCdAAV483pRCge8PCl6+ZIwLSnz?=
 =?iso-8859-1?Q?zKC0bw6Zk1eiGzR3Q/OmruC5Adfh4ddCcgRNLd2LzP4iaT4STqlja0/zIs?=
 =?iso-8859-1?Q?YtzA7gEQLLsU9KdUbvHoy2qjX3oLZXor5gj04zQES8g7O/YlZhP6C6x+Dc?=
 =?iso-8859-1?Q?n+VzqA3cJKxN0JMBanqH+fEnRL1/hOfgLzg159z2cayshdJvXPj3KoVia0?=
 =?iso-8859-1?Q?w8GWWlCJuI7MzAcgfO0BetPIa37rlB/G3r/mZi0ZzX/wZ/XS3V4wtVHWtj?=
 =?iso-8859-1?Q?DQGn3MPaqreDUakbicFGqqLjvk0b6IyQTxXwicKmYZS+SSZQTjocwGyOTg?=
 =?iso-8859-1?Q?ByVlTDN32QFHrbTYwb2i4JLyzqaRO7HgEYgnR1gg2fMJq4RWteaAZxr8Kz?=
 =?iso-8859-1?Q?LVxiteT7w5/uGnNNKriLmrafjlq6MePp1Yjtv0EteA3tPeB1F8YAPuWIj+?=
 =?iso-8859-1?Q?fl6hI3BIm/VOQW04/5w5kfCVWvza3t6CYupnqEUb1iFeMadvDEv9nT6kmE?=
 =?iso-8859-1?Q?c/JHAuKTpxgK3yQA5A3CZn8RE15bw1Ue6/z0ieYQTba72C/K7BNpZS7iYp?=
 =?iso-8859-1?Q?z2Kx6dlImFqh1CSRtSHZsmSKXEQX4E2yCsU3xKSMBsttWJRDLzc1g862sH?=
 =?iso-8859-1?Q?7riTWLUZlI40ZmV4K67cJv1mSQ00Y+nG0JeF5no3RFWZbgZcySmsK7M5i9?=
 =?iso-8859-1?Q?EAYBmH9TtMX+3myenJPNfqFgbYx4SUEmvhkPwSAP0K3jU+UxTGyzNfDhob?=
 =?iso-8859-1?Q?R4WdesX3nOPB2+9JdkgrtPQj655wV8I9LZ1KvQ0iJvb291UteEMLoqs/Ol?=
 =?iso-8859-1?Q?zIiw/vKkI43bKKYyanPKlQYExOJKUFc0jKQoMxK8AHx5zNhudGxra0jqAC?=
 =?iso-8859-1?Q?fKmr9naNoBJ9ugiejVFEFaF/EVsW4WUEQ9RnlX++rQuXkxXmWlr4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff9535a-2444-4c3b-7146-08de89d47d8e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:38:06.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqkWBArMbfkXP5T6TRWRZRVc+IzaQ73a1Wv9JQSFf8XFBjLCKl9C5QosVkCN6QFDcW7ckRa/LTv6oWcDvmEEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542

On Tue, Mar 24, 2026 at 05:15:33PM +0800, Xu Yilun wrote:
> On Tue, Mar 03, 2026 at 03:08:41PM -0500, Yury Norov wrote:
> > Switch show_canceled_csk() to use the proper sysfs_emit("%*pbl").
> > 
> > Reviewed-by: Russ Weight <russ.weight@linux.dev>
> > Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > index 10f678b9ed36..ae364c6636eb 100644
> > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/firmware.h>
> >  #include <linux/mfd/intel-m10-bmc.h>
> >  #include <linux/mod_devicetable.h>
> > +#include <linux/mm.h>
> 
> Why add this header file?

When I was preparing the series, I had build issues without this. But
now I checked it against -rc5, and it's clean. Would you like me to
resend?

> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> > @@ -183,7 +184,7 @@ show_canceled_csk(struct device *dev, u32 addr, char *buf)
> >  
> >  	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
> >  	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> > -	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> > +	return sysfs_emit(buf, "%*pbl\n", CSK_BIT_LEN, csk_map);
> >  }
> >  
> >  #define DEVICE_ATTR_SEC_CSK_RO(_name)						\
> > -- 
> > 2.43.0
> > 
> > 
