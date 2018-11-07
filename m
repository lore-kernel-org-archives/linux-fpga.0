Return-Path: <SRS0=gGtO=NS=ellerman.id.au=mpe@kernel.org>
Return-Path: <SRS0=gGtO=NS=ellerman.id.au=mpe@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6 03/18] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
In-Reply-To: <1541431515-25197-4-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com> <1541431515-25197-4-git-send-email-frowand.list@gmail.com>
Date: Wed, 07 Nov 2018 23:14:23 +1100
Message-ID: <87pnvhqe3k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

frowand.list@gmail.com writes:

> From: Frank Rowand <frank.rowand@sony.com>
>
> There is a matching of_node_put() in __of_detach_node_sysfs()
>
> Remove misleading comment from function header comment for
> of_detach_node().
>
> This patch may result in memory leaks from code that directly calls
> the dynamic node add and delete functions directly instead of
> using changesets.
>
> Tested-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

This seems sensible to me. I guess we could argue about whether the
sysfs code needs its own reference, but it certainly doesn't hurt that
it does, as long as it's handled symmetrically - which it is now.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

> ---
>
> This patch should result in powerpc systems that dynamically
> allocate a node, then later deallocate the node to have a
> memory leak when the node is deallocated.
>
> The next patch in the series will fix the leak.

I think this should go in the changelog, it's useful information that we
don't want to lose track of once this is applied.

Either that or we actually squash the two patches together when applying
to avoid the bisection break.

cheers

>  drivers/of/dynamic.c | 3 ---
>  drivers/of/kobj.c    | 4 +++-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 12c3f9a15e94..146681540487 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -272,9 +272,6 @@ void __of_detach_node(struct device_node *np)
>  
>  /**
>   * of_detach_node() - "Unplug" a node from the device tree.
> - *
> - * The caller must hold a reference to the node.  The memory associated with
> - * the node is not freed until its refcount goes to zero.
>   */
>  int of_detach_node(struct device_node *np)
>  {
> diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
> index 7a0a18980b98..c72eef988041 100644
> --- a/drivers/of/kobj.c
> +++ b/drivers/of/kobj.c
> @@ -133,6 +133,9 @@ int __of_attach_node_sysfs(struct device_node *np)
>  	}
>  	if (!name)
>  		return -ENOMEM;
> +
> +	of_node_get(np);
> +
>  	rc = kobject_add(&np->kobj, parent, "%s", name);
>  	kfree(name);
>  	if (rc)
> @@ -159,6 +162,5 @@ void __of_detach_node_sysfs(struct device_node *np)
>  		kobject_del(&np->kobj);
>  	}
>  
> -	/* finally remove the kobj_init ref */
>  	of_node_put(np);
>  }
> -- 
> Frank Rowand <frank.rowand@sony.com>
