Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1521808032-29645-3-git-send-email-p.pisati@gmail.com>
References: <1521808032-29645-1-git-send-email-p.pisati@gmail.com> <1521808032-29645-3-git-send-email-p.pisati@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 28 Mar 2018 11:26:36 -0500
Message-ID: <CANk1AXRAXQ8cURb+ObS5SpaBKQLdoFFB6nmLTnmA1gQowmoVbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 23, 2018 at 7:27 AM, Paolo Pisati <p.pisati@gmail.com> wrote:

Hi Paolo,

Looking good.  A few things below.  Also, when you post, please use
the '-v' parameter of 'git format-patch' to add the version to the
subject line such as [PATCH v9].

> This patch adds support to the FPGA manager for programming
> MachXO2 device=E2=80=99s internal flash memory, via slave SPI.
>
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> ---
>  drivers/fpga/Kconfig       |   8 +
>  drivers/fpga/Makefile      |   1 +
>  drivers/fpga/machxo2-spi.c | 388 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 397 insertions(+)
>  create mode 100644 drivers/fpga/machxo2-spi.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index ad5448f..65ccbc5 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -38,6 +38,14 @@ config FPGA_MGR_ALTERA_PS_SPI
>           FPGA manager driver support for Altera Arria/Cyclone/Stratix
>           using the passive serial interface over SPI.
>
> +config FPGA_MGR_MACHXO2_SPI
> +       tristate "Lattice MachXO2 SPI"
> +       depends on SPI
> +       help
> +         FPGA manager driver support for Lattice MachXO2 configuration
> +         over slave SPI interface.
> +
> +

Please move this section after FPGA_MGR_ICE40_SPI.  That keeps the two
lattice drivers together in the Kconfig.  You may need to rebase your
driver to go onto linux-next.

Also, please delete the extra line feed above.

>  config FPGA_MGR_SOCFPGA
>         tristate "Altera SOCFPGA FPGA Manager"
>         depends on ARCH_SOCFPGA || COMPILE_TEST
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index f98dcf1..38abb08 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_FPGA)                    +=3D fpga-mgr.o
>  obj-$(CONFIG_FPGA_MGR_ALTERA_CVP)      +=3D altera-cvp.o
>  obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI)   +=3D altera-ps-spi.o
>  obj-$(CONFIG_FPGA_MGR_ICE40_SPI)       +=3D ice40-spi.o
> +obj-$(CONFIG_FPGA_MGR_MACHXO2_SPI)     +=3D machxo2-spi.o
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)         +=3D socfpga.o
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)     +=3D socfpga-a10.o
>  obj-$(CONFIG_FPGA_MGR_TS73XX)          +=3D ts73xx-fpga.o
> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> new file mode 100644
> index 0000000..6a5c5c7
> --- /dev/null
> +++ b/drivers/fpga/machxo2-spi.c
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: GPL-2.0

The above line is good but...

> +// Lattice MachXO2 Slave SPI Driver
> +//
> +// Manage Lattice FPGA firmware that is loaded over SPI using
> +// the slave serial configuration interface.
> +//
> +// Copyright (C) 2018 Paolo Pisati <p.pisati@gmail.com>

This stuff should be as:
/*
 * some stuff
 * more stuff
 */

> +
> +//#define DEBUG

Please remove the //#define DEBUG

> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +
> +/* MachXO2 Programming Guide - sysCONFIG Programming Commands */
> +#define IDCODE_PUB                     {0xe0, 0x00, 0x00, 0x00}
> +#define ISC_ENABLE                     {0xc6, 0x08, 0x00, 0x00}
> +#define ISC_ERASE                      {0x0e, 0x04, 0x00, 0x00}
> +#define ISC_PROGRAMDONE                {0x5e, 0x00, 0x00, 0x00}
> +#define LSC_INITADDRESS                {0x46, 0x00, 0x00, 0x00}
> +#define LSC_PROGINCRNV         {0x70, 0x00, 0x00, 0x01}
> +#define LSC_READ_STATUS                {0x3c, 0x00, 0x00, 0x00}
> +#define LSC_REFRESH                    {0x79, 0x00, 0x00, 0x00}
> +
> +/*
> + * Max CCLK in Slave SPI mode according to 'MachXO2 Family Data
> + * Sheet' sysCONFIG Port Timing Specifications (3-36)
> + */
> +#define MACHXO2_MAX_SPEED                      66000000
> +
> +#define MACHXO2_LOW_DELAY                      5               /* us */

