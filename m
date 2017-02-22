Return-Path: <SRS0=KGx0=2D=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=KGx0=2D=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 22 Feb 2017 14:04:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] fpga: Add flag to indicate bitstream needs
 decrypting
Message-ID: <20170222130408.GC15769@kroah.com>
References: <1487624123-13579-1-git-send-email-mdf@kernel.org>
 <928f959d-fc36-ba5d-95ba-990dd1927489@xilinx.com>
 <CANk1AXQ6Tf3MtHV2_iJ8cHxG71HYehQbZfcuKgK9124zCpS-nA@mail.gmail.com>
 <CANk1AXR3RK3na3h+EgPAcfjS2+4QRSqCZVKcJWHS=adcrpe=4w@mail.gmail.com>
 <20170222071505.GA9412@kroah.com>
 <b2b3980e-89df-435b-4047-ac2cff35cae5@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b3980e-89df-435b-4047-ac2cff35cae5@xilinx.com>
To: Michal Simek <michal.simek@xilinx.com>
Cc: Alan Tull <delicious.quinoa@gmail.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Feb 22, 2017 at 09:22:19AM +0100, Michal Simek wrote:
> On 22.2.2017 08:15, Greg Kroah-Hartman wrote:
> > On Tue, Feb 21, 2017 at 12:26:17PM -0600, Alan Tull wrote:
> >> On Tue, Feb 21, 2017 at 10:35 AM, Alan Tull <delicious.quinoa@gmail.com>
> >>
> >> Hi Greg,
> >>
> >> Would it be helpful for us to resend patches for you to take with you
> >> on cc?  Or is it enough that they are on lkml?
> > 
> > Yes, please send patches with your signed-off-by: for what I should
> > take.
> 
> Does it make sense to have git repo in MAINTAINERS file then?
> 
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git

Why not, that doesn't mean that's where they get pulled from, but
rather, where the latest version of the patches can be found at.

thanks,

greg k-h
