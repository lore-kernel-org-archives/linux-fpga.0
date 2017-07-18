Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <BE8371DA886269458E0220A16DC1F8277E058300@SHSMSX104.ccr.corp.intel.com>
References: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
 <1498441938-14046-13-git-send-email-hao.wu@intel.com> <CANk1AXRD8eUSmcdJ9ZXpGDE=HVvxgFJyCMKSfGpJeD6a4TgCmg@mail.gmail.com>
 <BE8371DA886269458E0220A16DC1F8277E058300@SHSMSX104.ccr.corp.intel.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 18 Jul 2017 09:33:59 -0500
Message-ID: <CANk1AXTL-G589ysWrW2zvHMUSm8ADh=KwVHBpGR10Dt_Z1Ox3Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/22] fpga: intel: fme: add header sub feature support
Content-Type: text/plain; charset="UTF-8"
To: "Wu, Hao" <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, "Whisonant, Tim" <tim.whisonant@intel.com>, "Luebbers, Enno" <enno.luebbers@intel.com>, "Rao, Shiva" <shiva.rao@intel.com>, "Rauer, Christopher" <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Jul 17, 2017 at 8:17 PM, Wu, Hao <hao.wu@intel.com> wrote:
>> On Sun, Jun 25, 2017 at 8:52 PM, Wu Hao <hao.wu@intel.com> wrote:
>>
>> Hi Hao,
>>
>> I'm making my way through this (very large) patchset.  Some minor
>> comments below.
>>
>
> Hi Alan
>
> Thanks for your review. : )

Hi Hao,

Thanks, this looks good and will be helpful for folks who are new to this.

Alan

>
>> > From: Kang Luwei <luwei.kang@intel.com>
>> >
>> > The header register set is always present for FPGA Management Engine (FME),
>> > this patch implements init and uinit function for header sub feature and
>> > introduce several read-only sysfs interfaces for the capability and status.
>> >
>> > Sysfs interfaces:
>> > * /sys/class/fpga/<fpga.x>/<intel-fpga-fme.x>/ports_num
>> >   Read-only. Number of ports implemented
>> >
>> > * /sys/class/fpga/<fpga.x>/<intel-fpga-fme.x>/bitstream_id
>> >   Read-only. Blue Bitstream identifier number
>>
>> Blue and Green bitstreams are an Intel implementation terminology.  I
>> see that you've defined them in drivers/fpga, but it will be helpful
>> to add in "static region" and "partial reconfiguration region" added
>> in any API documentation files that use the green/blue terminology to
>> keep it accessible.
>>
>
> Sure, thanks for your suggestion, will update it like this.
>
> * /sys/class/fpga/<fpga.x>/<intel-fpga-fme.x>/bitstream_id
>   Read-only. Blue Bitstream (static FPGA region) identifier number
>
> * /sys/class/fpga/<fpga.x>/<intel-fpga-fme.x>/bitstream_metadata
>   Read-only. Blue Bitstream (static FPGA region) meta data
>
>> >
>> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
>> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
>> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
>> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
>> > Signed-off-by: Kang Luwei <luwei.kang@intel.com>
>> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>> > Signed-off-by: Wu Hao <hao.wu@intel.com>
>> > ---
>> > v2: add sysfs documentation
>> > ---
>> >  .../ABI/testing/sysfs-platform-intel-fpga-fme      | 19 ++++++++
>> >  drivers/fpga/intel-feature-dev.h                   |  3 ++
>> >  drivers/fpga/intel-fme-main.c                      | 55 ++++++++++++++++++++++
>> >  3 files changed, 77 insertions(+)
>> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-fpga-
>> fme
>> >
>> > diff --git a/Documentation/ABI/testing/sysfs-platform-intel-fpga-fme
>> b/Documentation/ABI/testing/sysfs-platform-intel-fpga-fme
>> > new file mode 100644
>> > index 0000000..783cfa9
>> > --- /dev/null
>> > +++ b/Documentation/ABI/testing/sysfs-platform-intel-fpga-fme
>> > @@ -0,0 +1,19 @@
>> > +What:          /sys/bus/platform/devices/intel-fpga-fme.0/ports_num
>> > +Date:          June 2017
>> > +KernelVersion:  4.12
>> > +Contact:       Wu Hao <hao.wu@intel.com>
>> > +Description:   Read-only. One Intel FPGA device may have more than 1
>> > +               port/Accelerator Function Unit (AFU). It returns the
>> > +               number of ports on the FPGA device when read it.
>> > +
>> > +What:          /sys/bus/platform/devices/intel-fpga-fme.0/bitstream_id
>> > +Date:          June 2017
>> > +KernelVersion:  4.12
>> > +Contact:       Wu Hao <hao.wu@intel.com>
>> > +Description:   Read-only. It returns Blue Bitstream identifier number.
>>
>> Here
>
> Will update this patch as below.
>
> +Description:   Read-only. It returns Blue Bitstream (static FPGA region)
> +               identifier number.
>
>>
>> > +
>> > +What:          /sys/bus/platform/devices/intel-fpga-fme.0/bitstream_meta
>> > +Date:          June 2017
>> > +KernelVersion:  4.12
>> > +Contact:       Wu Hao <hao.wu@intel.com>
>> > +Description:   Read-only. It returns Blue Bitstream meta data.
>>
>> And here
>
> Will update this patch as below.
>
> +Description:   Read-only. It returns Blue Bitstream (static FPGA region)
> +               meta data.
>
> Thanks
> Hao
