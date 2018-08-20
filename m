Return-Path: <SRS0=86sa=LD=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=86sa=LD=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 20 Aug 2018 10:54:25 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2] fpga: dfl: region: Restory symmetry in
 probe()/remove()
Message-ID: <20180820175425.zoxnbcz3ziutxaq5@derp-derp.local>
References: <20180820171818.7710-1-mdf@kernel.org>
 <CANk1AXSMSLGCcaRcZo4TWKEJW+YUQqbHWEuHpz_csF5J1m-Sew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSMSLGCcaRcZo4TWKEJW+YUQqbHWEuHpz_csF5J1m-Sew@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Mon, Aug 20, 2018 at 12:46:32PM -0500, Alan Tull wrote:
> On Mon, Aug 20, 2018 at 12:18 PM, Moritz Fischer <mdf@kernel.org> wrote:
> 
> Hi Moritz,
> 
> > Replace dev_get_drvdata() with platform_get_drvdata() to
> > match the platform_set_drvdata() in the probe function of
> > the platform driver.
> >
> > Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for FME")
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >
> > Changes from v1:
> > - Still compile after change ...
> >
> > ---
> >  drivers/fpga/dfl-fme-region.c | 2 +-
> 
> Thanks for catching this.  of-fpga-region.c does a similar thing and
> needs s/dev_set_drvdata/platform_set_drvdata/ in the probe.  Could you
> fix it here too?

Yeah, can do in a v3 series ... Will add your Suggested-by: ...

Cheers,

Moritz
