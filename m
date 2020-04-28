Return-Path: <SRS0=lCID=6M=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=lCID=6M=intel.com=yilun.xu@kernel.org>
Date: Tue, 28 Apr 2020 13:01:35 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: How to update a piece of flash for FPGA firmware?
Message-ID: <20200428050135.GA27416@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi,

I wonder if an updating of FPGA Flash (but cannot reload) could be
implemented as fpga-mgr?

I have the pcie based FPGA card. The bitstream for FPGA static region is
stored on flash chip. Board will load the bitstream to FPGA on system
power cycle. The flash chip could be accessed through "PCIE -> ... ->
Flash update engine -> Flash". So the update of the FPGA static region is
basicly updating the flash chip through PCIE and rebooting system.

Should I implement the flash update engine as a fpga-mgr device? On one
hand it is just a flash write, FPGA functionality is actually not
changed before reboot. Does fpga-mgr requires bitstream takes function
immediately after write_complete()? On the other hand, the flash write
do affects FPGA static region on next boot. Operating on the
corresponding fpga region makes kernel fully aware of what is being
done.

Actually the FPGA card do has the capability to reload bitstream at
runtime. But it will cause the whole PCIE device lost, static region is
also destroyed. We need to rescan PCI to get it back. So I think
basically this is the same case as system reboot from FPGA's
perspective.

Thanks
Yilun
