Return-Path: <SRS0=iJay=AT=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=iJay=AT=linuxfoundation.org=gregkh@kernel.org>
Date: Mon, 18 Sep 2017 12:17:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] fpga: altera-cvp: remove DRIVER_ATTR() usage
Message-ID: <20170918101736.GA30415@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

It's better to be explicit and use the DRIVER_ATTR_RW() macro when
defining a driver's sysfs file.

This is part of a series to drop DRIVER_ATTR() from the tree entirely.

Cc: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/fpga/altera-cvp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 08629ee69d11..00e73d28077c 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -361,12 +361,12 @@ static const struct fpga_manager_ops altera_cvp_ops = {
 	.write_complete	= altera_cvp_write_complete,
 };
 
-static ssize_t show_chkcfg(struct device_driver *dev, char *buf)
+static ssize_t chkcfg_show(struct device_driver *dev, char *buf)
 {
 	return snprintf(buf, 3, "%d\n", altera_cvp_chkcfg);
 }
 
-static ssize_t store_chkcfg(struct device_driver *drv, const char *buf,
+static ssize_t chkcfg_store(struct device_driver *drv, const char *buf,
 			    size_t count)
 {
 	int ret;
@@ -378,7 +378,7 @@ static ssize_t store_chkcfg(struct device_driver *drv, const char *buf,
 	return count;
 }
 
-static DRIVER_ATTR(chkcfg, 0600, show_chkcfg, store_chkcfg);
+static DRIVER_ATTR_RW(chkcfg);
 
 static int altera_cvp_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *dev_id);
-- 
2.14.1
