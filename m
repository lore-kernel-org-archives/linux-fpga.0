Return-Path: <SRS0=Ij0y=IY=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ij0y=IY=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:38325 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeFFPsW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jun 2018 11:48:22 -0400
Received: by mail-lf0-f46.google.com with SMTP id i83-v6so9871514lfh.5
        for <linux-fpga@vger.kernel.org>; Wed, 06 Jun 2018 08:48:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHhAz+j=KBFwc10tFCT1mj1dxtR0LhU3TysPz0fFVuDnUOAm-A@mail.gmail.com>
References: <CAHhAz+grcWVZAOvLL9VBHoPLiDCT3LApJTkE7GchtLA3g4U3NA@mail.gmail.com>
 <c8e47c11-e3f5-589f-3a58-4aa2466cac6d@desy.de> <CAHhAz+j=KBFwc10tFCT1mj1dxtR0LhU3TysPz0fFVuDnUOAm-A@mail.gmail.com>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Wed, 6 Jun 2018 08:48:20 -0700
Message-ID: <CAAtXAHdrOCkv_jA_nMCMa-2dT=V0006xVNELddjV40TkU+2bhA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_pcie=3A_fpga=3A_programme_FPGA_PROM=E2=80=99s?=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: Ludwig Petrosyan <ludwig.petrosyan@desy.de>, linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org

Hi Muni,

On Wed, Jun 6, 2018 at 4:37 AM, Muni Sekhar <munisekharrms@gmail.com> wrote:
> On Wed, Jun 6, 2018 at 4:50 PM, Ludwig Petrosyan
> <ludwig.petrosyan@desy.de> wrote:
>> Hi
>>
>> why You do not use jtagplayer from Xilinx?
>
> Yes, JTAG can be used. But we have a lot many of these FPGA boards,
> using JTAG costs more. And also we want to automate the PROM
> programming.
>
>
>>
>>
>> with best regards
>>
>>
>> Ludwig
>>
>>
>>
>> On 06/06/2018 11:08 AM, Muni Sekhar wrote:
>>>
>>> [ Please keep me in CC as I'm not subscribed to the list]
>>>
>>> Hi All,
>>>
>>> We have a Kintex7 FPGA board connected to Intel Atom PC running Ubuntu
>>> on PCIe bus.

Are you using a Tandem flow? What kind of PROM are we talking about QSPI flash?

Cheers,

Moritz
