Return-Path: <SRS0=sUDD=K7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=sUDD=K7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:49504
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389224AbeHPKPI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Aug 2018 06:15:08 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Date: Thu, 16 Aug 2018 09:18:06 +0200
Message-ID: <10047668.mDZqRoECEV@pcbe13614>
In-Reply-To: <CANk1AXTWZk2bA2ysK+1ZEMGUo5rd8GaVoRi+MH8Fwsxs1H0RYA@mail.gmail.com>
References: <4617134.5euanDEBgJ@pcbe13614> <2076282.DFHNtXLtgF@harkonnen> <CANk1AXTWZk2bA2ysK+1ZEMGUo5rd8GaVoRi+MH8Fwsxs1H0RYA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Hi alan,

inline comments

On Wednesday, August 15, 2018 11:02:12 PM CEST Alan Tull wrote:
> On Wed, Jul 18, 2018 at 4:47 PM, Federico Vaga <federico.vaga@cern.ch> 
wrote:
> > Hi Alan,
> > 
> > Thanks for your time, comments below
> > 
> > On Wednesday, July 18, 2018 9:47:24 PM CEST Alan Tull wrote:
> >> On Thu, Jun 28, 2018 at 2:50 AM, Federico Vaga <federico.vaga@cern.ch>
> > 
> > wrote:
> >> > On Wednesday, 27 June 2018 23:23:07 CEST Alan Tull wrote:
> >> >> On Wed, Jun 27, 2018 at 4:25 AM, Federico Vaga
> >> > 
> >> > <federico.vaga@cern.ch> wrote:
> >> >> > Hi Alan,
> >> >> > 
> >> >> > On Tuesday, 26 June 2018 23:00:46 CEST Alan Tull wrote:
> >> >> >> On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga
> >> >> >> <federico.vaga@cern.ch> wrote:
> >> >> >> 
> >> >> >> Hi Federico,
> >> >> >> 
> >> >> >> >> > What is buggy is the function fpga_mgr_get().
> >> >> >> >> > That patch has been done to allow multiple FPGA manager
> >> >> >> >> > instances
> >> >> >> >> > to be linked to the same device (PCI it says). But function
> >> >> >> >> > fpga_mgr_get() will return only the first found: what about
> >> >> >> >> > the
> >> >> >> >> > others?
> >> 
> >> Looking at this further, no code change is needed in the FPGA API to
> >> support multiple managers.  A FPGA manager driver is a self-contained
> >> platform driver.  The PCI driver for a board that contains multiple
> >> FPGAs should create a platform device for each manager and save each
> >> of those devs in its pdata.
> >> 
> >> >> >> >> > Then, all load kernel-doc comments says:
> >> >> >> >> > 
> >> >> >> >> > "This code assumes the caller got the mgr pointer from
> >> >> >> >> > of_fpga_mgr_get() or fpga_mgr_get()"
> >> >> >> >> > 
> >> >> >> >> > but that function does not allow me to get, for instance,
> >> >> >> >> > the
> >> >> >> >> > second FPGA manager on my card.
> >> 
> >> fpga_mgr_get() will do what you want if your PCI driver creates a
> >> platform device per FPGA manager as mentioned above.
> >> 
> >> >> >> >> > Since, thanks to this patch I'm actually the creator of the
> >> >> >> >> > fpga_manager structure,  I do not need to use fpga_mgr_get()
> >> >> >> >> > to
> >> >> >> >> > retrieve that data structure.
> >> 
> >> The creator of the FPGA mgr structure is the low level FPGA manager
> >> driver, not the PCIe driver.
> > 
> > In my case it is.
> > It's a bit like where SPI driver is the low level FPGA manager driver for
> > the xilinx-spi.c. But if I understand what you mean, I should always have
> > a
> > platform_driver just for the FPGA manager even if it has a 1:1 relation
> > with its carrier? In other words, I write two drivers:
> > - one for the FPGA manager
> > - one for the PCI device that then register the FPGA manager driver
> > 
> > In my case the FPGA programmed is also the PCIe bridge (GN4124). Probably
> > I
> > can do it anyway, because the part dedicated to FPGA programming is quite
> > independent from the rest (don't remember all details)
> > 
> >> >> >> >> > Despite this, I believe we still need to increment the
> >> >> >> >> > module
> >> >> >> >> > reference counter (which is done by fpga_mgr_get()).
> >> 
> >> This is only done in the probe function of a FPGA region driver.
> >> 
> >> >> >> >> > We can fix this function by just replacing the argument from
> >> >> >> >> > 'device' to 'fpga_manager' (the one returned by create() ).
> >> >> >> >> 
> >> >> >> >> At first thought, that's what I'd want.
> >> >> >> >> 
> >> >> >> >> > Alternatively, we
> >> >> >> >> > can add an 'owner' field in "struct fpga_manager_ops" and
> >> >> >> >> > 'get'
> >> >> >> >> > it
> >> >> >> >> > when we use it. Or again, just an 'owner' argument in the
> >> >> >> >> > create()
> >> >> >> >> > function.
> >> >> >> >> 
> >> >> >> >> It seems like we shouldn't have to do that.
> >> >> >> > 
> >> >> >> > Why?
> >> >> >> 
> >> >> >> OK yes, I agree; the kernel has a lot of examples of doing this.
> >> >> >> 
> >> >> >> I'll have to play with it, I'll probably add the owner arg to the
> >> >> >> create function, add owner to struct fpga_manager, and save.
> >> >> > 
> >> >> > I have two though about this.
> >> >> > 
> >> >> > 1. file_operation like approach. The onwer is associated to the
> >> >> > FPGA manager operation. Whenever the FPGA manager wants to use an
> >> >> > operation it get/put the module owner of these operations
> >> >> > (because this is what we need to protect). With this the user is
> >> >> > not directly involved, read it as less code, less things to care
> >> >> > about. And probably there is no need for fpga_manager_get().
> >> >> 
> >> >> How does try_module_get fit into this scheme?  I think this proposal
> >> >> #1 is missing the point of what the reference count increment is
> >> >> meant to do.  Or am I misunderstanding?  How does that keep the
> >> >> module from being unloaded 1/3 way through programming a FPGA?
> >> >> IIUC you are saying that the reference count would be incremented
> >> >> before doing the manager ops .write_init, then decremented again
> >> >> afterwards, incremented before each call to .write, decremented
> >> >> afterwards, then the same for .write_complete.
> >> > 
> >> > I'm not saying to do module_get/put just around the mops->XXX(): it's
> >> > too much. Just where you have this comment:
> >> > 
> >> > "This code assumes the caller got the mgr pointer from
> >> > of_fpga_mgr_get() or fpga_mgr_get()"
> >> > 
> >> > Because, currently, it's here where we do module_get()
> >> 
> >> No it's not.
> > 
> > It is not in the code, but the comment says that we should do it before
> > calling fpga_mgr_load()
> > 
> >> fpga_mgr_get() or of_fpga_mgr_get() is called when the region is
> >> created such as in of-fpga-region's probe.  That way, as long as the
> >> region exists, the manager won't be unloaded.  If someone wants to
> >> start unloading modules, they need to unload higher level ones first,
> >> so they'll have to unload the region before mgr.
> >> 
> >> > Most mops are invoked within a set of static functions which are
> >> > called only by few exported functions. I'm suggesting to do
> >> > module_get/put in those exported function at the beginning (get) and
> >> > and the end (put) because we know that within these functions, here
> >> > and there, we will use mops which are owned by a different module.
> >> > We do not want the module owner of the mops to disappear while someone
> >> > is doing fpga_mgr_load(). For example, inside fpga_mgr_load() we use
> >> > most of the mops, so we 'get' the module at the beginning and 'put' it
> >> > at the end. The same for fpga_region_program_fpga().
> >> 
> >> If we do it the way you are suggesting, then someone can unload the
> >> manager module without unloading the region.  The region code will be
> >> in for a nasty surprise when programming is attempted.
> > 
> > Of course, this should be taken into account. I was not suggesting a
> > precise implementation, but only the idea to hide get/put. Probably there
> > other things as well that I'm not considering (indeed I do not have a
> > patch, but just a comment)
> > 
> >> > Like this we do not have to ask users to do fpga_mgr_get()/put().
> >> 
> >> The only user who has to do this is a region's probe function.
> >> 
> >> I'm assuming that only fpga_region is using fpga_mgr_load() and
> >> anybody who is creating a region uses fpga_region_program_fpga().
> >> That's what I want to encourage anyway.  I should probably move
> >> fpga_mgr_load to a private header.
> > 
> > All right, if this is what you want to encourage I do not have anything to
> > say because I did exactly what you do not want to encourage :)
> > 
> > For me this change everything because I do not use regions since I do not
> > have them. The way the API is exposed to me did not encouraged me to use
> > their API. In addition, the documentation guides me directly to the FPGA
> > manager.
> 
> The documentation says:
> 
> "If you are adding a new interface to the FPGA framework, add it on
> top of a FPGA region to allow the most reuse of your interface."

