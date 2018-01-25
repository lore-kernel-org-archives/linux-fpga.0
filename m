Date: Thu, 25 Jan 2018 11:09:50 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: fpga-region: comment on fpga_region_program_fpga
 locking
Message-ID: <20180125190950.GA26170@tyrael.ni.corp.natinst.com>
References: <20180125153922.3119-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20180125153922.3119-1-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

looks good.

On Thu, Jan 25, 2018 at 09:39:22AM -0600, Alan Tull wrote:
> Add a comment to the header of fpga_region_program_fpga()
> regarding locking of the bridges.
>=20
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/fpga-region.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index edab2a2..cb0603e 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -95,6 +95,11 @@ static void fpga_region_put(struct fpga_region *region)
>   * fpga_region_program_fpga - program FPGA
>   * @region: FPGA region
>   * Program an FPGA using fpga image info (region->info).
> + * If the region has a get_bridges function, the exclusive reference for=
 the
> + * bridges will be held if programming succeeds.  This is intended to pr=
event
> + * reprogramming the region until the caller considers it safe to do so.
> + * The caller will need to call fpga_bridges_put() before attempting to
> + * reprogram the region.
>   * Return 0 for success or negative error code.
>   */
>  int fpga_region_program_fpga(struct fpga_region *region)
> --=20
> 2.7.4
>=20

- Moritz

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlpqK3oACgkQUVwKRFcJ
cNi2vggArrlkDETk2bSyx5tG3vDjvOcpLdUy8dF09+bHwbTPUWgEPwH6AB3LT+a5
IEXZeF7VqzRQGsQEu7y+s5E2J5qZRMTWAiF846MPPoOji4kszI97qFL4BQcYA4Gi
p6//ZdiNV3JFxw1oiXFbtbEFZ/tU8mjJfiIg8EtwWvS8d26Z4s1LqEeKWAWvljFt
s8hUv1vW/E1K+QkOtqhn4FlJN1EuML/6MAAuIl21hNxcxQpR51j1axKdHobgQAc1
hOhnxDYkO2EC13OUvEp+LbKiZUqNhKD/n17QBdjP+CznvTEk0m0LMmIv5j0J7bdX
PneiFqdlff/X+XQDJ0/V6zvRVKYnvg==
=fQv5
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
