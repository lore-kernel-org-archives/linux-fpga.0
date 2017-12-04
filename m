Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171128031519.GA25705@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-9-git-send-email-hao.wu@intel.com> <f5ae8e5edf88420e89cfbe754407b92e@AcuMS.aculab.com>
 <20171128031519.GA25705@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Mon, 4 Dec 2017 13:46:59 -0600
Message-ID: <CANk1AXRBEcz5_j+v0oTAXfH10hrPbHGabdR8Pqt07exYxYgfCw@mail.gmail.com>
Subject: Re: [PATCH v3 08/21] fpga: add Intel FPGA DFL PCIe device
Content-Type: text/plain; charset="UTF-8"
To: Wu Hao <hao.wu@intel.com>
Cc: David Laight <David.Laight@aculab.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "luwei.kang@intel.com" <luwei.kang@intel.com>, "yi.z.zhang@intel.com" <yi.z.zhang@intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Nov 27, 2017 at 9:15 PM, Wu Hao <hao.wu@intel.com> wrote:
> On Mon, Nov 27, 2017 at 10:28:04AM +0000, David Laight wrote:
>> From: Wu Hao
>> > Sent: 27 November 2017 06:42
>> > From: Zhang Yi <yi.z.zhang@intel.com>
>> >
>> > The Intel FPGA device appears as a PCIe device on the system. This patch
>> > implements the basic framework of the driver for Intel PCIe device which
>> > is located between CPU and Accelerated Function Units (AFUs), and has
>> > the Device Feature List (DFL) implemented in its MMIO space.
>>
>> This ought to have a better name than 'Intel FPGA'.
>> An fpga can be used for all sorts of things, this looks like
>> a very specific architecture using a common VHDL environment to
>> allow certain types of user VHDL be accessed over PCIe.
>
> Hi David
>
> This patch adds a pcie device driver for Intel FPGA devices which implements
> the DFL, e.g Intel Server Platform with In-package FPGA and Intel FPGA PCIe
> Acceleration Cards. They are pcie devices, and all have DFL implemented in
> the MMIO space, so we would like to use one kernel driver to handle them.
>
> With this full patchset, it just provides user the interfaces to configure
> and access the FPGA accelerators on Intel DFL based FPGA devices. For sure,
> users can develop and build their own logics via tools provided by Intel,
> program them to accelerators on these Intel FPGA devices, and access them
> for their workloads.

I don't see anything Intel specific here.  This could all be named dfl-*

Alan

>
> Thanks
> Hao
