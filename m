Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <4617134.5euanDEBgJ@pcbe13614>
References: <4617134.5euanDEBgJ@pcbe13614>
From: Alan Tull <atull@kernel.org>
Date: Thu, 21 Jun 2018 21:07:41 -0500
Message-ID: <CANk1AXQ6cZnxN5tXckZektnbfWixPhS8+VitMZ4fcMyAcQzfqA@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Content-Type: text/plain; charset="UTF-8"
To: federico.vaga@cern.ch
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jun 21, 2018 at 8:13 AM, Federico Vaga <federico.vaga@cern.ch> wrote:

Hi Federico,

Thanks for the analysis.  I'll probably not be able to look into this
very much until next week.  A few notes below.

> Hello,
>
> I believe that this patch
>
> fpga: manager: change api, don't use drvdata
> 7085e2a94f7df5f419e3cfb2fe809ce6564e9629
>
> is incomplete and buggy.
>
> I completely agree that drvdata should not be used by the FPGA manager
> or any other subsystem like that.
>
> What is buggy is the function fpga_mgr_get().
> That patch has been done to allow multiple FPGA manager instances to
> be linked to the same device (PCI it says). But function
> fpga_mgr_get() will return only the first found: what about the
> others?

I was thinking it was going to be one manager per device which makes
sense if the device corresponds to a single FPGA.  But I could see
that there could be valid use cases that had more than one FPGA such
as on a PCI card.

>
> Then, all load kernel-doc comments says:
>
> "This code assumes the caller got the mgr pointer from
> of_fpga_mgr_get() or fpga_mgr_get()"
>
> but that function does not allow me to get, for instance, the second
> FPGA manager on my card.
>
> Since, thanks to this patch I'm actually the creator of the
> fpga_manager structure,  I do not need to use fpga_mgr_get() to
> retrieve that data structure.
> Despite this, I believe we still need to increment the module
> reference counter (which is done by fpga_mgr_get()).
>
> We can fix this function by just replacing the argument from 'device'
> to 'fpga_manager' (the one returned by create() ).

At first thought, that's what I'd want.

> Alternatively, we
> can add an 'owner' field in "struct fpga_manager_ops" and 'get' it
> when we use it. Or again, just an 'owner' argument in the create()
> function.

It seems like we shouldn't have to do that.

> I'm proposing these alternatives because I'm not sure that
> this is correct:
>
>         if (!try_module_get(dev->parent->driver->owner))
>
> What if the device does not have a driver? Do we consider the
> following a valid use case?
>
>
> probe(struct device *dev) {
>   struct device *mydev;
>
>   mydev->parent = dev;
>   device_register(mydev);
>   fpga_mrg_create(mydev, ....);
> }

When would you want to do that?

Alan

>
>
> thanks :)
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
