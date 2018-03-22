Return-Path: <SRS0=45aN=GM=perches.com=joe@kernel.org>
Return-Path: <SRS0=45aN=GM=perches.com=joe@kernel.org>
Message-ID: <1521754493.7999.49.camel@perches.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
From: Joe Perches <joe@perches.com>
Date: Thu, 22 Mar 2018 14:34:53 -0700
In-Reply-To: <CANk1AXT6TY5N+gR=tBNuvhQMnOpuaWKWVoUSjB+Vfof2=GAM6w@mail.gmail.com>
References: <1521653726-24625-1-git-send-email-p.pisati@gmail.com>
	 <1521653726-24625-3-git-send-email-p.pisati@gmail.com>
	 <1521655492.7999.13.camel@perches.com>
	 <CANk1AXT6TY5N+gR=tBNuvhQMnOpuaWKWVoUSjB+Vfof2=GAM6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS  <devicetree@vger.kernel.org>, linux-kernel" <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, 2018-03-22 at 16:32 -0500, Alan Tull wrote:
> On Wed, Mar 21, 2018 at 1:04 PM, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2018-03-21 at 18:35 +0100, Paolo Pisati wrote:
> > > This patch adds support to the FPGA manager for programming
> > > MachXO2 device’s internal flash memory, via slave SPI.
> > 
> > style trivia:
> > 
> > > diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> > 
> > []
> > > +static int get_status(struct spi_device *spi, unsigned long *status)
> > > +{
> > > +     struct spi_message msg;
> > > +     struct spi_transfer rx, tx;
> > > +     u8 cmd[] = LSC_READ_STATUS;
> > 
> > static const u8 cmd[]
> > here and everywhere else as all the tx_buf assignments
> > of cmd are to const void *
> 
> Why *static* const u8 cmd[]?

So various compilers don't reload it on each call.
