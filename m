Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30E35B650
	for <linux-fpga@vger.kernel.org>; Mon,  2 Feb 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028656; cv=pass; b=G6v4/n1y5mep52mFXEyLFJLGgz6s8EPI/8azezXItfMdZB6cMxOkV6YTbC7hJUfHkb8CTyNNULirnEj9zK9940ZGP+dktTRiKFVYz1Gvi/MzeFQuVrF86/PDy+M8zO+L7TK+yRe/RWneVSKIHWvLsUT+wOMV8ksH687BkKXCaHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028656; c=relaxed/simple;
	bh=P7BrR8QvBj73TBqsrF6OihXrgbB+M4oc79DNzrwO8BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbovVgvB/KocWW/ctGoJ9SQCY+SsxmPdPOKu6s97LjqrER4OH+nZb1wK8FCw+DMAqNxwoS1QZkW8DNM12ICr+Qt35b7FlKOCwvEMDGpIUXRLQZ55/EEIHwwrNCF1oZDpBq5eU1rQDYFPpSR4qEfhD8Ci2LWEjViObfkrPHmc47w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cokpgzLR; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cokpgzLR"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so8265369a12.0
        for <linux-fpga@vger.kernel.org>; Mon, 02 Feb 2026 02:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770028652; cv=none;
        d=google.com; s=arc-20240605;
        b=EE2rKtGguD1zDG6xUVeoVQYUDAylngKB+JR6iugPF84NG62T8vNCRj0YTKlwlHtnY3
         KJ4+YWolnyQ9PCS9Ran6MMLbd0ekq9eTKA4FLHXyWUeQU3qNBf7zFvXj+SQwz2N4i5Ro
         n4QyQ/FLCeHRXo4J60bNkuXtu4a/ic+lR11SGQR4HYbVRR+lIBqAOLAq0bGAf2Fy1o2Q
         Kn2A9Q6o6sqMm/lDobwzZPOyM2giiz3yt2QJO8zh9ucWQyvrb+aXkCmFCIgVyoTkHoFu
         JPj6OKBL7uLN2EUzauDz/8xvtS/+VbX+GI2RFJjbnIGwizUdpE/pIyEB1PtYgBqfoLmg
         oQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=osHQLxXgB0+OWVrxqsLMgDWtZoVUS3LxuKc/2PLIVd4=;
        fh=JjZ7r+JYedT1LEPb2PZuOyax6cqgS6fiHXSJEWkUAAA=;
        b=DiFK9LBPn9YRX9YBV8nTSQfQbi3Cf8E8ClK+0i5IwwV+1Jf3LbRkbROScKvZJnMbAo
         HPMhSzV9IGFH/JeVYcf2houOWN2+t2qFKvspamzlUNk20um82Uo0GThOn52Yzq4zYSWq
         i8qfjSaaqv1ZS0TmxqqYK9xgtLkfhd9gHaM98whza0bqi2yyqcK/OmWpM8PHgf3wP/ce
         LiyuQW70FpEkeTnqNqudCqQjMBSk90+4VquES2EE0kcU7+F05bljBj3JFjTox/HK6i/y
         tK7C2Tsn6wHIOK3IkxsSgEAEBrpk+KcX+cyKuKuim6UFkhE9qlImvvP9eZ4EWPHwvWEM
         HfFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770028652; x=1770633452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osHQLxXgB0+OWVrxqsLMgDWtZoVUS3LxuKc/2PLIVd4=;
        b=cokpgzLRaUg1hFkww5OdV3eUx/XkrPcRA02cd3ttmu3nZvhh8Wekhde5qONvZxgu+g
         Ob28B8aEAZ2QMavjzvt8Shifw+Ks0aKmXnat68zKG8oraffacKYmdkCZxMUQ64ozZ2YF
         8dnRvXn1BteokgbZZeEl4djePK9GEhYFgkNtl5noNFSSfsZguUUwCWzPjnInhgwtmrPp
         gHANB+GnH8mhT/aQGrl2JAfjHujibsU5l6SKR0rP9zC1GXvUtUODpgz1Nb2dIGTLDv5X
         Jn7ejTwnUN75G8MIz0jyBqpEm6iJ82/W/sCTHb343HgAn94mde3USzfyiYAl5b4WIS8B
         U1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028652; x=1770633452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=osHQLxXgB0+OWVrxqsLMgDWtZoVUS3LxuKc/2PLIVd4=;
        b=aQ6pLww8foCeF4YIG/3tDevzB5RwWjB7C/8Va8ekqZ7RMT/XiJnk48uFD1F6FW5gba
         jEQuaIYnulHpFlGxpNQmLKRoNwrIfzXXLEs4DON87aNFjb1cjLR7lS5g6/UVY7TygURl
         Ch8U+WWFVZ+Svj4oMI4TpPuOGV0rUWD3yJu+wYmpIH0uWquXH8oVCm8wVqspzKH9eiht
         BqCVNH0lq/kEmQJ9F9fVWXQ9V21L6YuzT8BK71vevCmce7WcQJzJvAYhT2BWCZAxEOwA
         Yo7mI9inbwlDNmP9JnOA3ws1/e4kU8JvzQBPxFHInuWdlaniMg3psyIVHotl1yV6lnnG
         yVNw==
