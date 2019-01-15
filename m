Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20190114223312.3254-1-atull@kernel.org> <0574de1a-a238-7ad3-1bc2-24d27ff50cba@kernel.org>
In-Reply-To: <0574de1a-a238-7ad3-1bc2-24d27ff50cba@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Tue, 15 Jan 2019 12:06:36 -0600
Message-ID: <CANk1AXQQUVUBfSHCEQbiVEe4ud=K6s75CTmAoBfamkj1oiQ=NQ@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: altera_freeze_bridge: remove restriction to socfpga
Content-Type: text/plain; charset="UTF-8"
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jan 15, 2019 at 11:47 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> minor nit
>
> On 1/14/19 4:33 PM, Alan Tull wrote:
> > The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> > since it can be used on other platforms such as Stratix10.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> > ---
> >  drivers/fpga/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 0bb7b5c..da5786a 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -104,7 +104,8 @@ config SOCFPGA_FPGA_BRIDGE
> >
> >  config ALTERA_FREEZE_BRIDGE
> >       tristate "Altera FPGA Freeze Bridge"
> > -     depends on ARCH_SOCFPGA && FPGA_BRIDGE
> > +     depends on FPGA_BRIDGE
> > +     depends on HAS_IOMEM
>
> can just be:
>
> depends on FPGA_BRIDGE && HAS_IOMEM

I agree.

>
> Dinh