I'd prefer MACHXO2_LOW_DELAY_USEC so that you don't need the comment
here and it's clear in the rest of the driver.  Same for the next two.

> +#define MACHXO2_HIGH_DELAY                     200             /* us */
> +#define MACHXO2_REFRESH                                4800    /* us */
> +#define MACHXO2_MAX_BUSY_LOOP          128
> +#define MACHXO2_MAX_REFRESH_LOOP       16
> +
> +#define MACHXO2_PAGE_SIZE                      16
> +#define MACHXO2_BUF_SIZE                       (MACHXO2_PAGE_SIZE + 4)
> +
> +/* Status register bits, errors and error mask */
> +#define BUSY   12
> +#define DONE   8
> +#define DVER   27
> +#define ENAB   9
> +#define ERRBITS        23
> +#define ERRMASK        7
> +#define FAIL   13
> +
> +#define ENOERR 0 /* no error */
> +#define EID            1
> +#define ECMD   2
> +#define        ECRC    3
> +#define EPREAM 4 /* preamble error */
> +#define EABRT  5 /* abort error */
> +#define EOVERFL 6 /* overflow error */
> +#define ESDMEOF 7 /* SDM EOF */
> +
> +static inline u8 get_err(unsigned long *status)
> +{
> +       return (*status >> ERRBITS) & ERRMASK;
> +}
> +
> +static int get_status(struct spi_device *spi, unsigned long *status)
> +{
> +       struct spi_message msg;
> +       struct spi_transfer rx, tx;
> +       static const u8 cmd[] =3D LSC_READ_STATUS;
> +       int ret;
> +
> +       memset(&rx, 0, sizeof(rx));
> +       memset(&tx, 0, sizeof(tx));
> +       tx.tx_buf =3D cmd;
> +       tx.len =3D sizeof(cmd);
> +       rx.rx_buf =3D status;
> +       rx.len =3D 4;
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&tx, &msg);
> +       spi_message_add_tail(&rx, &msg);
> +       ret =3D spi_sync(spi, &msg);
> +       if (ret)
> +               return ret;
> +
> +       *status =3D be32_to_cpu(*status);

Add a line feed before returning.