I would change this in something like:

"If you are adding a new interface to the FPGA framework, add it on
top of a FPGA region."

What I understand from the current statement is:
"if you care about re-usability, add your interface on top of an FPGA region" 
Since in my special case, I do not care about re-usability, I skipped the FPGA 
region.

> https://www.kernel.org/doc/html/latest/driver-api/fpga/intro.html
> 
> But the stuff that I submitted yesterday goes back through the docs to
> clear out anything that is not clear about this.
> 
> > To be honest I did not have much time to look at the region code. My
> > understanding, after a quick look, is that it works great with
> > device-tree.
> 
> It is used by the DFL framework which doesn't use device tree.
> 
> > But what if I do not have it? Actually, I cannot use device-tree because
> > of
> > environment limitations and Linux version in use. Oops, this implies that
> > I
> > back-ported the FPGA manager to an older Linux version? Yes, guilty :)
> 
> I separated region code from its device-tree dependencies.  But if you
> can't use device-tree, then you end up having to implement some of the
> things DT gives you for free.

unfortunately yes

> > Anyway, I'm using the API exposed, and if part of the assumptions behind
> > this API is that I should use device-tree, then I'm out of scope.
> > 
> > <chatting>
> > Just for chatting. One addition I made for the FPGA manager is to support
> > 
> > dynamic loading of FPGA code using char devices. Something like:
> >    dd if=binary.bin of=/dev/fpga0
> >    cat binary.bin > /dev/fpga0
> 
> Since it's not handling the bridge, there's some risk involved.
> 
> > We do not have device tree, and we do not have binaries in /lib/firmware.
> > It's quite handy to quickly load a binary just synthesized, especially for
> > debugging purpose.
> 
> Like a debugfs?
> 
> https://lkml.org/lkml/2018/8/2/125
> 
> But for a debugging/developing, I have a debugfs that was a downstream
> patchset that I'm cleaning for submission.

