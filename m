Return-Path: <SRS0=wxY1=AX=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=wxY1=AX=intel.com=hao.wu@kernel.org>
Date: Fri, 22 Sep 2017 10:15:01 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v2 03/22] fpga: bridge: remove OF dependency for
 fpga-bridge
Message-ID: <20170922021501.GA15082@hao-dev>
References: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
 <1498441938-14046-4-git-send-email-hao.wu@intel.com>
 <20170921191109.GA7814@tyrael.ni.corp.natinst.com>
 <CANk1AXRbXybjwq-ha=G6Z7nXwd8fNjPWP5awTz6=23KVXbd=kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRbXybjwq-ha=G6Z7nXwd8fNjPWP5awTz6=23KVXbd=kQ@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Sep 21, 2017 at 02:50:07PM -0500, Alan Tull wrote:
> On Thu, Sep 21, 2017 at 2:11 PM, Moritz Fischer <mdf@kernel.org> wrote:
> 
> Hi Moritz,
> 
> > Hi,
> >
> > On Mon, Jun 26, 2017 at 09:51:59AM +0800, Wu Hao wrote:
> >> This patch removes OF dependency of fpga-bridge, it allows drivers
> >> to use fpga-bridge class without device tree support.
> >>
> >> Signed-off-by: Wu Hao <hao.wu@intel.com>
> >> ---
> >>  drivers/fpga/Kconfig | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> >> index ed600d5..c1d8f41 100644
> >> --- a/drivers/fpga/Kconfig
> >> +++ b/drivers/fpga/Kconfig
> >> @@ -75,7 +75,6 @@ config FPGA_MGR_ZYNQ_FPGA
> >>
> >>  config FPGA_BRIDGE
> >>       tristate "FPGA Bridge Framework"
> >> -     depends on OF
> >
> > Shouldn't that dependency be removed in the patch that removes the
> > dependency, or was the dependency never there in the first place?
> 
> It wasn't dependent on OF in the first place.

Hi Alan / Moritz

I see this change has been integrated into below patch from Alan.

[PATCH v4 15/18] fpga: region: move device tree support to of-fpga-region.c

so I think I can drop this patch in my next version patch set. : )

Thanks
Hao

> 
> Thanks,
> Alan
> 
> >
> >>       help
> >>         Say Y here if you want to support bridges connected between host
> >>         processors and FPGAs or between FPGAs.
> >> --
> >> 1.8.3.1
> >>
> >
> > Thanks,
> >
> > Moritz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
