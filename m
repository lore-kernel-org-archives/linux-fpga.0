Return-Path: <SRS0=cIxQ=M3=perches.com=joe@kernel.org>
Return-Path: <SRS0=cIxQ=M3=perches.com=joe@kernel.org>
Message-ID: <b6ee53f7e02cc3ea52713ae82402e97d7050cb3e.camel@perches.com>
Subject: Re: [PATCH v3 13/18] of: overlay: check prevents multiple fragments
 touching same property
From: Joe Perches <joe@perches.com>
Date: Sun, 14 Oct 2018 18:06:40 -0700
In-Reply-To: <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
	 <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Sun, 2018-10-14 at 17:24 -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add test case of two fragments updating the same property.  After
> adding the test case, the system hangs at end of boot, after
> after slub stack dumps from kfree() in crypto modprobe code.
[]
> -static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
> +static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
>  {
> -	struct of_changeset_entry *ce_1, *ce_2;
> -	char *fn_1, *fn_2;
> -	int name_match;
> +	struct of_changeset_entry *ce_1;
> +	int dup_entry = 0;
>  
>  	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
> -
> -		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
> -		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
> -
> -			ce_2 = ce_1;
> -			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
> -				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
> -				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
> -					/* inexpensive name compare */
> -					if (!of_node_cmp(ce_1->np->full_name,
> -					    ce_2->np->full_name)) {
> -						/* expensive full path name compare */
> -						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
> -						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
> -						name_match = !strcmp(fn_1, fn_2);
> -						kfree(fn_1);
> -						kfree(fn_2);
> -						if (name_match) {
> -							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
> -							       ce_1->np);
> -							return -EINVAL;
> -						}
> -					}
> -				}
> -			}
> -		}
> +		dup_entry |= find_dup_cset_node_entry(ovcs, ce_1);
> +		dup_entry |= find_dup_cset_prop(ovcs, ce_1);

I think this is worse performance than before.

This now walks all entries when before it would
return -EINVAL directly when it found a match.