Yes, like that more or less.

I did a chardevice in /dev/ because in our environment debugfs is not mounted 
automatically and we need this feature also operationally. But yes, that's the 
idea.

One comment. The code on github [1] looks like it is assuming that on 
userspace people write the full image in one shot and it is smaller that 4MiB. 
What I did is to build a scatterlist in order to support the following case:

cat image.bin > /sys/kernel/debug/.../image

where `cat` write 4K at time. And it can be bigger than 4M

[1] https://github.com/altera-opensource/linux-socfpga/blob/socfpga-4.17/
drivers/fpga/fpga-mgr-debugfs.c

Below (end of this email) the patch I quickly did last year. Unfortunately I 
do not have the time to clean this solution, so it is the very first thing I 
implemented without many thoughts (that's why I never pushed this patch).


> > If you are interested I can try to clean it up (at some
> > point, probably in autumn), or I can show you the code in private for a
> > quick look.
> > </chatting>
> > 
> >> > <Parenthesis>
> >> > fpga_region_program_fpga() does not do (today) fpga_mgr_get() because
> >> > it assumes, but it is not enforced, that both fpga_region and fpga_mgr
> >> > are child of the same device.
> >> 
> >> fpga_region_program_fpga() doesn't do fpga_mgr_get() becuase
> >> fpga_mgr_get() happens when the fpga_region probes.  The assumption I
> >> am making is that nobody other than a region is calling
> >> fpga_manager_load().  I should create a fpga_private.h and move
> >> fpga_manager_load() out of fpga-mgr.h to make that official.
> > 
> > Yes, I agree. If what I'm doing is not supposed to happen I should not be
> > allowed to do it :)
> > 
> > <suggestion>
> > If you want to encourage people to use regions rather than the manager
> > directly, have you though about changing the API and merge in a single
> > module fpga-mgr and fpga-region?
> > 
> > Brainstorming. Perhaps, it is possible to have a `struct fpga_region_info`
> > and when we register and FPGA manager we use something like:
> > 
> > struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> > 
> >                                      const struct fpga_manager_ops *mops,
> >                      
> >                      struct fpga_region_info *info, int n_regions,
> >                      
> >                                      void *priv)
> > 
> > So those regions will be created directly and the interface will be
> > smaller
> > and easier.
> > 
> > Don't waste much time on this suggestion, as I said before I did not study
> > much the fpga-region.c code and perhaps this is not possible and I'm just
> > speaking rubbish :)
> > </suggestion>
> > 
> >> > Probably this is true 99.99% of the
> >> > time.
> >> > Let me open in parallel another point: why fpga_region is not a child
> >> > of fpga_manager?
> >> 
> >> FPGA regions are children of FPGA bridges.
> >> 
> >> Alan
> > 
> > --
> > Federico Vaga
> > [BE-CO-HT]
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


