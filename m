Date: Wed, 29 Apr 2020 20:26:51 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: How to upload fpga firmware
Message-ID: <20200430032649.GB6168@epycbox.lan>
References: <20200422114432.GM1694@pengutronix.de>
 <20200423013648.GA2430@epycbox.lan>
 <20200423062331.GR1694@pengutronix.de>
 <20200425035949.GA11710@epycbox.lan>
 <20200427064433.GH5877@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427064433.GH5877@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Apr 27, 2020 at 08:44:33AM +0200, Sascha Hauer wrote:
> On Fri, Apr 24, 2020 at 08:59:49PM -0700, Moritz Fischer wrote:
> > Hi Sascha,
> > 
> > On Thu, Apr 23, 2020 at 08:23:31AM +0200, Sascha Hauer wrote:
> > > Hi Moritz,
> > > 
> > > On Wed, Apr 22, 2020 at 06:36:48PM -0700, Moritz Fischer wrote:
> > > > Hi Sascha,
> > > > 
> > > > On Wed, Apr 22, 2020 at 01:44:32PM +0200, Sascha Hauer wrote:
> > > > > Hi,
> > > > > 
> > > > > I wonder what can be done with the mainline state of drivers/fpga/. The
> > > > > entry to the framework seems to be fpga_mgr_load(). The only user of
> > > > > this function is fpga_region_program_fpga(). This in turn is only called
> > > > > in response of applying a device tree overlay. A device tree overlay is
> > > > > applied with of_overlay_fdt_apply() which has no users in the Kernel.
> > > > 
> > > > Yes. It is waiting for dt_overlays one way or another. I personally
> > > > don't currently have the bandwidth to work actively on this.
> > > > 
> > > > > My current task is to load a firmware to a FPGA. The code all seems to
> > > > > be there in the Kernel, it only lacks a way to trigger it. I am not very
> > > > > interested in device tree overlays since the FPGA appears as a PCI
> > > > > device (although applying a dtbo could enable the PCIe controller device
> > > > > tree node). Is there some mainline way to upload FPGA firmware? At the
> > > > > moment we are using the attached patch to trigger loading the firmware
> > > > > from userspace. Would something like this be acceptable for mainline?
> > > > 
> > > > We've looked into this sort of patches over the years and never came to
> > > > a general interface that really works.
> > > > 
> > > > The OPAE folks (and other users I know of) usually use FPGA Manager with
> > > > a higher layer on top of it that moves the bitstream into the kernel via
> > > > an ioctl().
> > > > 
> > > > One concept I had toyed with mentally, but haven't really gotten around
> > > > to implement is a 'discoverable' region, that would deal with the
> > > > necessary re-enumeration via a callback and have a sysfs interface
> > > > similar to what the patch below has.
> > > > This would essentially cover use-cases where you have a discoverable
> > > > device implemented in FPGA logic, such as say an FPGA hanging off of
> > > > PCIe bus that can get loaded over USB, a CPLD or some other side-band
> > > > mechanism. After loading the image you'd have to rescan the PCIe bus -
> > > > which - imho is the kernel's job.
> > > > 
> > > > What I really wanna avoid is creating another /dev/fpga0 / /dev/xdevcfg
> > > > that completely leaves the kernel in the dark about the fact that it
> > > > reconfigures a bit of hardware hanging off the bus.
> > > 
> > > Yes, makes sense. While this would suffice my needs at the moment it
> > > really sounds like a dead end.
> > > 
> > > > 
> > > > In my ideal world you'd create a pci driver that binds to your device,
> > > > and creates mfd style subdevices for whatever you'd want your design to
> > > > do. One of these devices would be an FPGA and a FPGA region attached to
> > > > that FPGA manager. Your top level driver would co-ordinate the fact that
> > > > you are re-programming parts of the FPGA and create / destroy devices as
> > > > needed for the hardware contained in the bitstream.
> > > 
> > > In my case there is no pci device visible before loading the firmware,
> > > so creating a pci driver is not an option. Maybe pci host controllers
> > > could register themselves as fpga-bridges. With this we could put the
> > > pci host controller (or the pci device, AFAIK there is a PCI device tree
> > > binding) where the fpga is connected into the fpga-bridges phandles list
> > > of the fpga-region.
> > 
> > Can you talk a bit more about the system you're working with? Is there
> > some sort of sideband mechanism to load the image? What exposes the
> > image loading capaibility? A CPLD, an ASIC, USB device, JTAG?
> 
> We have two systems. One uploads the FPGA firmware via SPI passive
> serial mode (compatible fpga-arria10-passive-serial). The other system
> has a ftdi FT232H USB/serial converter chip working in synchronous FIFO
> mode, connected to the FPGA via a CPLD. The series from Anatolij Gustchin
> here https://patchwork.kernel.org/cover/10824743/ would have been useful
> for us, although of course our CPLD has a different protocol. On this
> system we currently ended up with a small custom driver which bypasses
> FPGA manager and only uploads the firmware at USB connect time.

Yeah this seems imho the only legit use-case for a something like the
sysfs entry for the fpga-region. That being said once we add that, it's
going to become ABI and everyone is gonna use that instead of
implementing a proper driver using FPGA Regions to deal with
re-enumeration.

We don't really have a good way of modelling systems where the bus is
100% discoverable (like a PCI device), but only after we load firmware.

I mean you could implement a FPGA manager for your CPLD that also
instantiates a region that you then target when you want to reprogram
the FPGA region. How you'd tie that together though with the PCI device
to get the bus to be re-enumerated as part of reprogramming the region,
I'm not 100% sure :)

> > It also depends a bit on the use-case: After you program the bitstream,
> > do you need to runtime re-program it? Does it do partial
> > reconfiguration? Are there subdevices inside your device, or is the
> > whole thing a discoverable PCI device afterwards?
> 
> On both systems It's one PCI device only. Currently we don't need runtime
> re-programming, although this might be useful in the future. Also there's
> no partial reconfiguration.
> 

Sorry for the late response, things are busy at the moment.

Cheers,
Moritz
