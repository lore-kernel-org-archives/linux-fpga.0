Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171026070821.GA2461@tyrael.ni.corp.natinst.com>
References: <20171017212031.3770-1-atull@kernel.org> <20171017212031.3770-14-atull@kernel.org>
 <1F870B2EBF7EE147840708BE00416263C61FD3@dggemi508-mbs.china.huawei.com>
 <20171022094306.GA24055@tyrael.ni.corp.natinst.com> <1F870B2EBF7EE147840708BE00416263C63435@dggemi508-mbs.china.huawei.com>
 <20171026070821.GA2461@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 26 Oct 2017 16:28:48 -0500
Message-ID: <CANk1AXRMnvGjB505nWaXO_rSSTWtVbQTGvaaHe50F9YzKjyj7A@mail.gmail.com>
Subject: Re: [PATCH v5 13/18] fpga: region: add register/unregister functions
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: majiuyue <majiuyue@huawei.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Oct 26, 2017 at 2:08 AM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Jiuyue,

> Hi Jiuyue,
>
> On Thu, Oct 26, 2017 at 02:14:56AM +0000, majiuyue wrote:
>> Hi Moritz,
>>
>> Sorry for the late reply, because I'm still trying to figure out the differences between a device-tree based system and a pcie base system.
>>
>> In my mind, the main differences between them are:
>>
>>   - In a of_* based system, the kernel will create platform_device objects for all of_node when system is boot up.
>>     Because these platform_device(s) are already there, a driver only need to match them and do the probe/register works.
>>
>>   - But, for pcie based system, it is the driver's responsibility to discover all the sub-features/sub-devices for a pci_dev.
>>     So the driver have the right to decide how to construct the device hierarchy below the parent pci_dev.
>>     We (the fpga framework) should not make any restrictions/assumptions on this, such as:
>>       * "fpga_mgr/region/bridge are stored in pdev->driver_data" --> the pci driver may use it to store private data

I'll have to look at this more.  The code that uses drvdata that way
may need to move out of the fpga-bridge/mgr/region framework register
functions to the calling probe functions.

Alan

>>
>> So I'm not agree with your point:
>>
>> >
>> >This step doesn't seem to crazy to me, because most likely you wanna be able to have region specific behavior on a per subdevice basis?
>> >
>
> You are right, I had misunderstood what you where trying to do.
>>
>> And surely, we are very glad to share our usecase to the fpga framework and make it better :)
>>
>
> Sounds good,
>>
>> Thanks.
>>
>> ----
>> Jiuyue
>
> Cheers,
>
> Moritz
