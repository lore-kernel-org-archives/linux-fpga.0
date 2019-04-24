Return-Path: <SRS0=ycEN=S2=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ycEN=S2=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfDXLWc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Apr 2019 07:22:32 -0400
Message-ID: <efb56be4292ec510c56393fd3c90d3dc15e6c509.camel@suse.de>
Subject: Re: [PATCH] fpga: stratix10-soc: fix use-after-free on s10_init()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Wed, 24 Apr 2019 13:22:29 +0200
In-Reply-To: <1556062325-26141-1-git-send-email-wen.yang99@zte.com.cn>
References: <1556062325-26141-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-70T5DtD+qLFz8KVBAb+J"
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc: wang.yi59@zte.com.cn, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org


--=-70T5DtD+qLFz8KVBAb+J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thanks,

On Wed, 2019-04-24 at 07:32 +0800, Wen Yang wrote:
> The refcount of fw_np has already been decreased by of_find_matching_node=
()
> so it shouldn't be used anymore.
> This patch adds an of_node_get() before of_find_matching_node() to avoid
> the use-after-free problem.
>=20
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: linux-fpga@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/fpga/stratix10-soc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 13851b3..215d337 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -507,12 +507,16 @@ static int __init s10_init(void)
>  	if (!fw_np)
>  		return -ENODEV;
> =20
> +	of_node_get(fw_np);
>  	np =3D of_find_matching_node(fw_np, s10_of_match);
> -	if (!np)
> +	if (!np) {
> +		of_node_put(fw_np);
>  		return -ENODEV;
> +	}
> =20
>  	of_node_put(np);
>  	ret =3D of_platform_populate(fw_np, s10_of_match, NULL, NULL);
> +	of_node_put(fw_np);
>  	if (ret)
>  		return ret;
> =20


Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-70T5DtD+qLFz8KVBAb+J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzARvUACgkQlfZmHno8
x/7t8wgAsvjz3+gn78pDmB032WBkCYgK2KwlJEiWEgPuoev2hDJ+l+bGs1OicCVV
isETGRXY8Pwt6TXMnNDxUqZxtFky48Mddgk0wbxakl4yQYO1sqKoFqmpwaPcgCsu
dBJjrrpRLiVSyuJIuoR+XACFf42oqMuKb0TgxXoQKP0aL4PfOFzxKrO7F4Szchxf
JCI1yp3r4QxNzbAam+tC3uJFzzBCrlKqj3U7IIEt3fd9SWTg8gHac1pKexT14DFb
zF+mQA6g1nxk9dzf5hM3l9SZe2V2tiaT7EDg/LESeej83xEIqtqGPPh/g4twFE84
NTBMEEhGIShUwXO7Acee4SaQRvxp3g==
=AYa7
-----END PGP SIGNATURE-----

--=-70T5DtD+qLFz8KVBAb+J--
