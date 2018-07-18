Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <2419388.jt6midSiEu@pcbe13614>
References: <4617134.5euanDEBgJ@pcbe13614> <1569671.PEFH9RgftX@pcbe13614>
 <CANk1AXSmDWb=up_xDwvSg1SLS0iv6spcpcv42fSpM7+=Cy06wQ@mail.gmail.com> <2419388.jt6midSiEu@pcbe13614>
From: Alan Tull <atull@kernel.org>
Date: Wed, 18 Jul 2018 14:47:24 -0500
Message-ID: <CANk1AXSd7V03w=uPuo+HiibxmD9_JwaTZyx4uRJ_OfXB4o-_Cw@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Content-Type: text/plain; charset="UTF-8"
To: federico.vaga@cern.ch
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jun 28, 2018 at 2:50 AM, Federico Vaga <federico.vaga@cern.ch> wrote:
> On Wednesday, 27 June 2018 23:23:07 CEST Alan Tull wrote:
>> On Wed, Jun 27, 2018 at 4:25 AM, Federico Vaga
> <federico.vaga@cern.ch> wrote:
>> > Hi Alan,
>> >
>> > On Tuesday, 26 June 2018 23:00:46 CEST Alan Tull wrote:
>> >> On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga
>> >> <federico.vaga@cern.ch> wrote:
>> >>
>> >> Hi Federico,
>> >>
>> >> >> > What is buggy is the function fpga_mgr_get().
>> >> >> > That patch has been done to allow multiple FPGA manager
>> >> >> > instances
>> >> >> > to be linked to the same device (PCI it says). But function
>> >> >> > fpga_mgr_get() will return only the first found: what about
>> >> >> > the
>> >> >> > others?

Looking at this further, no code change is needed in the FPGA API to
support multiple managers.  A FPGA manager driver is a self-contained
platform driver.  The PCI driver for a board that contains multiple
FPGAs should create a platform device for each manager and save each
of those devs in its pdata.

>> >> >> > Then, all load kernel-doc comments says:
>> >> >> >
>> >> >> > "This code assumes the caller got the mgr pointer from
>> >> >> > of_fpga_mgr_get() or fpga_mgr_get()"
>> >> >> >
>> >> >> > but that function does not allow me to get, for instance,
>> >> >> > the
>> >> >> > second FPGA manager on my card.

fpga_mgr_get() will do what you want if your PCI driver creates a
platform device per FPGA manager as mentioned above.

>> >> >> > Since, thanks to this patch I'm actually the creator of the
>> >> >> > fpga_manager structure,  I do not need to use fpga_mgr_get()
>> >> >> > to
>> >> >> > retrieve that data structure.

The creator of the FPGA mgr structure is the low level FPGA manager
driver, not the PCIe driver.

>> >> >> > Despite this, I believe we still need to increment the
>> >> >> > module
>> >> >> > reference counter (which is done by fpga_mgr_get()).

This is only done in the probe function of a FPGA region driver.

>> >> >> >
>> >> >> > We can fix this function by just replacing the argument from
>> >> >> > 'device' to 'fpga_manager' (the one returned by create() ).
>> >> >>
>> >> >> At first thought, that's what I'd want.
>> >> >>
>> >> >> > Alternatively, we
>> >> >> > can add an 'owner' field in "struct fpga_manager_ops" and
>> >> >> > 'get'
>> >> >> > it
>> >> >> > when we use it. Or again, just an 'owner' argument in the
>> >> >> > create()
>> >> >> > function.
>> >> >>
>> >> >> It seems like we shouldn't have to do that.
>> >> >
>> >> > Why?
>> >>
>> >> OK yes, I agree; the kernel has a lot of examples of doing this.
>> >>
>> >> I'll have to play with it, I'll probably add the owner arg to the
>> >> create function, add owner to struct fpga_manager, and save.
>> >
>> > I have two though about this.
>> >
>> > 1. file_operation like approach. The onwer is associated to the
>> > FPGA manager operation. Whenever the FPGA manager wants to use an
>> > operation it get/put the module owner of these operations
>> > (because this is what we need to protect). With this the user is
>> > not directly involved, read it as less code, less things to care
>> > about. And probably there is no need for fpga_manager_get().
>>
>> How does try_module_get fit into this scheme?  I think this proposal
>> #1 is missing the point of what the reference count increment is
>> meant to do.  Or am I misunderstanding?  How does that keep the
>> module from being unloaded 1/3 way through programming a FPGA?
>> IIUC you are saying that the reference count would be incremented
>> before doing the manager ops .write_init, then decremented again
>> afterwards, incremented before each call to .write, decremented
>> afterwards, then the same for .write_complete.
>
> I'm not saying to do module_get/put just around the mops->XXX(): it's
> too much. Just where you have this comment:
>
> "This code assumes the caller got the mgr pointer from
> of_fpga_mgr_get() or fpga_mgr_get()"
>
> Because, currently, it's here where we do module_get()

No it's not.

fpga_mgr_get() or of_fpga_mgr_get() is called when the region is
created such as in of-fpga-region's probe.  That way, as long as the
region exists, the manager won't be unloaded.  If someone wants to
start unloading modules, they need to unload higher level ones first,
so they'll have to unload the region before mgr.

>
> Most mops are invoked within a set of static functions which are
> called only by few exported functions. I'm suggesting to do
> module_get/put in those exported function at the beginning (get) and
> and the end (put) because we know that within these functions, here
> and there, we will use mops which are owned by a different module.
> We do not want the module owner of the mops to disappear while someone
> is doing fpga_mgr_load(). For example, inside fpga_mgr_load() we use
> most of the mops, so we 'get' the module at the beginning and 'put' it
> at the end. The same for fpga_region_program_fpga().

If we do it the way you are suggesting, then someone can unload the
manager module without unloading the region.  The region code will be
in for a nasty surprise when programming is attempted.

> Like this we do not have to ask users to do fpga_mgr_get()/put().

The only user who has to do this is a region's probe function.

I'm assuming that only fpga_region is using fpga_mgr_load() and
anybody who is creating a region uses fpga_region_program_fpga().
That's what I want to encourage anyway.  I should probably move
fpga_mgr_load to a private header.

>
> <Parenthesis>
> fpga_region_program_fpga() does not do (today) fpga_mgr_get() because
> it assumes, but it is not enforced, that both fpga_region and fpga_mgr
> are child of the same device.

fpga_region_program_fpga() doesn't do fpga_mgr_get() becuase
fpga_mgr_get() happens when the fpga_region probes.  The assumption I
am making is that nobody other than a region is calling
fpga_manager_load().  I should create a fpga_private.h and move
fpga_manager_load() out of fpga-mgr.h to make that official.

> Probably this is true 99.99% of the
> time.
> Let me open in parallel another point: why fpga_region is not a child
> of fpga_manager?

FPGA regions are children of FPGA bridges.

Alan
