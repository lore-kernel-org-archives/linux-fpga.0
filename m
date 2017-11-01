Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171101013428.GA21728@tyrael.ni.corp.natinst.com>
References: <1509482535-4921-1-git-send-email-atull@kernel.org>
 <1509482535-4921-3-git-send-email-atull@kernel.org> <20171031205924.p37uv6mfsmackhbj@us-sjc-wireless-10-16-34-58.amer.corp.natinst.com>
 <CANk1AXSpp=t71FmwRyX+gqY2r27JLzPKSg0e6yfMe35OsAv3Hw@mail.gmail.com> <20171101013428.GA21728@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 31 Oct 2017 21:22:52 -0500
Message-ID: <CANk1AXTLNFE5mBrNv0kBaOXJt0bT0QEbHh0BOSOg-ZHkanbxpA@mail.gmail.com>
Subject: Re: [PATCH 2/3] fpga: manager: don't use drvdata in common fpga code
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Oct 31, 2017 at 8:34 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Tue, Oct 31, 2017 at 04:45:54PM -0500, Alan Tull wrote:
>> On Tue, Oct 31, 2017 at 3:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
>> > On Tue, Oct 31, 2017 at 08:42:14PM +0000, Alan Tull wrote:
>> >> Changes to the fpga manager code to not use drvdata in common
>> >> code.
>> >>
>> >> Change fpga_mgr_register to not set or use drvdata.
>> >>
>> >> Change the register/unregister function parameters to take the mgr
>> >> struct:
>> >> * int fpga_mgr_register(struct device *dev,
>> >>                         struct fpga_manager *mgr);
>> >> * void fpga_mgr_unregister(struct fpga_manager *mgr);
>> >>
>> >> Change the drivers that call fpga_mgr_register to alloc the struct
>> >> fpga_manager (using devm_kzalloc) and partly fill it, adding name,
>> >> ops, and priv.
>> >>
>> >> The rationale is that setting drvdata is fine for DT based devices
>> >> that will have one manager, bridge, or region per platform device.
>> >> However PCIe based devices may have multiple FPGA mgr/bridge/regions
>> >> under one pcie device.  Without these changes, the PCIe solution has
>> >> to create an extra device for each child mgr/bridge/region to hold
>> >> drvdata.
>> >
>> > This looks very common, in fact several subsystems provide this two step
>> > way of registering things.
>> >
>> > - Allocate fpga_mgr via fpga_mgr_alloc() where you pass in the size of
>> >   the private data
>> > - Fill in some fields
>> > - fpga_mgr_register() where you pass in the fpga_mgr as suggested
>> >
>> > See for example the alloc_etherdev() for ethernet devices.
>> >
>>
>> Yes, I considered it when I was writing this.  I've seen it both ways.
>> In the case you mention, they've got reasons they absolutely needed to
>> do it that way.  alloc_etherdev() calls eventually to
>> alloc_netdev_mqs() which is about 100 lines of alloc'ing and
>> initializing a network device struct.
>
> Yeah, sure. I looked around some more. Other subsystems just alloc
> manually, seems fine with me.
>>
>> > The benefit of the API you proposed is that one could embed the fpga_mgr
>> > struct inside of another struct and get to the container via
>> > container_of() I guess ...
>>
>> Yes, let's keep it simple for now, as that gives us greater
>> flexibility.  We can add alloc functions when it becomes clear that it
>> won't get in the way of someone's use.
>
> Agreed.
>>
>> Alan
>>
>> >
>> >>
>> >> Signed-off-by: Alan Tull <atull@kernel.org>
>> >> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
>> >> ---
>> >>  Documentation/fpga/fpga-mgr.txt  | 23 ++++++++++++++++-------
>> >>  drivers/fpga/altera-cvp.c        | 17 +++++++++++++----
>> >>  drivers/fpga/altera-pr-ip-core.c | 16 ++++++++++++++--
>> >>  drivers/fpga/altera-ps-spi.c     | 17 ++++++++++++++---
>> >>  drivers/fpga/fpga-mgr.c          | 28 +++++++---------------------
>> >>  drivers/fpga/ice40-spi.c         | 19 +++++++++++++++----
>> >>  drivers/fpga/socfpga-a10.c       | 15 ++++++++++++---
>> >>  drivers/fpga/socfpga.c           | 17 ++++++++++++++---
>> >>  drivers/fpga/ts73xx-fpga.c       | 17 ++++++++++++++---
>> >>  drivers/fpga/xilinx-spi.c        | 17 ++++++++++++++---
>> >>  drivers/fpga/zynq-fpga.c         | 15 ++++++++++++---
>> >>  include/linux/fpga/fpga-mgr.h    |  6 ++----
>> >>  12 files changed, 147 insertions(+), 60 deletions(-)
>> >>
>> >> diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-mgr.txt
>> >> index cc6413e..7e5e5c8 100644
>> >> --- a/Documentation/fpga/fpga-mgr.txt
>> >> +++ b/Documentation/fpga/fpga-mgr.txt
>> >> @@ -67,11 +67,9 @@ fpga_mgr_unlock when done programming the FPGA.
>> >>  To register or unregister the low level FPGA-specific driver:
>> >>  -------------------------------------------------------------
>> >>
>> >> -     int fpga_mgr_register(struct device *dev, const char *name,
>> >> -                           const struct fpga_manager_ops *mops,
>> >> -                           void *priv);
>> >> +     int fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
>
> At that point you could also just give the struct fpga_manager a
> ->parent or ->dev that you populate with &pdev->dev or &spi->dev etc instead of
> making it a separate parameter, this makes an odd mix of half and half here.

Yes, I'd have to call it parent as dev is taken.  I also noticed that
I forgot to edit the function parameter documentation in the c file.

>> >>
>> >> -     void fpga_mgr_unregister(struct device *dev);
>> >> +     void fpga_mgr_unregister(struct fpga_manager *mgr);
>> >>
>> >>  Use of these two functions is described below in "How To Support a new FPGA
>> >>  device."
>> >> @@ -148,8 +146,13 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>> >>  {
>> >>       struct device *dev = &pdev->dev;
>> >>       struct socfpga_fpga_priv *priv;
>> >> +     struct fpga_manager *mgr;
>> >>       int ret;
>> >>
>> >> +     mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
>> >> +     if (!mgr)
>> >> +             return -ENOMEM;
>> >> +
>> >>       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> >>       if (!priv)
>> >>               return -ENOMEM;
>> >> @@ -157,13 +160,19 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>> >>       /* ... do ioremaps, get interrupts, etc. and save
>> >>          them in priv... */
>> >>
>> >> -     return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
>> >> -                              &socfpga_fpga_ops, priv);
>> >> +     mgr->name = "Altera SOCFPGA FPGA Manager";
>> >> +     mgr->mops = &socfpga_fpga_ops;
>> >> +     mgr->priv = priv;
> Like here: mgr->dev = &pdev->dev

Yes, good catch.  By the way, I pushed these patches on a branch to
linux-fpga (branch name is review-v4.14-rc7-non-dt-support-v5.1).

Thanks for reviewing,
Alan

>
>> >> +     platform_set_drvdata(pdev, mgr);
>> >> +
>> >> +     return fpga_mgr_register(dev, mgr);
>> >>  }
