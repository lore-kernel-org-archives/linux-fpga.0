Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com> <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
In-Reply-To: <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 11 Feb 2019 12:41:40 -0600
Message-ID: <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
Subject: Re: [GIT PULL] of: overlay: validation checks, subsequent fixes for
 v20 -- correction: v4.20
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Moritz Fischer <mdf@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Nov 9, 2018 at 12:58 AM Frank Rowand <frowand.list@gmail.com> wrote:

What LTSI's are these patches likely to end up in?  Just to be clear,
I'm not pushing for any specific answer, I just want to know what to
expect.

Thanks,
Alan

>
> On 11/8/18 10:56 PM, Frank Rowand wrote:
> > Hi Rob,
> >
> > Please pull the changes to add the overlay validation checks.
> >
> > This is the v7 version of the patch series.
> >
> > -Frank
> >
> >
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> >
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git tags/kfree_validate_v7-for-4.20
> >
> > for you to fetch changes up to eeb07c573ec307c53fe2f6ac6d8d11c261f64006:
> >
> >   of: unittest: initialize args before calling of_*parse_*() (2018-11-08 22:12:37 -0800)
> >
> > ----------------------------------------------------------------
> > Add checks to (1) overlay apply process and (2) memory freeing
> > triggered by overlay release.  The checks are intended to detect
> > possible memory leaks and invalid overlays.
> >
> > The checks revealed bugs in existing code.  Fixed the bugs.
> >
> > While fixing bugs, noted other issues, which are fixed in
> > separate patches.
> >
> > ----------------------------------------------------------------
> > Frank Rowand (17):
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
> >
> >  arch/powerpc/platforms/pseries/dlpar.c             |   2 +
> >  drivers/of/dynamic.c                               |  59 ++++-
> >  drivers/of/kobj.c                                  |   4 +-
> >  drivers/of/overlay.c                               | 292 ++++++++++++++++-----
> >  drivers/of/unittest-data/Makefile                  |   2 +
> >  .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
> >  .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
> >  drivers/of/unittest-data/overlay_base.dts          |   1 +
> >  drivers/of/unittest.c                              |  96 +++++--
> >  include/linux/of.h                                 |  21 +-
> >  10 files changed, 432 insertions(+), 97 deletions(-)
> >  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
> >
>
