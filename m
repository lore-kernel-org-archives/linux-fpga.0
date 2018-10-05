Return-Path: <SRS0=I98M=MR=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=I98M=MR=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH 09/16] of: overlay: validate overlay properties
 #address-cells and #size-cells
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKK3f4W1DdPkzNed0=tx5Oxu9w=RKs8PnaXMfuShBpV1A@mail.gmail.com>
 <f39a84d3-f706-d31e-db22-4e3ebc72c447@gmail.com>
 <CAL_Jsq+53znm=LHxH8bZZJ2wN4uUez8D7E2V03+Zc9nvYBNjrg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <c3a72a61-01f9-955c-8bcf-7845cd6c993a@gmail.com>
Date: Fri, 5 Oct 2018 12:09:06 -0700
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+53znm=LHxH8bZZJ2wN4uUez8D7E2V03+Zc9nvYBNjrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/05/18 12:04, Rob Herring wrote:
> On Fri, Oct 5, 2018 at 1:53 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 10/05/18 08:07, Rob Herring wrote:
>>> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>>>>
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> If overlay properties #address-cells or #size-cells are already in
>>>> the live devicetree for any given node, then the values in the
>>>> overlay must match the values in the live tree.
>>>>
>>>> If the properties are already in the live tree then there is no
>>>> need to create a changeset entry to add them since they must
>>>> have the same value.  This reduces the memory used by the
>>>> changeset and eliminates a possible memory leak.  This is
>>>> verified by 12 fewer warnings during the devicetree unittest,
>>>> as the possible memory leak warnings about #address-cells and
>>>
>>> and...?
>>
>> #size-cells no longer occur.
>>
>> (Thanks for catching that.)
>>
>>
>>>>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>>> index 29c33a5c533f..e6fb3ffe9d93 100644
>>>> --- a/drivers/of/overlay.c
>>>> +++ b/drivers/of/overlay.c
>>>> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
>>>>   * @target may be either in the live devicetree or in a new subtree that
>>>>   * is contained in the changeset.
>>>>   *
>>>> - * Some special properties are not updated (no error returned).
>>>> + * Some special properties are not added or updated (no error returned):
>>>> + * "name", "phandle", "linux,phandle".
>>>> + *
>>>> + * Properties "#address-cells" and "#size-cells" are not updated if they
>>>> + * are already in the live tree, but if present in the live tree, the values
>>>> + * in the overlay must match the values in the live tree.
>>>
>>> Perhaps this should be generalized to apply to any property? We can't
>>> really deal with property values changing on the fly anyways.
>>
>> That is a bigger discussion.  I'd prefer to not hold up this series for that
>> question to be resolved.  It will be easy enough to generalize in an add-on
>> patch later.
> 
> Fair enough.
> 
>>>> +               if (prop->length != 4 || new_prop->length != 4 ||
>>>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
>>>
>>> Technically these are __be32 types. This could use a helper (of_prop_val_eq).
>>
>> These are in a unpacked form, so cpu byte order, not FDT byte order.
> 
> You sure about that? Unpacking doesn't change the order. It can't
> because the type is unknown. The value of 'value' is the address of
> the data in the FDT.

Aargh.  You are totally right.


>>> I'm not sure we really need to validate the length here as dtc does
>>> that (but yes, not everything is from dtc).
>>
>> Since I'm accessing 4 bytes of the values, I need to be sure the lengths
>> are at least 4.  For #address-cells and #size-cells the property is
>> specified as four bytes, so I could simplify the code for the specific case.
>>
>> If this gets extended to any arbitrary property then a new of_prop_val_eq()
>> would check that the lengths are equal and the values (of size length) are
>> also equal.
> 
> Right, that's what I was thinking. Check lengths are equal and then
> you can just do a memcmp().

Based on all of this it seems better that I create of_prop_val_eq(), as you
suggested, and change to use that.


> 
> Rob
> 
