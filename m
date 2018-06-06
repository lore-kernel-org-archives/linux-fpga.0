Return-Path: <SRS0=Ij0y=IY=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ij0y=IY=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:34380 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeFFLhp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jun 2018 07:37:45 -0400
MIME-Version: 1.0
In-Reply-To: <c8e47c11-e3f5-589f-3a58-4aa2466cac6d@desy.de>
References: <CAHhAz+grcWVZAOvLL9VBHoPLiDCT3LApJTkE7GchtLA3g4U3NA@mail.gmail.com>
 <c8e47c11-e3f5-589f-3a58-4aa2466cac6d@desy.de>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Wed, 6 Jun 2018 17:07:44 +0530
Message-ID: <CAHhAz+j=KBFwc10tFCT1mj1dxtR0LhU3TysPz0fFVuDnUOAm-A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_pcie=3A_fpga=3A_programme_FPGA_PROM=E2=80=99s?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
Cc: linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org

On Wed, Jun 6, 2018 at 4:50 PM, Ludwig Petrosyan
<ludwig.petrosyan@desy.de> wrote:
> Hi
>
> why You do not use jtagplayer from Xilinx?

Yes, JTAG can be used. But we have a lot many of these FPGA boards,
using JTAG costs more. And also we want to automate the PROM
programming.


>
>
> with best regards
>
>
> Ludwig
>
>
>
> On 06/06/2018 11:08 AM, Muni Sekhar wrote:
>>
>> [ Please keep me in CC as I'm not subscribed to the list]
>>
>> Hi All,
>>
>> We have a Kintex7 FPGA board connected to Intel Atom PC running Ubuntu
>> on PCIe bus.
>> We are looking for a tool to allow us to remotely programme FPGA
>> PROM=E2=80=99s via the Intel Atom PC on PCIe bus. Does any one already d=
one
>> this or can someone share the ideas?
>>
>>
>>
>



--=20
Thanks,
Sekhar
