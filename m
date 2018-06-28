Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/2] fpga: altera-cvp: Fix an error handling path in 'altera_cvp_probe()'
Date: Wed, 27 Jun 2018 20:56:18 -0500
Message-Id: <1530150979-5693-2-git-send-email-atull@kernel.org>
In-Reply-To: <1530150979-5693-1-git-send-email-atull@kernel.org>
References: <1530150979-5693-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>, Christophe Jaillet <christophe.jaillet@wanadoo.fr>
List-ID: <linux-fpga@vger.kernel.org>

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

If 'fpga_mgr_create()' fails, we should release some resources, as done
in the other error handling path of the function.

Fixes: 7085e2a94f7d ("fpga: manager: change api, don't use drvdata")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/altera-cvp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index dd4edd8..7fa7936 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -455,8 +455,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 
 	mgr = fpga_mgr_create(&pdev->dev, conf->mgr_name,
 			      &altera_cvp_ops, conf);
-	if (!mgr)
-		return -ENOMEM;
+	if (!mgr) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
 
 	pci_set_drvdata(pdev, mgr);
 
-- 
2.7.4
