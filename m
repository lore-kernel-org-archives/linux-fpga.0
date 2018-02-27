Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKfKVtGPhb6Mg4UcX58iknEHAvRhp7NzisEONz8Cj+k9OYcu7A@mail.gmail.com>
References: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <1519188826-2047-2-git-send-email-shubhrajyoti.datta@gmail.com>
 <CANk1AXQ1R4dbgDJrUC4pgKtmoCaJhryTnD=bxwwWbEJn0BQcaA@mail.gmail.com>
 <20180227002832.GA24387@tyrael.ni.corp.natinst.com> <CAKfKVtGPhb6Mg4UcX58iknEHAvRhp7NzisEONz8Cj+k9OYcu7A@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 27 Feb 2018 11:00:56 -0600
Message-ID: <CANk1AXR6aSwyQTW=NeYrRUQo2Oe8BysyOzf6VHvBuXaxKwNp-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: reset bridge: Add the reset bridge
Content-Type: text/plain; charset="UTF-8"
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, nofooter@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Feb 26, 2018 at 10:46 PM, Shubhrajyoti Datta
<shubhrajyoti.datta@gmail.com> wrote:
> Hi  Moritz,
>
> On Tue, Feb 27, 2018 at 5:58 AM, Moritz Fischer <mdf@kernel.org> wrote:
>> Hi Shubhrajyoti, Alan
>>
>> On Mon, Feb 26, 2018 at 04:53:59PM -0600, Alan Tull wrote:
>>> On Tue, Feb 20, 2018 at 10:53 PM,  <shubhrajyoti.datta@gmail.com> wrote:
>>> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>> >
>>> > Adds the reset bridge. After the bitstream load the reset
>>> > bridge helps in reseting the programable logic. The
>>> > reset lines depends on the design.
>>>
>>> Hi Shubhrajyoti,
>>>
>>> OK so adding this 'bridge' will get a reset line to be toggled after
>>> programming is done.  It looks like it might be generally usable.
>>> This doesn't look very xilinx specific (i.e. no specific device
>>> registers, just using a reset), so maybe it is just a 'rst-brige'.
>>> How is it used?  To hit a reset line on a whole FPGA?
>>
>> In zynq-fpga we have the fpga-mgr hit on the reset, which to some
>> extend I suppose makes sense, since after reload you wanna reset the
>> entire FPGA space (unless you do PR, where you don't hit on the resets).
>>
>> Shubhrajyoti's solution seems more modular I guess, however I don't
>> really see a good usecase for only hitting a single reset.
>>
>> IP that's in the FPGA and needs reset should have their dedicated resets
>> via normal reset API bindings imho and not rely on bridges to do the
>> right thing.
>>
>> The ZynqMP is fairly complex and I might be missing something here,
>> so maybe you (Shubhrajyoti) can elaborate a bit more. The paragraph in
>> the TRM seemed fairly short, and didn't enlighten me as to why it is
>> required.
>
> The FPGA supports both the PR case and independent execution
> Like  a design can have 2 parts that can have independent execution.

I want to understand you better here.  What do you mean by
'independent execution'?  Like 2 partial reconfiguration regions that
each have a single reset to reset the hardware in their region?  Or
something else?

> In that case they have to have independent resets.
>
> There are 4 PS-PL lines that could be used by designs.
> So in that case we should have  multiple resets.

Normally, as Moritz is saying, the reset would be handled by the
driver for the fabric-based hardware.

Alan

>
>
>>
>> Cheers,
>>
>> Moritz
>>>
>>> Alan
>>>
>>> >
>>> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>> > ---
>>> >  drivers/fpga/Kconfig             |   8 ++++
>>> >  drivers/fpga/Makefile            |   1 +
>>> >  drivers/fpga/xilinx-rst-bridge.c | 100 +++++++++++++++++++++++++++++++++++++++
>>> >  3 files changed, 109 insertions(+)
>>> >  create mode 100644 drivers/fpga/xilinx-rst-bridge.c
>>> >
>>> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>>> > index ad5448f..752a907 100644
>>> > --- a/drivers/fpga/Kconfig
>>> > +++ b/drivers/fpga/Kconfig
>>> > @@ -117,4 +117,12 @@ config XILINX_PR_DECOUPLER
>>> >           region of the FPGA from the busses while that region is
>>> >           being reprogrammed during partial reconfig.
>>> >
>>> > +config XILINX_RST_BRIDGE
>>> > +       tristate "Xilinx Reset bridge"
>>> > +       depends on FPGA_BRIDGE
>>> > +       help
>>> > +         Say Y to enable drivers for Xilinx Reset bridge.
>>> > +         After writing the bitstream there has to be a reset.
>>> > +         The reset lines are design specific.
>>> > +
>>> >  endif # FPGA
>>> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>>> > index f98dcf1..c1b0d13 100644
>>> > --- a/drivers/fpga/Makefile
>>> > +++ b/drivers/fpga/Makefile
>>> > @@ -23,6 +23,7 @@ obj-$(CONFIG_FPGA_BRIDGE)             += fpga-bridge.o
>>> >  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)      += altera-hps2fpga.o altera-fpga2sdram.o
>>> >  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)     += altera-freeze-bridge.o
>>> >  obj-$(CONFIG_XILINX_PR_DECOUPLER)      += xilinx-pr-decoupler.o
>>> > +obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)     += xilinx-rst-bridge.o
>>> >
>>> >  # High Level Interfaces
>>> >  obj-$(CONFIG_FPGA_REGION)              += fpga-region.o
>>> > diff --git a/drivers/fpga/xilinx-rst-bridge.c b/drivers/fpga/xilinx-rst-bridge.c
>>> > new file mode 100644
>>> > index 0000000..8062283
>>> > --- /dev/null
>>> > +++ b/drivers/fpga/xilinx-rst-bridge.c
>>> > @@ -0,0 +1,100 @@
>>> > +// SPDX-License-Identifier: GPL-2.0
>>> > +/*
>>> > + * Xilinx FPGA reset bridge.
>>> > + * Copyright (c) 2018 Xilinx Inc.
>>> > + *
>>> > + */
>>> > +
>>> > +#include <linux/kernel.h>
>>> > +#include <linux/module.h>
>>> > +#include <linux/of_device.h>
>>> > +#include <linux/fpga/fpga-bridge.h>
>>> > +#include <linux/reset.h>
>>> > +
>>> > +struct xlnx_rst_bridge_priv {
>>> > +       struct device *dev;
>>> > +       bool enable;
>>> > +};
>>> > +
>>> > +static int xlnx_rst_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
>>> > +{
>>> > +       struct xlnx_rst_bridge_priv *priv = bridge->priv;
>>> > +       struct device *dev = priv->dev;
>>> > +       struct reset_control *rstc;
>>> > +       int ret = 0;
>>> > +
>>> > +       if (enable) {
>>> > +               rstc = of_reset_control_array_get(dev->of_node, false, false);
>>> > +               if (IS_ERR(rstc))
>>> > +                       return PTR_ERR(rstc);
>>> > +
>>> > +               ret = reset_control_reset(rstc);
>>> > +
>>> > +               reset_control_put(rstc);
>>> > +
>>> > +               if (ret)
>>> > +                       dev_err(dev, "Reset failed\n");
>>> > +       } else {
>>> > +               dev_dbg(dev, "Bridge disabled\n");
>>> > +       }
>>> > +
>>> > +       if (!ret)
>>> > +               priv->enable = enable;
>>> > +
>>> > +       return ret;
>>> > +}
>>> > +
>>> > +static int xlnx_rst_bridge_enable_show(struct fpga_bridge *bridge)
>>> > +{
>>> > +       struct xlnx_rst_bridge_priv *priv = bridge->priv;
>>> > +
>>> > +       return priv->enable;
>>> > +}
>>> > +
>>> > +static struct fpga_bridge_ops xlnx_rst_bridge_ops = {
>>> > +       .enable_set = xlnx_rst_bridge_enable_set,
>>> > +       .enable_show = xlnx_rst_bridge_enable_show,
>>> > +};
>>> > +
>>> > +static int xlnx_rst_bridge_probe(struct platform_device *pdev)
>>> > +{
>>> > +       struct xlnx_rst_bridge_priv *priv;
>>> > +       struct device *dev = &pdev->dev;
>>> > +
>>> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> > +       if (!priv)
>>> > +               return -ENOMEM;
>>> > +
>>> > +       priv->dev = dev;
>>> > +
>>> > +       return fpga_bridge_register(dev, "xlnx_rst_bridge",
>>> > +                                   &xlnx_rst_bridge_ops, priv);
>>> > +}
>>> > +
>>> > +static int xlnx_rst_bridge_remove(struct platform_device *pdev)
>>> > +{
>>> > +       fpga_bridge_unregister(&pdev->dev);
>>> > +
>>> > +       return 0;
>>> > +}
>>> > +
>>> > +static const struct of_device_id xlnx_rst_bridge_of_match[] = {
>>> > +       { .compatible = "xlnx,rst-bridge", },
>>> > +       {},
>>> > +};
>>> > +MODULE_DEVICE_TABLE(of, xlnx_rst_bridge_of_match);
>>> > +
>>> > +static struct platform_driver xlnx_rst_bridge_driver = {
>>> > +       .probe = xlnx_rst_bridge_probe,
>>> > +       .remove = xlnx_rst_bridge_remove,
>>> > +       .driver = {
>>> > +               .name   = "xlnx_rst_bridge",
>>> > +               .of_match_table = of_match_ptr(xlnx_rst_bridge_of_match),
>>> > +       },
>>> > +};
>>> > +
>>> > +module_platform_driver(xlnx_rst_bridge_driver);
>>> > +
>>> > +MODULE_DESCRIPTION("Xilinx reset Bridge");
>>> > +MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>");
>>> > +MODULE_LICENSE("GPL v2");
>>> > --
>>> > 2.1.1
>>> >
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
