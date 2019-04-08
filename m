Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20190402123123.915-1-nava.manne@xilinx.com> <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
 <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
 <d425bd61-238b-f085-f450-d052349878a8@xilinx.com> <20190408165109.GA6459@archbook>
In-Reply-To: <20190408165109.GA6459@archbook>
From: Alan Tull <atull@kernel.org>
Date: Mon, 8 Apr 2019 15:27:02 -0500
Message-ID: <CANk1AXQ5mHr0ZTuRoby3GomKbbQxv8z-O=o83VV=mXTh1aUZZA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Moritz Fischer <mdf@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Apr 8, 2019 at 11:51 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Michal,
>
> On Mon, Apr 08, 2019 at 04:36:15PM +0200, Michal Simek wrote:
> > On 08. 04. 19 16:17, Alan Tull wrote:
> > > On Mon, Apr 8, 2019 at 7:39 AM Nava kishore Manne <navam@xilinx.com> =
wrote:
> > >>
> > >> Hi Alan,
> > >>
> > >> Thanks for look into it and providing the ACK.
> > >> I got one minor comments from Moritz Fischer do you want me fix that=
 issue now or I can fix it later as it=E2=80=99s a minor comment?
> > >
> > > Please fix for Moritz comment.
> > >
> > >> In which kernel version i can expect this driver changes??
> > >
> > > Patch 2/3 and 3/3 are dependent on 1/3 which isn't a drivers/fpga
> > > thing, it's drivers/firmware.
> >
> > I can take it via arm-soc guys if you are ok with that.
> > Just need to have your ack in commits.
> > We have done it like this several times, IIRC reset, nvmem.
>
> I'm fine with you taking it through arm-soc. Alan?

Fine with me!

Alan

> I'll look at the other
> patches.
>
> Thanks,
> Moritz
