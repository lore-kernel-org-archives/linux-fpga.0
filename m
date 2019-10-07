Date: Mon, 7 Oct 2019 14:21:00 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v4 1/2] fpga: fpga-mgr: Add readback support
Message-ID: <20191007212058.GA2929169@archbox>
References: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
 <CANk1AXSEWcZ7Oqv5pgpwvJRyyFWk5gPtniXa7T+oe6-uywqEqA@mail.gmail.com>
 <MN2PR02MB6400CD5312983443A67DCC4EDC810@MN2PR02MB6400.namprd02.prod.outlook.com>
 <4476bf39-b665-50d8-fecd-d50687d10ca2@linux.intel.com>
 <20190927182308.GA6797@archbox>
 <f8a9bc07-0705-1318-eba2-8878e839d696@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8a9bc07-0705-1318-eba2-8878e839d696@linux.intel.com>
To: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Appana Durga Kedareswara Rao <appanad@xilinx.com>, Alan Tull <atull@kernel.org>, Michal Simek <michals@xilinx.com>, "kedare06@gmail.com" <kedare06@gmail.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Nava kishore Manne <navam@xilinx.com>, Siva Durga Prasad Paladugu <sivadur@xilinx.com>, Richard Gong <richard.gong@linux.intel.com>, Dinh Nguyen <dinguyen@kernel.org>, agust@denx.de
List-ID: <linux-fpga@vger.kernel.org>

Hi Thor,

On Mon, Oct 07, 2019 at 01:06:51PM -0500, Thor Thayer wrote:
> Hi Moritz,
> 
> On 9/27/19 1:23 PM, Moritz Fischer wrote:
> > Thor,
> > 
> > On Fri, Sep 27, 2019 at 09:32:11AM -0500, Thor Thayer wrote:
> > > Hi Kedar & Moritz,
> > > 
> > > On 9/27/19 12:13 AM, Appana Durga Kedareswara Rao wrote:
> > > > Hi Alan,
> > > > 
> > > > Did you get a chance to send your framework changes to upstream?
> > No they weren't upstreamed.
> > 
> > > > @Moritz Fischer: If Alan couldn't send his patch series, Can we take this patch series??
> > > > Please let me know your thoughts on this.
> > 
> > Alan had some comments RE: #defines, I'll have to take another look.
> > > > 
> > > > Regards,
> > > > Kedar.
> > > 
> > > 
> > > I'd like to see some mechanism added as well. Our CvP driver needs a way to
> > > load images to the FPGA over the PCIe bus.
> > 
> > Can you elaborate a bit on the CvP use-case and how that would work? Who
> > would use the device how after loading the bitstream?
> > 
> > Generally there are several use cases that I have collected mentally
> > over the years:
> > 
> > I) DFL use case:
> >    - Mixed-set of drivers: Kernel and Userspace
> >    - FPGA logic is discoverable through DFL
> >    - Userspace application wants to reprogram FPGA
> > 
> > II) DT configfs use case:
> >    - Mixed-set of drivers: Kernel and Userspace
> >    - FPGA logic is *not* discoverable (hence DT overlay)
> >    - Userspace application wants to reprogram FPGA
> > 
> > III) Thomas' case:
> >    - Kernel only drivers (pcie bridge, pcie drivers, ...)
> >    - FPGA logic is fully discoverable (i.e. PCIe endpoint
> >      implemented in FPGA, connected to SoC via PCIe)
> >    - Userspace application wants to reprogram FPGA
> > 
> > IV) VFIO case:
> >    - Usually exposes either entire device via vfio-pci or part via
> >      vfio-mdev
> >    - Loading (basic) bitstream at boot from flash
> >    - vfio-mdev case can use FPGA region interface + ioctl
> >    - Full VFIO case is similar to III)
> > 
> > How does your CvP use case fit in? Collecting all the use-cases would
> > help with moving forward on coming up with an API :)
> > 
> The CvP case is the same as III) Thomas' case. The FPGA configuration
> bitstream is downloaded over the PCIe.
> 
> The one difference in my case is that there isn't an SoC. This is a Intel
> host processor connecting to a non-SoC Stratix10/Arria10. The non-SoC
> A10/S10, boots a minimal image (CvP) setting up the peripheral pins and
> enabling the PCIe endpoint for CvP downloads.
> 
> The host can then download bitstreams using the FPGA Manager through debugFS
> and when the bitstream finishes downloading and the FPGA enters User Mode,
> the functionality is available for the host to use.

I am generally confused by this driver. How does it work exactly? What
happens after altera-cvp binds a PCI device?

You can use it to download a bitstream (say we had the debugfs
interface), and then what happens next? How do I use the device? It
already has a PCI driver bound to it at that point?

What happens next?

Please tell me that not the only use-case for this is /dev/mem :)

Thomas' use-case is different in that behind the FPGA device there are
actual other *discoverable* PCI devices that will get enumerated and
bind to separate drivers.

Thanks,
Moritz

PS: I'll be out this week on vacation starting tmr so responses might be delayed
