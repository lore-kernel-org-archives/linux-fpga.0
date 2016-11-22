Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 22 Nov 2016 09:07:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as co-maintainer to fpga mgr
 framework.
Message-ID: <20161122080713.GB22441@kroah.com>
References: <1479764942-14321-1-git-send-email-mdf@kernel.org>
 <1479764942-14321-2-git-send-email-mdf@kernel.org>
 <alpine.DEB.2.20.1611212021050.3633@atull-VirtualBox2>
 <47eb36a7-ee48-53bd-fbdc-15225c3147ec@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47eb36a7-ee48-53bd-fbdc-15225c3147ec@xilinx.com>
To: Michal Simek <michal.simek@xilinx.com>
Cc: atull <atull@opensource.altera.com>, Moritz Fischer <moritz.fischer@ettus.com>, linux-kernel@vger.kernel.org, marex@denx.de, mbrugger@suse.com, jgunthorpe@obsidianresearch.com, mike.looijmans@topic.nl, linux-arm-kernel@lists.infradead.org, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Nov 22, 2016 at 08:48:57AM +0100, Michal Simek wrote:
> On 22.11.2016 03:29, atull wrote:
> > On Mon, 21 Nov 2016, Moritz Fischer wrote:
> > 
> >> Add myself as co-maintainer to fpga mgr framework.
> >>
> >> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> >> Cc: Alan Tull <atull@opensource.altera.com>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-fpga@vger.kernel.org
> >> ---
> >> Hi all,
> >>
> >> Lately we've fallen behind a bit on reviewing patches lately.
> > 
> > Hi Moritz,
> > 
> > drivers/fpga has been in the upstream kernel a year now.  Most of that
> > time, traffic has been very slow.  Recently we had more traffic while
> > I was travelling and moving to a new office, both cases leaving me
> > with bad network connectivity.  Things will probably return to normal.
> > I appreciate your passion and all your effort reviewing stuff.  I
> > don't see a need for two maintainers at this point.
> 
> TBH. I think it is not a bad option. I do normally have backup person
> for all repos I do maintain. It doesn't mean that second maintainer does
> something but it has all accesses to repos you maintain.
> It means if something really happens to you (hopefully not) than this
> person can continue in this work without any delay which is not a bad
> thing.
> It is really just about talking to each other what that second person
> will do - probably just review patches as is done now. You can also
> learn from each other.
> I would like to be involved more in this but unfortunately I don't have
> enough time to do it properly.
> 
> Regarding maintaining this repo. It is just standard process. Apply
> sensible things, well described and test it. And then send pull request
> to Greg based on signed tags and you are done.
> Greg should told you what should be the base which you should use for
> pull request. Someone is taking patches based on rc1 tag, someone is
> rebasing it on the final tag.

Greg doesn't care what base you use, as long as you don't rebase
patches.  What subsystem does that?  I need to go yell at someone...

And I take patches just as easily, what ever works best for the
subsystem.

thanks,

greg k-h
