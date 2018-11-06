Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181105171457.28150-1-agust@denx.de> <CANk1AXTTWMSsnjSgubnP6Mrt5GJ_edOL=cgix_rcrXs7t4-2CA@mail.gmail.com>
 <20181106102931.7ec6d038@crub>
In-Reply-To: <20181106102931.7ec6d038@crub>
From: Alan Tull <atull@kernel.org>
Date: Tue, 6 Nov 2018 11:22:35 -0600
Message-ID: <CANk1AXSWzDoSNJu4KX+fUYNJJvd1RmGy7QZBorEh2kc4-N1yVA@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: mgr: add notifier for manager
 register/unregister events
Content-Type: text/plain; charset="UTF-8"
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Nov 6, 2018 at 3:29 AM Anatolij Gustschin <agust@denx.de> wrote:
>
> Hi Alan,
>
> On Mon, 5 Nov 2018 15:08:03 -0600
> Alan Tull atull@kernel.org wrote:
>
> >On Mon, Nov 5, 2018 at 11:15 AM Anatolij Gustschin <agust@denx.de> wrote:
> >
> >Hi Anatolij,
> >
> >>
> >> Add API functions for registering and removing a notifier for FPGA
> >> manager register/unregister events. Notify when a new FPGA manager
> >> has been registered or when an existing manager is being removed.
> >> This will help configuration interface drivers to get the notion
> >> of low-level FPGA managers appearing or disappearing, when using
> >> hotpluggable FPGA configuration devices (e.g. via USB-FPP or
> >> USB-SPI adapters).

To be clear, this patch will need to wait to go upstream when there is
a user for it.  So you could resubmit it when you are submitting
patches that use it.  That way we won't be adding code and maintaining
an API which has no upstream use.

> >
> >Are you going to be adding any code upstream that uses this API?
>
> I'd like to add our fpga-cfg driver [1] in upstream which uses this API.
> Here [2] is a better readable README about it.

This is adding a debugfs interface for FPGA manager.  I've posted a
patch for this recently and it got discussed [3].

My view is that FPGA manager debugfs is fine for debug/development
work, but  turning it on and leaving it on for production work is
really wrong.   I keep seeing it come up since there currently is not
an accessible alternative if you are running without devicetree.

It's more stable and secure if the kernel handles reprogramming,
bridges (if they exist), and enumeration all together under kernel
control rather than userspace handling them piecemeal.  So any
production FPGA interfaces need to be added on top of FPGA region
(which coordinates programming and bridges) and if possible handle
enumeration.  The other benefit of adding the interface on top of FPGA
regions is that supports a wider set of users, i.e. if you can control
a region, you can handle users who need bridges as well as users who
don't.

>
> Thanks,
>
> Anatolij
>
>
> [1] http://git.denx.de/?p=fpga-cfg.git;a=summary
> [2] https://github.com/vdsao/fpga-cfg/blob/master/README.md

[3] https://lkml.org/lkml/2018/8/16/665
