Return-Path: <SRS0=i2hy=WR=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=i2hy=WR=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 21 Aug 2019 10:28:33 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Add sysfs attribute for disabling PCIe link to
 downstream component
Message-ID: <20190821072833.GM19908@lahna.fi.intel.com>
References: <20190529104942.74991-1-mika.westerberg@linux.intel.com>
 <20190703133953.GK128603@google.com>
 <20190703150341.GW2640@lahna.fi.intel.com>
 <20190801215339.GF151852@google.com>
 <20190806101230.GI2548@lahna.fi.intel.com>
 <20190819235245.GX253360@google.com>
 <20190820095820.GD19908@lahna.fi.intel.com>
 <20190820141717.GA14450@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820141717.GA14450@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Aug 20, 2019 at 09:17:17AM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 20, 2019 at 12:58:20PM +0300, Mika Westerberg wrote:
> > On Mon, Aug 19, 2019 at 06:52:45PM -0500, Bjorn Helgaas wrote:
> > > > Right, it looks like we need some sort of flag there anyway.
> > > 
> > > Does this mean you're looking at getting rid of "has_secondary_link",
> > > you think it's impossible, or you think it's not worth trying?
> > 
> > I was of thinking that we need some flag anyway for the downstream port
> > (such as has_secondary_link) that tells us the which side of the port
> > the link is.
> > 
> > > I'm pretty sure we could get rid of it by looking upstream, but I
> > > haven't actually tried it.
> > 
> > So if we are downstream port, look at the parent and if it is also
> > downstream port (or root port) we change the type to upstream port
> > accordingly? That might work.
> 
> If we see a type of PCI_EXP_TYPE_ROOT_PORT or
> PCI_EXP_TYPE_PCIE_BRIDGE, I think we have to assume that's accurate
> (which we already do today -- for those types, we assume the device
> has a secondary link).
> 
> For a device that claims to be PCI_EXP_TYPE_DOWNSTREAM, if a parent
> device exists and is a Downstream Port (Root Port, Switch Downstream
> Port, and I suppose a PCI-to-PCIe bridge (this is basically
> pcie_downstream_port()), this device must actually be acting as a
> PCI_EXP_TYPE_UPSTREAM device.
> 
> If a device claiming to be PCI_EXP_TYPE_UPSTREAM has a parent that is
> PCI_EXP_TYPE_UPSTREAM, this device must actually be a
> PCI_EXP_TYPE_DOWNSTREAM port.
> 
> For PCI_EXP_TYPE_DOWNSTREAM and PCI_EXP_TYPE_UPSTREAM devices that
> don't have parents, we just have to assume they advertise the correct
> type (as we do today).  There are sparc and virtualization configs
> like this.

OK, thanks for the details. I'll try to make patch based on the above.

> > Another option may be to just add a quirk for these ports.
> 
> I don't really like the quirk approach because then we have to rely on
> user reports of something being broken.
> 
> > Only concern for both is that we have functions that rely on the type
> > such as pcie_capability_read_word() so if we change the type do we end
> > up breaking something? I did not check too closely, though.
> 
> I don't think we'll break anything that's not already broken because
> the type will reflect exactly what has_secondary_link now tells us.
> In fact, we might *fix* some things, e.g., pcie_capability_read_word()
> should work better if we fix the type that pcie_downstream_port()
> checks.

Fair enough :)
