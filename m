Return-Path: <SRS0=rg85=SS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=rg85=SS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45391 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPMFd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 Apr 2019 08:05:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so26649025wra.12
        for <linux-fpga@vger.kernel.org>; Tue, 16 Apr 2019 05:05:32 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] fpga: mgr: Use devicetree /alias to assign FPGA IDs
References: <20190411221109.173242-1-brandon.maier@rockwellcollins.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <a3513e84-0328-b2ef-1ca2-1c563caf0e6d@monstr.eu>
Date: Tue, 16 Apr 2019 14:05:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190411221109.173242-1-brandon.maier@rockwellcollins.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="geJ9MXXcljNAs0rXvKDNFnn0MxNBfhboN"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Brandon Maier <brandon.maier@rockwellcollins.com>, atull@kernel.org, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, clayton.shotwell@rockwellcollins.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--geJ9MXXcljNAs0rXvKDNFnn0MxNBfhboN
Content-Type: multipart/mixed; boundary="TG1hPNfu4U3Oqwdxdpat09RyHmvFwtuEH";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Brandon Maier <brandon.maier@rockwellcollins.com>, atull@kernel.org,
 mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, clayton.shotwell@rockwellcollins.com
Message-ID: <a3513e84-0328-b2ef-1ca2-1c563caf0e6d@monstr.eu>
Subject: Re: [PATCH] fpga: mgr: Use devicetree /alias to assign FPGA IDs
References: <20190411221109.173242-1-brandon.maier@rockwellcollins.com>
In-Reply-To: <20190411221109.173242-1-brandon.maier@rockwellcollins.com>

--TG1hPNfu4U3Oqwdxdpat09RyHmvFwtuEH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12. 04. 19 0:11, Brandon Maier wrote:
> The fpga-mgr assigns device IDs based on the order each driver calls
> fpga_mgr_register(). This is fine for systems with one FPGA, but if
> multiple FPGAs are in use, the device ID can change as probe order
> changes across reboots or configuration changes.
>=20
> This makes it difficult to use the sysfs attributes, as the device path=

> may change. Instead allow a static ID to be set by adding fpgaX props
> to the devicetree /aliases. Falling back to incrementing IDs if none ar=
e
> provided.
>=20
> This is based on the function rtc_device_get_id() in drivers/rtc/class.=
c
> (9d2b7e532da8 rtc: honor device tree /alias entries when assigning IDs)=
=2E
>=20
> Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
> ---
>  drivers/fpga/fpga-mgr.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index c3866816456a..d8b7e7a61117 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -551,6 +551,26 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
> =20
> +static int fpga_mgr_get_id(struct device *dev)
> +{
> +	int of_id =3D -1, id =3D -1;
> +
> +	if (dev->of_node)
> +		of_id =3D of_alias_get_id(dev->of_node, "fpga");
> +
> +	if (of_id >=3D 0) {
> +		id =3D ida_simple_get(&fpga_mgr_ida, of_id, of_id + 1,
> +				    GFP_KERNEL);
> +		if (id < 0)
> +			dev_warn(dev, "/aliases ID %d not available\n", of_id);
> +	}
> +
> +	if (id < 0)
> +		id =3D ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> +
> +	return id;
> +}

=46rom the first look this is not proper implementation. It is not
handling cases where you have mix of devices with and without aliases.
If first mgr has no alias it gets 0, then second devices with fpga0
alias can't take it even it is assign to it.

For exactly this reason I have introduced of_alias_get_alias_list()
and take a look at cdns_get_id() in serial driver how I am using it.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--TG1hPNfu4U3Oqwdxdpat09RyHmvFwtuEH--

--geJ9MXXcljNAs0rXvKDNFnn0MxNBfhboN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAly1xQQACgkQykllyylKDCGhbACeI7LNYucEEOEq+qas2DZpTgQ0
0uMAn2DJulkoxpz/Cyb86eulFjSABSEG
=FOaD
-----END PGP SIGNATURE-----

--geJ9MXXcljNAs0rXvKDNFnn0MxNBfhboN--
