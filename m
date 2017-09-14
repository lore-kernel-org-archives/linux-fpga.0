Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1709140856110.2384@mgerlach-VirtualBox>
References: <20170913204841.2730-1-atull@kernel.org> <20170913204841.2730-18-atull@kernel.org>
 <alpine.DEB.2.20.1709140856110.2384@mgerlach-VirtualBox>
From: Alan Tull <atull@kernel.org>
Date: Thu, 14 Sep 2017 15:41:37 -0500
Message-ID: <CANk1AXQERQxnFqQ8rJCChqJZwuPSLHhF2Dc6=dHzr=gWqtSCvA@mail.gmail.com>
Subject: Re: [PATCH v4 17/18] fpga: clean up fpga Kconfig
Content-Type: text/plain; charset="UTF-8"
To: matthew.gerlach@linux.intel.com
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Sep 14, 2017 at 10:56 AM,  <matthew.gerlach@linux.intel.com> wrote:

Hi Matthew,

>
> Hi Alan,
>
> s/mixxed/mixed/
>

OK, I'll fix that.

Alan

> On Wed, 13 Sep 2017, Alan Tull wrote:
>
>> The fpga menuconfig has gotten messy.  The bridges and managers are
>> mixxed together.
>>
>> * Separate the bridges and things dependent on CONFIG_FPGA_BRIDGE
>>  from the managers.
>> * Group the managers by vendor in order that they were added
>>  to the kernel.
>>
>> The following is what the menuconfig ends up looking like more or less
>> (platform dependencies are hiding some of these on any given
>> platform).
>>
>>    --- FPGA Configuration Framework
>>    <*>   Altera SOCFPGA FPGA Manager
>>    <*>   Altera SoCFPGA Arria10
>>    <*>   Altera Partial Reconfiguration IP Core
>>    <*>     Platform support of Altera Partial Reconfiguration IP Core
>>    <*>   Altera FPGA Passive Serial over SPI
>>    <*>   Altera Arria-V/Cyclone-V/Stratix-V CvP FPGA Manager
>>    <*>   Xilinx Zynq FPGA
>>    <*>   Xilinx Configuration over Slave Serial (SPI)
>>    <*>   Lattice iCE40 SPI
>>    <*>   Technologic Systems TS-73xx SBC FPGA Manager
>>    <*>   FPGA Bridge Framework
>>    <*>     Altera SoCFPGA FPGA Bridges
>>    <*>     Altera FPGA Freeze Bridge
>>    <*>     Xilinx LogiCORE PR Decoupler
>>    <*>     FPGA Region
>>    <*>       FPGA Region Device Tree Overlay Support
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> ---
>> v4: Patch added to patchset in v4
