Return-Path: <SRS0=sUDD=K7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=sUDD=K7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:55712
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbeHQAWk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Aug 2018 20:22:40 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Date: Thu, 16 Aug 2018 23:21:32 +0200
Message-ID: <1841468.1pWPcT6Du7@harkonnen>
In-Reply-To: <CANk1AXTZqaZxrEeb3TpyH7HtiVNw+MvVsBZzXWZkSLzUGQkrnA@mail.gmail.com>
References: <20180815220958.3606-1-atull@kernel.org> <20180816185952.GA3932@archbook> <CANk1AXTZqaZxrEeb3TpyH7HtiVNw+MvVsBZzXWZkSLzUGQkrnA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Dinh Nguyen <dinguyen@kernel.org>, Appana Durga Kedareswara Rao <appanad@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Alan Tull <atull@opensource.altera.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>

Hi,

On Thursday, August 16, 2018 10:04:51 PM CEST Alan Tull wrote:
> On Thu, Aug 16, 2018 at 1:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> > Hi Alan,
> 
> Hi Moritz,
> 
> > comments inline. While I see how this is useful, I have the
> > suspicion that from the moment this gets merged vendor kernels
> > will just default to use this ...
> 
> Yeah, I have that suspicion as well.  That's probably why I sat on
> this and didn't upstream it for 2 years.  But on the other hand, I
> keep hearing of lots of cases of people implementing this
> independently anyway.  At least if it is debugfs, it makes it clear
> that it's not intended for production use.

I'm one of those guys who implemented this independently.

@Mortiz
I do not see how this can be a bad thing (from what you wrote I guess you 
prefer another interface). Which interface to use depends on the use case.
If you have this suspicion it's, I guess, because such interface it is 
extremely easy to use.

@Alan
DebugFS can be a first step, but I would go for a normal device in /dev at 
some point. I do not see why this should not be used in production

Below, again, my code that does the same thing. I already posted this in 
another thread [1] but probably this is the best place. As I said in the 
other thread, this is what I did quickly last year to make things working 
for us (where this kind of interface is a must). Unfortunately, I do not 
have time to review my own code and improve it.


[1] https://lkml.org/lkml/2018/8/16/107


-----
From d6a6df9515c5e92cc74b8948c3c10ac9cbeec6d2 Mon Sep 17 00:00:00 2001
From: Federico Vaga <federico.vaga@vaga.pv.it>
Date: Mon, 20 Nov 2017 14:40:26 +0100
Subject: [PATCH] fpga: program from user-space

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/fpga/fpga-mgr.txt |   3 +
 drivers/fpga/fpga-mgr.c         | 261 ++++++++++++++++++++++++++++++++++++
++
+-
 include/linux/fpga/fpga-mgr.h   |  19 +++
 3 files changed, 281 insertions(+), 2 deletions(-)

diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-
mgr.txt
index 78f197f..397dae9 100644
--- a/Documentation/fpga/fpga-mgr.txt
+++ b/Documentation/fpga/fpga-mgr.txt
@@ -197,3 +197,6 @@ to put the FPGA into operating mode.
 The ops include a .state function which will read the hardware FPGA 
manager 
and
 return a code of type enum fpga_mgr_states.  It doesn't result in a change 
in
 hardware state.
+
+Configuring the FPGA from user-space
+====================================
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 6441f91..964b7e4 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -27,10 +27,56 @@
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/highmem.h>
+#include <linux/spinlock.h>
 #include <linux/version.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
 
 static DEFINE_IDA(fpga_mgr_ida);
 static struct class *fpga_mgr_class;
