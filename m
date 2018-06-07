Return-Path: <SRS0=sWxv=IZ=gmail.com=munisekharrms@kernel.org>
Return-Path: <SRS0=sWxv=IZ=gmail.com=munisekharrms@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180606201903.GA1459@archbook>
References: <CAHhAz+grcWVZAOvLL9VBHoPLiDCT3LApJTkE7GchtLA3g4U3NA@mail.gmail.com>
 <c8e47c11-e3f5-589f-3a58-4aa2466cac6d@desy.de> <CAHhAz+j=KBFwc10tFCT1mj1dxtR0LhU3TysPz0fFVuDnUOAm-A@mail.gmail.com>
 <CAAtXAHdrOCkv_jA_nMCMa-2dT=V0006xVNELddjV40TkU+2bhA@mail.gmail.com>
 <CAHhAz+gDvU9o2bpts=M0inJmrAxJfuspSz1QCqRZBC2_Bo5s6Q@mail.gmail.com> <20180606201903.GA1459@archbook>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Thu, 7 Jun 2018 09:19:53 +0530
Message-ID: <CAHhAz+h-2nKoypFGyJPpfint07Bjy-_SqepxnCD+zYwfuMKnuA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_pcie=3A_fpga=3A_programme_FPGA_PROM=E2=80=99s?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Moritz Fischer <mdf@kernel.org>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Ludwig Petrosyan <ludwig.petrosyan@desy.de>, linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jun 7, 2018 at 1:49 AM, Moritz Fischer <mdf@kernel.org> wrote:
> On Wed, Jun 06, 2018 at 10:40:47PM +0530, Muni Sekhar wrote:
>> On Wed, Jun 6, 2018 at 9:18 PM, Moritz Fischer <moritz.fischer@ettus.com=
> wrote:
>> > Hi Muni,
>> >
>> > On Wed, Jun 6, 2018 at 4:37 AM, Muni Sekhar <munisekharrms@gmail.com> =
wrote:
>> >> On Wed, Jun 6, 2018 at 4:50 PM, Ludwig Petrosyan
>> >> <ludwig.petrosyan@desy.de> wrote:
>> >>> Hi
>> >>>
>> >>> why You do not use jtagplayer from Xilinx?
>> >>
>> >> Yes, JTAG can be used. But we have a lot many of these FPGA boards,
>> >> using JTAG costs more. And also we want to automate the PROM
>> >> programming.
>> >>
>> >>
>> >>>
>> >>>
>> >>> with best regards
>> >>>
>> >>>
>> >>> Ludwig
>> >>>
>> >>>
>> >>>
>> >>> On 06/06/2018 11:08 AM, Muni Sekhar wrote:
>> >>>>
>> >>>> [ Please keep me in CC as I'm not subscribed to the list]
>> >>>>
>> >>>> Hi All,
>> >>>>
>> >>>> We have a Kintex7 FPGA board connected to Intel Atom PC running Ubu=
ntu
>> >>>> on PCIe bus.
>> >
>> > Are you using a Tandem flow? What kind of PROM are we talking about QS=
PI flash?
>> I'm not sure about the Tandem flow, can you please clarify me on this?
>>
>> Okay, we have two onboard PROM=E2=80=99s (Micron=E2=80=99s SPI NOR Flash=
 MT25QL128).
>> The FPGA will be loaded from one of the two onboard PROM=E2=80=99s, it w=
ill be
>> up and running before the PC powers up.
>
> In which case you don't need Tandem. Tandem basically just brings up
> minmal bitstream to bring up PCIe link and does the rest via some sort
> of partial reconfiguration flow. This allows to meet the PCIe deadline.
>
>> When the Intel Atom PC powers up the FPGA will enumerate over PCIe.
>> I'm looking for any available Linux tool(user space or kernel space)
>> to program the PROM's via PCIe interface.
>
> Any reason you can't drop a SPI controller in the fabric and use that
> to program the FPGA or do you intend to do the initial programing of
> the PROM also over PCIe?
No, we use a removeable dongle with a pre-loaded PROM.

>
> - Moritz



--=20
Thanks,
Sekhar
