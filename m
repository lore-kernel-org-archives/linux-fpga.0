Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com> <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 12 Jun 2018 13:16:21 -0500
Message-ID: <CANk1AXQZ6ax5j9QOrLZA9qT2xGpiU0BQLxAmKQFEqSb6NrbeRQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Sun, Mar 4, 2018 at 6:14 PM,  <frowand.list@gmail.com> wrote:

Hi Frank,

I'm investigating a refcount use-after-free warning that happens after
overlays are applied, removed, reapplied a few (typically three) times
(see below).  This is new in v4.17, didn't happen in v4.16.  As I was
investigating I found that rebuilding the phandle_cache after overlays
are applied or removed seems to help.  I exported
of_populate_phandle_cache() and called it after overlays were applied
or removed such as the snippet below, it seemed to fix the problem.
I'll keep digging to understand the problem better.

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 848f549..4184273 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -102,7 +102,7 @@ static u32 phandle_cache_mask;
  *   - the phandle lookup overhead reduction provided by the cache
  *     will likely be less
  */
-static void of_populate_phandle_cache(void)
+void of_populate_phandle_cache(void)
 {
        unsigned long flags;
        u32 cache_entries;
@@ -133,6 +133,7 @@ static void of_populate_phandle_cache(void)
 out:
        raw_spin_unlock_irqrestore(&devtree_lock, flags);
 }
+EXPORT_SYMBOL_GPL(of_populate_phandle_cache);

 #ifndef CONFIG_MODULES
 static int __init of_free_phandle_cache(void)
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7baa53e..55caf42 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -885,6 +885,8 @@ int of_overlay_fdt_apply(const void *overlay_fdt,
u32 overlay_fdt_size,
                goto out;
        }

+       of_populate_phandle_cache();
+
        return 0;


@@ -1070,6 +1072,7 @@ int of_overlay_remove(int *ovcs_id)
        }

        free_overlay_changeset(ovcs);
+       of_populate_phandle_cache();

 out_unlock:
        mutex_unlock(&of_mutex);
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f..a662d4e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1342,6 +1342,9 @@ static inline int
of_reconfig_get_state_change(unsigned long action,
 }
 #endif /* CONFIG_OF_DYNAMIC */

