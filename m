Return-Path: <SRS0=tXaj=WQ=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=tXaj=WQ=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 20 Aug 2019 12:58:20 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Add sysfs attribute for disabling PCIe link to
 downstream component
Message-ID: <20190820095820.GD19908@lahna.fi.intel.com>
References: <20190529104942.74991-1-mika.westerberg@linux.intel.com>
 <20190703133953.GK128603@google.com>
 <20190703150341.GW2640@lahna.fi.intel.com>
 <20190801215339.GF151852@google.com>
 <20190806101230.GI2548@lahna.fi.intel.com>
 <20190819235245.GX253360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819235245.GX253360@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Aug 19, 2019 at 06:52:45PM -0500, Bjorn Helgaas wrote:
> > Right, it looks like we need some sort of flag there anyway.
> 
> Does this mean you're looking at getting rid of "has_secondary_link",
> you think it's impossible, or you think it's not worth trying?

I was of thinking that we need some flag anyway for the downstream port
(such as has_secondary_link) that tells us the which side of the port
the link is.

> I'm pretty sure we could get rid of it by looking upstream, but I
> haven't actually tried it.

So if we are downstream port, look at the parent and if it is also
downstream port (or root port) we change the type to upstream port
accordingly? That might work.

Another option may be to just add a quirk for these ports.

Only concern for both is that we have functions that rely on the type
such as pcie_capability_read_word() so if we change the type do we end
up breaking something? I did not check too closely, though.

I'm willing to cook a patch that fixes this once we have some consensus
what it should do ;-)
