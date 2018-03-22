Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1521655492.7999.13.camel@perches.com>
References: <1521653726-24625-1-git-send-email-p.pisati@gmail.com>
 <1521653726-24625-3-git-send-email-p.pisati@gmail.com> <1521655492.7999.13.camel@perches.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 22 Mar 2018 16:32:47 -0500
Message-ID: <CANk1AXT6TY5N+gR=tBNuvhQMnOpuaWKWVoUSjB+Vfof2=GAM6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Joe Perches <joe@perches.com>
Cc: Paolo Pisati <p.pisati@gmail.com>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Mar 21, 2018 at 1:04 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-03-21 at 18:35 +0100, Paolo Pisati wrote:
>> This patch adds support to the FPGA manager for programming
>> MachXO2 device=E2=80=99s internal flash memory, via slave SPI.
>
> style trivia:
>
>> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> []
>> +static int get_status(struct spi_device *spi, unsigned long *status)
>> +{
>> +     struct spi_message msg;
>> +     struct spi_transfer rx, tx;
>> +     u8 cmd[] =3D LSC_READ_STATUS;
>
> static const u8 cmd[]
> here and everywhere else as all the tx_buf assignments
> of cmd are to const void *

Why *static* const u8 cmd[]?

Alan

>
>> +     int ret;
>> +
>> +     memset(&rx, 0, sizeof(rx));
>> +     memset(&tx, 0, sizeof(tx));
>> +     tx.tx_buf =3D cmd;
>
> []
>
>> +#ifdef DEBUG
>> +static void dump_status_reg(unsigned long *status)
>> +{
>
> Instead of multiple declarations of dump_status_reg
> it's frequently nicer to use a style like
>
> static void debug_func(args...)
> {
> #ifdef DEBUG
>         [code...]
> #endif
> }
>
> so if function arguments ever need to be changed
> it's only required to be changed in one spot and
> not multiply compilation tested with and without
> the DEBUG definition
>
>> +     char *ferr;
>> +
>> +     switch (get_err(status)) {
>> +     case ENOERR:
>> +             ferr =3D "No Error";
>> +             break;
>> +     case EID:
>> +             ferr =3D "ID ERR";
>> +             break;
>> +     case ECMD:
>> +             ferr =3D "CMD ERR";
>> +             break;
>> +     case ECRC:
>> +             ferr =3D "CRC ERR";
>> +             break;
>> +     case EPREAM:
>> +             ferr =3D "Preamble ERR";
>> +             break;
>> +     case EABRT:
>> +             ferr =3D "Abort ERR";
>> +             break;
>> +     case EOVERFL:
>> +             ferr =3D "Overflow ERR";
>> +             break;
>> +     case ESDMEOF:
>> +             ferr =3D "SDM EOF";
>> +             break;
>> +     default:
>> +             ferr =3D "Default switch case";
>> +     }
>
> It's frequently nicer to use a static function
> for these enum -> string conversions like:
>
> static const char *get_err_string(unsigned long err)
> {
>         switch (err) {
>         case ENOERR:    return "No Error";
>         case EID:       return "ID ERR";
>         case ECMD:      return "CMD ERR";
>         [...]
>         }
>         return "default switch case";
> }
>
>> +     pr_debug("machxo2 status: 0x%08lX - done=3D%d, cfgena=3D%d, busy=
=3D%d, fail=3D%d, devver=3D%d, err=3D%s\n",
>> +            *status, test_bit(DONE, status), test_bit(ENAB, status),
>> +            test_bit(BUSY, status), test_bit(FAIL, status),
>> +                test_bit(DVER, status), ferr);
>
> So instead of ferr, this could use
>         get_err_string(*status)
>
> And please try to keep a consistent alignment for
> indentation of multiple line statements
>
>> +}
>> +#else
>> +static void dump_status_reg(unsigned long *status) {}
>> +#endif
>> +
>> +static int wait_until_not_busy(struct spi_device *spi)
>> +{
>> +     unsigned long status;
>> +     int ret, loop =3D 0;
>> +
>> +     do {
>> +             ret =3D get_status(spi, &status);
>> +             if (ret)
>> +                     break;
>> +             if (++loop >=3D MACHXO2_MAX_BUSY_LOOP) {
>> +                     ret =3D -EBUSY;
>> +                     break;
>> +             }
>> +     } while (test_bit(BUSY, &status));
>> +
>> +     return ret;
>> +}
>
> Direct returns are OK and would shorten the function
> line count.
>
