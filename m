Return-Path: <robh@kernel.org>
Return-Path: <robh@kernel.org>
MIME-Version: 1.0
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
 <20181018170931.GC15557@bogus> <780fb659-29e8-1ef4-4f62-97dacf36f6c8@gmail.com>
In-Reply-To: <780fb659-29e8-1ef4-4f62-97dacf36f6c8@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 19 Oct 2018 11:10:19 -0500
Message-ID: <CAL_JsqJ+WW2kMHzExMrQvUCAODvOrDW3gTrJzvSUd_3n55oCwA@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Oct 18, 2018 at 2:09 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/18/18 10:09, Rob Herring wrote:
> > On Mon, Oct 15, 2018 at 07:37:24PM -0700, frowand.list@gmail.com wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
> >> added a missing of_node_get() to __of_attach_node_sysfs().  This
> >> results in a refcount imbalance for nodes attached with
> >> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
> >> to __of_attach_node_sysfs() is:
> >>
> >>    dlpar_attach_node()
> >>       of_attach_node()
> >>          __of_attach_node_sysfs()
> >
> > IIRC, there's a long standing item in the todo (Grant's) to convert the
> > open coded dlpar code. Maybe you want to do that first?
>
> I'd like to avoid extra delays to getting the current (with necesary
> fixes) series accepted because the series is rather intrusive and
> could have conflicts with other patches.
>
> I'm also worried that I don't have access to any of the systems that
> use the dynamic overlay code, and I don't have any way to test the
> changes.

Mainly I was thinking you are asking them to test changes now, so I
was thinking better to do that once than twice.

Either way is fine though.

> Can we encourage the users of this code to convert the open coded
> dlpar code?

That would be ideal...

Rob
