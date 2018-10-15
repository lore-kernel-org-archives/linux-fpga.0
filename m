Return-Path: <SRS0=63Yb=M3=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=63Yb=M3=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v3 09/18] of: overlay: validate overlay properties
 #address-cells and #size-cells
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <1539563070-12969-10-git-send-email-frowand.list@gmail.com>
 <CANk1AXQNkYDA9hRCMR_MkOJiobPjmYoJN8Gv+3YN9ReV+q5XEw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <87525c4a-6c7d-5c1d-1f99-6784f315b89c@gmail.com>
Date: Mon, 15 Oct 2018 13:16:50 -0700
MIME-Version: 1.0
In-Reply-To: <CANk1AXQNkYDA9hRCMR_MkOJiobPjmYoJN8Gv+3YN9ReV+q5XEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/15/18 12:01, Alan Tull wrote:
> On Sun, Oct 14, 2018 at 7:26 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> If overlay properties #address-cells or #size-cells are already in
>> the live devicetree for any given node, then the values in the
>> overlay must match the values in the live tree.
>>
>> If the properties are already in the live tree then there is no
>> need to create a changeset entry to add them since they must
>> have the same value.  This reduces the memory used by the
>> changeset and eliminates a possible memory leak.  This is
>> verified by 12 fewer warnings during the devicetree unittest,
>> as the possible memory leak warnings about #address-cells and
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 272a0d1a5e18..ee66651db553 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
>>   * @target may be either in the live devicetree or in a new subtree that
>>   * is contained in the changeset.
>>   *
>> - * Some special properties are not updated (no error returned).
>> + * Some special properties are not added or updated (no error returned):
>> + * "name", "phandle", "linux,phandle".
>> + *
>> + * Properties "#address-cells" and "#size-cells" are not updated if they
>> + * are already in the live tree, but if present in the live tree, the values
>> + * in the overlay must match the values in the live tree.
>>   *
>>   * Update of property in symbols node is not allowed.
>>   *
>> @@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>  {
>>         struct property *new_prop = NULL, *prop;
>>         int ret = 0;
>> +       bool check_for_non_overlay_node = false;
>>
>>         if (!of_prop_cmp(overlay_prop->name, "name") ||
>>             !of_prop_cmp(overlay_prop->name, "phandle") ||
>> @@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>         if (!new_prop)
>>                 return -ENOMEM;
>>
>> -       if (!prop)
>> +       if (!prop) {
>> +
>> +               check_for_non_overlay_node = true;
>>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
>>                                                 new_prop);
>> -       else
>> +
>> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
>> +
> 
> Hi Frank,
> 
> If we get these ERROR messages, I suggest that this function should
> return an error so the overlay will be rejected.
> 
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> 
>                         *(u32 *)prop->value != *(u32 *)new_prop->value) {
> 
>> +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
>> +                              target->np);
> 
>                        ret = -EINVAL;
>                 }
> 
> Otherwise there is an ERROR message, but it continues trying to apply
> the invalid overlay anyway and I get an oops.  By adding the ret =
> -EINVAL, the overlay gets rejected and the oops is avoided.

Yes, that sounds good.


>> +
>> +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
>> +
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
>> +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
>> +                              target->np);
> 
> Add the ret = -EINVAL here also.  This give me the following (if my
> overlay changes #address-cells):

Yes.


> [   21.167551] OF: overlay: ERROR: overlay and/or live tree
> #address-cells invalid in node /soc/base_fpga_region
> [   21.177442] OF: overlay: add_changeset_property ret=-22
> [   21.182656] create_overlay: Failed to create overlay (err=-22)
> 
> Also, I wonder if the ERROR message could be more direct.  Currently
> it says the #address-cells property is invalid but that doesn't say
> anything about why it's invalid.  How about something like:
> 
>  OF: overlay: ERROR: changing #address-cells not allowed (/soc/base_fpga_region)

That sounds like a more useful message, maybe a slight change
s/changing #address-cells/changing value of #address-cells/


> The 'OF: overlay' part still makes it clear it's overlay related.  The
> rest of it makes it clear *why* it's invalid.  This ERROR will be a
> surprise for people who have been using overlays, so that could be
> helpful to light the way a bit.
> 
> Alan
> 
>> +
>> +       } else {
>> +
>> +               check_for_non_overlay_node = true;
>>                 ret = of_changeset_update_property(&ovcs->cset, target->np,
>>                                                    new_prop);
>>
>> +       }
>> +
>> +       if (check_for_non_overlay_node &&
>> +           !of_node_check_flag(target->np, OF_OVERLAY))
>> +               pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
>> +                      __func__, target->np, new_prop->name);
>> +
>>         if (ret) {
>>                 kfree(new_prop->name);
>>                 kfree(new_prop->value);
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>
> 
