Return-Path: <SRS0=QIa4=SK=xilinx.com=michals@kernel.org>
Return-Path: <SRS0=QIa4=SK=xilinx.com=michals@kernel.org>
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
 <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <d425bd61-238b-f085-f450-d052349878a8@xilinx.com>
Date: Mon, 8 Apr 2019 16:36:15 +0200
MIME-Version: 1.0
In-Reply-To: <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>, Nava kishore Manne <navam@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "ARM/FREESCALE IMX / MXC ARM ARCHITECTURE  <linux-arm-kernel@lists.infradead.org>, linux-kernel" <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On 08. 04. 19 16:17, Alan Tull wrote:
> On Mon, Apr 8, 2019 at 7:39 AM Nava kishore Manne <navam@xilinx.com> wrote:
>>
>> Hi Alan,
>>
>> Thanks for look into it and providing the ACK.
>> I got one minor comments from Moritz Fischer do you want me fix that issue now or I can fix it later as it’s a minor comment?
> 
> Please fix for Moritz comment.
> 
>> In which kernel version i can expect this driver changes??
> 
> Patch 2/3 and 3/3 are dependent on 1/3 which isn't a drivers/fpga
> thing, it's drivers/firmware.

I can take it via arm-soc guys if you are ok with that.
Just need to have your ack in commits.
We have done it like this several times, IIRC reset, nvmem.

Thanks,
Michal
