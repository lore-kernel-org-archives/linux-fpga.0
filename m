Return-Path: <SRS0=wW2w=SM=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=wW2w=SM=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mx25lb.world4you.com ([81.19.149.135]:36402 "EHLO
        mx25lb.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbfDJK43 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 10 Apr 2019 06:56:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Apr 2019 12:30:14 +0200
From: Eric Schwarz <eas@sw-optimization.com>
Subject: Re: Device Description for FPGA Components on x86 system
In-Reply-To: <6563205.xRkLC0driV@pcbe13614>
References: <1629227.alSmCsHHUc@pcbe13614> <6563205.xRkLC0driV@pcbe13614>
Message-ID: <dae0b7ba500cc03fab23956eac85ca79@sw-optimization.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: federico.vaga@cern.ch
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-x86_64@vger.kernel.org, linux-fpga-owner@vger.kernel.org

Hi,

everything you want is already available and on the way to mainline 
concerning support for various FPGA loading modes or available for 
checkout from a git repository.
All that has already been discussed on the mailing list.

FPGA loading interface is available here [1].
Patchset missing for FPGA loading has been sent to the mailing list from 
Anatolij Gustschin for various Linux kernel versions. Link to the most 
recent patchset version [2].
FPGA Manager mailing list archive link [3] - Please read up the story 
here around those patches and also the replies of the others.

Cheers
Eric

[1] https://github.com/vdsao/fpga-cfg
[2] https://marc.info/?l=linux-fpga&m=155078072107199&w=2
[3] https://marc.info/?l=linux-fpga

Am 10.04.2019 12:01, schrieb Federico Vaga:

> Hello,
> 
> sorry to push for an answer but I do not want to take the risk of 
> designing
> something useless. I do not know how should I interpret a no-answer.
> 
> If the solution really does not exist today, then I would like to 
> collect
> opinions/arguments/requirements on the topic so that I can write 
> something
> useful not only for CERN but for the entire community.
> 
> Thank you
> 
> On Wednesday, March 27, 2019 6:17:18 PM CEST Federico Vaga wrote:
> 
>> Hello,
>> 
>> I'm looking for guidance
>> 
>> What I have:
>> * Intel x86_64 computer
>> * PCIe card with FPGA on it
>> 
>> What I want to achieve:
>> * load an FPGA bitstream on the card
>> * load a device-tree like description for the FPGA devices contained 
>> in the
>> bitstream
>> 
>> This is achievable on ARM with DeviceTree, overlay-dt, fpga-mgr; but 
>> I'm
>> puzzled about the x86_64 use-case. I'm not able to find recent and 
>> clear
>> information.
>> 
>> Does anyone know if this is doable? Perhaps with ACPI SSDTs overlay? 
>> Or with
>> the DT?
>> 
>> thanks