------
From d6a6df9515c5e92cc74b8948c3c10ac9cbeec6d2 Mon Sep 17 00:00:00 2001
From: Federico Vaga <federico.vaga@vaga.pv.it>
Date: Mon, 20 Nov 2017 14:40:26 +0100
Subject: [PATCH] fpga: program from user-space

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/fpga/fpga-mgr.txt |   3 +
 drivers/fpga/fpga-mgr.c         | 261 ++++++++++++++++++++++++++++++++++++++
+-
 include/linux/fpga/fpga-mgr.h   |  19 +++
 3 files changed, 281 insertions(+), 2 deletions(-)

diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-mgr.txt
index 78f197f..397dae9 100644
--- a/Documentation/fpga/fpga-mgr.txt
+++ b/Documentation/fpga/fpga-mgr.txt
@@ -197,3 +197,6 @@ to put the FPGA into operating mode.
 The ops include a .state function which will read the hardware FPGA manager 
and
 return a code of type enum fpga_mgr_states.  It doesn't result in a change in
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
+	void *data;
+	size_t size;
+	struct list_head list;
+};
+#define CHUNK_MAX_SIZE (PAGE_SIZE)
+
+/**
+ * struct fpga_user_load - structure to handle configuration from user-space
+ * @mgr: pointer to the FPGA manager
+ * @chunk_list: HEAD point of a linked list of FPGA chunks
+ * @n_chunks: number of chunks in the list
+ * @lock: it protects: chunk_list, n_chunks
+ */
+struct fpga_user_load {
+	struct fpga_manager *mgr;
+	struct list_head chunk_list;
+	unsigned int n_chunks;
+	struct spinlock lock;
+};
+
+
+/**
+ * It sets by default a huge timeout for configuration coming from user-space
+ * just to play safe.
+ *
+ * FIXME what about sysfs parameters to adjust it? The flag bit in particular
+ */
+struct fpga_image_info default_user_info = {
+	.flags = 0,
+	.enable_timeout_us = 10000000, /* 10s */
+	.disable_timeout_us = 10000000, /* 10s */
+	.config_complete_timeout_us = 10000000, /* 10s */
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
+	struct fpga_manager *mgr = container_of(inode->i_cdev,
+						struct fpga_manager,
+						cdev);
+	struct fpga_user_load *usr;
+	int ret;
+
+	/* Allow the user-space programming only if user unlocked the FPGA */
+	if (!test_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags)) {
+		dev_info(&mgr->dev, "The FPGA programming is locked\n");
+		return -EPERM;
+	}
+
+	ret = mutex_trylock(&mgr->usr_mutex);
+	if (ret == 0)
+		return -EBUSY;
+
+	usr = kzalloc(sizeof(struct fpga_user_load), GFP_KERNEL);
+	if (!usr) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	usr->mgr = mgr;
+	spin_lock_init(&usr->lock);
+	INIT_LIST_HEAD(&usr->chunk_list);
+	file->private_data = usr;
+
+	return 0;
+
+err_alloc:
+	spin_lock(&mgr->lock);
+	clear_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+	spin_unlock(&mgr->lock);
+	mutex_unlock(&mgr->usr_mutex);
+	return ret;
+}
+
+
+static int fpga_mgr_flush(struct file *file, fl_owner_t id)
+{
+	struct fpga_user_load *usr = file->private_data;
+	struct fpga_image_chunk *chunk, *tmp;
+	struct sg_table sgt;
+	struct scatterlist *sg;
+	int err = 0;
+
+	if (!usr->n_chunks)
+		return 0;
+
+	err = sg_alloc_table(&sgt, usr->n_chunks, GFP_KERNEL);
+	if (err)
+		goto out;
+
+	sg = sgt.sgl;
+	list_for_each_entry(chunk, &usr->chunk_list, list) {
+		sg_set_buf(sg, chunk->data, chunk->size);
+		sg = sg_next(sg);
+		if (!sg)
+			break;
+	}
+
+	err = fpga_mgr_buf_load_sg(usr->mgr,
+				   &default_user_info,
+				   &sgt);
+	sg_free_table(&sgt);
+
+out:
+	/* Remove all chunks */
+	spin_lock(&usr->lock);
+	list_for_each_entry_safe(chunk, tmp, &usr->chunk_list, list) {
+		list_del(&chunk->list);
+		kfree(chunk->data);
+		kfree(chunk);
+		usr->n_chunks--;
+	}
+	spin_unlock(&usr->lock);
+
+	return err;
+}
+
+
+static int fpga_mgr_close(struct inode *inode, struct file *file)
+{
+	struct fpga_user_load *usr = file->private_data;
+	struct fpga_manager *mgr = usr->mgr;
+
+	kfree(usr);
+
+	spin_lock(&mgr->lock);
+	clear_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+	spin_unlock(&mgr->lock);
+
+	mutex_unlock(&mgr->usr_mutex);
+
+	return 0;
+}
+
+
+static ssize_t fpga_mgr_write(struct file *file, const char __user *buf,
+			      size_t count, loff_t *offp)
+{
+	struct fpga_user_load *usr = file->private_data;
+	struct fpga_image_chunk *chunk;
+	int err;
+
+	chunk = kmalloc(sizeof(struct fpga_image_chunk), GFP_KERNEL);
+	if (!chunk)
+		return -ENOMEM;
+
+	chunk->size = count > CHUNK_MAX_SIZE ? CHUNK_MAX_SIZE : count;
+	chunk->data = kmalloc(chunk->size, GFP_KERNEL);
+	if (!chunk->data) {
+		err = -ENOMEM;
+		goto err_buf_alloc;
+	}
+
+	err = copy_from_user(chunk->data, buf, chunk->size);
+	if(err)
+		goto err_buf_copy;
+
+	spin_lock(&usr->lock);
+	list_add_tail(&chunk->list, &usr->chunk_list);
+	usr->n_chunks++;
+	spin_unlock(&usr->lock);
+
+	*offp += count;
+
+	return chunk->size;
+
+err_buf_copy:
+	kfree(chunk->data);
+err_buf_alloc:
+	kfree(chunk);
+	return err;
+}
+
+
+/**
+ * Char device operation
+ */
+static const struct file_operations fpga_mgr_fops = {
+	.owner = THIS_MODULE,
+	.open = fpga_mgr_open,
+	.flush = fpga_mgr_flush,
+	.release = fpga_mgr_close,
+	.write  = fpga_mgr_write,
+};
+
+
 static const char * const state_str[] = {
 	[FPGA_MGR_STATE_UNKNOWN] =		"unknown",
 	[FPGA_MGR_STATE_POWER_OFF] =		"power off",
@@ -352,13 +550,43 @@ static ssize_t state_show(struct device *dev,
 	return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
+static ssize_t config_lock_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct fpga_manager *mgr = to_fpga_manager(dev);
+
+	if (test_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags))
+		return sprintf(buf, "unlock\n");
+	return sprintf(buf, "lock\n");
+}
+
+static ssize_t config_lock_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct fpga_manager *mgr = to_fpga_manager(dev);
+
+	spin_lock(&mgr->lock);
+	if (strncmp(buf, "lock" , min(4, (int)count)) == 0)
+		clear_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+	else if (strncmp(buf, "unlock" , min(6, (int)count)) == 0)
+		set_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+	else
+		count = -EINVAL;
+	spin_unlock(&mgr->lock);
+
+	return count;
+}
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(state);
+static DEVICE_ATTR_RW(config_lock);
 
 static struct attribute *fpga_mgr_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_state.attr,
