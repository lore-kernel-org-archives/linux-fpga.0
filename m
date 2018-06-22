Return-Path: <SRS0=mbOz=JI=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=mbOz=JI=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-he1eur01on0041.outbound.protection.outlook.com ([104.47.0.41]:60105
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750985AbeFVHxS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 22 Jun 2018 03:53:18 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Date: Fri, 22 Jun 2018 09:53:06 +0200
Message-ID: <22840601.TEhG8FuRZq@pcbe13614>
In-Reply-To: <CANk1AXQ6cZnxN5tXckZektnbfWixPhS8+VitMZ4fcMyAcQzfqA@mail.gmail.com>
References: <4617134.5euanDEBgJ@pcbe13614> <CANk1AXQ6cZnxN5tXckZektnbfWixPhS8+VitMZ4fcMyAcQzfqA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Hi Alan,

inline comments

On Friday, 22 June 2018 04:07:41 CEST Alan Tull wrote:
> On Thu, Jun 21, 2018 at 8:13 AM, Federico Vaga
> <federico.vaga@cern.ch> wrote:
> 
> Hi Federico,
> 
> Thanks for the analysis.  I'll probably not be able to look into
> this very much until next week.  A few notes below.
> 
> > Hello,
> > 
> > I believe that this patch
> > 
> > fpga: manager: change api, don't use drvdata
> > 7085e2a94f7df5f419e3cfb2fe809ce6564e9629
> > 
> > is incomplete and buggy.
> > 
> > I completely agree that drvdata should not be used by the FPGA
> > manager or any other subsystem like that.
> > 
> > What is buggy is the function fpga_mgr_get().
> > That patch has been done to allow multiple FPGA manager instances
> > to be linked to the same device (PCI it says). But function
> > fpga_mgr_get() will return only the first found: what about the
> > others?
> 
> I was thinking it was going to be one manager per device which makes
> sense if the device corresponds to a single FPGA.  But I could see
> that there could be valid use cases that had more than one FPGA
> such as on a PCI card.

Here a practical example where we have 2 FPGAs on the same card

https://www.ohwr.org/projects/svec/wiki/wiki

> > Then, all load kernel-doc comments says:
> > 
> > "This code assumes the caller got the mgr pointer from
> > of_fpga_mgr_get() or fpga_mgr_get()"
> > 
> > but that function does not allow me to get, for instance, the
> > second FPGA manager on my card.
> > 
> > Since, thanks to this patch I'm actually the creator of the
> > fpga_manager structure,  I do not need to use fpga_mgr_get() to
> > retrieve that data structure.
> > Despite this, I believe we still need to increment the module
> > reference counter (which is done by fpga_mgr_get()).
> > 
> > We can fix this function by just replacing the argument from
> > 'device' to 'fpga_manager' (the one returned by create() ).
> 
> At first thought, that's what I'd want.
> 
> > Alternatively, we
> > can add an 'owner' field in "struct fpga_manager_ops" and 'get' it
> > when we use it. Or again, just an 'owner' argument in the create()
> > function.
> 
> It seems like we shouldn't have to do that.

Why? 
 
> > I'm proposing these alternatives because I'm not sure that
> > 
> > this is correct:
> >         if (!try_module_get(dev->parent->driver->owner))
> > 
> > What if the device does not have a driver? Do we consider the
> > following a valid use case?
> > 
> > 
> > probe(struct device *dev) {
> > 
> >   struct device *mydev;
> >   
> >   mydev->parent = dev;
> >   device_register(mydev);
> >   fpga_mrg_create(mydev, ....);
> > 
> > }
>
> When would you want to do that?

Not sure when, I'm in the middle of some other development and I 
stumbled into this issue. But of course I can do it ... at some point 
:)

> Alan
> 
> > thanks :)
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-fpga" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html




