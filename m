Return-Path: <SRS0=Q/oG=OA=sirena.org.uk=broonie@kernel.org>
Return-Path: <SRS0=Q/oG=OA=sirena.org.uk=broonie@kernel.org>
Date: Wed, 21 Nov 2018 12:42:37 +0000
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: add FTDI MPSSE SPI controller driver
Message-ID: <20181121124237.GC8059@sirena.org.uk>
References: <20181120002821.12794-1-agust@denx.de>
 <20181120002821.12794-3-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20181120002821.12794-3-agust@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2018 at 01:28:20AM +0100, Anatolij Gustschin wrote:

> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_SPI_XILINX)		+=3D spi-xilinx.o
>  obj-$(CONFIG_SPI_XLP)			+=3D spi-xlp.o
>  obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+=3D spi-xtensa-xtfpga.o
>  obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+=3D spi-zynqmp-gqspi.o
> +obj-$(CONFIG_SPI_FTDI_MPSSE)		+=3D spi-ftdi-mpsse.o
> =20
>  # SPI slave protocol handlers
>  obj-$(CONFIG_SPI_SLAVE_TIME)		+=3D spi-slave-time.o

Please keep the Makefile sorted.

> +++ b/drivers/spi/spi-ftdi-mpsse.c
> @@ -0,0 +1,673 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FTDI FT232H MPSSE SPI controller driver

Please make the entire comment block here a C++ one so it looks more
consistent.

> +	struct gpiod_lookup_table *lookup[13];

This magic number for the size of the lookup table is not good.

> +static void ftdi_spi_chipselect(struct ftdi_spi *priv, struct spi_device=
 *spi,
> +				bool value)
> +{
> +	int cs =3D spi->chip_select;
> +
> +	dev_dbg(&priv->master->dev, "%s: CS %d, cs mode %d, val %d\n",
> +		__func__, cs, (spi->mode & SPI_CS_HIGH), value);
> +
> +	gpiod_set_raw_value_cansleep(priv->cs_gpios[cs], value);
> +}

This is just a gpio chip select - can't it be handled by the core chip
select code?

> +	remaining =3D len;
> +	do {
> +		stride =3D min_t(size_t, remaining, SZ_64K - 3);

Rather than having a magic number for the buffer size it would be better
to either have a driver specific constant that's used consistently or
just use sizeof() when it's referenced in the code.  That way if the
buffer size is changed nothing will get missed.

> +		/* Last transfer with cs_change set, stop keeping CS */
> +		if (list_is_last(&t->transfer_list, &msg->transfers)) {
> +			keep_cs =3D true;
> +			break;
> +		}
> +		ftdi_spi_chipselect(priv, spi, !(spi->mode & SPI_CS_HIGH));
> +		usleep_range(10, 15);
> +		ftdi_spi_chipselect(priv, spi, spi->mode & SPI_CS_HIGH);

I'm not clear what this is intended to do?  It's overall not clear to me
that the driver needs to use transfer_one_message and not transfer_one,
the latter keeps more of the code in common code.

> +	/* Find max. slave chipselect number */
> +	num_cs =3D pd->spi_info_len;
> +	for (i =3D 0; i < num_cs; i++) {
> +		if (max_cs < pd->spi_info[i].chip_select)
> +			max_cs =3D pd->spi_info[i].chip_select;
> +	}
> +
> +	if (max_cs > 12) {
> +		dev_err(dev, "Invalid max CS in platform data: %d\n", max_cs);
> +		return -EINVAL;
> +	}
> +	dev_dbg(dev, "CS count %d, max CS %d\n", num_cs, max_cs);
> +	max_cs +=3D 1; /* including CS0 */

Why not just size the array based on the platform data?

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv1UrwACgkQJNaLcl1U
h9CMUQf/RfnJpbbB4fY15ij3HrjRQh3rrVElV6GD+CXWUn8tl4MUCougWoAUypAx
r6gdIA2IlGsoPSqtBxLEjAnfECFjyUKRoRojxgYseW1DuN2rNSkk4wtspZv0aWPH
6LtSCNJZtICIfVXvBU/ZXQLnthuY9MPVAPU9mGuQA8y6njXvAAGD6v7cO7Da9IVq
KkB4TVGSv4iwZIAZ7ThDrkN8teY/jEJGClEgFroJrG/X9t0aMVxzD/23H6+P2G2X
yvsoIZFDOoksz7PdLBr3oxrn3Pc54TwOosYDtrDSLMAqYEQPScToVIe8ZmUbBtj1
ysSOIwStMuVzC8HCS42wtcvKXxEvug==
=bkBV
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
