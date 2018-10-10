Return-Path: <SRS0=5255=MW=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=5255=MW=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH 05.1/16] of:overlay: missing name, phandle, linux,phandle
 in new nodes
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
 <1539151495-8110-1-git-send-email-frowand.list@gmail.com>
 <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
 <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <e32a99a2-1db5-80e6-5022-83cd8fd07180@gmail.com>
Date: Wed, 10 Oct 2018 14:03:00 -0700
MIME-Version: 1.0
In-Reply-To: <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/10/18 13:40, Alan Tull wrote:
> On Wed, Oct 10, 2018 at 1:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 10/09/18 23:04, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>>
>>> "of: overlay: use prop add changeset entry for property in new nodes"
>>> fixed a problem where an 'update property' changeset entry was
>>> created for properties contained in nodes added by a changeset.
>>> The fix was to use an 'add property' changeset entry.
>>>
>>> This exposed more bugs in the apply overlay code.  The properties
>>> 'name', 'phandle', and 'linux,phandle' were filtered out by
>>> add_changeset_property() as special properties.  Change the filter
>>> to be only for existing nodes, not newly added nodes.
>>>
>>> The second bug is that the 'name' property does not exist in the
>>> newest FDT version, and has to be constructed from the node's
>>> full_name.  Construct an 'add property' changeset entry for
>>> newly added nodes.
>>>
>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>> ---
>>>
>>>
>>> Hi Alan,
>>>
>>> Thanks for reporting the problem with missing node names.
>>>
>>> I was able to replicate the problem, and have created this preliminary
>>> version of a patch to fix the problem.
>>>
>>> I have not extensively reviewed the patch yet, but would appreciate
>>> if you can confirm this fixes your problem.
>>>
>>> I created this patch as patch 17 of the series, but have also
>>> applied it as patch 05.1, immediately after patch 05/16, and
>>> built the kernel, booted, and verified name and phandle for
>>> one of the nodes in a unittest overlay for both cases.  So
>>> minimal testing so far on my part.
>>>
>>> I have not verified whether the series builds and boots after
>>> each of patches 06..16 if this patch is applied as patch 05.1.
>>>
>>> There is definitely more work needed for me to complete this
>>> patch because it allocates some more memory, but does not yet
>>> free it when the overlay is released.
>>>
>>> -Frank
>>>
>>>
>>>  drivers/of/overlay.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++----
>>>  1 file changed, 67 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>> index 0b0904f44bc7..9746cea2aa91 100644
>>> --- a/drivers/of/overlay.c
>>> +++ b/drivers/of/overlay.c
>>> @@ -301,10 +301,11 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>>       struct property *new_prop = NULL, *prop;
>>>       int ret = 0;
>>>
>>> -     if (!of_prop_cmp(overlay_prop->name, "name") ||
>>> -         !of_prop_cmp(overlay_prop->name, "phandle") ||
>>> -         !of_prop_cmp(overlay_prop->name, "linux,phandle"))
>>> -             return 0;
>>> +     if (target->in_livetree)
>>> +             if (!of_prop_cmp(overlay_prop->name, "name") ||
>>> +                 !of_prop_cmp(overlay_prop->name, "phandle") ||
>>> +                 !of_prop_cmp(overlay_prop->name, "linux,phandle"))
>>> +                     return 0;
>>
>> This is a big hammer patch.
>>
>> Nobody should waste time reviewing this patch.
> 
> I wasn't clear if you still could use the testing so I did re-run my
> test.  This patch adds back some of the missing properties, but the
> the kobject names aren't set as dev_name() returns NULL:
> 
> * without this patch some of_node properties don't show up in sysfs:
> root@arria10:~# ls
> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
> clocks            compatible        interrupt-parent  interrupts        reg
> 
> * with this patch, the of_node properties phandle and name are back:
> root@arria10:~#  ls
> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
> clocks            compatible        interrupt-parent  interrupts
>  name              phandle           reg

Thanks for the testing.  I'll keep chasing after this problem today.

This is useful data for me as I was not looking under the /sys/bus/...
tree that you reported, but was instead looking at /proc/device-tree/...
which showed the same type of problem since the overlay I was using
does not show up under /sys/bus/...

