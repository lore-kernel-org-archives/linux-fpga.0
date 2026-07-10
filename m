Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191522BE656;
	Fri, 10 Jul 2026 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703983; cv=fail; b=DBcp/U//Nc5+RsUiWC+3is4g00xfKWzDvaTi/HZwJBn9M4MBoMmzQ/A9bUq+iF/pDeC8pucRq6XB8h2Q0Uugo4uQtceT6AOAl/78ZZ4/T1nkrvLn2p93ievAgw6eGCGznrRZJnM2AwR/KXWW7Gsd1c2kIma5RQxuQ3a7mu7UK8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703983; c=relaxed/simple;
	bh=OjWOpHW5pcEFP/PRVUzX4yAWSgMvooNdPVpBSQkQ5oY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oNGirR7wtR4oR611/9gWjH2ZwEHK/DssiHgUWbfLtMT+bb5Ti6xTOQKYxeyrpBxW29pKP3oqc+5TsLEr9AHm/Kz6RNIU6hQlpbgw1VbQrJBHaDzYD8VPk6ZGsGV4dGZAlFRUgZOD62jtoEBJupcbm75qLXgKCaDx2KXvA63u+Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=AYr9Va8r; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="AYr9Va8r"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH1jsW977962;
	Fri, 10 Jul 2026 17:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=FnWVUBeJf
	na2yOgAd2M2Rw0wcggU9p8AnHXgb4Evsu0=; b=AYr9Va8rpClUrOsTd7AwndtQM
	EN6HgpA21NDnUjQqf6/UhZG2rYBt2+whEd1xmR4ZbwWgh/hXiprqaKuMuoKktbIp
	JHdbF5IQv+iixiYrvk6E2zbgBlxF+hhNA2dWeKQBPzKWUW1YJ77jQg3vGO4N8ob0
	c+MNE16YkJuQWCz7mc9GMQ2t/UKhayXCC6/cm5TgHtDRT17cPzdxC7ag5vT3mhqR
	Qxni3zzG5zIfqObVcfC3GjbUpEB9epDWmtgtYPgBS/Pi5v9foMIvyw6dYBhaC0W2
	jyfjeM2LIQkTc3OIO2NUvsP7+X6yAYn9/ISuE/DFXiiUShWDFOOKTXzTyWulg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1h2313d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 17:19:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEPO3Wa0Za3oq6o06xl3Lb3UNBWGd2vY0IKurF2nU/61co4C9/pJ+WWVKzxFws1x6zBjE+U3uvi4UhJrKh2ae+Vo3Iupw5pXuJp7Bp/2UkDEcVHHYQkcpSgBuOiNKc71pvUfbRiIkF8PEV6B7Gowf9M/jUv5zb4QBMd+hZyKETp6eyw81kBfCnbcq5MBFFrSus3sx6W3FXdoW+AhVBKZD1ENSzmAFz7rliBeriGCHlDYcWRIw09Sqtfuf7ZObN8gqvKCa4mnM0TzkHLsGQxJ7LkNtHe9haTbLAFQWGbwZCofGCLEwrP6uHxKVzKhGx235QJf3BG2mvYIR1krViot+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnWVUBeJfna2yOgAd2M2Rw0wcggU9p8AnHXgb4Evsu0=;
 b=R1qp0+KaYL9u7sALx/DFW8GtjLuUHLnB3pbCHb1L0KwNs2XUnEmp03PqT1ZUs5vXVtKJ7Bz0OAaoou/GJ0WLY2iE6aQ/Of4GNOMtpvWHgoMyXnsfyU0664bqnY4YCIt2qqjCbWiOlL1Pw3+8Ulq3Rytf20fsLxqObGYJzk+0tw57+hvbOZoYaU3vLvICfd2i9eTOr62itGvD/SfSanhLOd1tn6JIo6ArFCyIkoivgElreZxGOtWo9KpWj6e8fdxHpQCMzvGid9EWEIA6ZRGJjtEux7W4lfsJNzwNEO2r3B7dXbnXzeD/UzTprmtnp38ZwCvFFbV/cHSV6xDK6UWwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS3PR11MB9672.namprd11.prod.outlook.com (2603:10b6:8:38e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 17:19:23 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%4]) with mapi id 15.21.0181.017; Fri, 10 Jul 2026
 17:19:23 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: matthew.gerlach@altera.com, yilun.xu@intel.com
