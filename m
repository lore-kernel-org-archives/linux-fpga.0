Return-Path: <SRS0=Pw8r=MZ=perches.com=joe@kernel.org>
Return-Path: <SRS0=Pw8r=MZ=perches.com=joe@kernel.org>
Message-ID: <97b26203e6792795bdc0a66ce4cdb47571ff16c1.camel@perches.com>
Subject: Re: [PATCH v2 12/18] of: overlay: check prevents multiple fragments
 add or delete same node
From: Joe Perches <joe@perches.com>
Date: Sat, 13 Oct 2018 05:51:46 -0700
In-Reply-To: <1539406418-18162-13-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
	 <1539406418-18162-13-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, 2018-10-12 at 21:53 -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Multiple overlay fragments adding or deleting the same node is not
> supported.  Replace code comment of such, with check to detect the
> attempt and fail the overlay apply.
> 
> Devicetree unittest where multiple fragments added the same node was
> added in the previous patch in the series.  After applying this patch
> the unittest messages will no longer include:
> 
>    Duplicate name in motor-1, renamed to "controller#1"
>    OF: overlay: of_overlay_apply() err=0
>    ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
>    ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed
> 
>    ...
> 
>    ### dt-test ### end of unittest - 210 passed, 1 failed
> 
> but will instead include:
> 
>    OF: overlay: ERROR: multiple overlay fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
> 
>    ...
> 
>    ### dt-test ### end of unittest - 211 passed, 0 failed
[]
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
[]
> @@ -523,6 +515,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
>  }
>  
>  /**
> + * check_changeset_dup_add_node() - changeset validation: duplicate add node
> + * @ovcs:	Overlay changeset
> + *
> + * Check changeset @ovcs->cset for multiple add node entries for the same
> + * node.
> + *
> + * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
> + * invalid overlay in @ovcs->fragments[].
> + */
> +static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
> +{
> +	struct of_changeset_entry *ce_1, *ce_2;
> +	char *fn_1, *fn_2;
> +	int name_match;
> +
> +	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
> +
> +		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
> +		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
> +
> +			ce_2 = ce_1;
> +			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
> +				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
> +				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
> +					/* inexpensive name compare */
> +					if (!of_node_cmp(ce_1->np->full_name,
> +					    ce_2->np->full_name)) {

A bit of odd indentation here.
This line is normally aligned to the second ( on the line above.

> +						/* expensive full path name compare */
> +						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
> +						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
> +						name_match = !strcmp(fn_1, fn_2);
> +						kfree(fn_1);
> +						kfree(fn_2);
> +						if (name_match) {
> +							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
> +							       ce_1->np);
> +							return -EINVAL;
> +						}
> +					}
> +				}
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

Style trivia:

Using inverted tests and continue would reduce indentation.

	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
		if (ce_1->action != OF_RECONFIG_ATTACH_NODE &&
		    ce_1->action != OF_RECONFIG_DETACH_NODE)
			continue;

		ce_2 = ce_1;
		list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
			if (ce_2->action != OF_RECONFIG_ATTACH_NODE &&
			    ce_2->action != OF_RECONFIG_DETACH_NODE)
				continue;

			/* inexpensive name compare */
			if (of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
				continue;

			/* expensive full path name compare */
			fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
			fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
			name_match = !strcmp(fn_1, fn_2);
			kfree(fn_1);
			kfree(fn_2);
			if (name_match) {
				pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
				       ce_1->np);
				return -EINVAL;
			}
		}
	}
