Date: Wed, 29 Apr 2020 20:12:12 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: How to update a piece of flash for FPGA firmware?
Message-ID: <20200430031210.GA6168@epycbox.lan>
References: <20200428050135.GA27416@yilunxu-OptiPlex-7050>
 <alpine.LFD.2.21.2004281434001.59524@psera2-dell24.ra.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.2004281434001.59524@psera2-dell24.ra.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Matthew, Yilun

On Tue, Apr 28, 2020 at 03:06:07PM -0700, matthew.gerlach@linux.intel.com wrote:
> Hi Yilun,
> 
> You raise some very interesting questions. Please see
> my comments below.
> 
> Matthew
> 
> On Tue, 28 Apr 2020, Xu Yilun wrote:
> 
> > Hi,
> > 
> > I wonder if an updating of FPGA Flash (but cannot reload) could be
> > implemented as fpga-mgr?
> > 
> > I have the pcie based FPGA card. The bitstream for FPGA static region is
> > stored on flash chip. Board will load the bitstream to FPGA on system
> > power cycle. The flash chip could be accessed through "PCIE -> ... ->
> > Flash update engine -> Flash". So the update of the FPGA static region is
> > basicly updating the flash chip through PCIE and rebooting system.
> 
> I think you mean power cycle when you say "rebooting system" above, but
> your point is worth highlighting.  During this flash update the
> FPGA is actually fully configured and running its application.  Typically,
> during a fpga-mgr update of the static region or partial reconfiguration
> region, the actual contents of the fpga region is "changing" during the
> update.

Yeah, this sounds more like a flash driver with MTD or maybe NVMEM?
That's probably how I'd do it. Depending on your (Q)SPI controller you
might already have a driver for that, and you'd just have to instantiate
it as a sub-device.

> 
> > 
> > Should I implement the flash update engine as a fpga-mgr device? On one
> > hand it is just a flash write, FPGA functionality is actually not
> > changed before reboot. Does fpga-mgr requires bitstream takes function
> > immediately after write_complete()? On the other hand, the flash write
> > do affects FPGA static region on next boot. Operating on the
> > corresponding fpga region makes kernel fully aware of what is being
> > done.
> 
> When an fpga-mgr is used in a device tree overlay flow, one gains
> the benefit the enumeration of the nodes in the overlay after the
> update has completed.

I'm not sure how to model 'on next reboot' part.
> 
> > 
> > Actually the FPGA card do has the capability to reload bitstream at
> > runtime. But it will cause the whole PCIE device lost, static region is
> > also destroyed. We need to rescan PCI to get it back. So I think
> > basically this is the same case as system reboot from FPGA's
> > perspective.
> 
> Yes, on those cards that have the ability to power cycle themselves (i.e.
> fully reconfigure the FPGA from flash), the PCIe connection to the card
> is broken because of a surprise link down PCIe error.  As you say a PCI
> rescan (i.e. re-enumeration of the entire card) is required.  Since
> the card has to be re-scanned at the PCI level anyway, there may not be much
> benefit to using the fpga-mgr in this flow.

Agreed.
> 
> I wonder if these kinds of more disruptive updates are better suited to
> something firmware updates rather than fpga updates?

Yeah.

Cheers,
Moritz
