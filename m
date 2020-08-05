Return-Path: <SRS0=xNcZ=BP=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=xNcZ=BP=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH v3 1/4] fpga: dfl: change data type of feature id to u16
Date: Wed, 5 Aug 2020 09:13:44 +0000
Message-ID: <DM6PR11MB3819752BB8E7437CC6E20284854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1596524715-18038-2-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "trix@redhat.com" <trix@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

> Subject: [PATCH v3 1/4] fpga: dfl: change data type of feature id to u16
>=20
> The feature id is stored in a 12 bit field in DFH. So a u16 variable is
> enough for feature id.
>=20
> This patch changes all feature id related places to fit u16.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao
