Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAtXAHc2sn23oh0kESTke4V97QEdSLktm280=gabW+v6_CKPzQ@mail.gmail.com>
References: <1492697401-11211-1-git-send-email-atull@kernel.org>
 <1492697401-11211-3-git-send-email-atull@kernel.org> <20170503115831.GA30448@hao-dev>
 <CANk1AXRrFjBVaeP0F0Yjm8t4H8yp0c8gzURO+_WEEFnkK4O6Uw@mail.gmail.com>
 <CANk1AXQRFXs8OiRBsNQS1CvK4Ao=rVJWuY9mO5HZy1SKsw=WdA@mail.gmail.com>
 <BE8371DA886269458E0220A16DC1F8277D6413BB@SHSMSX101.ccr.corp.intel.com>
 <CANk1AXTPBAwNwWGJ+oX+8zyUDeFg_qeecF-+Y9WtuOXFLn=M5w@mail.gmail.com> <CAAtXAHc2sn23oh0kESTke4V97QEdSLktm280=gabW+v6_CKPzQ@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 8 May 2017 16:02:52 -0500
Message-ID: <CANk1AXSjAQFUGyCUHXZAHvoCRJ4raBHVoO-TFtU0b+P-HGnuSg@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] fpga: bridge: support getting bridge from device
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: "Wu, Hao" <hao.wu@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, May 8, 2017 at 3:52 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Mon, May 8, 2017 at 1:44 PM, Alan Tull <atull@kernel.org> wrote:
>> On Mon, May 8, 2017 at 3:44 AM, Wu, Hao <hao.wu@intel.com> wrote:
>>>> On Wed, May 3, 2017 at 3:07 PM, Alan Tull <atull@kernel.org> wrote:
>>>> > On Wed, May 3, 2017 at 6:58 AM, Wu Hao <hao.wu@intel.com> wrote:
>>>> >> On Thu, Apr 20, 2017 at 09:09:47AM -0500, Alan Tull wrote:
>>>> >>> Add two functions for getting the FPGA bridge from the device
>>>> >>> rather than device tree node.  This is to enable writing code
>>>> >>> that will support using FPGA bridges without device tree.
>>>> >>> Rename one old function to make it clear that it is device
>>>> >>> tree-ish.  This leaves us with 3 functions for getting a bridge:
>>>> >>>
>>>> >>> * fpga_bridge_get
>>>> >>>   Get the bridge given the device.
>>>> >>>
>>>> >>> * fpga_bridges_get_to_list
>>>> >>>   Given the device, get the bridge and add it to a list.
>>>> >>>
>>>> >>> * of_fpga_bridges_get_to_list
>>>> >>>   Renamed from priviously existing fpga_bridges_get_to_list.
>>>> >>>   Given the device node, get the bridge and add it to a list.
>>>> >>>
>>>> >>
>>>> >> Hi Alan
>>>> >>
>>>> >> Thanks a lot for providing this patch set for non device tree support. :)
>>>> >> Actually I am reworking the Intel FPGA device drivers based on this patch
>>>> >> set, and I find some problems with the existing APIs including fpga bridge
>>>> >> and manager. My idea is to create all fpga bridges/regions/manager under
>>>> >> the same platform device (FME), it allows FME driver to establish the
>>>> >> relationship for the bridges/regions/managers it creates in an easy way.
>>>> >> But I found current fpga class API doesn't support this very well.
>>>> >> e.g fpga_bridge_get/get_to_list only accept parent device as the input
>>>> >> parameter, but it doesn't work if we have multiple bridges (and
>>>> >> regions/manager) under the same platform device. fpga_mgr has similar
>>>> >> issue, but fpga_region APIs work better, as they accept fpga_region as
>>>> >> parameter not the shared parent device.
>>>> >
>>>> > That's good feedback.  I can post a couple patches that apply on top
>>>> > of that patchset to add the APIs you need.
>>>> >
>>>> > Probably what I'll do is add
>>>> >
>>>> > struct fpga_manager *fpga_mgr_get(struct fpga_manager *mgr);
>>>> >
>>>> > And rename fpga_bridge_get() to fpga_bridge_dev_get() and add the
>>>> following:
>>>> >
>>>> > struct fpga_bridge *fpga_bridge_get(struct fpga_bridge *br,
>>>> >                                 struct fpga_image_info *info);
>>>> >
>>>> > int of_fpga_bridge_get_to_list(struct fpga_bridge *br,
>>>> >                                struct fpga_image_info *info,
>>>> >                                struct list_head *bridge_list);
>>>> >
>>>> > Working on it now.
>>>> >
>>>> >>
>>>> >> Do you think if having multiple fpga-* under one parent device is in the
>>>> >> right direction?
>>>> >
>>>> > That should be fine as long as it's coded with an eye on making things
>>>> > reusable and seeing beyond the current project.  Just thinking of the
>>>> > future and of what can be of general usefulness for others.  And there
>>>> > will be others interested in reusing this.
>>>> >
>>>> > Alan
>>>>
>>>> Actually,  I don't think you will need the additional APIs we were
>>>> just discussing after all.  What you have is a multifunction device
>>>> (single piece of hardware, multi functions such as in drivers/mfd).
>>>> It will have child devices for the mgr, bridges, and regions.  When
>>>> registering the mgr and bridges you will need to allocate child
>>>> devices and use them to create the mgr and bridges.
>>>>
>>>> Alan
>>>
>>> Hi Alan
>>>
>>> I tried to create child devices as the parent device for the mgr and
>>> bridges in fme platform driver module. If only creates the device without
>>> driver, it doesn't work as try_module_get(dev->parent->driver->owner)
>>> always failed in mgr_get and bridge_get functions.
>>
>> I tried it and it wasn't hard.
>>
>> Each mgr or bridge driver should be a separate file which registers
>> its driver using 'module_platform_driver".  That way the drivers are
>> registered with the kernel in a normal fashion.  The thing we want
>> here is to not bypass the kernel driver model.
>>
>> You'll need to keep the platform_device pointers in private data somewhere.
>>
>> For each child platform device, do a platform_device_alloc and
>> platform_device_add.
>>
>> Then to get the manager, you can do
>>
>> mgr = fpga_mgr_get(&priv->mgr_pdev->dev);
>>
>> If this is in your probe function, you can use -EPROBE_DEFER if
>> platform_device_alloc or fpga_mgr_get fail.  Then you could destroy
>> whatever you've created and return -EPROBE_DEFER to wait for the
>> drivers you need to be registered and ready for devices to be added.
>>
>>>
>>> If it creates platform devices as child devices, and introduce new platform
>>> device drivers for bridge and mgr, then it will be difficult to establish the
>>> relationship for region/mgr/bridges (e.g when should region->mgr be
>>> configured and cleared, as mgr is created/destroyed when mgr parent
>>> device platform driver module is loaded/unload), and it maybe not really
>>> necessary to introduce more different driver modules here.
>>
>> It should be pretty easy to create/destroy child devices as shown
>> above.  The kernel does this all the time.
>>
>>>
>>> But if it allows multiple fpga-* created under one device in one device
>>> driver, it will be much easier to avoid above problems. So I asked if it
>>> is possible to create multiple fpga-* under one parent device,
>>
>> I think it's fine for your FME to create child platform devices.  It's
>> similar to a mfd, but the mfd framework hides the platform devices
>> from the module that creates them, unfortunately.
>>
>>> I feel
>>> this will not impact to current fpga drivers a lot, but provide more
>>> flexibility for drivers to use fpga-region/bridge/manager to create
>>> the topology in a device specific way, especially for non device
>>> tree case.
>>>
>>
>> I would like to see most of this code as FME enumeration code + a mgr
>> driver + a bridge driver + a region driver.  If the FME and the
>> enumeration code can be separate files, so much the better for general
>> usability.
>>
>> The enumeration code can build a set of regions by doing something like this:
>> 1. figure out what type of mgr and bridges your hardware FME has.
>> 2. do platform_device_alloc and platform_device_add to create the mgr
>> device, save a pointer to its platform_device in your FME driver's
>> private data.
>> 2. For each port, create a region and a bridge device.  Save the
>> region's platform device or struct in a list in your FME driver's
>> priv.
>> 3. then you can create the sub function devices.
>
> The above sounds like a poster-child application for MFD. If you do it
> in a clever
> way (i.e. write your platform drivers in a reusable way) you might be able to
> just reuse them on your next generation.

Yes, I played with that with some test code.   I wrote some test code
that allocates dummy mgr and bridge devices using mfd_add_devices().
I didn't see any way of getting access to the devices after creating
them.  Maybe I'm missing something.  Neither the dev nor the
platform_device is saved in the cell struct.

Alan

>
> Cheers,
>
> Moritz
