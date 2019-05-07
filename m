Return-Path: <SRS0=dz0a=TH=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=dz0a=TH=ettus.com=moritz.fischer@kernel.org>
Date: Tue, 7 May 2019 12:31:54 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: zynqmp-fpga: Correctly handle error pointer
Message-ID: <20190507193154.GB30078@archbox>
References: <20190507170257.25451-1-mdf@kernel.org>
 <CANk1AXS2m+v2uMoE0gLhKqYhn_NcbV8gZq+ogMsC_Zp81ZHAow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXS2m+v2uMoE0gLhKqYhn_NcbV8gZq+ogMsC_Zp81ZHAow@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-ID: <linux-fpga@vger.kernel.org>

Alan,

On Tue, May 07, 2019 at 02:11:06PM -0500, Alan Tull wrote:
> On Tue, May 7, 2019 at 12:03 PM Moritz Fischer <mdf@kernel.org> wrote:
> 
> Hi Moritz,
> 
> >
> > Fixes the following static checker error:
> >
> > drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
> > error: 'eemi_ops' dereferencing possible ERR_PTR()
> >
> > Note: This does not handle the EPROBE_DEFER value in a
> >       special manner.
> >
> > Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
> > Xilinx zynqmp")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/zynqmp-fpga.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > index f7cbaadf49ab..abcb0b2e75bf 100644
> > --- a/drivers/fpga/zynqmp-fpga.c
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> >         char *kbuf;
> >         int ret;
> >
> > -       if (!eemi_ops || !eemi_ops->fpga_load)
> > +       if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
> 
> This if statement also happens in fpga_mgr_states
> zynqmp_fpga_ops_state(), so we'll need this fix there also.

Good catch, will fix in v2.

Thanks
Moritz