X-Forwarded-Encrypted: i=1; AJvYcCXDyUmcg+A3/+TMl26aakjI+9yzcsth/jXtklBO5Dh2r/WSHDMHZcvVI5iyjZUS/z1XsdoclaY7qqrk@vger.kernel.org
X-Gm-Message-State: AOJu0YxttKhRQZNY5R8l9nr2YAynGYRQCOMyUvpLF29Uby0pUILUbd+z
	uAJ/gRgnifHWvMdC0vpnoDXvO0HIP4uDKT9xIwkyUzELu1NL0IIKJxHsadDQ1MBq2VilN016zvm
	FvY1dWXQm+vEIy/Ota9J0KliSyktfyKc=
X-Gm-Gg: AZuq6aKYSr/BkROwZp5LE9hUKjI+3EcwLbs93t7uhYVP4IxXUaDFAvLyyKRxg4NTOer
	lF/p2fUHHqiSJAxigWUmDYFCjeOG7ilgZPv0ovn/KUOlXDE8vMQHk1eu1EazWvWoouGD67/xLvA
	43kbWv4yZhsGrseIKDqlB7PC6D7HLNLZwxGGfGrvJPCdvHTymWRbJ4hf+b8bII2D5OI3Bt4BbJ7
	iJc5313Frc2KipbHnCwwCZdOGoY7ogPNbDsGctWmvEcvJe0CwwR8vJFDtgkTzUuqQYxldiNGQ6f
	z0M/SISvUNR1qa5IM1RAJ5YwrFc=
X-Received: by 2002:a17:906:9f8a:b0:b87:1ffc:bfc0 with SMTP id
 a640c23a62f3a-b8dff430c2bmr675859166b.20.1770028651996; Mon, 02 Feb 2026
 02:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119184708.566461-1-iansdannapel@gmail.com>
 <20251119184708.566461-4-iansdannapel@gmail.com> <aTv1s6ui1/JmBis0@yilunxu-OptiPlex-7050>
In-Reply-To: <aTv1s6ui1/JmBis0@yilunxu-OptiPlex-7050>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Mon, 2 Feb 2026 11:37:21 +0100
X-Gm-Features: AZwV_QhfHFH2QK9_GDCT9HKbl2SXGCpE-BCgTCvibfpml-PbjYBSjsiIIVJPNws
Message-ID: <CAKrir7jj7h+gO0GPtPbdb4oT5jUmATW1CFwU6YHeuvx4VS1gBA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] fpga-mgr: Add Efinix SPI programming driver
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-fpga@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com, 
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	heiko@sntech.de, neil.armstrong@linaro.org, mani@kernel.org, 
	kever.yang@rock-chips.com, dev@kael-k.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Yilun,
thank you very much for your review

On Fri, Dec 12, 2025 at 12:16=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com=
> wrote:

> >
> > +config FPGA_MGR_EFINIX_SPI
> > +     tristate "Efinix FPGA configuration over SPI"
> > +     depends on SPI
> > +     help
> > +       FPGA manager driver support for Efinix FPGAs configuration over=
 SPI
> > +       (passive mode only).
> > +
>
> Any reason insert it here? If no add it at tail.
No reason at all, will move to the back.
>