+//todo locate this more correctly, just testing for now
+void of_populate_phandle_cache(void);
+
 /**
  * of_device_is_system_power_controller - Tells if
system-power-controller is found for device_node
  * @np: Pointer to the given device_node


Dump (with my added pr_err's in of_node_get) without the above snippet
to help out.

[  226.115974] OF: Got from phandle_cache np=/soc/base_fpga_region/
[  226.121956] OF: about to get np=/soc/base_fpga_region/
[  226.127073] ------------[ cut here ]------------
[  226.131682] WARNING: CPU: 1 PID: 1529 at
/home/atull/repos/linux-socfpga/lib/refcount.c:153
refcount_inc+0x4c/0x50
[  226.141988] refcount_t: increment on 0; use-after-free.
[  226.147191] Modules linked in:
[  226.150241] CPU: 1 PID: 1529 Comm: python Not tainted
4.17.0-00134-gb6fd158 #10
[  226.157521] Hardware name: Altera SOCFPGA Arria10
[  226.162223] [<c01132d8>] (unwind_backtrace) from [<c010defc>]
(show_stack+0x20/0x24)
[  226.169943] [<c010defc>] (show_stack) from [<c07be4e0>]
(dump_stack+0x8c/0xa0)
[  226.177146] [<c07be4e0>] (dump_stack) from [<c0123620>] (__warn+0x104/0x11c)
[  226.184170] [<c0123620>] (__warn) from [<c012368c>]
(warn_slowpath_fmt+0x54/0x70)
[  226.191631] [<c012368c>] (warn_slowpath_fmt) from [<c0481ac8>]
(refcount_inc+0x4c/0x50)
[  226.199613] [<c0481ac8>] (refcount_inc) from [<c07c2ff4>]
(kobject_get+0x2c/0x5c)
[  226.207073] [<c07c2ff4>] (kobject_get) from [<c06485bc>]
(of_node_get.part.0+0x30/0x44)
[  226.215050] [<c06485bc>] (of_node_get.part.0) from [<c06485f8>]
(of_node_get+0x28/0x2c)
[  226.223028] [<c06485f8>] (of_node_get) from [<c06434c8>]
(of_find_node_by_phandle+0xa0/0xec)
[  226.231438] [<c06434c8>] (of_find_node_by_phandle) from
[<c06435c4>] (of_phandle_iterator_next+0xb0/0x178)
[  226.241057] [<c06435c4>] (of_phandle_iterator_next) from
[<c0643f48>] (__of_parse_phandle_with_args+0x50/0xf8)
[  226.251022] [<c0643f48>] (__of_parse_phandle_with_args) from
[<c0644038>] (of_parse_phandle+0x48/0x78)
[  226.260298] [<c0644038>] (of_parse_phandle) from [<c0657424>]
(of_fpga_region_get_bridges+0x140/0x1d0)
[  226.269572] [<c0657424>] (of_fpga_region_get_bridges) from
[<c0657070>] (fpga_region_program_fpga+0x98/0x184)
[  226.279450] [<c0657070>] (fpga_region_program_fpga) from
[<c06578b4>] (of_fpga_region_notify+0x2c4/0x340)
[  226.288984] [<c06578b4>] (of_fpga_region_notify) from [<c01472f4>]
(notifier_call_chain+0x54/0x94)
[  226.297913] [<c01472f4>] (notifier_call_chain) from [<c01476d8>]
(__blocking_notifier_call_chain+0x58/0x70)
[  226.307619] [<c01476d8>] (__blocking_notifier_call_chain) from
[<c0147718>] (blocking_notifier_call_chain+0x28/0x30)
[  226.318105] [<c0147718>] (blocking_notifier_call_chain) from
[<c064e930>] (overlay_notify+0x8c/0xec)
[  226.327206] [<c064e930>] (overlay_notify) from [<c064f2f4>]
(of_overlay_fdt_apply+0x41c/0x714)
[  226.335791] [<c064f2f4>] (of_overlay_fdt_apply) from [<c06481dc>]
(cfs_overlay_item_dtbo_write+0x68/0xbc)
[  226.345327] [<c06481dc>] (cfs_overlay_item_dtbo_write) from
[<c02e3d38>] (configfs_release_bin_file+0x6c/0xa0)
[  226.355294] [<c02e3d38>] (configfs_release_bin_file) from
[<c026b920>] (__fput+0x94/0x1e4)
[  226.363530] [<c026b920>] (__fput) from [<c026bae0>] (____fput+0x18/0x1c)
[  226.370207] [<c026bae0>] (____fput) from [<c0143aa8>]
(task_work_run+0xb4/0xd8)
[  226.377492] [<c0143aa8>] (task_work_run) from [<c010d438>]
(do_work_pending+0xac/0xcc)
[  226.385382] [<c010d438>] (do_work_pending) from [<c010106c>]
(slow_work_pending+0xc/0x20)

Alan

> From: Frank Rowand <frank.rowand@sony.com>
>
> Create a cache of the nodes that contain a phandle property.  Use this
> cache to find the node for a given phandle value instead of scanning
> the devicetree to find the node.  If the phandle value is not found
> in the cache, of_find_node_by_phandle() will fall back to the tree
> scan algorithm.
>
> The cache is initialized in of_core_init().
>
> The cache is freed via a late_initcall_sync() if modules are not
> enabled.
>
> If the devicetree is created by the dtc compiler, with all phandle
> property values auto generated, then the size required by the cache
> could be 4 * (1 + number of phandles) bytes.  This results in an O(1)
> node lookup cost for a given phandle value.  Due to a concern that the
> phandle property values might not be consistent with what is generated
> by the dtc compiler, a mask has been added to the cache lookup algorithm.
> To maintain the O(1) node lookup cost, the size of the cache has been
> increased by rounding the number of entries up to the next power of
> two.
>
> The overhead of finding the devicetree node containing a given phandle
> value has been noted by several people in the recent past, in some cases
> with a patch to add a hashed index of devicetree nodes, based on the
> phandle value of the node.  One concern with this approach is the extra
> space added to each node.  This patch takes advantage of the phandle
> property values auto generated by the dtc compiler, which begin with
> one and monotonically increase by one, resulting in a range of 1..n
> for n phandle values.  This implementation should also provide a good
> reduction of overhead for any range of phandle values that are mostly
> in a monotonic range.
>
> Performance measurements by Chintan Pandya <cpandya@codeaurora.org>
> of several implementations of patches that are similar to this one
> suggest an expected reduction of boot time by ~400ms for his test
> system.  If the cache size was decreased to 64 entries, the boot
> time was reduced by ~340 ms.  The measurements were on a 4.9.73 kernel
> for arch/arm64/boot/dts/qcom/sda670-mtp.dts, contains 2371 nodes and
> 814 phandle values.
>
> Reported-by: Chintan Pandya <cpandya@codeaurora.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>
> Changes since v3:
>   - of_populate_phandle_cache(): add check for failed memory allocation
>
> Changes since v2:
>   - add mask to calculation of phandle cache entry
>   - which results in better overhead reduction for devicetrees with
>     phandle properties not allocated in the monotonically increasing
>     range of 1..n
>   - due to mask, number of entries in cache potentially increased to
>     next power of two
>   - minor fixes as suggested by reviewers
>   - no longer using live_tree_max_phandle() so do not move it from
>     drivers/of/resolver.c to drivers/of/base.c
>
> Changes since v1:
>   - change short description from
>     of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
>   - rebase on v4.16-rc1
>   - reorder new functions in base.c to avoid forward declaration
>   - add locking around kfree(phandle_cache) for memory ordering
>   - add explicit check for non-null of phandle_cache in
>     of_find_node_by_phandle().  There is already a check for !handle,
>     which prevents accessing a null phandle_cache, but that dependency
>     is not obvious, so this check makes it more apparent.
>   - do not free phandle_cache if modules are enabled, so that
>     cached phandles will be available when modules are loaded
>
>  drivers/of/base.c       | 86 ++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/of/of_private.h |  3 ++
>  drivers/of/resolver.c   |  3 --
>  3 files changed, 85 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ad28de96e13f..e71d157d7149 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -91,10 +91,72 @@ int __weak of_node_to_nid(struct device_node *np)
>  }
>  #endif
>
> +static struct device_node **phandle_cache;
> +static u32 phandle_cache_mask;
> +
> +/*
> + * Assumptions behind phandle_cache implementation:
> + *   - phandle property values are in a contiguous range of 1..n
> + *
> + * If the assumptions do not hold, then
> + *   - the phandle lookup overhead reduction provided by the cache
> + *     will likely be less
> + */
> +static void of_populate_phandle_cache(void)
> +{
> +       unsigned long flags;
> +       u32 cache_entries;
> +       struct device_node *np;
> +       u32 phandles = 0;
> +
> +       raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +       kfree(phandle_cache);
> +       phandle_cache = NULL;
> +
> +       for_each_of_allnodes(np)
> +               if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> +                       phandles++;
> +
> +       cache_entries = roundup_pow_of_two(phandles);
> +       phandle_cache_mask = cache_entries - 1;
> +
> +       phandle_cache = kcalloc(cache_entries, sizeof(*phandle_cache),
> +                               GFP_ATOMIC);
> +       if (!phandle_cache)
> +               goto out;
> +
> +       for_each_of_allnodes(np)
> +               if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> +                       phandle_cache[np->phandle & phandle_cache_mask] = np;
> +
> +out:
> +       raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +}
> +
> +#ifndef CONFIG_MODULES
> +static int __init of_free_phandle_cache(void)
> +{
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +       kfree(phandle_cache);
> +       phandle_cache = NULL;
> +
> +       raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +
> +       return 0;
> +}
> +late_initcall_sync(of_free_phandle_cache);
> +#endif
> +
>  void __init of_core_init(void)
>  {
>         struct device_node *np;
>
> +       of_populate_phandle_cache();
> +
>         /* Create the kset, and register existing nodes */
>         mutex_lock(&of_mutex);
>         of_kset = kset_create_and_add("devicetree", NULL, firmware_kobj);
> @@ -1021,16 +1083,32 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
>   */
>  struct device_node *of_find_node_by_phandle(phandle handle)
>  {
> -       struct device_node *np;
> +       struct device_node *np = NULL;
>         unsigned long flags;
> +       phandle masked_handle;
>
>         if (!handle)
>                 return NULL;
>
>         raw_spin_lock_irqsave(&devtree_lock, flags);
> -       for_each_of_allnodes(np)
> -               if (np->phandle == handle)
> -                       break;
> +
> +       masked_handle = handle & phandle_cache_mask;
> +
> +       if (phandle_cache) {
> +               if (phandle_cache[masked_handle] &&
> +                   handle == phandle_cache[masked_handle]->phandle)
> +                       np = phandle_cache[masked_handle];
> +       }
> +
> +       if (!np) {
> +               for_each_of_allnodes(np)
> +                       if (np->phandle == handle) {
> +                               if (phandle_cache)
> +                                       phandle_cache[masked_handle] = np;
> +                               break;
> +                       }
> +       }
> +
>         of_node_get(np);
>         raw_spin_unlock_irqrestore(&devtree_lock, flags);
>         return np;
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 0c609e7d0334..fa70650136b4 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -131,6 +131,9 @@ extern void __of_update_property_sysfs(struct device_node *np,
>  extern void __of_sysfs_remove_bin_file(struct device_node *np,
>                                        struct property *prop);
>
> +/* illegal phandle value (set when unresolved) */
> +#define OF_PHANDLE_ILLEGAL     0xdeadbeef
> +
>  /* iterators for transactions, used for overlays */
>  /* forward iterator */
>  #define for_each_transaction_entry(_oft, _te) \
> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
> index 740d19bde601..b2ca8185c8c6 100644
> --- a/drivers/of/resolver.c
> +++ b/drivers/of/resolver.c
> @@ -19,9 +19,6 @@
>
>  #include "of_private.h"
>
> -/* illegal phandle value (set when unresolved) */
> -#define OF_PHANDLE_ILLEGAL     0xdeadbeef
> -
>  static phandle live_tree_max_phandle(void)
>  {
>         struct device_node *node;
> --
> Frank Rowand <frank.rowand@sony.com>
>
