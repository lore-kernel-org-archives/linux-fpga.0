Return-Path: <SRS0=63Yb=M3=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=63Yb=M3=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v2 12/18] of: overlay: check prevents multiple fragments
 add or delete same node
From: Frank Rowand <frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
 <1539406418-18162-13-git-send-email-frowand.list@gmail.com>
 <97b26203e6792795bdc0a66ce4cdb47571ff16c1.camel@perches.com>
 <651a8488-caec-b153-43c7-1fb81f641f1a@gmail.com>
Message-ID: <06898888-59dc-c37f-5013-a58fc73df2e1@gmail.com>
Date: Sun, 14 Oct 2018 17:29:14 -0700
MIME-Version: 1.0
In-Reply-To: <651a8488-caec-b153-43c7-1fb81f641f1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/13/18 11:21, Frank Rowand wrote:
> On 10/13/18 05:51, Joe Perches wrote:
>> On Fri, 2018-10-12 at 21:53 -0700, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Multiple overlay fragments adding or deleting the same node is not
>>> supported.  Replace code comment of such, with check to detect the
>>> attempt and fail the overlay apply.
>>>
>>> Devicetree unittest where multiple fragments added the same node was
>>> added in the previous patch in the series.  After applying this patch
>>> the unittest messages will no longer include:
>>>
>>>    Duplicate name in motor-1, renamed to "controller#1"
>>>    OF: overlay: of_overlay_apply() err=0
>>>    ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
>>>    ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed
>>>
>>>    ...
>>>
>>>    ### dt-test ### end of unittest - 210 passed, 1 failed
>>>
>>> but will instead include:
>>>
>>>    OF: overlay: ERROR: multiple overlay fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
>>>
>>>    ...
>>>
>>>    ### dt-test ### end of unittest - 211 passed, 0 failed
>> []
>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> []
>>> @@ -523,6 +515,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
>>>  }
>>>  
>>>  /**
>>> + * check_changeset_dup_add_node() - changeset validation: duplicate add node
>>> + * @ovcs:	Overlay changeset
>>> + *
>>> + * Check changeset @ovcs->cset for multiple add node entries for the same
>>> + * node.
>>> + *
>>> + * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
>>> + * invalid overlay in @ovcs->fragments[].
>>> + */
>>> +static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
>>> +{
>>> +	struct of_changeset_entry *ce_1, *ce_2;
>>> +	char *fn_1, *fn_2;
>>> +	int name_match;
>>> +
>>> +	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
>>> +
>>> +		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
>>> +		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
>>> +
>>> +			ce_2 = ce_1;
>>> +			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
>>> +				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
>>> +				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
>>> +					/* inexpensive name compare */
>>> +					if (!of_node_cmp(ce_1->np->full_name,
>>> +					    ce_2->np->full_name)) {
>>
>> A bit of odd indentation here.
>> This line is normally aligned to the second ( on the line above.
> 
> Yes, thanks.

This line gets joined into a single line in version 3, so I will leave
the bad formatting in patch 12 to make my life easier when moving
to version 3.


>>
>>> +						/* expensive full path name compare */
>>> +						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>>> +						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>>> +						name_match = !strcmp(fn_1, fn_2);
>>> +						kfree(fn_1);
>>> +						kfree(fn_2);
>>> +						if (name_match) {
>>> +							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
>>> +							       ce_1->np);
>>> +							return -EINVAL;
>>> +						}
>>> +					}
>>> +				}
>>> +			}
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> Style trivia:
>>
>> Using inverted tests and continue would reduce indentation.
> 
> Yes, thanks.

In version 3, fixed in patch 13/18 instead of 12/18, where this pattern
has been split into two functions.

-Frank


> 
> -Frank
> 
> 
>>
>> 	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
>> 		if (ce_1->action != OF_RECONFIG_ATTACH_NODE &&
>> 		    ce_1->action != OF_RECONFIG_DETACH_NODE)
>> 			continue;
>>
>> 		ce_2 = ce_1;
>> 		list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
>> 			if (ce_2->action != OF_RECONFIG_ATTACH_NODE &&
>> 			    ce_2->action != OF_RECONFIG_DETACH_NODE)
>> 				continue;
>>
>> 			/* inexpensive name compare */
>> 			if (of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
>> 				continue;
>>
>> 			/* expensive full path name compare */
>> 			fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>> 			fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>> 			name_match = !strcmp(fn_1, fn_2);
>> 			kfree(fn_1);
>> 			kfree(fn_2);
>> 			if (name_match) {
>> 				pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
>> 				       ce_1->np);
>> 				return -EINVAL;
>> 			}
>> 		}
>> 	}
>>
>>
>>
> 
> 