> >  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)      +=3D xilinx-selectmap.o
> >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)    +=3D xilinx-spi.o
> > +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)    +=3D efinix-spi.o
>
> Ditto, maybe add it at tail of "FPGA Manager Drivers"?
of course
> > +#include <linux/spi/spi.h>
> > +
> > +/* 13 dummy bytes =E2=86=92 104 SPI clock cycles (8 bits each)
>
> Wrong format for multi-line comments, please see:
>
>   Documentation/process/coding-style.rst
okay, will fix all comments styling
>
> > + * Used to meet the requirement for >100 clock cycles idle sequence.
> > + */
> > +#define EFINIX_SPI_IDLE_CYCLES_BYTES 13
> > +
> > +/* tDMIN: Minimum time between deassertion of CRESET_N to first
>
> ditto, please go through the entire patch for this.
>
> > + * valid configuration data. (32 =C2=B5s)
> > + */
> > +#define EFINIX_TDMIN_US_MIN    35
> > +#define EFINIX_TDMIN_US_MAX    40
> > +
> > +/* tCRESET_N: Minimum CRESET_N low pulse width required to
> > + * trigger re-configuration. (320 ns)
> > + */
> > +#define EFINIX_TCRESETN_DELAY_MIN_US  1
> > +#define EFINIX_TCRESETN_DELAY_MAX_US  2
> > +
> > +/* tUSER: Minimum configuration duration after CDONE goes high
> > + * before entering user mode. (25 =C2=B5s)
> > + */
> > +#define EFINIX_TUSER_US_MIN    30
> > +#define EFINIX_TUSER_US_MAX    35
> > +
> > +struct efinix_spi_conf {
> > +     struct spi_device *spi;
> > +     struct gpio_desc *cdone;
> > +     struct gpio_desc *reset;
> > +     bool bus_locked;
> > +};
> > +
> > +static void efinix_spi_reset(struct efinix_spi_conf *conf)
> > +{
> > +     gpiod_set_value(conf->reset, 1);
> > +     usleep_range(EFINIX_TCRESETN_DELAY_MIN_US, EFINIX_TCRESETN_DELAY_=
MAX_US);
> > +     gpiod_set_value(conf->reset, 0);
> > +     usleep_range(EFINIX_TDMIN_US_MIN, EFINIX_TDMIN_US_MAX);
> > +}
> > +
> > +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> > +{
> > +     struct efinix_spi_conf *conf =3D mgr->priv;
> > +
> > +     if (conf->cdone && gpiod_get_value(conf->cdone) =3D=3D 1)
> > +             return FPGA_MGR_STATE_OPERATING;
> > +
> > +     return FPGA_MGR_STATE_UNKNOWN;
> > +}
> > +
> > +static int efinix_spi_write_init(struct fpga_manager *mgr,
> > +                              struct fpga_image_info *info,
> > +                              const char *buf, size_t count)
> > +{
> > +     struct efinix_spi_conf *conf =3D mgr->priv;
> > +     struct spi_transfer assert_cs =3D {
> > +             .cs_change =3D 1,
>
> You've addressed an important concern, please briefly describe in this
> function & changelog: what's the HW requirement, how to solve it by
> cs_change & spi_bus_lock().
OK. changelog means description in the commit message?
>
> > +     };
> > +     struct spi_message message;
> > +     int ret;
> > +
> > +     if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > +             dev_err(&mgr->dev, "Partial reconfiguration not supported=
\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     spi_bus_lock(conf->spi->controller);
> > +     conf->bus_locked =3D true;
> > +     spi_message_init_with_transfers(&message, &assert_cs, 1);
> > +     ret =3D spi_sync_locked(conf->spi, &message);
> > +     if (ret) {
> > +             spi_bus_unlock(conf->spi->controller);
> > +             conf->bus_locked =3D false;
> > +             return ret;
> > +     }
> > +
> > +     /* Reset with CS asserted */
> > +     efinix_spi_reset(conf);
> > +
> > +     return 0;
> > +}
> > +
> > +static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
> > +                         size_t count)
> > +{
> > +     struct spi_transfer write_xfer =3D {
> > +             .tx_buf =3D buf,
> > +             .len =3D count,
> > +             .cs_change =3D 1, /* Keep CS asserted */
> > +     };
> > +     struct efinix_spi_conf *conf =3D mgr->priv;
> > +     struct spi_message message;
> > +     int ret;
> > +
> > +     spi_message_init_with_transfers(&message, &write_xfer, 1);
> > +     ret =3D spi_sync_locked(conf->spi, &message);
> > +     if (ret) {
> > +             dev_err(&mgr->dev, "SPI error in firmware write: %d\n", r=
et);
> > +             if (conf->bus_locked) {
>
> Do we really need this flag? If we failed to lock bus on write_init(),
> we can't get here, is it?
Its actually not needed, it's just extra protection in case the API is
misused, eg write_complete() is executed even if write() failed.
But since this is not the case, I will remove it.
>
> > +                     spi_bus_unlock(conf->spi->controller);
> > +                     conf->bus_locked =3D false;
> > +             }
> > +     }
> > +     return ret;
> > +}
> > +
> > +static int efinix_spi_write_complete(struct fpga_manager *mgr,
> > +                                  struct fpga_image_info *info)
> > +{
> > +     unsigned long timeout =3D
> > +             jiffies + usecs_to_jiffies(info->config_complete_timeout_=
us);
> > +     struct spi_transfer clk_cycles =3D {
> > +             .len =3D EFINIX_SPI_IDLE_CYCLES_BYTES,
>
> Here we also release the cs, is it? Please add comments here.
Exactly, I think I should also add .cs_change state to explicitly release i=
t.
>
> > +     };
> > +     struct efinix_spi_conf *conf =3D mgr->priv;
> > +     struct spi_message message;
> > +     int ret =3D -1, done =3D 0;
>
> Why initialize these 2 variables, IIUC they are all re-assigned before
> any usage.
will fix
>
> > +     bool expired =3D false;
> > +     u8 *dummy_buf;
> > +
> > +     dummy_buf =3D kzalloc(EFINIX_SPI_IDLE_CYCLES_BYTES, GFP_KERNEL);
> > +     if (!dummy_buf) {
> > +             ret =3D -ENOMEM;
> > +             goto unlock_spi;
> > +     }
> > +
> > +     clk_cycles.tx_buf =3D dummy_buf;
> > +     spi_message_init_with_transfers(&message, &clk_cycles, 1);
> > +     ret =3D spi_sync_locked(conf->spi, &message);
> > +     if (ret) {
> > +             dev_err(&mgr->dev, "SPI error in write complete: %d\n", r=
et);
> > +             goto free_buf;
> > +     }
> > +
> > +     if (conf->cdone) {
> > +             while (!expired) {
> > +                     done =3D gpiod_get_value(conf->cdone);
> > +                     if (done < 0) {
> > +                             ret =3D done;
> > +                             goto free_buf;
> > +                     }
> > +                     if (done)
> > +                             break;
> > +
> > +                     usleep_range(10, 20);
> > +                     expired =3D time_after(jiffies, timeout);
> > +             }
> > +
> > +             if (expired) {
> > +                     dev_err(&mgr->dev, "Timeout waiting for CDONE\n")=
;
> > +                     ret =3D -ETIMEDOUT;
> > +                     goto free_buf;
> > +             }
> > +     }
> > +
> > +     usleep_range(EFINIX_TUSER_US_MIN, EFINIX_TUSER_US_MAX);
> > +
> > +free_buf:
> > +     kfree(dummy_buf);
> > +unlock_spi:
> > +     if (conf->bus_locked) {
> > +             spi_bus_unlock(conf->spi->controller);
> > +             conf->bus_locked =3D false;
> > +     }
> > +     return ret;
> > +}
> > +
> > +static const struct fpga_manager_ops efinix_spi_ops =3D {
> > +     .state =3D efinix_spi_state,
> > +     .write_init =3D efinix_spi_write_init,
> > +     .write =3D efinix_spi_write,
> > +     .write_complete =3D efinix_spi_write_complete,
> > +};
> > +
> > +static int efinix_spi_probe(struct spi_device *spi)
> > +{
> > +     struct efinix_spi_conf *conf;
> > +     struct fpga_manager *mgr;
> > +
> > +     conf =3D devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> > +     if (!conf)
> > +             return -ENOMEM;
> > +
> > +     conf->spi =3D spi;
> > +
> > +     conf->reset =3D devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH=
);
> > +     if (IS_ERR(conf->reset))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(conf->reset),
> > +                                  "Failed to get RESET gpio\n");
> > +
> > +     if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
> > +             return dev_err_probe(&spi->dev, -EINVAL,
> > +                                  "Unsupported SPI mode, set CPHA and =
CPOL\n");
> > +
> > +     conf->cdone =3D devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD=
_IN);
> > +     if (IS_ERR(conf->cdone))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
> > +                                  "Failed to get CDONE gpio\n");
> > +
> > +     mgr =3D devm_fpga_mgr_register(&spi->dev,
> > +                                  "Efinix FPGA Manager",
> > +                                  &efinix_spi_ops, conf);
>
> The initialization sequence is quite random...
>
> 1. if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
> 2. conf =3D devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> 3. conf->reset =3D devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
> 4. conf->cdone =3D devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
> 5. Initialize other fields in conf.
> 6. mgr =3D devm_fpga_mgr_register()
> 7. return PTR_ERR_OR_ZERO(mgr);
>
> Is it better?

I agree, I will reorder the initialization!

Regards,
Ian