Cc: trix@redhat.com, ilpo.jarvinen@linux.intel.com, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, chris.friesen@windriver.com,
        ionut.nechita@windriver.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: fpga: m10bmc-sec: upstreaming image_load sysfs for N3000/D5005 (and 6.18-stable)?
Date: Fri, 10 Jul 2026 20:18:35 +0300
Message-ID: <20260710171834.580604-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0017.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::9) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS3PR11MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ab54f2-b43b-4659-5fc5-08dedea762ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|52116014|366016|18002099003|38350700014|6133799003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	HMDwmdgDqIYvwSTUjNOTnq3C7bO7/9kQmG1RYIoY3Dv4YP+LiypO2RPBfq7cHyq52nYV/sZKsJpVCsLK7GxBr5q/g2ucnWeucfufdL8YdSoDaYfasdskps+e/BOdQwd23N6589dRKPV9mdqPbY1ZDgtKtoMQEeV5FNodhfBOnpNnUYYS+IBfypIjvAq3LlpQa+NYI+Vhn0P6qpmB2ZMh870XY6UfV8FT0lA0hNPDXIH9S63RwqZ7HesHvCDJq2++A04M2ceZQUn3t4LRv0aWEkO0G6TiCxmzlJXHhpxOKvCH4RujNUP2RKgj6oXdZhBxrWjm0C/h20d6t9QMiI4mlPi/YpQzXU78+MKX8cpsOywwhBva2OF1UMSYe7Og4JCtJOcKtPZunqhGK6/1Nf0RYSJ1wzfW7116XIGBVI8saB4056T/UV7yHh+GCQqvMbwa5c0Sppi3Bx742Feg+nhgFAl2yBjUCUGIhkN7q3x7vm1VNH5NAplzUOR/yEyRq7P/gOIwC0oxhnG7Tj8CyfT+yD5qtWM0TiBQnVUzn1zA5YT5/5Bqkk+xpj/Jq5Up9KPItqz227CaEukVdvs6EKqU2Wodhn9WBvno6KKdDQsWKd9SXU6+cglYysFktlzmbPGxslQjE7azOf3W1APcFGLTtbhAcdp3jQK7cT0YzeAm+TLM/M7MF9sTkGnqQ3pZNa9kjhHUvTeRKmmK82Trftg1IV/WXvqL6HoK32IOyZdX9V4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(52116014)(366016)(18002099003)(38350700014)(6133799003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y0QlgBvShCRFpVtTIY94b7I6RF7Iby+epKWV0uCsQ56yqVOsjU+yMXRl63bM?=
 =?us-ascii?Q?KEOu0Wg7RhV8XHkc2muiBWt15CSfIInqCZMFBe/XUEzr46Q15C0sa2fGbGt3?=
 =?us-ascii?Q?abVpBnlI2NQlkf7seBCWHQaRGkOM99bo9R/G8HUJmT92/Ud4QDpefIoCyDEo?=
 =?us-ascii?Q?W7fLYPLC6rAtbnFIGgWotdlOmbnMjl5+xbnsa4R9V7dZE0uFwvs0woHD3Swi?=
 =?us-ascii?Q?csNNYnVC82PMTm/4DsEivwp1EeK0pwZwSd6fszKhD8Fd3Opt4CFHJSTkkPsL?=
 =?us-ascii?Q?3bVAL6PL1J/CMtYhaKYiI7pbF5kpoOSlV2rm81bbI+3U36zH0nGa6QlBEMGO?=
 =?us-ascii?Q?i7tDV/8z/cPugO9O+lcH1igc5n6PIdMUYDHYaddSrJhr3u9QtcDZMaX3KMkG?=
 =?us-ascii?Q?kANJ0pM+GpQe5VRQV5NvyhiDntaYi4z+C5tFwbv1mnGR/x8B4v8Y7nsrxwyU?=
 =?us-ascii?Q?eIZyv7xZizSKLsavuaQt+D9p/gFA6jtDBJzlUJ0PvC+yUNwr1Ligm7TrzG5g?=
 =?us-ascii?Q?DrS2tHsvtFQHoVTqdj4MTJAz9s8ipEhA+1SqlbA5BlBYfP0g5fhcQi40ZxIx?=
 =?us-ascii?Q?UgDBd4YQkNBGILTvNHHy8toCkJoi/t0H2otpXBTpucC7X78C+5W/bWS6ERFw?=
 =?us-ascii?Q?1VSy2qruQu22Zc7XI/p9evmRzemd9eOy8irU+Vm6kU5YSZjY+KVGo+CkT9YT?=
 =?us-ascii?Q?+5TzU9JLqOmxnE7WDEJhce2iGJD4pyXwF1g6UXXXZ5bYvHXYa59++9I9CKOk?=
 =?us-ascii?Q?Lk8rx+YKm67uu1NXidbM8Q18MVOZ7n+cheVoRBfMeFV9ogJgwCQzseiKSOG/?=
 =?us-ascii?Q?nDhQ69jrzH5MYsy5hwhslB8r0l+GG1eA95yI4DqUMKoVymQ+w89k879Xpmhr?=
 =?us-ascii?Q?mNBsyei+pX1UXR5ykT7xiLJyoU703YbjLRbHEsDqvvpRBuNh/i1+jN/phswL?=
 =?us-ascii?Q?F0ZwI69ApGnLWM6PY1gwSH14Hvmeu4k1OWLGUVidw/0uZeXPb8SHE0hL8+/M?=
 =?us-ascii?Q?bN2HJwA8g3on12SvBtVGnMsbByEyJV+k0IT5vDhUbv/1oWmTFGlzlekkkuTI?=
 =?us-ascii?Q?oFsfU3dv0OC+kFF1zmauI/e7HrG+Fl2l0079/00WBZ8dcR1X847Od0SSgCXy?=
 =?us-ascii?Q?pB6THw0eLTTnvtLUMshGMTfFwMoQqWqCA3YBGP6TcprimnMmxvyHV4rjTy3s?=
 =?us-ascii?Q?s/flr7yKkizM+6lmvRl7JkC5ICqhTs8JT1s0uxq6IbiVeDYScLm6VCOFdfNI?=
 =?us-ascii?Q?03jAV4lXAD7SkjyydAJN71SeR3PkIPabj+MdWBWBUlAWorjKMLriUN+QHwgR?=
 =?us-ascii?Q?j/Lp6w4SSfOXw3SEAaY/458UE13VLgLnniC8spZRu7REY/+lOv9bTAtXz7Ml?=
 =?us-ascii?Q?NKIM/LlJAdCakwKikjvFNVjlhy93hEJtr/vky0bOgTt5eXcC3VIdFOJTpE0e?=
 =?us-ascii?Q?wKJJL7HL1eKv41HgEHZo0n7ROMVFwugMx/PbN2YLSXGXvck5YwbhFIRLF4zX?=
 =?us-ascii?Q?WDlvx8InFV53H4Ha3LqlWhHKzKOHW/8bM0NnyafIfRfopIyur1AQ/fVE1Wz9?=
 =?us-ascii?Q?F4SrMtdpPM9Unn+j3WfL5fUVDD7gsRz1qfN3Upk60SqHJJelOQbb0t2Jvgsx?=
 =?us-ascii?Q?eNkY2ZwW6hWbwTMDjs0MXFmYrMC0kQRRdGFENSpv+HosFDsQY7qSNi7XlPat?=
 =?us-ascii?Q?Cm0Jy8kz1tL4qKCNRDcKoQSQXCZlz8q8xtF+VCDAlkPIfiOr27lWNIfWEnjX?=
 =?us-ascii?Q?QlZ2teCYbWY5uXZfcojstBlMbwG1ukQ=3D?=
X-Exchange-RoutingPolicyChecked:
	tEMvLT6M6iqhqE53l7elX6hdDn+ccbk2kIRmRGH/A6QOgLIAP7zCWlp4ZVAb2A+894SZwY6zRitRpyv+fHJ92reFuCru3sXXxbPfniTGeyZ7rZ3A7uHIf+djCJdMLIzvxJzPIliRY6riCpBEjlP9DhXJJYLs/vm3pGdlhwUU+MeYPvbW8MTuuDdMNnyRdifa1hOwv5fCv2TPWnyH5r+nQwdWSODtOZY8Usm6mZrHo8ldKREiemsGYRRpSERX3mMRV9gUYD7iLLqEV7XddFLr5Ki9nYt6bDfrgnYZRhgn4DB2I+jXgZ8swFHJdidoKoIaV8nAxADa9YKAuzUOlpUfjg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ab54f2-b43b-4659-5fc5-08dedea762ac
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 17:19:23.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOKR8XOPOeV9OyDksSC3O/IvB9Uh3UKe2PFCpRZgcAh3OljgT4NFM98gUWIHGcENAO9sInD2ydlbcwPI5xB0S8rhKvYGDwaa4URnfE9uOuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9672
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a51299d cx=c_pps
 a=dnat/ZFdcaejr8kp+uhwWQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=3l-6mH92vxuJywMkn1oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE3MyBTYWx0ZWRfX1fT5Til0kLxP
 PfK4/AO85VamEU3gw/vKWVOG74kuqK069dolRKV92VvHt1ZX6DMChxLTIdfVeKc5/HF3H/cjt2r
 dcL3bwinHQnLu+32f3gvSX6pCIsCu80yUZSYdpNOVb6M2lkLcGXl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE3MyBTYWx0ZWRfXzEhedb6eha7T
 d+YY9lmLYf7TXfXWmiYc+TQ6taXh2hHT+OFpemKNDcKwqK52G8WctGmLmeMzZKPP4gkp45zr/te
 4UtUStzkxR9eCdtHlLrAatVqMQ7PNEYHZ7M0eoYCI5RXIcDb1b0hAHcXg1VqA0juiEWZo0oeQ4Q
 q2TK2AZPVwzzkym6kUo2sGmbZkcR53jQ1GS2d1Rn7wX3zlP9cxA/wpXtT1vDace/bsuLu8LWJ7S
 534EdqX21sj8ufJINpD/uthZ6fDvqzahSZmIBfazv9gz9YdELV4k1km2yeJQcgNu3Ae81Pkd7kw
 bx2ueQwAJRfdJc8wz0lNAtAUFBnnr/bU/kbrhvoUdh0NkBQq4wainUoZNvKuTsPdawbY3QGJ1Dc
 o0hy6a0zTEj+Ui6FNfAgkl5MNVgXhQGxEeH1mFr9TAWXdwr8lqVGlr1Adj7jo2AeHRDAxvCcfvT
 w9iAsEc5grJ6hbHMiWA==
X-Proofpoint-ORIG-GUID: ej63Zd0Dw5rZuJTutCKHCirvPp8HBtI8
X-Proofpoint-GUID: ej63Zd0Dw5rZuJTutCKHCirvPp8HBtI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100173

Hi Matthew, Yilun,

I'm moving Intel PAC N3000 (and D5005) support off the out-of-tree OPAE
driver and onto the in-tree DFL stack on a 6.18-based product. The goal
is simply to have the N3000 FPGA fully functional with the current
opae-sdk (2.14.x) userspace on top of the mainline drivers, so we can
drop the OOT driver entirely. Before sending any patch I'd like your
guidance on one functional gap.

The mainline MAX10 BMC secure-update driver
(drivers/fpga/intel-m10-bmc-sec-update.c) exposes only the
firmware-upload ABI (/sys/class/firmware/secure-updateN) for flashing
images. It does not provide the control/available_images and
control/image_load sysfs attributes that opae-sdk uses to *trigger* a
reload rather than a flash:

  - bmc_user / bmc_factory: reload the BMC user/factory image via the
    doorbell (DRBL_CONFIG_SEL | DRBL_REBOOT_REQ)
  - retimer_fw (N3000 only): trigger a PKVL retimer EEPROM reload and
    poll for completion

These attributes existed in linux-dfl (commits e1b885714f68 and
604ad4f48cee) but were never upstreamed. As far as I can tell there is
no equivalent mechanism in mainline to trigger a bank reload or a
retimer EEPROM reload from userspace. In practice this means the
migration off the OOT OPAE driver is blocked for these field-update
use cases: opae-sdk expects control/image_load, and without it the
in-tree driver cannot fully replace the OOT one on N3000/D5005.

My questions:

1. Would you be open to upstreaming the N3000/D5005 subset of this
   interface to mainline? I have a patch that adds a small image_load
   handler table gated per-device (N6000 keeps .image_load = NULL, so
   the control/ group stays hidden for it), plus the M10BMC_PKVL_*
   register definitions needed by the retimer path. I intentionally
   left out the N6000/PMCI/SDM handlers.

   Or was this interface deliberately dropped during upstreaming in
   favour of another mechanism I've missed? If so, I'd rather adopt the
   preferred approach so opae-sdk keeps working on the in-tree driver.

2. Assuming it's acceptable and lands in mainline, would a subsequent
   backport to 6.18.y stable be reasonable via the normal
   (mainline-first) stable process?

If the direction sounds right, I'll send it as a proper RFC/PATCH with
the ABI documentation update. Tested on Intel PAC N3000 (0x8086:0x0b30)
with 6.18.15 and opae-sdk 2.14.x: control/available_images reports
"bmc_factory bmc_user retimer_fw" and control/image_load accepts a
valid name.

Thanks,
Ionut
