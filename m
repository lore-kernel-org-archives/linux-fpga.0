Return-Path: <SRS0=ukmm=JO=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ukmm=JO=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-he1eur01on0071.outbound.protection.outlook.com ([104.47.0.71]:42112
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752057AbeF1Huh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 28 Jun 2018 03:50:37 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Date: Thu, 28 Jun 2018 09:50:12 +0200
Message-ID: <2419388.jt6midSiEu@pcbe13614>
In-Reply-To: <CANk1AXSmDWb=up_xDwvSg1SLS0iv6spcpcv42fSpM7+=Cy06wQ@mail.gmail.com>
References: <4617134.5euanDEBgJ@pcbe13614> <1569671.PEFH9RgftX@pcbe13614> <CANk1AXSmDWb=up_xDwvSg1SLS0iv6spcpcv42fSpM7+=Cy06wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Wednesday, 27 June 2018 23:23:07 CEST Alan Tull wrote:
> On Wed, Jun 27, 2018 at 4:25 AM, Federico Vaga 
<federico.vaga@cern.ch> wrote:
> > Hi Alan,
> > 
> > On Tuesday, 26 June 2018 23:00:46 CEST Alan Tull wrote:
> >> On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga
> >> <federico.vaga@cern.ch> wrote:
> >> 
> >> Hi Federico,
> >> 
> >> >> > What is buggy is the function fpga_mgr_get().
> >> >> > That patch has been done to allow multiple FPGA manager
> >> >> > instances
> >> >> > to be linked to the same device (PCI it says). But function
> >> >> > fpga_mgr_get() will return only the first found: what about
> >> >> > the
> >> >> > others?
> >> 
> >> I've had more time with this, I agree with you.  I didn't intend
> >> to
> >> limit us to one manager per parent device.
> >> 
> >> >> > Then, all load kernel-doc comments says:
> >> >> > 
> >> >> > "This code assumes the caller got the mgr pointer from
> >> >> > of_fpga_mgr_get() or fpga_mgr_get()"
> >> >> > 
> >> >> > but that function does not allow me to get, for instance,
> >> >> > the
> >> >> > second FPGA manager on my card.
> >> >> > 
> >> >> > Since, thanks to this patch I'm actually the creator of the
> >> >> > fpga_manager structure,  I do not need to use fpga_mgr_get()
> >> >> > to
> >> >> > retrieve that data structure.
> >> >> > Despite this, I believe we still need to increment the
> >> >> > module
> >> >> > reference counter (which is done by fpga_mgr_get()).
> >> >> > 
> >> >> > We can fix this function by just replacing the argument from
> >> >> > 'device' to 'fpga_manager' (the one returned by create() ).
> >> >> 
> >> >> At first thought, that's what I'd want.
> >> >> 
> >> >> > Alternatively, we
> >> >> > can add an 'owner' field in "struct fpga_manager_ops" and
> >> >> > 'get'
> >> >> > it
> >> >> > when we use it. Or again, just an 'owner' argument in the
> >> >> > create()
> >> >> > function.
> >> >> 
> >> >> It seems like we shouldn't have to do that.
> >> > 
> >> > Why?
> >> 
> >> OK yes, I agree; the kernel has a lot of examples of doing this.
> >> 
> >> I'll have to play with it, I'll probably add the owner arg to the
> >> create function, add owner to struct fpga_manager, and save.
> > 
> > I have two though about this.
> > 
> > 1. file_operation like approach. The onwer is associated to the
> > FPGA manager operation. Whenever the FPGA manager wants to use an
> > operation it get/put the module owner of these operations
> > (because this is what we need to protect). With this the user is
> > not directly involved, read it as less code, less things to care
> > about. And probably there is no need for fpga_manager_get().
> 
> How does try_module_get fit into this scheme?  I think this proposal
> #1 is missing the point of what the reference count increment is
> meant to do.  Or am I misunderstanding?  How does that keep the
> module from being unloaded 1/3 way through programming a FPGA? 
> IIUC you are saying that the reference count would be incremented
> before doing the manager ops .write_init, then decremented again
> afterwards, incremented before each call to .write, decremented
> afterwards, then the same for .write_complete.

I'm not saying to do module_get/put just around the mops->XXX(): it's 
too much. Just where you have this comment:

"This code assumes the caller got the mgr pointer from 
of_fpga_mgr_get() or fpga_mgr_get()"

Because, currently, it's here where we do module_get()

Most mops are invoked within a set of static functions which are 
called only by few exported functions. I'm suggesting to do 
module_get/put in those exported function at the beginning (get) and 
and the end (put) because we know that within these functions, here 
and there, we will use mops which are owned by a different module.
We do not want the module owner of the mops to disappear while someone 
is doing fpga_mgr_load(). For example, inside fpga_mgr_load() we use 
most of the mops, so we 'get' the module at the beginning and 'put' it 
at the end. The same for fpga_region_program_fpga().
Like this we do not have to ask users to do fpga_mgr_get()/put().

<Parenthesis>
fpga_region_program_fpga() does not do (today) fpga_mgr_get() because 
it assumes, but it is not enforced, that both fpga_region and fpga_mgr 
are child of the same device. Probably this is true 99.99% of the 
time.
Let me open in parallel another point: why fpga_region is not a child 
of fpga_manager? (and then fpga_region_create can have one argument 
less and close any other weird possibility)
</Parenthesis>

I'm thinking about fpga_mgr_load() because, in principle, this can be 
used by other modules to program the FPGA with what they want.
While functions like fpga_mgr_unregister() are most likely called by 
the module that owns the ops; here we can safely assumes that its the 
same module to call this function and not a third one (if this is the 
case, then it is a bug) and we can forget about module_get()/put() 
(and indeed you do not suggest to call fpga_mgr_get()).

I did my best to make it clear but I understand that it is not always 
easy to read someone else mind and I'm not a best-seller writer :D
 
> > 2. fpga_manager onwer, we can still play the game above but
> > conceptually, from the user point of view, I see it like the
> > driver
> > that creates the fpga_manager instance becomes the owner of it.
> 
> I think that's what's happening.  And can continue to happen, adding
> the owner parameter to fpga_mgr_create.
> 
> > I
> > think that this is not true,
> 
> How do you figure that?  fpga_mgr_create() is called with pdev->dev
> from each of the FPGA manager's probe functions.  It stores dev as
> the parent: mgr->dev.parent = dev;

Let me say that I'm not advocating for this or that, I'm expressing my 
point of view (taste if you want). I do not see a true technical 
difference because mops are in a 1:1 relation with the fpga_manager 
structure. So, whatever is easier to implement is good :)

