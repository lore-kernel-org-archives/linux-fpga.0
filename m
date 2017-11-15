Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171115155324.GG21681@tyrael.ni.corp.natinst.com>
References: <20171017212031.3770-1-atull@kernel.org> <20171115155324.GG21681@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 15 Nov 2017 14:31:25 -0600
Message-ID: <CANk1AXSYyyMUVmzPwGDLhnMgJ_PO-w=-2On0Z84cmidye4gQtQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Enable upper layers using FPGA region w/o device tree
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Nov 15, 2017 at 9:53 AM, Moritz Fischer <mdf@kernel.org> wrote:
> On Tue, Oct 17, 2017 at 04:20:13PM -0500, Alan Tull wrote:
>> * Change the fpga-mgr API to have one fpga_mgr_load function
>>   instead of three.
>>
>> * Separate common FPGA region code from Device Tree support
>>
>> * Expose API functions for FPGA regions
>>
>> * Add API functions for bridges where DT is not used.
>>
>> * clean up drivers/fpga/Kconfig
>>
>> * add attribute groups when registering a fpga manager, bridge, or region.
>>
>> Needed because the current FPGA layer has a couple of problems:
>>
>> * We now have 3 functions for programming a FPGA, depending on whether
>> the image is in a sg list, a buffer, or firmware.  So upper layers
>> have to be written assuming where the image will be or will have to
>> write extra code to maintain flexibility.
>>
>> * users who aren't using device tree are left to write their
>> own code that is essentially a rewrite of FPGA region.
>>
>> v5 changes are small:
>> * add back in fpga_mgr_put in of_fpga_region_remove
>> * make __fpga_bridge_get static
>> * move #ifndef before #includes in headers
>> * Spelling fixes and other nits
>>
>> Alan Tull (18):
>>   fpga: bridge: support getting bridge from device
>>   fpga: mgr: API change to replace fpga load functions with single
>>     function
>>   fpga: mgr: separate getting/locking FPGA manager
>>   fpga: region: use dev_err instead of pr_err
>>   fpga: region: remove unneeded of_node_get and put
>>   fpga: region: get mgr early on
>>   fpga: region: check for child regions before allocing image info
>>   fpga: region: fix slow warning with more than one overlay
>>   fpga: region: use image info as parameter for programming region
>>   fpga: region: separate out code that parses the overlay
>>   fpga: region: add fpga-region.h header
>>   fpga: region: rename some functions prior to moving
>>   fpga: region: add register/unregister functions
>>   fpga: region: add fpga_region_class_find
>>   fpga: region: move device tree support to of-fpga-region.c
>>   fpga: of-fpga-region: accept overlays that don't program FPGA
>>   fpga: clean up fpga Kconfig
>>   fpga: add attribute groups
>
> Anyways, feel free to add my Acked-by's to the series.

Thanks!

> I have tried to /
> done my change with bridge locking on top of this, but it became quickly
> ugly. Let's get this stuff merged, and I'll try with a follow up patch.

Sounds like a plan!  I've asked Greg to take the patchset.  I'll post
v2 of my 'don't use drvdata in FPGA common code' set that goes on top
of it.  I posted a branch to linux-fpga which has both patchsets for
convenience.  Branch name is next-20171113-non-dt-support-v6+v2

Alan
