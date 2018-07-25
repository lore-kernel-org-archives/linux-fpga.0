Return-Path: <SRS0=HJlN=KJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=HJlN=KJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728694AbeGYRqx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 25 Jul 2018 13:46:53 -0400
MIME-Version: 1.0
In-Reply-To: <CANk1AXRewvAAxRi=kmCNL3CEki9ODk7LvLS6q8Hd64JRanyfew@mail.gmail.com>
References: <5553262.evi6GU8epL@pcbe13614> <CANk1AXRewvAAxRi=kmCNL3CEki9ODk7LvLS6q8Hd64JRanyfew@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 25 Jul 2018 11:33:44 -0500
Message-ID: <CANk1AXRYAPMgvFo-oLEz0-WwUstTvKD5f0_5NkvKzEO3K1=f2Q@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_free usage
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: federico.vaga@cern.ch
Cc: linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, Jul 11, 2018 at 10:59 AM, Alan Tull <atull@kernel.org> wrote:
> On Wed, Jul 11, 2018 at 7:38 AM, Federico Vaga <federico.vaga@cern.ch> wrote:
>
> Hi Federico,
>
>> Hi Alan,
>>
>> I have another point that I would like to discuss. It is about the
>> usage of 'fpga_mgr_free()' which does not look like consistent.
>>
>> This function, according to the current implementation, can be used by
>> an FPGA manager user and it is used by the FPGA manager itself on
>> device release. This means that the user can only use this function if
>> fpga_mgr_register() fails (to clean up), otherwise the user must NOT
>> use this function, otherwise we most likely get an oops (NULL or
>> invalid pointer). The example here is correct, this is what we should
>> do:
>>
>> https://www.kernel.org/doc/html/latest/driver-api/fpga/fpga-mgr.html
>>
>> But I suggest to document it better or prevent this type of mistakes
>> from happening. Following a couple of proposals
>>
>> ------
>> 1.
>> Document it better. This is easy, in the fpga_mgr_free() kernel-doc
>> comment we explain that the use of this function must be limited to
>> clean up the memory on a registration failure. If an FPGA manager has
>> been successfully registered then it will be freed by the framework
>> itself.

As I was researching this, I remembered why I implemented it this way.
  See below for that explanation.

It looks like I'm going to switch to option 1 here and add more
documentation for both fpga_mgr_free() and fpga_mgr_unregister().
Note that fpga_mgr_unregister() already says that that it frees the
manager, and the usage example already does the right thing, but I'll
add more words to really beat the message in.

>>
>> But still, this does not prevent an oops from happening.
>> ------
>> 2.
>> Remove the fpga_mgr_free() from fpga_mgr_dev_release() and ask the
>> user to free the manager when necessary.
>>
>> This makes the usage consistent: the user creates and destroy its own
>> objects. This is also consistent with our other discussion where we
>> said, among the other things, that the module that uses the FPGA
>> manager can the owner of the fpga_manager data structure.
>
> You're not the first to complain about this.  I think I'll err on the
> side of consistency and implement your option 2 here.
>
> Alan

If you write a class or create a device, the kernel wants a release
function and will give a warning if you leave it out.  The warning is
"Device 'fpga0' does not have a release() function, it is broken and
must be fixed." and comes from drivers/base/core.c.

I will add some more documentation to make it clear that once a a
mgr/bridge/region has been registered, the cleanup will be handled
automatically when the device goes away.  Until the
fpga_(mgr|bridge|region)_register succeeds, the caller still needs to
do cleanup.

I did find one bug while looking at this.  I'll post some patches.

Full message was:
root@cyclone5:~# rmmod socfpga
[   48.206235] fpga_manager fpga0: fpga_mgr_unregister Altera SOCFPGA
FPGA Manager
[   48.213677] ------------[ cut here ]------------
[   48.218312] WARNING: CPU: 1 PID: 1369 at
/home/atull/repos/linux-socfpga/drivers/base/core.c:895
device_release+0x9c/0xa0
[   48.229293] Device 'fpga0' does not have a release() function, it
is broken and must be fixed.
[   48.237904] Modules linked in: socfpga(-) altera_hps2fpga fpga_mgr
fpga_bridge [last unloaded: fpga_region]
[   48.247659] CPU: 1 PID: 1369 Comm: rmmod Not tainted
4.18.0-rc5-next-20180717-00012-ge5f548e-dirty #3
[   48.256843] Hardware name: Altera SOCFPGA
[   48.260858] [<c01137ac>] (unwind_backtrace) from [<c010dc04>]
(show_stack+0x20/0x24)
[   48.268582] [<c010dc04>] (show_stack) from [<c07d448c>]
(dump_stack+0x8c/0xa0)
[   48.275786] [<c07d448c>] (dump_stack) from [<c0123bc0>] (__warn+0x104/0x11c)
[   48.282810] [<c0123bc0>] (__warn) from [<c0123c2c>]
(warn_slowpath_fmt+0x54/0x70)
[   48.290269] [<c0123c2c>] (warn_slowpath_fmt) from [<c052c9cc>]
(device_release+0x9c/0xa0)
[   48.298418] [<c052c9cc>] (device_release) from [<c07d904c>]
(kobject_put+0xa8/0xe0)
[   48.306047] [<c07d904c>] (kobject_put) from [<c052ec3c>]
(device_unregister+0x2c/0x30)
[   48.313939] [<c052ec3c>] (device_unregister) from [<bf01262c>]
(fpga_mgr_unregister+0x58/0x74 [fpga_mgr])
[   48.323475] [<bf01262c>] (fpga_mgr_unregister [fpga_mgr]) from
[<bf02b01c>] (socfpga_fpga_remove+0x1c/0x24 [socfpga])
[   48.334047] [<bf02b01c>] (socfpga_fpga_remove [socfpga]) from
[<c0534be8>] (platform_drv_remove+0x34/0x4c)
[   48.343664] [<c0534be8>] (platform_drv_remove) from [<c0532f64>]
(device_release_driver_internal+0x180/0x230)
[   48.353538] [<c0532f64>] (device_release_driver_internal) from
[<c0533090>] (driver_detach+0x58/0xa0)
[   48.362720] [<c0533090>] (driver_detach) from [<c0531bf8>]
(bus_remove_driver+0x5c/0xb4)
[   48.370781] [<c0531bf8>] (bus_remove_driver) from [<c0533a70>]
(driver_unregister+0x38/0x58)
[   48.379186] [<c0533a70>] (driver_unregister) from [<c0534cd0>]
(platform_driver_unregister+0x1c/0x20)
[   48.388370] [<c0534cd0>] (platform_driver_unregister) from
[<bf02b688>] (socfpga_fpga_driver_exit+0x18/0x990 [socfpga])
[   48.399113] [<bf02b688>] (socfpga_fpga_driver_exit [socfpga]) from
[<c01ad948>] (sys_delete_module+0x1a0/0x1f0)
[   48.409164] [<c01ad948>] (sys_delete_module) from [<c0101000>]
(ret_fast_syscall+0x0/0x54)
[   48.417391] Exception stack(0xee6dbfa8 to 0xee6dbff0)
[   48.422424] bfa0:                   0001dce0 beba4be0 0001dd1c
00000800 0000000a 80080000
[   48.430568] bfc0: 0001dce0 beba4be0 00000000 00000081 0001c22c
00000000 00000001 beba4dcc
[   48.438708] bfe0: b6ecdd00 beba4b9c 00012b43 b6ecdd0c
[   48.443773] ---[ end trace bcf003ed0f464330 ]---

Alan
