Date: Mon, 30 Mar 2020 18:28:22 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [GIT PULL] FPGA Manager changes for 5.7
Message-ID: <20200331012820.GA1492@epycbox.lan>
References: <20200327162944.GA4118@epycbox.lan>
 <20200330141506.GA438143@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330141506.GA438143@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, moritzf@google.com, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Mar 30, 2020 at 04:15:06PM +0200, Greg KH wrote:
> On Fri, Mar 27, 2020 at 09:29:44AM -0700, Moritz Fischer wrote:
> > The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> > 
> >   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-for-5.7
> > 
> > for you to fetch changes up to 3d5a5417ad064a6ca64a33f0c554d917311c79f4:
> > 
> >   fpga: dfl: afu: support debug access to memory-mapped afu regions (2020-03-21 13:14:30 -0700)
> 
> This is too late for 5.7-rc1 as stuff needed to be in my tree last week
> (and not Friday), to give it time to test in linux-next.

Yeah, I realized I'm a bit late ... I figured since they've been already in
linux-next it might be ok. Sorry about that :)
> 
> Care to break this up into two trees, stuff for 5.7-final with bugfixes,
> and stuff for 5.8-rc1?

Sure, will do.

Cheers,
Moritz
