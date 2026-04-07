Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C73A3E63
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550066; cv=pass; b=bQ8Y0eVbOIlts/Iz6zv6FIc7qcOE0/04YkFoPIJ2ha/tfB0zZS4itfu0dNMD8a4X5s9KbVuG+Nto95U/E5rVla2MA/CoR0hhaoHVi2SP96FenLVDo24liXnloMYS01toL7toIeghBvlNQfslqhE60Swjc3HT+fIEfrMGM4P41h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550066; c=relaxed/simple;
	bh=Qg1cBh282b3adVb2ppjf9AqleTOEcC98vfshrCTnT7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+dS84LcsvX2drjOQDxgzEPrqzFw1qx870nzOk0gv/pRPLjI/Udv9RSelfv/8UKajlbu3VsRDWvN5iM1bnqP2+U48k1ZvoZAgsLGsQEY4XzfrPWXLr1wLV1ioJhp31zC6EoL+1QyNfiGZYLbm6VFXrAEJYJLn8Ni99HbSv6bLJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhfzWEfN; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhfzWEfN"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89f87257904so42870876d6.1
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 01:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775550063; cv=none;
        d=google.com; s=arc-20240605;
        b=PG3pXIdtsJ9p/doDNSobCpLyPCCKhI4TKLnXvjxwRyS/FQhmCG8vLFBxLMZ4wIZZpA
         EmlrzzxsOjFfCX2q4RpSJ4IAbVZ2pKjH56fA03m2o78zksv+1bZn4QAs47s/Wkh2QbTS
         AJgg/qeJ7lgK/qSYrGBVN9aoVlW24lhfc4m4lNmwRLv7iyh4983rFT23LirTmqxKxgqB
         BqRrik2Vx1yXeNH1zMyXDS0MUHj0siJ3cI6j2eQPaHyCuJMLrOWS5tqAjX8Uut9oYkwT
         1OUJzQ/b7xox2ievpu9xnoRHf0tDSQ9XaVrTEMYlZ8pvPVgvD7DV/8IAN0hICdahGKF9
         i3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2/PLRkpetLF6qpK6ewdWqtNt7+OhKgQIPHRbLKcPeEY=;
        fh=7+Lgn3T5IzfxYCRSklQAj5yhb2W2dHZG+EwsGyL/oTg=;
        b=K9WlJvsBEVbjQIBaTyTrvY11a8dbSjwvfZ8ifcR2oR90el1vq3a+tBe6w+8LD/ohsR
         aiDZEEUUNlrFnaKys1jhWsmlLL25JKrt1ETuXw6RCbaAgX0rur4fsIPqTCwe2lmIiIEJ
         0EiNT0+hfHmL/jbwMaqHGyF+paNUzQo5ssSFMac8uL3ohRWK1GASu4fGko3bkXlsh0/w
         91HsxaUcJHf/0xs9LmRKLrfnw5Og2Be8cWjZTiAMUMC7Uz522NsdBI7zT+NKQWGIfuGN
         c8ck99z0nXdewnky+/iaNZ9R1L0PkB86ohmxUQZWE6oDqCdyYv4+DFhT0VMjhMYKOZfd
         bDMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550063; x=1776154863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/PLRkpetLF6qpK6ewdWqtNt7+OhKgQIPHRbLKcPeEY=;
        b=XhfzWEfNNlqaz4UUUZpR/e+7lsUNjcU5jSueh2ShYmzWNcs8l28I5f20qSZrO6ukfc
         Pgjfz5/bkgO2qljXfgCSUmuCsAUT/ZjtKAKLr6UXbGDs22p6MY34JvN4pR/zKrdxH/0m
         lcscGftcZTE8gSLZ+dZVQe+3S9nk28QI7IxAg2s6YQHPPSJl7Pm6YiJ+AFm/QTNRUqqy
         ONgshKVcOb0UWzO08ah+iD0Certh21y+fc9wk3mhpgBo0u62WlDuuFtxzGUd8PmvWczn
         QpN3glH9oX9L/r514KE88VFdTxbF88j5ZTPXT/AhOE4ynr3lHMfqx+eWBvesnwz7ijyK
         5BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550063; x=1776154863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/PLRkpetLF6qpK6ewdWqtNt7+OhKgQIPHRbLKcPeEY=;
        b=ZHg5CKoltp9Q+Wd7xPbK+FgM3A6lFgu5IgS3UYdLSEf0YizDP2UiS19NpQqHddnUh+
         oboNd/GsCrKGMSmT9fdfrOJRcADaPJ0dygDbtt6CtiE6ZMURtMDcE88czhgQHNQTfii3
         U+zti96QmagfyVpgXq3ZgyeUGVGrAQcI029K1v7jPcg8erMcf73R8miAwaNr4lyQjP0k
         WzULi8THsy2yMHYa5RuuZCgI8DcyHma2pNP3pW1IJljU8qLeF2r8eKT9qKBIqaqsRSI4
         Q66mJrYW1ljQOrelvmMbv1tfnX2KHvJ2CuOWkJoCoQ952lf2rZ4MNAjNXN1G7jwnP1e/
         AY4Q==
