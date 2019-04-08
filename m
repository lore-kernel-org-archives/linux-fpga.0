Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20190402123123.915-1-nava.manne@xilinx.com> <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com> <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 8 Apr 2019 09:17:51 -0500
Message-ID: <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Nava kishore Manne <navam@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Apr 8, 2019 at 7:39 AM Nava kishore Manne <navam@xilinx.com> wrote:
>
> Hi Alan,
>
> Thanks for look into it and providing the ACK.
> I got one minor comments from Moritz Fischer do you want me fix that issu=
e now or I can fix it later as it=E2=80=99s a minor comment?

Please fix for Moritz comment.

> In which kernel version i can expect this driver changes??

Patch 2/3 and 3/3 are dependent on 1/3 which isn't a drivers/fpga
thing, it's drivers/firmware.

Alan

>
>
> Regards,
> Navakishore.
>
> > -----Original Message-----
> > From: Alan Tull [mailto:atull@kernel.org]
> > Sent: Tuesday, April 2, 2019 11:57 PM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: Moritz Fischer <mdf@kernel.org>; Rob Herring <robh+dt@kernel.org>; =
Mark
> > Rutland <mark.rutland@arm.com>; Michal Simek <michals@xilinx.com>; Raja=
n
> > Vaja <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; linux-
> > fpga@vger.kernel.org; open list:OPEN FIRMWARE AND FLATTENED DEVICE
> > TREE BINDINGS <devicetree@vger.kernel.org>; moderated list:ARM/FREESCAL=
E
> > IMX / MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linu=
x-
> > kernel <linux-kernel@vger.kernel.org>; kishore m
> > <chinnikishore369@gmail.com>
> > Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support f=
or
> > Xilinx zynqmp
> >
> > On Tue, Apr 2, 2019 at 7:32 AM Nava kishore Manne <nava.manne@xilinx.co=
m>
> > wrote:
> >
> > Hi Nava,
> >
> > Looks good.
> >
> > >
> > > This patch adds FPGA Manager support for the Xilinx ZynqMP chip.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > Acked-by: Alan Tull <atull@kernel.org>
> >
> > > ---
> > > Changes for v4:
> > >                 -Updated the Fpga Mgr registrations call's
> > >                  to 5.0
> > >                 -Removed dma_set_mask_and_coherent() As the FW
> > >                  supports only 32-bit address operations.
> > >
> > > Changes for v3:
> > >                 -Created patches on top of 5.0-rc5.
> > >                  No functional changes.
> > >
> > > Changes for v2:
> > >                 -Fixed some minor coding issues as suggested by
> > >                  Moritz
> > >
> > > Changes for v1:
> > >                 -None.
> > >
> > > Changes for RFC-V2:
> > >                 -Updated the Fpga Mgr registrations call's
> > >                  to 4.18
> >
> > Thanks,
> > Alan
