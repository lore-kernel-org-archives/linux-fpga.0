Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH 2/2] fpga: dfl: fix bug in port reset handshake
Date: Thu, 16 Apr 2020 08:06:17 +0000
Message-ID: <DM6PR11MB381991FD47E055D344B77D2985D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-3-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1587006712-22696-3-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "trix@redhat.com" <trix@redhat.com>, "bhu@redhat.com" <bhu@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of Xu Yilun
> Sent: Thursday, April 16, 2020 11:12 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; bhu@redhat.com; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>; Xu, Yilun <yilun.xu@intel.com>
> Subject: [PATCH 2/2] fpga: dfl: fix bug in port reset handshake
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> When putting the port in reset, driver must wait for the soft reset
> acknowledgment bit instead of the soft reset bit.
>=20
> Fixes: 47c1b19c160f (fpga: dfl: afu: add port ops support)
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>

Thanks for catching this.

Acked-by: Wu Hao <hao.wu@intel.com>

> ---
>  drivers/fpga/dfl-afu-main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index b0c3178..3fa2c59 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -83,7 +83,8 @@ int __afu_port_disable(struct platform_device *pdev)
>  	 * on this port and minimum soft reset pulse width has elapsed.
>  	 * Driver polls port_soft_reset_ack to determine if reset done by HW.
>  	 */
> -	if (readq_poll_timeout(base + PORT_HDR_CTRL, v, v &
> PORT_CTRL_SFTRST,
> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> +			       v & PORT_CTRL_SFTRST_ACK,
>  			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
>  		dev_err(&pdev->dev, "timeout, fail to reset device\n");
>  		return -ETIMEDOUT;
> --
> 2.7.4
