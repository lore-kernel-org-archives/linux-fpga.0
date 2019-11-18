Return-Path: <SRS0=BKog=ZK=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=BKog=ZK=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfKRWu0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 18 Nov 2019 17:50:26 -0500
Date: Mon, 18 Nov 2019 16:50:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: FPGA device behaves strangely with Linux
Message-ID: <20191118225022.GA69921@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJh_itMXcZJ0Qxe1emrRXwYSGmVowm8gqipj6-8i0CNOA@mail.gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Ranran <ranshalit@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>

[+cc Alex, linux-fpga]

Hi Ran, sorry for the delay; I overlooked this until now.

On Mon, Nov 04, 2019 at 04:35:00PM +0200, Ranran wrote:
> Hello,
> 
> I use x86 device with FPGA device.
> The FPGA device acts strangely with Linux, while with vother OS on
> same HW there is no issue.
> The Other PCIe device acts find without any issues.

If I understand correctly, there is no issue with other PCIe devices
in the system, but the FPGA device doesn't work correctly.

How long does it take the FPGA to initialize after reset?

> Doing lspci after reset, sometimes the device appear and other times
> not enumerated at all.

How are you doing the reset?  Writing to "1"  to
/sys/bus/pci/devices/.../reset?  Can you tell what kind of reset we're
doing (maybe you can instrument __pci_reset_function_locked()?)

It's possible we're missing a delay after doing the reset and before
restoring the device state, e.g., before calling pci_dev_restore() in
pci_reset_function().  You could add "msleep(5000)" there to see if it
makes any difference.

If we do config reads or MMIO reads to a device too soon after reset
and the device isn't ready to respond yet, we'll get 0xffffffff data,
which could explain some of what you're seeing.

> After reset it is almost always missing.
> Then I force rescan several times, until it appears in lspci:
> 03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID (rev ff)
> 
> After it appears there is still inconsistency when reading
> configuration BAR with lspci -vv:

What specific inconsistencies are you seeing here?  I see that "lspci
-xx" doesn't show anything in BAR 0, but the "lspci -vv" says it's
"virtual", which means it isn't a real BAR (I can't remember exactly
what it *does* mean, but the lspci source would tell you).

> 03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID
>         Subsystem: Xilinx Corporation Default PCIe endpoint ID
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 255
>         Region 0: [virtual] Memory at 91500000 (32-bit,
> non-prefetchable) [size=1M]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [58] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 1, Latency L0s
> <64ns, L1 <1us
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
> FLReset- SlotPowerLimit 10.000W
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq-
> AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s,
> Exit Latency L0s unlimited
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-00-00
> 
> [root@localhost ~]# lspci -xx -s 03:00.00
> 03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID
> 00: ee 10 07 00 00 00 10 00 00 00 00 05 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 ee 10 07 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> 
> 
> Other tries of reading (without reseting in between):
> =========
> 03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID (rev
> ff) (prog-if ff)
>         !!! Unknown header type 7f
> 
> root@localhost ~]# lspci -xx -s 03:00.00
> 03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID (rev ff)
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> 
> [root@localhost pcimem]# ./pcimem
> /sys/bus/pci/devices/0000\:03\:00.0/resource0  0 w*100
> /sys/bus/pci/devices/0000:03:00.0/resource0 opened.
> Target offset is 0x0, page size is 4096
> mmap(0, 4096, 0x3, 0x1, 3, 0x0)
> PCI Memory mapped to address 0x7faf91256000.
> 0x0000: 0xFFFFFFFF
> ...
> 
> The BIOS is also different between Linux and the other OS on same HW.

Not sure what this means.  Are you saying you need a different BIOS to
run Linux than the BIOS you need for the other OS?

> Any idea what configuration can cause this behavior ?

Most likely the device isn't responding for some reason, and we get ~0
data (0xffffffff) in that error case.

Bjorn