Just to try to clarify my way of seeing things ----------------------
In the reletionship between the driver and the FPGA manager, if we say 
that the driver owns the fpga_manager instance, then we do not need to 
do any module_get/put, because it is the driver that does everything 
with its own instance. If the driver does something wrong with the 
FPGA manager, it's its fault.
 
If we allow a third module to use fpga_mgr_load() (which I think is 
the case) then I think it's different. The fpga_manager is an instance 
owned by the FPGA manager module; fpga_manager is a token to access 
some services (like a middleware), when you use these services we need 
support (mops) from another module that actually does the loading and 
owns the operations.
And I stop here with this argument ----------------------------------

> > the fpga_manager structure is completely
> > used by the FPGA manager module and the driver use it as a token
> > to
> > access the FPGA manager API. I hope my point is clear :)
> > 
> > I'm more for the solution 1.
> > 
> >> >> > I'm proposing these alternatives because I'm not sure that
> >> >> > 
> >> >> > this is correct:
> >> >> >         if (!try_module_get(dev->parent->driver->owner))
> >> >> > 
> >> >> > What if the device does not have a driver? Do we consider
> >> >> > the
> >> >> > following a valid use case?
> >> >> > 
> >> >> > 
> >> >> > probe(struct device *dev) {
> >> >> > 
> >> >> >   struct device *mydev;
> >> >> >   
> >> >> >   mydev->parent = dev;
> >> >> >   device_register(mydev);
> >> >> >   fpga_mrg_create(mydev, ....);
> >> >> > 
> >> >> > }
> >> 
> >> Sure
> >> 
> >> >> When would you want to do that?
> >> > 
> >> > Not sure when, I'm in the middle of some other development and
> >> > I
> >> > stumbled into this issue. But of course I can do it ... at some
> >> > point>
> >> > 
> >> > :)
> >> 
> >> I was meaning to ask something else.
> > 
> > I see, you meant the example about the "virtual device" without
> > driver. I do not have a true example, but this is a possible case
> > I
> > think we should support it or not (check this on register())
> 
> I think we should support this use, yes.
> 
> Alan
> 
> >> I don't mind writing this and would be interested in your review/
> >> feedback.  Thanks again for seeing this and for the thoughtful
> >> analysis.
> > 
> > I'm here for any feedback/review :)




