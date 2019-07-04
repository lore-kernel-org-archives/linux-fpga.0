Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 4 Jul 2019 13:04:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 06/15] fpga: dfl: fme: add
 DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
Message-ID: <20190704110449.GC1404@kroah.com>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-7-mdf@kernel.org>
 <20190703180753.GA24723@kroah.com>
 <20190703233058.GA15825@hao-dev>
 <20190704053927.GB347@kroah.com>
 <20190704063106.GA24777@hao-dev>
 <20190704082013.GE6438@kroah.com>
 <20190704085855.GB7391@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704085855.GB7391@hao-dev>
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Zhang Yi Z <yi.z.zhang@intel.com>, Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jul 04, 2019 at 04:58:55PM +0800, Wu Hao wrote:
> > > Hope things could be more clear now. :)
> > 
> > That's nice for the vfio stuff, but you are just a "normal" driver here.
> > You want an ioctl that just does one thing, no arguments, no flags, no
> > anything.  No need for a size argument then at all.  These ioctls don't
> > even need a structure for them!
> > 
> > Don't try to be fancy, it's not needed, it's not like you are running
> > out of ioctl space...
> 
> Thanks a lot for the comments and suggestions.
> 
> That's true, it's a "normal" driver, maybe I overly considered the
> extensibility of it. OK, Let me rework this patch to remove argsz from
> these two ioctls.
> 
> What about the existing ioctls for this driver, they have argsz too.
> shall I prepare another patch to remove them as well?

I am hoping you actually have users for those ioctls in userspace today?
If not, and no one is using them, then yes, please fix those too.

thanks,

greg k-h
