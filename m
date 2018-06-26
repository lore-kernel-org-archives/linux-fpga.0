Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <22840601.TEhG8FuRZq@pcbe13614>
References: <4617134.5euanDEBgJ@pcbe13614> <CANk1AXQ6cZnxN5tXckZektnbfWixPhS8+VitMZ4fcMyAcQzfqA@mail.gmail.com>
 <22840601.TEhG8FuRZq@pcbe13614>
From: Alan Tull <atull@kernel.org>
Date: Tue, 26 Jun 2018 16:00:46 -0500
Message-ID: <CANk1AXRFK8CYn_c7ckpJeXpFbc-CcZ+xzZiJzUsiDUUS7ancPA@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Content-Type: text/plain; charset="UTF-8"
To: federico.vaga@cern.ch
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga <federico.vaga@cern.ch> wrote:

Hi Federico,

>> > What is buggy is the function fpga_mgr_get().
>> > That patch has been done to allow multiple FPGA manager instances
>> > to be linked to the same device (PCI it says). But function
>> > fpga_mgr_get() will return only the first found: what about the
>> > others?

I've had more time with this, I agree with you.  I didn't intend to
limit us to one manager per parent device.

>> > Then, all load kernel-doc comments says:
>> >
>> > "This code assumes the caller got the mgr pointer from
>> > of_fpga_mgr_get() or fpga_mgr_get()"
>> >
>> > but that function does not allow me to get, for instance, the
>> > second FPGA manager on my card.
>> >
>> > Since, thanks to this patch I'm actually the creator of the
>> > fpga_manager structure,  I do not need to use fpga_mgr_get() to
>> > retrieve that data structure.
>> > Despite this, I believe we still need to increment the module
>> > reference counter (which is done by fpga_mgr_get()).
>> >
>> > We can fix this function by just replacing the argument from
>> > 'device' to 'fpga_manager' (the one returned by create() ).
>>
>> At first thought, that's what I'd want.
>>
>> > Alternatively, we
>> > can add an 'owner' field in "struct fpga_manager_ops" and 'get' it
>> > when we use it. Or again, just an 'owner' argument in the create()
>> > function.
>>
>> It seems like we shouldn't have to do that.
>
> Why?

OK yes, I agree; the kernel has a lot of examples of doing this.

I'll have to play with it, I'll probably add the owner arg to the
create function, add owner to struct fpga_manager, and save.

>
>> > I'm proposing these alternatives because I'm not sure that
>> >
>> > this is correct:
>> >         if (!try_module_get(dev->parent->driver->owner))
>> >
>> > What if the device does not have a driver? Do we consider the
>> > following a valid use case?
>> >
>> >
>> > probe(struct device *dev) {
>> >
>> >   struct device *mydev;
>> >
>> >   mydev->parent = dev;
>> >   device_register(mydev);
>> >   fpga_mrg_create(mydev, ....);
>> >
>> > }

Sure

>>
>> When would you want to do that?
>
> Not sure when, I'm in the middle of some other development and I
> stumbled into this issue. But of course I can do it ... at some point
> :)

I was meaning to ask something else.  I don't mind writing this and
would be interested in your review/feedback.  Thanks again for seeing
this and for the thoughtful analysis.

Alan