+	&dev_attr_lock.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
@@ -367,6 +595,9 @@ ATTRIBUTE_GROUPS(fpga_mgr);
 static struct device_attribute fpga_mgr_attrs[] = {
 	__ATTR(name, S_IRUGO, name_show, NULL),
 	__ATTR(state, S_IRUGO, state_show, NULL),
+	__ATTR(config_lock, S_IRUGO | S_IWUSR | S_IRGRP | S_IWGRP,
+	       config_lock_show, config_lock_store),
+	__ATTR_NULL,
 };
 #endif
 
@@ -507,6 +738,8 @@ int fpga_mgr_register(struct device *dev, const char 
*name,
 	}
 
 	mutex_init(&mgr->ref_mutex);
+	mutex_init(&mgr->usr_mutex);
+	spin_lock_init(&mgr->lock);
 
 	mgr->name = name;
 	mgr->mops = mops;
@@ -524,12 +757,19 @@ int fpga_mgr_register(struct device *dev, const char 
*name,
 	mgr->dev.parent = dev;
 	mgr->dev.of_node = dev->of_node;
 	mgr->dev.id = id;
+	mgr->dev.devt = MKDEV(MAJOR(fpga_mgr_devt), id);
 	dev_set_drvdata(dev, mgr);
 
 	ret = dev_set_name(&mgr->dev, "fpga%d", id);
 	if (ret)
 		goto error_device;
 
+	cdev_init(&mgr->cdev, &fpga_mgr_fops);
+	mgr->cdev.owner = THIS_MODULE;
+	ret = cdev_add(&mgr->cdev, mgr->dev.devt, 1);
+	if (ret)
+		goto err_cdev;
+
 	ret = device_add(&mgr->dev);
 	if (ret)
 		goto error_device;
@@ -539,6 +779,8 @@ int fpga_mgr_register(struct device *dev, const char 
*name,
 	return 0;
 
 error_device:
+	cdev_del(&mgr->cdev);
+err_cdev:
 	ida_simple_remove(&fpga_mgr_ida, id);
 error_kfree:
 	kfree(mgr);
@@ -572,17 +814,27 @@ static void fpga_mgr_dev_release(struct device *dev)
 {
 	struct fpga_manager *mgr = to_fpga_manager(dev);
 
+	cdev_del(&mgr->cdev);
 	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
 	kfree(mgr);
 }
 
 static int __init fpga_mgr_class_init(void)
 {
+	int err;
+
 	pr_info("FPGA manager framework\n");
 
+	err = alloc_chrdev_region(&fpga_mgr_devt, 0, FPGA_MGR_MAX_DEV,
+				  "fpga_mgr");
+	if (err)
+		return err;
+
 	fpga_mgr_class = class_create(THIS_MODULE, "fpga_manager");
-	if (IS_ERR(fpga_mgr_class))
-		return PTR_ERR(fpga_mgr_class);
+	if (IS_ERR(fpga_mgr_class)) {
+		err = PTR_ERR(fpga_mgr_class);
+		goto err_class;
+	}
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
 	fpga_mgr_class->dev_groups = fpga_mgr_groups;
 #else
@@ -591,12 +843,17 @@ static int __init fpga_mgr_class_init(void)
 	fpga_mgr_class->dev_release = fpga_mgr_dev_release;
 
 	return 0;
+
+err_class:
+	unregister_chrdev_region(fpga_mgr_devt, FPGA_MGR_MAX_DEV);
+	return err;
 }
 
 static void __exit fpga_mgr_class_exit(void)
 {
 	class_destroy(fpga_mgr_class);
 	ida_destroy(&fpga_mgr_ida);
+	unregister_chrdev_region(fpga_mgr_devt, FPGA_MGR_MAX_DEV);
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
+	struct cdev cdev;
 	struct device dev;
 	struct mutex ref_mutex;
 	enum fpga_mgr_states state;
 	const struct fpga_manager_ops *mops;
 	void *priv;
+
+	DECLARE_BITMAP(flags, FPGA_MGR_FLAG_BITS);
+	struct spinlock lock;
+	struct mutex usr_mutex;
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
-- 
2.15.0
