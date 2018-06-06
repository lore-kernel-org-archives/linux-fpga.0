Return-Path: <SRS0=Ij0y=IY=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ij0y=IY=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:40191 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933589AbeFFRKs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jun 2018 13:10:48 -0400
MIME-Version: 1.0
In-Reply-To: <CAAtXAHdrOCkv_jA_nMCMa-2dT=V0006xVNELddjV40TkU+2bhA@mail.gmail.com>
References: <CAHhAz+grcWVZAOvLL9VBHoPLiDCT3LApJTkE7GchtLA3g4U3NA@mail.gmail.com>
 <c8e47c11-e3f5-589f-3a58-4aa2466cac6d@desy.de> <CAHhAz+j=KBFwc10tFCT1mj1dxtR0LhU3TysPz0fFVuDnUOAm-A@mail.gmail.com>
 <CAAtXAHdrOCkv_jA_nMCMa-2dT=V0006xVNELddjV40TkU+2bhA@mail.gmail.com>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Wed, 6 Jun 2018 22:40:47 +0530
Message-ID: <CAHhAz+gDvU9o2bpts=M0inJmrAxJfuspSz1QCqRZBC2_Bo5s6Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_pcie=3A_fpga=3A_programme_FPGA_PROM=E2=80=99s?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Ludwig Petrosyan <ludwig.petrosyan@desy.de>, linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org

On Wed, Jun 6, 2018 at 9:18 PM, Moritz Fischer <moritz.fischer@ettus.com> w=
rote:
> Hi Muni,
>
> On Wed, Jun 6, 2018 at 4:37 AM, Muni Sekhar <munisekharrms@gmail.com> wro=
te:
>> On Wed, Jun 6, 2018 at 4:50 PM, Ludwig Petrosyan
>> <ludwig.petrosyan@desy.de> wrote:
>>> Hi
>>>
>>> why You do not use jtagplayer from Xilinx?
>>
>> Yes, JTAG can be used. But we have a lot many of these FPGA boards,
>> using JTAG costs more. And also we want to automate the PROM
>> programming.
>>
>>
>>>
>>>
>>> with best regards
>>>
>>>
>>> Ludwig
>>>
>>>
>>>
>>> On 06/06/2018 11:08 AM, Muni Sekhar wrote:
>>>>
>>>> [ Please keep me in CC as I'm not subscribed to the list]
>>>>
>>>> Hi All,
>>>>
>>>> We have a Kintex7 FPGA board connected to Intel Atom PC running Ubuntu
>>>> on PCIe bus.
>
> Are you using a Tandem flow? What kind of PROM are we talking about QSPI =
flash?
I'm not sure about the Tandem flow, can you please clarify me on this?

Okay, we have two onboard PROM=E2=80=99s (Micron=E2=80=99s SPI NOR Flash MT=
25QL128).
The FPGA will be loaded from one of the two onboard PROM=E2=80=99s, it will=
 be
up and running before the PC powers up.
When the Intel Atom PC powers up the FPGA will enumerate over PCIe.
I'm looking for any available Linux tool(user space or kernel space)
to program the PROM's via PCIe interface.


>
> Cheers,
>
> Moritz



--=20
Thanks,
Sekhar