> +       return 0;
> +}
> +
> +#ifdef DEBUG
> +static const char *get_err_string(u8 err)
> +{
> +       switch (err) {
> +       case ENOERR:    return "No Error";
> +       case EID:               return "ID ERR";
> +       case ECMD:              return "CMD ERR";
> +       case ECRC:              return "CRC ERR";
> +       case EPREAM:    return "Preamble ERR";
> +       case EABRT:             return "Abort ERR";
> +       case EOVERFL:   return "Overflow ERR";
> +       case ESDMEOF:   return "SDM EOF";
> +       }

Line feed before returning

> +       return "Default switch case";
> +}
> +#endif
> +
> +static void dump_status_reg(unsigned long *status)
> +{
> +#ifdef DEBUG
> +       pr_debug("machxo2 status: 0x%08lX - done=3D%d, cfgena=3D%d, busy=
=3D%d, fail=3D%d, devver=3D%d, err=3D%s\n",
> +               *status, test_bit(DONE, status), test_bit(ENAB, status),
> +               test_bit(BUSY, status), test_bit(FAIL, status),
> +               test_bit(DVER, status), get_err_string(get_err(status)));

Please align the the 3 lines after the pr_debug to match the above parenthe=
ses.

> +#endif
> +}
> +
> +static int wait_until_not_busy(struct spi_device *spi)
> +{
> +       unsigned long status;
> +       int ret, loop =3D 0;
> +
> +       do {
> +               ret =3D get_status(spi, &status);
> +               if (ret)
> +                       return ret;
> +               if (++loop >=3D MACHXO2_MAX_BUSY_LOOP)
> +                       return -EBUSY;
> +       } while (test_bit(BUSY, &status));
> +
> +       return 0;
> +}
> +
> +static int machxo2_cleanup(struct fpga_manager *mgr)
> +{
> +       struct spi_device *spi =3D mgr->priv;
> +       struct spi_message msg;
> +       struct spi_transfer tx[2];
> +       static const u8 erase[] =3D ISC_ERASE;
> +       static const u8 refresh[] =3D LSC_REFRESH;
> +       int ret;
> +
> +       memset(tx, 0, sizeof(tx));
> +       spi_message_init(&msg);
> +       tx[0].tx_buf =3D &erase;
> +       tx[0].len =3D sizeof(erase);
> +       spi_message_add_tail(&tx[0], &msg);
> +       ret =3D spi_sync(spi, &msg);
> +       if (ret)
> +               goto fail;
> +
> +       ret =3D wait_until_not_busy(spi);
> +       if (ret)
> +               goto fail;
> +
> +       spi_message_init(&msg);
> +       tx[1].tx_buf =3D &refresh;
> +       tx[1].len =3D sizeof(refresh);
> +       tx[1].delay_usecs =3D MACHXO2_REFRESH;
> +       spi_message_add_tail(&tx[1], &msg);
> +       ret =3D spi_sync(spi, &msg);
> +       if (ret)
> +               goto fail;
> +
> +       return 0;
> +fail:
> +       dev_err(&mgr->dev, "Cleanup failed\n");
> +       return ret;
> +}
> +
> +static enum fpga_mgr_states machxo2_spi_state(struct fpga_manager *mgr)
> +{
> +       return FPGA_MGR_STATE_UNKNOWN;

If you have a way of reporting whether the FPGA is in operating state
or some error state, etc here, that would be nice.

> +}
> +
> +static int machxo2_write_init(struct fpga_manager *mgr,
> +                             struct fpga_image_info *info,
> +                             const char *buf, size_t count)
> +{
> +       struct spi_device *spi =3D mgr->priv;
> +       struct spi_message msg;
> +       struct spi_transfer tx[3];
> +       static const u8 enable[] =3D ISC_ENABLE;
> +       static const u8 erase[] =3D ISC_ERASE;
> +       static const u8 initaddr[] =3D LSC_INITADDRESS;
> +       unsigned long status;
> +       int ret;
> +
> +       if ((info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> +               dev_err(&mgr->dev,
> +                       "Partial reconfiguration is not supported\n");
> +               return -ENOTSUPP;
> +       }
> +
> +       get_status(spi, &status);
> +       dump_status_reg(&status);
> +       memset(tx, 0, sizeof(tx));
> +       spi_message_init(&msg);
> +       tx[0].tx_buf =3D &enable;
> +       tx[0].len =3D sizeof(enable);
> +       tx[0].delay_usecs =3D MACHXO2_LOW_DELAY;
> +       spi_message_add_tail(&tx[0], &msg);
> +
> +       tx[1].tx_buf =3D &erase;
> +       tx[1].len =3D sizeof(erase);
> +       spi_message_add_tail(&tx[1], &msg);
> +       ret =3D spi_sync(spi, &msg);
> +       if (ret)
> +               goto fail;
> +
> +       ret =3D wait_until_not_busy(spi);
> +       if (ret)
> +               goto fail;
> +
> +       get_status(spi, &status);
> +       if (test_bit(FAIL, &status))
> +               goto fail;
> +       dump_status_reg(&status);
> +
> +       spi_message_init(&msg);
> +       tx[2].tx_buf =3D &initaddr;
> +       tx[2].len =3D sizeof(initaddr);
> +       spi_message_add_tail(&tx[2], &msg);
> +       ret =3D spi_sync(spi, &msg);
> +       if (ret)
> +               goto fail;
> +
> +       get_status(spi, &status);
> +       dump_status_reg(&status);
> +       return 0;
> +fail:
> +       dev_err(&mgr->dev, "Error during FPGA init.\n");
> +       return ret;
> +}
> +
> +static int machxo2_write(struct fpga_manager *mgr, const char *buf,
> +                        size_t count)
> +{
> +       struct spi_device *spi =3D mgr->priv;
> +       struct spi_message msg;
> +       struct spi_transfer tx;
> +       static const u8 progincr[] =3D LSC_PROGINCRNV;
> +       u8 payload[MACHXO2_BUF_SIZE];
> +       unsigned long status;
> +       int i, ret;
> +
> +       if (count % MACHXO2_PAGE_SIZE !=3D 0) {
> +               dev_err(&mgr->dev, "Malformed payload.\n");
> +               return -EINVAL;
> +       }
> +       get_status(spi, &status);
> +       dump_status_reg(&status);
> +       memcpy(payload, &progincr, sizeof(progincr));
> +       for (i =3D 0; i < count; i +=3D MACHXO2_PAGE_SIZE) {
> +               memcpy(&payload[sizeof(progincr)], &buf[i], MACHXO2_PAGE_=
SIZE);
> +               memset(&tx, 0, sizeof(tx));
> +               spi_message_init(&msg);
> +               tx.tx_buf =3D payload;
> +               tx.len =3D MACHXO2_BUF_SIZE;
> +               tx.delay_usecs =3D MACHXO2_HIGH_DELAY;
> +               spi_message_add_tail(&tx, &msg);
> +               ret =3D spi_sync(spi, &msg);
> +               if (ret) {
> +                       dev_err(&mgr->dev, "Error loading the bitstream.\=
n");
> +                       return ret;
> +               }
> +       }
> +       get_status(spi, &status);
> +       dump_status_reg(&status);
> +
> +       return 0;
> +}
> +
> +static int machxo2_write_complete(struct fpga_manager *mgr,
> +                                 struct fpga_image_info *info)
> +{
> +       struct spi_device *spi =3D mgr->priv;
> +       struct spi_message msg;
> +       struct spi_transfer tx[2];
> +       static const u8 progdone[] =3D ISC_PROGRAMDONE;
> +       static const u8 refresh[] =3D LSC_REFRESH;
> +       unsigned long status;
> +       int ret, refreshloop =3D 0;
> +
> +       memset(tx, 0, sizeof(tx));
> +       spi_message_init(&msg);
> +       tx[0].tx_buf =3D &progdone;
> +       tx[0].len =3D sizeof(progdone);
> +       spi_message_add_tail(&tx[0], &msg);
> +       ret =3D spi_sync(spi, &msg);
> +       if (ret)
> +               goto fail;
> +       ret =3D wait_until_not_busy(spi);
> +       if (ret)
> +               goto fail;
> +
> +       get_status(spi, &status);
> +       dump_status_reg(&status);
> +       if (!test_bit(DONE, &status)) {
> +               machxo2_cleanup(mgr);
> +               goto fail;
> +       }
> +
> +       do {
> +               spi_message_init(&msg);
> +               tx[1].tx_buf =3D &refresh;
> +               tx[1].len =3D sizeof(refresh);
> +               tx[1].delay_usecs =3D MACHXO2_REFRESH;
> +               spi_message_add_tail(&tx[1], &msg);
> +               ret =3D spi_sync(spi, &msg);
> +               if (ret)
> +                       goto fail;
> +
> +               /* check refresh status */
> +               get_status(spi, &status);
> +               dump_status_reg(&status);
> +               if (!test_bit(BUSY, &status) && test_bit(DONE, &status) &=
&
> +                       get_err(&status) =3D=3D ENOERR)
> +                               break;

The get_err should be aligned with the above parentheses.  Then you
can adjust the indentation of the break.

> +               if (++refreshloop =3D=3D MACHXO2_MAX_REFRESH_LOOP) {
> +                       machxo2_cleanup(mgr);
> +                       goto fail;
> +               }
> +       } while (1);
> +
> +       get_status(spi, &status);
> +       dump_status_reg(&status);
> +       return 0;
> +fail:
> +       dev_err(&mgr->dev, "Refresh failed.\n");
> +       return ret;
> +}
> +
> +static const struct fpga_manager_ops machxo2_ops =3D {
> +       .state =3D machxo2_spi_state,
> +       .write_init =3D machxo2_write_init,
> +       .write =3D machxo2_write,
> +       .write_complete =3D machxo2_write_complete,
> +};
> +
> +static int machxo2_spi_probe(struct spi_device *spi)
> +{
> +       struct device *dev =3D &spi->dev;
> +
> +       if (spi->max_speed_hz > MACHXO2_MAX_SPEED) {
> +               dev_err(dev, "Speed is too high\n");
> +               return -EINVAL;
> +       }
> +
> +       return fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
> +                                &machxo2_ops, spi);
> +}
> +
> +static int machxo2_spi_remove(struct spi_device *spi)
> +{
> +       struct device *dev =3D &spi->dev;
> +
> +       fpga_mgr_unregister(dev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id of_match[] =3D {
> +       { .compatible =3D "lattice,machxo2-slave-spi", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, of_match);
> +
> +static const struct spi_device_id lattice_ids[] =3D {
> +       { "machxo2-slave-spi", 0 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(spi, lattice_ids);
> +
> +static struct spi_driver machxo2_spi_driver =3D {
> +       .driver =3D {
> +               .name =3D "machxo2-slave-spi",
> +               .of_match_table =3D of_match_ptr(of_match),
> +       },
> +       .probe =3D machxo2_spi_probe,
> +       .remove =3D machxo2_spi_remove,
> +       .id_table =3D lattice_ids,
> +};
> +
> +module_spi_driver(machxo2_spi_driver)
> +
> +MODULE_AUTHOR("Paolo Pisati <p.pisati@gmail.com>");
> +MODULE_DESCRIPTION("Load Lattice FPGA firmware over SPI");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
