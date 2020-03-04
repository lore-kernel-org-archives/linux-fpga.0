Return-Path: <SRS0=yryN=4V=gmail.com=d.c.ddcc@kernel.org>
Return-Path: <SRS0=yryN=4V=gmail.com=d.c.ddcc@kernel.org>
From: Dominic Chen <d.c.ddcc@gmail.com>
Subject: [Resend] [PATCH] fpga: support debug access to memory-mapped afu regions
Date: Wed,  4 Mar 2020 01:14:06 -0500
Message-Id: <20200304061406.98865-1-d.c.ddcc@gmail.com>
To: hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org
Cc: Dominic Chen <d.c.ddcc@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Allow debug access to memory-mapped regions using e.g. gdb.

Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
---
 drivers/fpga/dfl-afu-main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 02baa6a227c0..38983f9dde98 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+const struct vm_operations_struct afu_vma_ops = {
+	.access = generic_access_phys,
+};
+#endif /* CONFIG_HAVE_IOREMAP_PROT */
+
 static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct platform_device *pdev = filp->private_data;
@@ -488,6 +494,11 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 	    !(region.flags & DFL_PORT_REGION_WRITE))
 		return -EPERM;
 
+	// Support debug access to the mapping
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	vma->vm_ops = &afu_vma_ops;
+#endif /* CONFIG_HAVE_IOREMAP_PROT */
+
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	return remap_pfn_range(vma, vma->vm_start,
-- 
2.17.1
