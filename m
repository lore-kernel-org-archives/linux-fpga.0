Return-Path: <SRS0=5jtu=QT=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=5jtu=QT=linuxfoundation.org=gregkh@kernel.org>
Date: Tue, 12 Feb 2019 08:28:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] of: overlay: validation checks, subsequent fixes for
 v20 -- correction: v4.20
Message-ID: <20190212072821.GA2940@kroah.com>
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
 <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
 <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
 <20190211191341.GA13134@kroah.com>
 <CANk1AXRnX+=v+7g-_rM3TwNmM3aVcOqRknv9BR+hBOeCtT24Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRnX+=v+7g-_rM3TwNmM3aVcOqRknv9BR+hBOeCtT24Fg@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Moritz Fischer <mdf@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Feb 11, 2019 at 02:43:48PM -0600, Alan Tull wrote:
> On Mon, Feb 11, 2019 at 1:13 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 11, 2019 at 12:41:40PM -0600, Alan Tull wrote:
> > > On Fri, Nov 9, 2018 at 12:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > >
> > > What LTSI's are these patches likely to end up in?  Just to be clear,
> > > I'm not pushing for any specific answer, I just want to know what to
> > > expect.
> >
> > I have no idea what you are asking here.
> >
> > What patches?
> 
> I probably should have asked my question *below* the pertinent context
> of the the 17 patches listed in the pull request, which was:
> 
> >       of: overlay: add tests to validate kfrees from overlay removal
> >       of: overlay: add missing of_node_put() after add new node to changeset
> >       of: overlay: add missing of_node_get() in __of_attach_node_sysfs
> >       powerpc/pseries: add of_node_put() in dlpar_detach_node()
> >       of: overlay: use prop add changeset entry for property in new nodes
> >       of: overlay: do not duplicate properties from overlay for new nodes
> >       of: overlay: reorder fields in struct fragment
> >       of: overlay: validate overlay properties #address-cells and #size-cells
> >       of: overlay: make all pr_debug() and pr_err() messages unique
> >       of: overlay: test case of two fragments adding same node
> >       of: overlay: check prevents multiple fragments add or delete same node
> >       of: overlay: check prevents multiple fragments touching same property
> >       of: unittest: remove unused of_unittest_apply_overlay() argument
> >       of: overlay: set node fields from properties when add new overlay node
> >       of: unittest: allow base devicetree to have symbol metadata
> >       of: unittest: find overlays[] entry by name instead of index
> >       of: unittest: initialize args before calling of_*parse_*()
> 
> > What is "LTSI's"?
> 
> I have recently seen some of devicetree patches being picked up for
> the 4.20 stable-queue.  That seemed to suggest that some, but not all
> of these will end up in the next LTS release.

If the git commit has the "cc: stable@" marking in it, yes, it will be
picked up.  Without the actual git ids, it's hard to know what did, and
what did not, get backported :)

> Also I was wondering if any of this is likely to get backported to
> LTSI-4.14.

Note, "LTSI" and "LTS" are two different things.  "LTSI" is a project
run by some LF member companies, and "LTS" are the normal long term
kernels that I release on kernel.org.  They have vastly different
requirements for inclusion in them.

If you have questions about LTSI, I recommend go asking on their mailing
list.

As for showing up in the 4.14 "LTS" kernel, again, I need git commit ids
to know for sure.

Also, as these are now in Linus's tree, you should be able to look at
the stable releases yourself to see if they are present there, right?

thanks,

greg k-h
