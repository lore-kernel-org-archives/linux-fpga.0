Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171204213224.GA3345@tyrael.ni.corp.natinst.com>
References: <1510779112-5517-1-git-send-email-atull@kernel.org>
 <1510779112-5517-2-git-send-email-atull@kernel.org> <20171204213224.GA3345@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 4 Dec 2017 16:03:34 -0600
Message-ID: <CANk1AXQeX96NnDOzwuUc_1LSmc_HbSW+8z_aPhX5q7n1iq=yig@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] fpga: region: don't use drvdata in common fpga code
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 4, 2017 at 3:32 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Wed, Nov 15, 2017 at 02:51:48PM -0600, Alan Tull wrote:
>> Part of patchset that changes the following fpga_*_register
>> functions to not set drvdata:
>> * fpga_region_register.
>> * fpga_mgr_register
>> * fpga_bridge_register
>>
>> The rationale is that setting drvdata is fine for DT based devices
>> that will have one manager, bridge, or region per platform device.
>> However PCIe based devices may have multiple FPGA mgr/bridge/regions
>> under one PCIe device.  Without these changes, the PCIe solution has
>> to create an extra device for each child mgr/bridge/region to hold
>> drvdata.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks!
Alan
