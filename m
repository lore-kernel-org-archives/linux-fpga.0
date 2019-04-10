Return-Path: <SRS0=wW2w=SM=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=wW2w=SM=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:33934
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728553AbfDJMud (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Apr 2019 08:50:33 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>
Subject: Re: Device Description for FPGA Components on x86 system
Date: Wed, 10 Apr 2019 14:50:05 +0200
Message-ID: <31100498.IIhqzTXyFT@pcbe13614>
In-Reply-To: <dae0b7ba500cc03fab23956eac85ca79@sw-optimization.com>
References: <1629227.alSmCsHHUc@pcbe13614> <6563205.xRkLC0driV@pcbe13614> <dae0b7ba500cc03fab23956eac85ca79@sw-optimization.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Eric Schwarz <eas@sw-optimization.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-x86_64@vger.kernel.org, linux-fpga-owner@vger.kernel.org

Hi,

P.S. sorry if I'm too verbose, hopefully it is useful

thanks for the answer

On Wednesday, April 10, 2019 12:30:14 PM CEST Eric Schwarz wrote:
> Hi,
> 
> everything you want is already available and on the way to mainline
> concerning support for various FPGA loading modes or available for
> checkout from a git repository.
> All that has already been discussed on the mailing list.
> 
> FPGA loading interface is available here [1].
> Patchset missing for FPGA loading has been sent to the mailing list from
> Anatolij Gustschin for various Linux kernel versions. Link to the most
> recent patchset version [2].
> FPGA Manager mailing list archive link [3] - Please read up the story
> here around those patches and also the replies of the others.

This does not answer the problem, which perhaps need to be clarified.

Loading FPGA is **not** the problem, I listed it in the things I want to 
achieve because it is a pre-requirement for the real problem and because the 
two processes are linked (or could be).

I continue by commenting myself below, trying to make the use case clearer.

> 
> Cheers
> Eric
> 
> [1] https://github.com/vdsao/fpga-cfg
> [2] https://marc.info/?l=linux-fpga&m=155078072107199&w=2
> [3] https://marc.info/?l=linux-fpga
> 
> Am 10.04.2019 12:01, schrieb Federico Vaga:
> > Hello,
> > 
> > sorry to push for an answer but I do not want to take the risk of
> > designing
> > something useless. I do not know how should I interpret a no-answer.
> > 
> > If the solution really does not exist today, then I would like to
> > collect
> > opinions/arguments/requirements on the topic so that I can write
> > something
> > useful not only for CERN but for the entire community.
> > 
> > Thank you
> > 
> > On Wednesday, March 27, 2019 6:17:18 PM CEST Federico Vaga wrote:
> >> Hello,
> >> 
> >> I'm looking for guidance
> >> 
> >> What I have:
> >> * Intel x86_64 computer
> >> * PCIe card with FPGA on it
> >> 
> >> What I want to achieve:
> >> * load an FPGA bitstream on the card
> >> * load a device-tree like description for the FPGA devices contained
> >> in the bitstream

Let me first elaborate on my knowledge to avoid misunderstandings.

On ARM, nowadays, we boot with a device tree. Later we program an FPGA in 
which there are other devices described by a device tree overlay. This can be 
done easily.

A typical PC (x86/x86_64) does not boot with DeviceTree (it is possible, but 
it is not common and probably not even suggested, not sure), instead it uses 
ACPI.

The FPGA Manager has support only for DeviceTree (there are patching floating 
around to load a bitstream with configfs, debugfs or a chardevice (guilty))

Most drivers foresee a DeviceTree loading but not an ACPI one (my feeling, I 
did not extract exact numbers from the sources)

DeviceTree overlay requires that the system boots with DeviceTree.

DeviceTree and ACPI do not work together

So, this is the state of art that I am aware of. Correct me if, and where, I 
am wrong.


Restarting from this point. I have a PC (x86_64) with a PCIe FPGA card (e.g. 
sis8160, spec, links below). How to load the FPGA bitstream (not really a 
problem as you correctly pointed out) **and** load all the IP-core instances 
in that FPGA bitstream so that drivers will start running?

- Is there a recommendation for such use case?
- ACPI SSDT overlay? 
- DT overlay?
- is there a standard way to load FPGA IP-core devices which is architecture 
independent?

A simple and practical example. The i2c-ocore.c is a platform_driver for an 
HDL I2C Master from open cores. I synthesize it and then load it on the FPGA. 
How to create the Linux platform_device instance to driver that IP-core? How 
to do that when you have also IRQ controller(s), DMA engine(s), EEPROM(s) and 
other devices?

The fastest solution is to do what was common on ARM systems: having all 
platform devices declared (hard coded) in a file and load them. Which is not a 
good solution, for the same reasons why arm stuff moved to devicetree.

Is it clearer?

I do not know if it important to highlight but those cards are extensible, 
potentially any FMC module could be plugged and this needs a different FPGA, 
with different FPGA devices etc. So, It is not possible to hardcode the 
description of all possible FPGA code (infinite) that can enable the usage of 
all possible FMC module (not infinite, but definitively grater than 1)


https://www.struck.de/sis8160.html
https://ohwr.org/project/spec/wikis/home


> >> 
> >> This is achievable on ARM with DeviceTree, overlay-dt, fpga-mgr; but
> >> I'm
> >> puzzled about the x86_64 use-case. I'm not able to find recent and
> >> clear
> >> information.
> >> 
> >> Does anyone know if this is doable? Perhaps with ACPI SSDTs overlay?
> >> Or with
> >> the DT?
> >> 
> >> thanks
