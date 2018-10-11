Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
 <1539151495-8110-1-git-send-email-frowand.list@gmail.com> <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
 <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
 <e32a99a2-1db5-80e6-5022-83cd8fd07180@gmail.com> <bcbba4ca-0656-aa27-c058-064fb7175d38@gmail.com>
In-Reply-To: <bcbba4ca-0656-aa27-c058-064fb7175d38@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 11 Oct 2018 13:57:02 -0500
Message-ID: <CANk1AXTTjKqnb8OW6HLeMLZm8UE6KeFR1Ehoyvj7oLp6FrZe9A@mail.gmail.com>
Subject: Re: [PATCH 05.1/16] of:overlay: missing name, phandle, linux,phandle
 in new nodes
Content-Type: multipart/alternative; boundary="0000000000007ddeab0577f88b40"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

--0000000000007ddeab0577f88b40
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 11, 2018 at 12:39 AM Frank Rowand <frowand.list@gmail.com>
wrote:

> On 10/10/18 14:03, Frank Rowand wrote:
> > On 10/10/18 13:40, Alan Tull wrote:
> >> On Wed, Oct 10, 2018 at 1:49 AM Frank Rowand <frowand.list@gmail.com>
> wrote:
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
> >>>>  drivers/of/overlay.c | 72
> ++++++++++++++++++++++++++++++++++++++++++++++++----
> >>>>  1 file changed, 67 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> >>>> index 0b0904f44bc7..9746cea2aa91 100644
> >>>> --- a/drivers/of/overlay.c
> >>>> +++ b/drivers/of/overlay.c
> >>>> @@ -301,10 +301,11 @@ static int add_changeset_property(struct
> overlay_changeset *ovcs,
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
> >> clocks            compatible        interrupt-parent  interrupts
> reg
> >>
> >> * with this patch, the of_node properties phandle and name are back:
> >> root@arria10:~#  ls
> >> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
> >> clocks            compatible        interrupt-parent  interrupts
> >>  name              phandle           reg
> >
> > Thanks for the testing.  I'll keep chasing after this problem today.
>

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
>
> -Frank
>

I understand you're quite busy with all this, but I'm wondering whether it
might be worth it go ahead and make the properties be kernel objects also
at this point.  That would be an improvement for the case of overlay
properties added to non-overlay nodes, so the lifespan of the overlay
property memory can be coupled with the properties kobj's instead of the
node kobj's.

Alan

>
>

--0000000000007ddeab0577f88b40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace"><span style=3D"font-family:Arial,Helvetica,sans-serif">On Thu,=
 Oct 11, 2018 at 12:39 AM Frank Rowand &lt;<a href=3D"mailto:frowand.list@g=
mail.com">frowand.list@gmail.com</a>&gt; wrote:</span><br></div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On 10/10/18 14:03, Frank Ro=
wand wrote:<br>
&gt; On 10/10/18 13:40, Alan Tull wrote:<br>
&gt;&gt; On Wed, Oct 10, 2018 at 1:49 AM Frank Rowand &lt;<a href=3D"mailto=
:frowand.list@gmail.com" target=3D"_blank">frowand.list@gmail.com</a>&gt; w=
rote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 10/09/18 23:04, <a href=3D"mailto:frowand.list@gmail.com" t=
arget=3D"_blank">frowand.list@gmail.com</a> wrote:<br>
&gt;&gt;&gt;&gt; From: Frank Rowand &lt;<a href=3D"mailto:frank.rowand@sony=
.com" target=3D"_blank">frank.rowand@sony.com</a>&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &quot;of: overlay: use prop add changeset entry for proper=
ty in new nodes&quot;<br>
&gt;&gt;&gt;&gt; fixed a problem where an &#39;update property&#39; changes=
et entry was<br>
&gt;&gt;&gt;&gt; created for properties contained in nodes added by a chang=
eset.<br>
&gt;&gt;&gt;&gt; The fix was to use an &#39;add property&#39; changeset ent=
ry.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This exposed more bugs in the apply overlay code.=C2=A0 Th=
e properties<br>
&gt;&gt;&gt;&gt; &#39;name&#39;, &#39;phandle&#39;, and &#39;linux,phandle&=
#39; were filtered out by<br>
&gt;&gt;&gt;&gt; add_changeset_property() as special properties.=C2=A0 Chan=
ge the filter<br>
&gt;&gt;&gt;&gt; to be only for existing nodes, not newly added nodes.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The second bug is that the &#39;name&#39; property does no=
t exist in the<br>
&gt;&gt;&gt;&gt; newest FDT version, and has to be constructed from the nod=
e&#39;s<br>
&gt;&gt;&gt;&gt; full_name.=C2=A0 Construct an &#39;add property&#39; chang=
eset entry for<br>
&gt;&gt;&gt;&gt; newly added nodes.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Frank Rowand &lt;<a href=3D"mailto:frank.ro=
wand@sony.com" target=3D"_blank">frank.rowand@sony.com</a>&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Alan,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thanks for reporting the problem with missing node names.<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I was able to replicate the problem, and have created this=
 preliminary<br>
&gt;&gt;&gt;&gt; version of a patch to fix the problem.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I have not extensively reviewed the patch yet, but would a=
ppreciate<br>
&gt;&gt;&gt;&gt; if you can confirm this fixes your problem.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I created this patch as patch 17 of the series, but have a=
lso<br>
&gt;&gt;&gt;&gt; applied it as patch 05.1, immediately after patch 05/16, a=
nd<br>
&gt;&gt;&gt;&gt; built the kernel, booted, and verified name and phandle fo=
r<br>
&gt;&gt;&gt;&gt; one of the nodes in a unittest overlay for both cases.=C2=
=A0 So<br>
&gt;&gt;&gt;&gt; minimal testing so far on my part.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I have not verified whether the series builds and boots af=
ter<br>
&gt;&gt;&gt;&gt; each of patches 06..16 if this patch is applied as patch 0=
5.1.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; There is definitely more work needed for me to complete th=
is<br>
&gt;&gt;&gt;&gt; patch because it allocates some more memory, but does not =
yet<br>
&gt;&gt;&gt;&gt; free it when the overlay is released.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -Frank<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 drivers/of/overlay.c | 72 ++++++++++++++++++++++++++=
++++++++++++++++++++++----<br>
&gt;&gt;&gt;&gt;=C2=A0 1 file changed, 67 insertions(+), 5 deletions(-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c<b=
r>
&gt;&gt;&gt;&gt; index 0b0904f44bc7..9746cea2aa91 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/of/overlay.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/of/overlay.c<br>
&gt;&gt;&gt;&gt; @@ -301,10 +301,11 @@ static int add_changeset_property(st=
ruct overlay_changeset *ovcs,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct property *new_prop =3D NU=
LL, *prop;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (!of_prop_cmp(overlay_prop-&gt;nam=
e, &quot;name&quot;) ||<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!of_prop_cmp(overlay_pr=
op-&gt;name, &quot;phandle&quot;) ||<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!of_prop_cmp(overlay_pr=
op-&gt;name, &quot;linux,phandle&quot;))<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;=
<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (target-&gt;in_livetree)<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!of_p=
rop_cmp(overlay_prop-&gt;name, &quot;name&quot;) ||<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0!of_prop_cmp(overlay_prop-&gt;name, &quot;phandle&quot;) ||<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0!of_prop_cmp(overlay_prop-&gt;name, &quot;linux,phandle&quot;))<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This is a big hammer patch.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Nobody should waste time reviewing this patch.<br>
&gt;&gt;<br>
&gt;&gt; I wasn&#39;t clear if you still could use the testing so I did re-=
run my<br>
&gt;&gt; test.=C2=A0 This patch adds back some of the missing properties, b=
ut the<br>
&gt;&gt; the kobject names aren&#39;t set as dev_name() returns NULL:<br>
&gt;&gt;<br>
&gt;&gt; * without this patch some of_node properties don&#39;t show up in =
sysfs:<br>
&gt;&gt; root@arria10:~# ls<br>
&gt;&gt; /sys/bus/platform/drivers/altera_freeze_br/ff200450.\&lt;NULL\&gt;=
/of_node<br>
&gt;&gt; clocks=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 interrupt-parent=C2=A0 interrupts=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 reg<br>
&gt;&gt;<br>
&gt;&gt; * with this patch, the of_node properties phandle and name are bac=
k:<br>
&gt;&gt; root@arria10:~#=C2=A0 ls<br>
&gt;&gt; /sys/bus/platform/drivers/altera_freeze_br/ff200450.\&lt;NULL\&gt;=
/of_node<br>
&gt;&gt; clocks=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 interrupt-parent=C2=A0 interrupts<br>
&gt;&gt;=C2=A0 name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phandle=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg<br>
&gt; <br>
&gt; Thanks for the testing.=C2=A0 I&#39;ll keep chasing after this problem=
 today.<br></blockquote><div><br></div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace">Glad to help!=C2=A0 Thanks for all you=
r work in this area!</div><div class=3D"gmail_default" style=3D"font-family=
:monospace,monospace"></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; <br>
&gt; This is useful data for me as I was not looking under the /sys/bus/...=
<br>
&gt; tree that you reported, but was instead looking at /proc/device-tree/.=
..<br>
&gt; which showed the same type of problem since the overlay I was using<br=
>
&gt; does not show up under /sys/bus/...<br>
&gt; <br>
&gt; I&#39;ll have to create a useful overlay test case that will show up u=
nder<br>
&gt; /sys/bus/...<br>
&gt; <br>
&gt; In the meantime, can you send me the base FDT and the overlay FDT for<=
br>
&gt; your test case?<br>
<br>
I now have a test case that shows the problem under /sys/bus/... so I<br>
no longer need the base FDT and overlay FDT for your test case.<br>
<br>
I have determined the location that sets the name to &quot;&lt;NULL&gt;&quo=
t; but do<br>
not have the fix yet.=C2=A0 Still working on that.<br>
<br>
-Frank<br></blockquote><div><br></div><div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace,monospace">I understand you&#39;re quite busy w=
ith all this, but I&#39;m wondering whether it might be worth it go ahead a=
nd make the properties be kernel objects also at this point.=C2=A0 That wou=
ld be an improvement for the case of overlay properties added to non-overla=
y nodes, so the lifespan of the overlay property memory can be coupled with=
 the properties kobj&#39;s instead of the node kobj&#39;s.=C2=A0</div><div =
class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div=
><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">Ala=
n</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><br>
</blockquote></div></div>

--0000000000007ddeab0577f88b40--
