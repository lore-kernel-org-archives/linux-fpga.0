Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 24 Jul 2019 17:41:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] FPGA Manager fix for 5.3
Message-ID: <20190724154141.GA3171@kroah.com>
References: <20190724052012.GA3140@archbox>
 <20190724072056.GA27472@kroah.com>
 <20190724145513.GA24455@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724145513.GA24455@archbox>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Jul 24, 2019 at 07:55:13AM -0700, Moritz Fischer wrote:
> On Wed, Jul 24, 2019 at 09:20:56AM +0200, Greg KH wrote:
> > On Tue, Jul 23, 2019 at 10:20:12PM -0700, Moritz Fischer wrote:
> > > The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> > > 
> > >   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fixes-for-5.3
> > > 
> > > for you to fetch changes up to c3aefa0b8f54e8c7967191e546a11019bc060fe6:
> > > 
> > >   fpga-manager: altera-ps-spi: Fix build error (2019-07-23 17:29:17 -0700)
> > > 
> > > ----------------------------------------------------------------
> > > FPGA Manager fixes for 5.3
> > > 
> > > Hi Greg,
> > > 
> > > this is only one (late) bugfix for 5.3 that fixes a build error,
> > > when altera-ps-spi is built as builtin while a dependency is built as a
> > > module.
> > > 
> > > This has been on the list for a while and I've reviewed it.
> > > 
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > 
> > This message is not in the signed tag in the repo, are you sure you make
> > this correctly?  All I see is the first line:
> > 	FPGA Manager fixes for 5.3
> > 
> > And it's a singluar "fix" :)
> 
> Yeah, over the top. I wanted to figure out the workflow with an easy
> example ... and ... learned something again :)
> 
> So basically the message above is what is supposed to go into the tag
> message?

Yes, and then git pull-request takes that and puts it into the message
to send me.

thanks,

greg k-h
