Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <BE8371DA886269458E0220A16DC1F8277E07031A@SHSMSX104.ccr.corp.intel.com>
References: <1501676385-32551-1-git-send-email-hao.wu@intel.com>
 <CANk1AXQs4bTwV9JeVC2B3HoEd+q39R4i3z4pvcZaRjj0bsLr0g@mail.gmail.com>
 <20170803075335.GA4120@hao-dev> <CANk1AXT+aoGuQE_U694r+=yFeeXyRUU99MfV-uTG9T3Wk85VMw@mail.gmail.com>
 <BE8371DA886269458E0220A16DC1F8277E07031A@SHSMSX104.ccr.corp.intel.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 10 Aug 2017 14:46:41 -0500
Message-ID: <CANk1AXQOAALsMZR3BfLeLREKA1YcYu8kb2ce4X9q5THK0nkQWw@mail.gmail.com>
Subject: Re: [PATCH RFC] fpga: add FPGA Bus device framework
Content-Type: text/plain; charset="UTF-8"
To: "Wu, Hao" <hao.wu@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Moritz Fischer <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Aug 8, 2017 at 1:25 PM, Wu, Hao <hao.wu@intel.com> wrote:
>> On Thu, Aug 3, 2017 at 2:53 AM, Wu Hao <hao.wu@intel.com> wrote:
>> > On Wed, Aug 02, 2017 at 04:16:32PM -0500, Alan Tull wrote:
>> >> On Wed, Aug 2, 2017 at 7:19 AM, Wu Hao <hao.wu@intel.com> wrote:
>> >> > This patch is a RFC patch which replaces the patch[1] which
>> >> > creates 'fpga-dev' class as container device. It introduces
>> >> > a 'fpga' bus type, and provides interfaces to create/destroy
>> >> > fpga bus devices. This fpga bus device only could be used as
>> >> > a container device, and no drivers needed for it.
>> >> >
>> >> > There is no interface change, so this patch could be used
>> >> > together with other patches of the original patch set[2].
>> >> >
>> >>
>> >> I am wondering whether this could be added to fpga-bridge.c so that
>> >> fpga-bridge becomes the fpga bus and fpga bus devices are under it.
>> >> The reasons for doing this are discussed in the other thread.
>> >>
>> >> > This following APIs are provided by FPGA Bus device framework:
>> >> > * fpga_dev_create
>> >> >   Create fpga bus device under the given parent device.
>> >> > * fpga_dev_destroy
>> >> >   Destroy fpga bus device
>> >>
>> >> This is being used in such that each fpga-dev is a container for
>> >> platform devices rather than fpga devices.  That's not what I was
>> >> expecting. :)
>> >
>> > Hi Alan
>> >
>> > So does that mean in Intel FPGA PCIe driver, it needs to create
>> > a fpga-bridge (as base bridge?),
>>
>> Yes
>>
>> > and this fpga-bridge should register
>> > a fpga-bus and have a fpga bus device as its child, after that we can
>> > use this fpga bus device as container device,
>>
>> Could the bus code be added to fpga-bridge?  Then the base bridge is
>> the container device.  A fpga-region would be under that and the AFU
>> and FME fpga devices would be under it.
>>
>> > and create sub feature
>> > devices (e.g AFU and FME platform device)
>>
>> We're talking about adding a new bus to the kernel here, not platform bus.
>>
>> > under it, and user application
>> > could locate it in /sys/bus/fpga/devices/. Is my understanding correct? :)
>>
>>  So sysfs may end up something like this in your case:
>>
>> /sys/bus/fpga/devices/fpga.0/intel-fpga-fme.0
>> /sys/bus/fpga/devices/fpga.0/intel-fpga-port.0
>> /sys/bus/fpga/devices/fpga.0/intel-fpga-port.1
>> /sys/bus/fpga/devices/fpga.0/fpga-mgr0
>> /sys/bus/fpga/devices/fpga.0/fpga-br1
>> /sys/bus/fpga/devices/fpga.0/fpga-br2
>
> Hi Alan
>
> I am a little confused on this.
>
> It seems that we could not have multiple fpga-br/region/mgr under one device.
> As in patch set2, intel-fpga-fme.0 creates platform devices as children, and register
> fpga-bridges/regions/mgr under these children platform devices. This is why 3 new
> platform device driver introduced in this patch set 2 to match with those new created
> children platform devices.
>
> So it is something like this
> /sys/bus/fpga/devices/fpga.0/intel-fpga-fme.0/intel-fpga-fme-region.0/fpga_region/region0
> /sys/bus/fpga/devices/fpga.0/intel-fpga-fme.0/intel-fpga-fme-region.1/fpga_region/region1
> /sys/bus/fpga/devices/fpga.0/intel-fpga-fme.0/intel-fpga-fme-br.0/fpga_bridge/br1
> /sys/bus/fpga/devices/fpga.0/intel-fpga-fme.0/intel-fpga-fme-br.1/fpga_region/br2
> /sys/bus/fpga/devices/fpga.1
> /sys/bus/fpga/devices/fpga.2

