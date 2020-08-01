Return-Path: <SRS0=et14=BL=gmail.com=refactormyself@kernel.org>
Return-Path: <SRS0=et14=BL=gmail.com=refactormyself@kernel.org>
From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Subject: [RFC PATCH 07/17] fpga: altera-cvp: Drop uses of pci_read_config_*() return value
Date: Sat,  1 Aug 2020 13:24:36 +0200
Message-Id: <20200801112446.149549-8-refactormyself@gmail.com>
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
To: helgaas@kernel.org, Moritz Fischer <mdf@kernel.org>
Cc: "Saheed O. Bolarinwa" <refactormyself@gmail.com>, bjorn@helgaas.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/fpga/altera-cvp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4e0edb60bfba..99c6e0754f8b 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -96,15 +96,15 @@ struct cvp_priv {
 static int altera_read_config_byte(struct altera_cvp_conf *conf,
 				   int where, u8 *val)
 {
-	return pci_read_config_byte(conf->pci_dev, conf->vsec_offset + where,
-				    val);
+	pci_read_config_byte(conf->pci_dev, conf->vsec_offset + where, val);
+	return (val == (u8)~0) ? -ENODEV : 0;
 }
 
 static int altera_read_config_dword(struct altera_cvp_conf *conf,
 				    int where, u32 *val)
 {
-	return pci_read_config_dword(conf->pci_dev, conf->vsec_offset + where,
-				     val);
+	pci_read_config_dword(conf->pci_dev, conf->vsec_offset + where, val);
+	return (val == (u32)~0) ? -ENODEV : 0;
 }
 
 static int altera_write_config_dword(struct altera_cvp_conf *conf,
-- 
2.18.4