+static dev_t fpga_mgr_devt;
+
+/**
+ * struct fpga_image_chunck - FPGA configuration chunck
+ * @data: chunk data
+ * @size: chunk data size
+ * @list: for the linked list of chunks
+ */
+struct fpga_image_chunk {
+       void *data;
+       size_t size;
+       struct list_head list;
+};
+#define CHUNK_MAX_SIZE (PAGE_SIZE)
+
+/**
+ * struct fpga_user_load - structure to handle configuration from user-
space
+ * @mgr: pointer to the FPGA manager
+ * @chunk_list: HEAD point of a linked list of FPGA chunks
+ * @n_chunks: number of chunks in the list
+ * @lock: it protects: chunk_list, n_chunks
+ */
+struct fpga_user_load {
+       struct fpga_manager *mgr;
+       struct list_head chunk_list;
+       unsigned int n_chunks;
+       struct spinlock lock;
+};
+
+
+/**
+ * It sets by default a huge timeout for configuration coming from user-
space
+ * just to play safe.
+ *
+ * FIXME what about sysfs parameters to adjust it? The flag bit in 
particular
+ */
+struct fpga_image_info default_user_info = {
+       .flags = 0,
+       .enable_timeout_us = 10000000, /* 10s */
+       .disable_timeout_us = 10000000, /* 10s */
+       .config_complete_timeout_us = 10000000, /* 10s */
+};
+
 
 /*
  * Call the low level driver's write_init function.  This will do the
@@ -310,6 +356,158 @@ int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_firmware_load);
 
+
+static int fpga_mgr_open(struct inode *inode, struct file *file)
+{
+       struct fpga_manager *mgr = container_of(inode->i_cdev,
+                                               struct fpga_manager,
+                                               cdev);
+       struct fpga_user_load *usr;
+       int ret;
+
+       /* Allow the user-space programming only if user unlocked the FPGA 
*/
+       if (!test_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags)) {
+               dev_info(&mgr->dev, "The FPGA programming is locked\n");
+               return -EPERM;
+       }
+
+       ret = mutex_trylock(&mgr->usr_mutex);
+       if (ret == 0)
+               return -EBUSY;
+
+       usr = kzalloc(sizeof(struct fpga_user_load), GFP_KERNEL);
+       if (!usr) {
+               ret = -ENOMEM;
+               goto err_alloc;
+       }
+
+       usr->mgr = mgr;
+       spin_lock_init(&usr->lock);
+       INIT_LIST_HEAD(&usr->chunk_list);
+       file->private_data = usr;
+
+       return 0;
+
+err_alloc:
+       spin_lock(&mgr->lock);
+       clear_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+       spin_unlock(&mgr->lock);
+       mutex_unlock(&mgr->usr_mutex);
+       return ret;
+}
+
+
+static int fpga_mgr_flush(struct file *file, fl_owner_t id)
+{
+       struct fpga_user_load *usr = file->private_data;
+       struct fpga_image_chunk *chunk, *tmp;
+       struct sg_table sgt;
+       struct scatterlist *sg;
+       int err = 0;
+
+       if (!usr->n_chunks)
+               return 0;
+
+       err = sg_alloc_table(&sgt, usr->n_chunks, GFP_KERNEL);
+       if (err)
+               goto out;
+
+       sg = sgt.sgl;
+       list_for_each_entry(chunk, &usr->chunk_list, list) {
+               sg_set_buf(sg, chunk->data, chunk->size);
+               sg = sg_next(sg);
+               if (!sg)
+                       break;
+       }
+
+       err = fpga_mgr_buf_load_sg(usr->mgr,
+                                  &default_user_info,
+                                  &sgt);
+       sg_free_table(&sgt);
+
+out:
+       /* Remove all chunks */
+       spin_lock(&usr->lock);
+       list_for_each_entry_safe(chunk, tmp, &usr->chunk_list, list) {
+               list_del(&chunk->list);
+               kfree(chunk->data);
+               kfree(chunk);
+               usr->n_chunks--;
+       }
+       spin_unlock(&usr->lock);
+
+       return err;
+}
+
+
+static int fpga_mgr_close(struct inode *inode, struct file *file)
+{
+       struct fpga_user_load *usr = file->private_data;
+       struct fpga_manager *mgr = usr->mgr;
+
+       kfree(usr);
+
+       spin_lock(&mgr->lock);
+       clear_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+       spin_unlock(&mgr->lock);
+
+       mutex_unlock(&mgr->usr_mutex);
+
+       return 0;
+}
+
+
+static ssize_t fpga_mgr_write(struct file *file, const char __user *buf,
+                             size_t count, loff_t *offp)
+{
+       struct fpga_user_load *usr = file->private_data;
+       struct fpga_image_chunk *chunk;
+       int err;
+
+       chunk = kmalloc(sizeof(struct fpga_image_chunk), GFP_KERNEL);
+       if (!chunk)
+               return -ENOMEM;
+
+       chunk->size = count > CHUNK_MAX_SIZE ? CHUNK_MAX_SIZE : count;
+       chunk->data = kmalloc(chunk->size, GFP_KERNEL);
+       if (!chunk->data) {
+               err = -ENOMEM;
+               goto err_buf_alloc;
+       }
+
+       err = copy_from_user(chunk->data, buf, chunk->size);
+       if(err)
+               goto err_buf_copy;
+
+       spin_lock(&usr->lock);
+       list_add_tail(&chunk->list, &usr->chunk_list);
+       usr->n_chunks++;
+       spin_unlock(&usr->lock);
+
+       *offp += count;
+
+       return chunk->size;
+
+err_buf_copy:
+       kfree(chunk->data);
+err_buf_alloc:
+       kfree(chunk);
+       return err;
+}
+
+
+/**
+ * Char device operation
+ */
+static const struct file_operations fpga_mgr_fops = {
+       .owner = THIS_MODULE,
+       .open = fpga_mgr_open,
+       .flush = fpga_mgr_flush,
+       .release = fpga_mgr_close,
+       .write  = fpga_mgr_write,
+};
+
+
 static const char * const state_str[] = {
        [FPGA_MGR_STATE_UNKNOWN] =              "unknown",
        [FPGA_MGR_STATE_POWER_OFF] =            "power off",
@@ -352,13 +550,43 @@ static ssize_t state_show(struct device *dev,
        return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
+static ssize_t config_lock_show(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct fpga_manager *mgr = to_fpga_manager(dev);
+
+       if (test_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags))
+               return sprintf(buf, "unlock\n");
+       return sprintf(buf, "lock\n");
+}
+
+static ssize_t config_lock_store(struct device *dev,
+                                struct device_attribute *attr,
+                                const char *buf, size_t count)
+{
+       struct fpga_manager *mgr = to_fpga_manager(dev);
+
+       spin_lock(&mgr->lock);
+       if (strncmp(buf, "lock" , min(4, (int)count)) == 0)
+               clear_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+       else if (strncmp(buf, "unlock" , min(6, (int)count)) == 0)
+               set_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+       else
+               count = -EINVAL;
+       spin_unlock(&mgr->lock);
+
+       return count;
+}
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(state);
+static DEVICE_ATTR_RW(config_lock);
 
 static struct attribute *fpga_mgr_attrs[] = {
        &dev_attr_name.attr,
        &dev_attr_state.attr,
+       &dev_attr_lock.attr,
        NULL,
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
@@ -367,6 +595,9 @@ ATTRIBUTE_GROUPS(fpga_mgr);
 static struct device_attribute fpga_mgr_attrs[] = {
        __ATTR(name, S_IRUGO, name_show, NULL),
        __ATTR(state, S_IRUGO, state_show, NULL),
+       __ATTR(config_lock, S_IRUGO | S_IWUSR | S_IRGRP | S_IWGRP,
+              config_lock_show, config_lock_store),
+       __ATTR_NULL,
 };
 #endif
 
@@ -507,6 +738,8 @@ int fpga_mgr_register(struct device *dev, const char 
*name,
        }
 
        mutex_init(&mgr->ref_mutex);
+       mutex_init(&mgr->usr_mutex);
+       spin_lock_init(&mgr->lock);
 
        mgr->name = name;
        mgr->mops = mops;
@@ -524,12 +757,19 @@ int fpga_mgr_register(struct device *dev, const char 
*name,
        mgr->dev.parent = dev;
        mgr->dev.of_node = dev->of_node;
        mgr->dev.id = id;
+       mgr->dev.devt = MKDEV(MAJOR(fpga_mgr_devt), id);
        dev_set_drvdata(dev, mgr);
 
        ret = dev_set_name(&mgr->dev, "fpga%d", id);
        if (ret)
                goto error_device;
 
+       cdev_init(&mgr->cdev, &fpga_mgr_fops);
+       mgr->cdev.owner = THIS_MODULE;
+       ret = cdev_add(&mgr->cdev, mgr->dev.devt, 1);
+       if (ret)
+               goto err_cdev;
+
        ret = device_add(&mgr->dev);
        if (ret)
                goto error_device;
@@ -539,6 +779,8 @@ int fpga_mgr_register(struct device *dev, const char 
*name,
        return 0;
 
 error_device:
+       cdev_del(&mgr->cdev);
+err_cdev:
        ida_simple_remove(&fpga_mgr_ida, id);
 error_kfree:
        kfree(mgr);
@@ -572,17 +814,27 @@ static void fpga_mgr_dev_release(struct device *dev)
 {
        struct fpga_manager *mgr = to_fpga_manager(dev);
 
+       cdev_del(&mgr->cdev);
        ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
        kfree(mgr);
 }
 
 static int __init fpga_mgr_class_init(void)
 {
+       int err;
+
        pr_info("FPGA manager framework\n");
 
+       err = alloc_chrdev_region(&fpga_mgr_devt, 0, FPGA_MGR_MAX_DEV,
+                                 "fpga_mgr");
+       if (err)
+               return err;
+
        fpga_mgr_class = class_create(THIS_MODULE, "fpga_manager");
-       if (IS_ERR(fpga_mgr_class))
-               return PTR_ERR(fpga_mgr_class);
+       if (IS_ERR(fpga_mgr_class)) {
+               err = PTR_ERR(fpga_mgr_class);
+               goto err_class;
+       }
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
        fpga_mgr_class->dev_groups = fpga_mgr_groups;
 #else
@@ -591,12 +843,17 @@ static int __init fpga_mgr_class_init(void)
        fpga_mgr_class->dev_release = fpga_mgr_dev_release;
 
        return 0;
+
+err_class:
+       unregister_chrdev_region(fpga_mgr_devt, FPGA_MGR_MAX_DEV);
+       return err;
 }
 
 static void __exit fpga_mgr_class_exit(void)
 {
        class_destroy(fpga_mgr_class);
        ida_destroy(&fpga_mgr_ida);
+       unregister_chrdev_region(fpga_mgr_devt, FPGA_MGR_MAX_DEV);
 }
 
 MODULE_AUTHOR("Alan Tull <atull@opensource.altera.com>");
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index bfa14bc..ae38e48 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -15,8 +15,10 @@
  * You should have received a copy of the GNU General Public License along 
with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 
 #ifndef _LINUX_FPGA_MGR_H
 #define _LINUX_FPGA_MGR_H
@@ -24,6 +26,8 @@
 struct fpga_manager;
 struct sg_table;
 
+#define FPGA_MGR_MAX_DEV (256)
+
 /**
  * enum fpga_mgr_states - fpga framework states
  * @FPGA_MGR_STATE_UNKNOWN: can't determine state
@@ -118,22 +122,37 @@ struct fpga_manager_ops {
        void (*fpga_remove)(struct fpga_manager *mgr);
 };
 
+/*
+ * List of status FLAGS for the FPGA manager
+ */
+#define FPGA_MGR_FLAG_BITS (32)
+#define FPGA_MGR_FLAG_UNLOCK BIT(0)
+
 /**
  * struct fpga_manager - fpga manager structure
  * @name: name of low level fpga manager
+ * @cdev: char device interface
  * @dev: fpga manager device
  * @ref_mutex: only allows one reference to fpga manager
  * @state: state of fpga manager
  * @mops: pointer to struct of fpga manager ops
  * @priv: low level driver private date
+ * @flags: manager status bits
+ * @lock: it protects: flags
+ * @usr_mutex: only allows one user to program the FPGA
  */
 struct fpga_manager {
        const char *name;
+       struct cdev cdev;
        struct device dev;
        struct mutex ref_mutex;
        enum fpga_mgr_states state;
        const struct fpga_manager_ops *mops;
        void *priv;
+
+       DECLARE_BITMAP(flags, FPGA_MGR_FLAG_BITS);
+       struct spinlock lock;
+       struct mutex usr_mutex;
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
-- 
2.15.0


-- 
Federico Vaga
[BE-CO-HT]
