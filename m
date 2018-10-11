Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
 <1539151495-8110-1-git-send-email-frowand.list@gmail.com> <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
 <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
 <e32a99a2-1db5-80e6-5022-83cd8fd07180@gmail.com> <bcbba4ca-0656-aa27-c058-064fb7175d38@gmail.com>
In-Reply-To: <bcbba4ca-0656-aa27-c058-064fb7175d38@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 11 Oct 2018 14:33:28 -0500
Message-ID: <CANk1AXSRifmwu1FQRY_hsuqDESEzcMET_hpLNZOeW4QLrUwsdw@mail.gmail.com>
Subject: Re: [PATCH 05.1/16] of:overlay: missing name, phandle, linux,phandle
 in new nodes
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Oct 11, 2018 at 12:39 AM Frank Rowand <frowand.list@gmail.com> wrote:

[resend of my messed up rejected email of a minute ago, sorry]

>
> On 10/10/18 14:03, Frank Rowand wrote:
> > On 10/10/18 13:40, Alan Tull wrote:
> >> On Wed, Oct 10, 2018 at 1:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>
> >>> On 10/09/18 23:04, frowand.list@gmail.com wrote:
> >>>> From: Frank Rowand <frank.rowand@sony.com>
> >>>>
> >>>>
> >>>> "of: overlay: use prop add changeset entry for property in new nodes"
> >>>> fixed a problem where an 'update property' changeset entry was
> >>>> created for properties contained in nodes added by a changeset.
> >>>> The fix was to use an 'add property' changeset entry.
> >>>>
> >>>> This exposed more bugs in the apply overlay code.  The properties
> >>>> 'name', 'phandle', and 'linux,phandle' were filtered out by
> >>>> add_changeset_property() as special properties.  Change the filter
> >>>> to be only for existing nodes, not newly added nodes.
> >>>>
> >>>> The second bug is that the 'name' property does not exist in the
> >>>> newest FDT version, and has to be constructed from the node's
> >>>> full_name.  Construct an 'add property' changeset entry for
> >>>> newly added nodes.
> >>>>
> >>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >>>> ---
> >>>>
> >>>>
> >>>> Hi Alan,
> >>>>
> >>>> Thanks for reporting the problem with missing node names.
> >>>>
> >>>> I was able to replicate the problem, and have created this preliminary
> >>>> version of a patch to fix the problem.
> >>>>
> >>>> I have not extensively reviewed the patch yet, but would appreciate
> >>>> if you can confirm this fixes your problem.
> >>>>
> >>>> I created this patch as patch 17 of the series, but have also
> >>>> applied it as patch 05.1, immediately after patch 05/16, and
> >>>> built the kernel, booted, and verified name and phandle for
> >>>> one of the nodes in a unittest overlay for both cases.  So
> >>>> minimal testing so far on my part.
> >>>>
> >>>> I have not verified whether the series builds and boots after
> >>>> each of patches 06..16 if this patch is applied as patch 05.1.
> >>>>
> >>>> There is definitely more work needed for me to complete this
> >>>> patch because it allocates some more memory, but does not yet
> >>>> free it when the overlay is released.
> >>>>
> >>>> -Frank
> >>>>
> >>>>
> >>>>  drivers/of/overlay.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >>>>  1 file changed, 67 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> >>>> index 0b0904f44bc7..9746cea2aa91 100644
> >>>> --- a/drivers/of/overlay.c
> >>>> +++ b/drivers/of/overlay.c
> >>>> @@ -301,10 +301,11 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >>>>       struct property *new_prop = NULL, *prop;
> >>>>       int ret = 0;
> >>>>
> >>>> -     if (!of_prop_cmp(overlay_prop->name, "name") ||
> >>>> -         !of_prop_cmp(overlay_prop->name, "phandle") ||
> >>>> -         !of_prop_cmp(overlay_prop->name, "linux,phandle"))
> >>>> -             return 0;
> >>>> +     if (target->in_livetree)
> >>>> +             if (!of_prop_cmp(overlay_prop->name, "name") ||
> >>>> +                 !of_prop_cmp(overlay_prop->name, "phandle") ||
> >>>> +                 !of_prop_cmp(overlay_prop->name, "linux,phandle"))
> >>>> +                     return 0;
> >>>
> >>> This is a big hammer patch.
> >>>
> >>> Nobody should waste time reviewing this patch.
> >>
> >> I wasn't clear if you still could use the testing so I did re-run my
> >> test.  This patch adds back some of the missing properties, but the
> >> the kobject names aren't set as dev_name() returns NULL:
> >>
> >> * without this patch some of_node properties don't show up in sysfs:
> >> root@arria10:~# ls
> >> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
> >> clocks            compatible        interrupt-parent  interrupts        reg
> >>
> >> * with this patch, the of_node properties phandle and name are back:
> >> root@arria10:~#  ls
> >> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
> >> clocks            compatible        interrupt-parent  interrupts
> >>  name              phandle           reg
> >
> > Thanks for the testing.  I'll keep chasing after this problem today.

Glad to help!  Thanks for all your work in this area!
> >
> > This is useful data for me as I was not looking under the /sys/bus/...
> > tree that you reported, but was instead looking at /proc/device-tree/...
> > which showed the same type of problem since the overlay I was using
> > does not show up under /sys/bus/...
> >
> > I'll have to create a useful overlay test case that will show up under
> > /sys/bus/...
> >
> > In the meantime, can you send me the base FDT and the overlay FDT for
> > your test case?
>
> I now have a test case that shows the problem under /sys/bus/... so I
> no longer need the base FDT and overlay FDT for your test case.
>
> I have determined the location that sets the name to "<NULL>" but do
> not have the fix yet.  Still working on that.

I understand you're quite busy with all this, but I'm wondering
whether it might be worth it go ahead and make the properties be
kernel objects also at this point.  That would be an improvement for
the case of overlay properties added to non-overlay nodes, so the
lifespan of the overlay property memory can be coupled with the
properties kobj's instead of the node kobj's.

Alan