X-Gm-Message-State: AOJu0YygA1PwayefOZMAMht58u4DEY5ZlTzJwQr8lrdvNjVt9/n4s5sv
	8AIG9lgqUPKiVUZEb8E50HWJ9kUUYCO88k+EoQJFnIn053AP9DgdbShp8oes+ItcU2kBfPe9her
	4ikp8Hu0urU3Dn67tlmIB7oiD5NRt+2OA85c6XLo=
X-Gm-Gg: AeBDieu/1Pw3bGkVQuk3VzGYzXQMhH5e7avWoFtldDf3KHZE9t153r4U4SSpTtH2RXL
	7Z8i2YRrcta1JnVLZqpmXVUnuAFlh6PVCFynOc/ENX9bed7kPZ5yl37G3hgzH9Oltj64XcEWNAZ
	QPbgMkQhXQsWRXz0fTe2QNwPMZCYzghXMu1dkwa5jdz/d50jNnIVhA0uDCHsB45oeNEK7CWK/ia
	QUURQ6igC83eZgOsf1RZcrxbcNECs7QZbzhnssHf0YAVcIg80rmmTB6QuTs6X3xFq6kQUwZc5Rq
	bf4eHw8ZSwI4GuBK91tpRvw9BC/R8/XGNJYEVa0=
X-Received: by 2002:a05:6214:2247:b0:899:ecd8:d266 with SMTP id
 6a1803df08f44-8a7028a94b4mr273928136d6.20.1775550063531; Tue, 07 Apr 2026
 01:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327114842.1300284-1-iansdannapel@gmail.com>
 <20260327114842.1300284-4-iansdannapel@gmail.com> <adSgQJa/8ZPlzPbO@yilunxu-OptiPlex-7050>
In-Reply-To: <adSgQJa/8ZPlzPbO@yilunxu-OptiPlex-7050>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Tue, 7 Apr 2026 10:20:51 +0200
X-Gm-Features: AQROBzCvZFmOBhNN1Ozi1tHPyAdgkPxiQnmrsvUxmnFBvR5Z3_2-fIjOS2_VhLw
Message-ID: <CAKrir7jWnoG4TXHOH5r658GaXL4fBcEP4BUMqHnFu4_ZVJ-o_Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fpga-mgr: Add Efinix SPI programming driver
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com, 
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	neil.armstrong@linaro.org, heiko@sntech.de, marex@nabladev.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, dev@kael-k.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
thanks for the quick review.

On Tue, Apr 7, 2026 at 8:33=E2=80=AFAM Xu Yilun <yilun.xu@linux.intel.com> =
wrote:
>
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index aeb89bb13517..21eb0ef1fc2e 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -24,6 +24,7 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)  +=3D versal-fpga.=
o
> >  obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI) +=3D microchip-spi.o
> >  obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG)     +=3D lattice-sysconfig.o
> >  obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI) +=3D lattice-sysconfig-sp=
i.o
> > +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)    +=3D efinix-spi.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE)              +=3D altera-pr-ip-core.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT) +=3D altera-pr-ip-core-plat.o
>
> This is the tail of "FPGA Manager Drivers", move it here.
All right
>
> ...
>
> > +static int efinix_spi_write_init(struct fpga_manager *mgr,
> > +                              struct fpga_image_info *info,
> > +                              const char *buf, size_t count)
> > +{
> > +     struct device *dev =3D &mgr->dev;
>
> Why do you make this change? This is just one-time usage, and in some
> other functions you don't make the same change. Please delete it.
Will revert it
>
> > +     struct efinix_spi_conf *conf =3D mgr->priv;
> > +     struct spi_transfer assert_cs =3D {
> > +             .cs_change =3D 1,
> > +     };
> > +     struct spi_message message;
> > +     int ret;
> > +
> > +     if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > +             dev_err(dev, "Partial reconfiguration not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     /*
> > +      * Efinix passive SPI configuration requires chip select to stay
> > +      * asserted from reset until the bitstream is fully clocked in.
> > +      * Lock the SPI bus so no other device can toggle CS between the
> > +      * reset pulse and the write/complete transfers.
> > +      */
> > +     spi_bus_lock(conf->spi->controller);
> > +     spi_message_init_with_transfers(&message, &assert_cs, 1);
> > +     ret =3D spi_sync_locked(conf->spi, &message);
> > +     if (ret) {
> > +             spi_bus_unlock(conf->spi->controller);
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
> > +     struct device *dev =3D &mgr->dev;
>
> ditto.
>
> > +     struct spi_transfer write_xfer =3D {
> > +             .tx_buf =3D buf,
> > +             .len =3D count,
> > +             .cs_change =3D 1, /* Keep CS asserted */
>
> Move this comment to its first appearance.
>
> ...
>
> > +static const struct of_device_id efinix_spi_of_match[] =3D {
> > +     { .compatible =3D "efinix,trion-config", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, efinix_spi_of_match);
> > +
> > +static const struct spi_device_id efinix_ids[] =3D {
> > +     { "trion-config", 0 },
> > +     { "titanium-config", 0 },
> > +     { "topaz-config", 0 },
>
> Since you've trimmed of_match_table, any reason to keep 3
> spi_device_ids? IIUC you could keep them in sync.
I don't see any reason to have other IDs, will drop them.

I would also rename the file from efinix-spi.c to efinix-config.c to
match the dt bindings
