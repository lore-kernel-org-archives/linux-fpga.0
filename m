Return-Path: <michal.simek@xilinx.com>
Return-Path: michal.simek@xilinx.com
Subject: Re: [PATCH 2/2] fpga: Add support for Xilinx LogiCORE PR Decoupler
References: <1489181435-3151-1-git-send-email-mdf@kernel.org>
 <1489181435-3151-2-git-send-email-mdf@kernel.org>
 <CAAtXAHe-AMq9Ux2LZZEWLcg8Dk6jTiHhrot4RhEVrxTBhnLE0g@mail.gmail.com>
 <2f21aeb3-dd4e-e170-729a-a785077b6f28@xilinx.com>
 <CAJYdmeM+OkvNHtXR7o7R7s418Q52KGDFH5B-oKWeMq-tkmwW2Q@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <b9823c9d-ca7e-a420-2a63-fc76a2b3a379@xilinx.com>
Date: Tue, 14 Mar 2017 07:40:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAJYdmeM+OkvNHtXR7o7R7s418Q52KGDFH5B-oKWeMq-tkmwW2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Moritz Fischer <moritz.fischer.private@gmail.com>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-fpga@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "Mark Rutland  <mark.rutland@arm.com>, linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Devicetree List <devicetree@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On 13.3.2017 17:18, Moritz Fischer wrote:
> On Mon, Mar 13, 2017 at 3:27 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> Hi Moritz,
>>
>> On 10.3.2017 23:42, Moritz Fischer wrote:
>>> On Fri, Mar 10, 2017 at 1:30 PM, Moritz Fischer <mdf@kernel.org> wrote:
>>>> This adds support for the Xilinx LogiCORE PR Decoupler
>>>> soft-ip that does decoupling of PR regions in the FPGA
>>>> fabric during partial reconfiguration.
>>>>
>>>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>>> Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: devicetree@vger.kernel.org
>>>> ---
>>>>  drivers/fpga/Kconfig               |   9 +++
>>>>  drivers/fpga/Makefile              |   1 +
>>>>  drivers/fpga/xilinx-pr-decoupler.c | 156 +++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 166 insertions(+)
>>>>  create mode 100644 drivers/fpga/xilinx-pr-decoupler.c
>>
>> I have written very similar driver some week ago but didn't sent it out.
> 
> Hah. I'll take a look.
> 
>> Here it is.
>> https://github.com/Xilinx/linux-xlnx/blob/master/drivers/fpga/xilinx-pr-decoupler.c
>>
>> Your clk handling is better and my enable_show is better.
>> You shouldn't rely on setting status before. It is better to read that
>> reg again. The reason is you can connect status signal from one PR
>> decoupler to decouple input which can change status
> 
> I will just merge them together and add you to author's list if that's
> fine with you?

sure. Go ahead.

> 
>> There is another topic I wanted to open in connection to this. There
>> should be gpio based bridge because this pr decoupler can be without axi
>> interface and for that gpio driver would be useful.
> 
> That's a good idea. I can look at that. This can be pretty generic
> code I suppose.

yes - it should be. Simple gpio driver with polarity support should be
enough.

Thanks,
Michal
