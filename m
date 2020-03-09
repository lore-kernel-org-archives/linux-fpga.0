Return-Path: <SRS0=+JAn=42=gmail.com=d.c.ddcc@kernel.org>
Return-Path: <SRS0=+JAn=42=gmail.com=d.c.ddcc@kernel.org>
From: Dominic Chen <d.c.ddcc@gmail.com>
Subject: [PATCH v4] fpga: dfl: afu: support debug access to memory-mapped afu regions
Date: Mon,  9 Mar 2020 14:53:23 -0400
Message-Id: <20200309185323.106443-1-d.c.ddcc@gmail.com>
To: hao.wu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Cc: Dominic Chen <d.c.ddcc@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Allow debug access to memory-mapped regions using e.g. gdb.

Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-afu-main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 02baa6a227c0..d2e6826af970 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return -EINVAL;
 }
 
+static const struct vm_operations_struct afu_vma_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	.access = generic_access_phys,
+#endif
+};
+
 static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct platform_device *pdev = filp->private_data;
@@ -488,6 +494,9 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 	    !(region.flags & DFL_PORT_REGION_WRITE))
 		return -EPERM;
 
+	/* Support debug access to the mapping */
+	vma->vm_ops = &afu_vma_ops;
+
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	return remap_pfn_range(vma, vma->vm_start,
-- 
2.17.1