Hi Hao,

OK I see that now.  Because the regions, mgr, and bridges are all
children of the fme's.

>
> br0 should be the base bridge. fpga.1 and 2 are the child fpga bus device of fpga bridge.
>
>>
>> /sys/bus/fpga/devices/fpga.1/fpga-region1
>> /sys/bus/fpga/devices/fpga.2/fpga-region2
>>
>> /sys/bus/fpga/devices/fpga.3/intel-fpga-fme.1
>> /sys/bus/fpga/devices/fpga.3/intel-fpga-port.2
>> /sys/bus/fpga/devices/fpga.3/intel-fpga-port.3
>> /sys/bus/fpga/devices/fpga.0/fpga-mgr1
>> /sys/bus/fpga/devices/fpga.3/fpga-br4
>> /sys/bus/fpga/devices/fpga.3/fpga-br5
>>
>> /sys/bus/fpga/devices/fpga.4/fpga-region4
>> /sys/bus/fpga/devices/fpga.5/fpga-region5
>>
>> fpga-br0 and 3 are base bridges (on top of PCIe) which show up as
>> fpga.0 and 3.  Regions 0 and 3 are base regions.
>>
>> fpga.0 and fpga.3 correspond to the real FPGA devices.
>>
>> >
>> > And if we have second level fpga-bridge for PR regions, then they
>> > should register fpga-bus and fpga bus type device as child too?
>> > If yes, then we need a method for user application to distinguish
>> > which one represents the FPGA device in /sys/bus/fpga/devices/, right?
>>
>> To find a bus that is a fpga, userspace only needs to look for busses
>> that have an FME (or a mgr).
>
> Do you mean that check all fpga-dev.x folder to see if anyone has FME?
>
> Then it is still not friendly to user space, as we may have a lot of bridges
> (and regions) on one system.

It doesn't sound too hard for userspace code to go through sysfs once
and find the FME's.

>
> And looks like no big difference that we reuse base fpga-region as
> container. Search all regionx in /sys/class/fpga_region/ to see if anyone
> has a FME.
>
> How do you think? : )

Yes, looking for
/sys/class/fpga_region/region*/device/intel-fpga-fme.*  That's not so
bad, right? :)

Then the fpga-dev stuff can go away and we can stop worrying about all
the issues involved in implementing a fpga bus or class.

Alan

>
> Hao
>
>>
>> > It seems to be a similar case that we see a lot of regions in
>> > /sys/class/fpga_region/ but not sure which one is the base region. :)
>>
>> I understand that the goal of fpga-dev was to describe the topology
>> (which is the function of a bus, not a class as Rob explained).  To be
>> honest, I'm still pondering the implications of adding a fpga bus.
>>
>> Alan
