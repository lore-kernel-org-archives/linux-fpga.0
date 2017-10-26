Return-Path: <SRS0=QyZJ=BZ=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=QyZJ=BZ=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 26 Oct 2017 00:08:21 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v5 13/18] fpga: region: add register/unregister functions
Message-ID: <20171026070821.GA2461@tyrael.ni.corp.natinst.com>
References: <20171017212031.3770-1-atull@kernel.org>
 <20171017212031.3770-14-atull@kernel.org>
 <1F870B2EBF7EE147840708BE00416263C61FD3@dggemi508-mbs.china.huawei.com>
 <20171022094306.GA24055@tyrael.ni.corp.natinst.com>
 <1F870B2EBF7EE147840708BE00416263C63435@dggemi508-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1F870B2EBF7EE147840708BE00416263C63435@dggemi508-mbs.china.huawei.com>
To: majiuyue <majiuyue@huawei.com>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Jiuyue,

On Thu, Oct 26, 2017 at 02:14:56AM +0000, majiuyue wrote:
> Hi Moritz,
> 
> Sorry for the late reply, because I'm still trying to figure out the differences between a device-tree based system and a pcie base system.
> 
> In my mind, the main differences between them are:
> 
>   - In a of_* based system, the kernel will create platform_device objects for all of_node when system is boot up.
>     Because these platform_device(s) are already there, a driver only need to match them and do the probe/register works.
> 
>   - But, for pcie based system, it is the driver's responsibility to discover all the sub-features/sub-devices for a pci_dev.
>     So the driver have the right to decide how to construct the device hierarchy below the parent pci_dev.
>     We (the fpga framework) should not make any restrictions/assumptions on this, such as:
>       * "fpga_mgr/region/bridge are stored in pdev->driver_data" --> the pci driver may use it to store private data
>       * "try_module_get(dev->parent->driver->owner)" --> the mgr/region/bridge's parent driver may not exist, because they are registered by parent's parent driver.
> 
> So I'm not agree with your point:
> 
> >
> >This step doesn't seem to crazy to me, because most likely you wanna be able to have region specific behavior on a per subdevice basis?
> >

You are right, I had misunderstood what you where trying to do.
> 
> And surely, we are very glad to share our usecase to the fpga framework and make it better :)
> 

Sounds good,
> 
> Thanks.
> 
> ----
> Jiuyue

Cheers,

Moritz