I'll have to create a useful overlay test case that will show up under
/sys/bus/...

In the meantime, can you send me the base FDT and the overlay FDT for
your test case?

Thanks,

Frank


> 
> root@arria10:~# cat
> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node/name
> freeze_controllerroot@arria10:~#  ("freeze_controller" w/o the \n so
> the name is correct)
> 
> * with or without the patch I see the behavior I reported yesterday,
> kobj names are NULL.
> root@arria10:~# ls /sys/bus/platform/drivers/altera_freeze_br/
> bind             ff200450.<NULL>  uevent           unbind
> 
> root@arria10:~# ls /sys/bus/platform/drivers/altera_gpio/
> bind             ff200010.<NULL>  ff200020.<NULL>  ff200030.<NULL>
> uevent           unbind
> 
> Alan
> 
> Alan
> 
>>
>> The following part should not be needed (though the above section might have
>> to become _slightly_ more complex).
>>
>> -Frank
>>>
>>>       if (target->in_livetree)
>>>               prop = of_find_property(target->np, overlay_prop->name, NULL);
>>> @@ -443,10 +444,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
>>>               struct target *target, const struct device_node *overlay_node)
>>>  {
>>>       struct device_node *child;
>>> -     struct property *prop;
>>> +     struct property *prop, *name_prop;
>>> +     bool has_name = false;
>>>       int ret;
>>>
>>>       for_each_property_of_node(overlay_node, prop) {
>>> +             if (!strcmp(prop->name, "name"))
>>> +                     has_name = true;
>>>               ret = add_changeset_property(ovcs, target, prop, 0);
>>>               if (ret) {
>>>                       pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
>>> @@ -455,6 +459,57 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
>>>               }
>>>       }
>>>
>>> +     /*
>>> +      * With FDT version 0x10 we may not have the name property,
>>> +      * recreate it here from the unit name if absent
>>> +      */
>>> +
>>> +     if (!has_name) {
>>> +             const char *p = target->np->full_name, *ps = p, *pa = NULL;
>>> +             int len;
>>> +
>>> +             /*
>>> +              * zzz
>>> +              * TODO: stash name_prop on a list in ovcs, to be freed
>>> +              * after overlay removed
>>> +              */
>>> +
>>> +             while (*p) {
>>> +                     if ((*p) == '@')
>>> +                             pa = p;
>>> +                     else if ((*p) == '/')
>>> +                             ps = p + 1;
>>> +                     p++;
>>> +             }
>>> +
>>> +             if (pa < ps)
>>> +                     pa = p;
>>> +             len = (pa - ps) + 1;
>>> +
>>> +             name_prop = kmalloc(sizeof(*name_prop), GFP_KERNEL);
>>> +             if (!name_prop)
>>> +                     return -ENOMEM;
>>> +
>>> +             name_prop->name = kstrdup("name", GFP_KERNEL);
>>> +             name_prop->value = kmalloc(len, GFP_KERNEL);
>>> +             if (!name_prop->name || !name_prop->value) {
>>> +                     ret = -ENOMEM;
>>> +                     goto err_free_name_prop;
>>> +             }
>>> +
>>> +             memcpy(name_prop->value, ps, len - 1);
>>> +             ((char *)name_prop->value)[len - 1] = 0;
>>> +
>>> +             name_prop->length = strlen(name_prop->value) + 1;
>>> +
>>> +             ret = add_changeset_property(ovcs, target, name_prop, 0);
>>> +             if (ret) {
>>> +                     pr_debug("Failed to apply name_prop @%pOF/%s, err=%d\n",
>>> +                              target->np, name_prop->name, ret);
>>> +                     goto err_free_name_prop;
>>> +             }
>>> +     }
>>> +
>>>       for_each_child_of_node(overlay_node, child) {
>>>               ret = add_changeset_node(ovcs, target, child);
>>>               if (ret) {
>>> @@ -466,6 +521,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
>>>       }
>>>
>>>       return 0;
>>> +
>>> +err_free_name_prop:
>>> +     kfree(name_prop->name);
>>> +     kfree(name_prop->value);
>>> +     kfree(name_prop);
>>> +     return ret;
>>> +
>>>  }
>>>
>>>  /*
>>>
>>
> 
