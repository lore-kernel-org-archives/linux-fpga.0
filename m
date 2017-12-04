Return-Path: <SRS0=SxHV=DA=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=SxHV=DA=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 4 Dec 2017 11:20:13 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 0/2] of: dynamic: restrict overlay by targets
Message-ID: <20171204192013.GB17574@tyrael.ni.corp.natinst.com>
References: <20171204191357.3211-1-atull@kernel.org>
 <20171204191849.GA17574@tyrael.ni.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171204191849.GA17574@tyrael.ni.corp.natinst.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 04, 2017 at 11:18:49AM -0800, Moritz Fischer wrote:
> On Mon, Dec 04, 2017 at 01:13:55PM -0600, Alan Tull wrote:
> > Restrict which nodes are valid targets for a DT overlay.
> > 
> > Add a flag bit to struct device_node allowing nodes to be marked as
> > valid target for overlays.
> > 
> > A driver that is always intended to handle DT overlays can
> > enable overlays by calling a function for its DT node.
> > 
> > For individual nodes that need to be opened up for a specific use,
> > adding the property "overlay-allowed" enables overlays targeting
> > that node.  I'll need to document the DT property, not sure where
> > specifically.  New file bindings/overlay.txt?
> > 
> > This patchset differs from the RFC:
> > * Added a flag bit and got rid of the whitelist
> > * Renamed the functions that enable a node
> > * Added a DT property
> > 
> > Alan Tull (2):
> >   of: overlay: add flag enabling overlays and enable fpga-region
> >     overlays
> >   of: dynamic: add overlay-allowed DT property
> 
> I think [1/2] and [2/2] are backwards order. If applied like this,
> it won't work. [1/2] uses stuff that gets added in [2/2]

Ignore that, my mailclient is being funny.

Moritz
> 
> > 
> >  drivers/fpga/of-fpga-region.c |  4 ++++
> >  drivers/of/base.c             |  4 ++--
> >  drivers/of/dynamic.c          |  3 +++
> >  drivers/of/fdt.c              |  3 +++
> >  drivers/of/of_private.h       |  2 ++
> >  drivers/of/overlay.c          | 26 ++++++++++++++++++++++++++
> >  include/linux/of.h            | 19 +++++++++++++++++++
> >  7 files changed, 59 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.7.4
> > 
> 
> Moritz
