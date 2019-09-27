Return-Path: <SRS0=04Uq=XW=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=04Uq=XW=ettus.com=moritz.fischer@kernel.org>
Date: Fri, 27 Sep 2019 11:23:08 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v4 1/2] fpga: fpga-mgr: Add readback support
Message-ID: <20190927182308.GA6797@archbox>
References: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
 <CANk1AXSEWcZ7Oqv5pgpwvJRyyFWk5gPtniXa7T+oe6-uywqEqA@mail.gmail.com>
 <MN2PR02MB6400CD5312983443A67DCC4EDC810@MN2PR02MB6400.namprd02.prod.outlook.com>
 <4476bf39-b665-50d8-fecd-d50687d10ca2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4476bf39-b665-50d8-fecd-d50687d10ca2@linux.intel.com>
To: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Appana Durga Kedareswara Rao <appanad@xilinx.com>, Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, Michal Simek <michals@xilinx.com>, "kedare06@gmail.com" <kedare06@gmail.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Nava kishore Manne <navam@xilinx.com>, Siva Durga Prasad Paladugu <sivadur@xilinx.com>, Richard Gong <richard.gong@linux.intel.com>, Dinh Nguyen <dinguyen@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Thor,

On Fri, Sep 27, 2019 at 09:32:11AM -0500, Thor Thayer wrote:
> Hi Kedar & Moritz,
> 
> On 9/27/19 12:13 AM, Appana Durga Kedareswara Rao wrote:
> > Hi Alan,
> > 
> > Did you get a chance to send your framework changes to upstream?
No they weren't upstreamed.

> > @Moritz Fischer: If Alan couldn't send his patch series, Can we take this patch series??
> > Please let me know your thoughts on this.

Alan had some comments RE: #defines, I'll have to take another look.
> > 
> > Regards,
> > Kedar.
> 
> 
> I'd like to see some mechanism added as well. Our CvP driver needs a way to
> load images to the FPGA over the PCIe bus.

Can you elaborate a bit on the CvP use-case and how that would work? Who
would use the device how after loading the bitstream?

Generally there are several use cases that I have collected mentally
over the years:

I) DFL use case:
  - Mixed-set of drivers: Kernel and Userspace
  - FPGA logic is discoverable through DFL
  - Userspace application wants to reprogram FPGA

II) DT configfs use case:
  - Mixed-set of drivers: Kernel and Userspace
  - FPGA logic is *not* discoverable (hence DT overlay)
  - Userspace application wants to reprogram FPGA

III) Thomas' case:
  - Kernel only drivers (pcie bridge, pcie drivers, ...)
  - FPGA logic is fully discoverable (i.e. PCIe endpoint
    implemented in FPGA, connected to SoC via PCIe)
  - Userspace application wants to reprogram FPGA

IV) VFIO case:
  - Usually exposes either entire device via vfio-pci or part via
    vfio-mdev
  - Loading (basic) bitstream at boot from flash
  - vfio-mdev case can use FPGA region interface + ioctl
  - Full VFIO case is similar to III)

How does your CvP use case fit in? Collecting all the use-cases would
help with moving forward on coming up with an API :)

> 
> It wasn't clear to me from the discussion on Alan's patchset[1] that the
> debugfs was acceptable to the mainline. I'd be happy to resurrect that
> patchset with the suggested changes.

Back then we decided to not move forward with the debugfs patchset since
it's essentially cat foo.bin > /dev/xdevcfg / cat bar.rbf > /dev/fpga0
in disguise. Which is why I vetoed it back then.

> Since debugfs isn't enabled for production, are there any alternatives?
> 
> Alan sent a RFC [2] for loading FIT images through the sysfs.
> 
> The RFC described a FIT image that included FPGA image specific information
> to be included with the image (for systems running without device tree like
> our PCIe bus FPGA CvP).

Yeah I had originally suggested that as a mechanim to make FPGA images
discoverable by the kernel. I still think the idea has merit, however it
will run into the same issues that the configfs interface ran into w.r.t
using dt-overlays.

Generally I'd like to see a solution that exposes the *same* interface
to DT and not DT systems to userspace.

Using FIT headers one could go ahead and design something along the
lines of what DFL is doing, except for instead of parsing the DFL in the
logic, one would parse the FIT header to create subdevices.

> Unfortunately, I believe this has the same uphill battle that the Device
> Tree Overlay patches[3] have to getting accepted.

See above. While I'm happy to discuss this more I atm don't have the
bandwidth to push the DT work any further.

Thanks,
Moritz
