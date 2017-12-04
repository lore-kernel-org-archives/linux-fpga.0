Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 2/2] of: dynamic: add overlay-allowed DT property
Date: Mon,  4 Dec 2017 13:13:57 -0600
Message-Id: <20171204191357.3211-3-atull@kernel.org>
In-Reply-To: <20171204191357.3211-1-atull@kernel.org>
References: <20171204191357.3211-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Alan Tull <atull@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Allow DT nodes to be marked as valid targets for DT
overlays by the added "overlay-allowed" property.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/of/base.c       | 4 ++--
 drivers/of/dynamic.c    | 3 +++
 drivers/of/fdt.c        | 3 +++
 drivers/of/of_private.h | 2 ++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 26618ba..ac6b326 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -116,8 +116,8 @@ void __init of_core_init(void)
 		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
 }
 
-static struct property *__of_find_property(const struct device_node *np,
-					   const char *name, int *lenp)
+struct property *__of_find_property(const struct device_node *np,
+				    const char *name, int *lenp)
 {
 	struct property *pp;
 
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index ab988d8..fae9b85 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -207,6 +207,9 @@ static void __of_attach_node(struct device_node *np)
 	np->name = __of_get_property(np, "name", NULL) ? : "<NULL>";
 	np->type = __of_get_property(np, "device_type", NULL) ? : "<NULL>";
 
+	if (__of_find_property(np, "overlay-allowed", NULL))
+		of_node_set_flag(np, OF_OVERLAY_ENABLED);
+
 	phandle = __of_get_property(np, "phandle", &sz);
 	if (!phandle)
 		phandle = __of_get_property(np, "linux,phandle", &sz);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4675e5a..9237f30 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -323,6 +323,9 @@ static bool populate_node(const void *blob,
 			np->name = "<NULL>";
 		if (!np->type)
 			np->type = "<NULL>";
+
+		if (of_find_property(np, "overlay-allowed", NULL))
+			of_node_set_flag(np, OF_OVERLAY_ENABLED);
 	}
 
 	*pnp = np;
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 92a9a36..75fcba3 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -115,6 +115,8 @@ struct device_node *__of_find_node_by_path(struct device_node *parent,
 struct device_node *__of_find_node_by_full_path(struct device_node *node,
 						const char *path);
 
+extern struct property *__of_find_property(const struct device_node *np,
+					   const char *name, int *lenp);
 extern const void *__of_get_property(const struct device_node *np,
 				     const char *name, int *lenp);
 extern int __of_add_property(struct device_node *np, struct property *prop);
-- 
2.7.4
