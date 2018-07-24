Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com> <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 24 Jul 2018 13:52:30 -0500
Message-ID: <CANk1AXQ7RH6gwjNMQSXJZ=wCrwTGZ+T6uVgOsb6N+YJ2Y6zR8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
Content-Type: text/plain; charset="UTF-8"
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, navam@xilinx.com, michals@xilinx.com, linux-fpga@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jul 24, 2018 at 9:17 AM, Appana Durga Kedareswara rao
<appana.durga.rao@xilinx.com> wrote:

Hi Appana,

Another minor thing.

> +
> +/****************************************************************************/

Let's keep the coding style consistent by not having
'***************************'

> +/**
> + *

Also, you don't need /** followed by '*', just take out the
essentially blank line here, please.

> + * Generates a Type 2 packet header that reads back the requested Configuration
> + * register.
> + *
> + * @param        OpCode is the read/write operation code.
> + * @param        Size is the size of the word to be read.
> + *
> + * @return       Type 2 packet header to read the specified register
> + *
> + * @note         None.
> + *
> + *****************************************************************************/
> +static int zynq_type2_pkt(u8 OpCode, u32 Size)
> +{

Thanks,
Alan
