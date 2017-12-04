Return-Path: <SRS0=wyNS=DA=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=wyNS=DA=free-electrons.com=thomas.petazzoni@kernel.org>
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] fpga: add simple userspace interface to trigger FPGA programming
Date: Mon,  4 Dec 2017 16:43:15 +0100
Message-Id: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-ID: <linux-fpga@vger.kernel.org>

The current FPGA subsystem only allows programming the FPGA bitstream
through Device Tree overlays. This assumes that the devices inside the
FPGA are described through a Device Tree.

However, some platforms have their FPGA connected to the main CPU over
PCIe and the devices in the FPGA are therefore dynamically
discoverable using the normal PCIe enumeration mechanisms. There is
therefore no Device Tree overlay describing the devices in the
FPGA. Furthermore, on my platform (an old SH7786), there is no Device
Tree at all, as there is no support for Device Tree for this SoC.

Adding a userspace interface to trigger the programming of the FPGA
has already been requested in the past (see [1]) showing that there is
a need for such a feature.

This commit therefore introduces a very simple interface, in the form
of a "load" sysfs file. Writing the name of the firmware file to
program into the FPGA to this "load" file triggers the programming
process.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/443034.html

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/ABI/testing/sysfs-class-fpga-manager | 11 +++++++++
 drivers/fpga/fpga-mgr.c                            | 28 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-manager b/Documentation/ABI/testing/sysfs-class-fpga-manager
index 23056c532fdd..46785ad8b878 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-manager
+++ b/Documentation/ABI/testing/sysfs-class-fpga-manager
@@ -35,3 +35,14 @@ Description:	Read fpga manager state as a string.
 		* write complete	= Doing post programming steps
 		* write complete error	= Error while doing post programming
 		* operating		= FPGA is programmed and operating
+
+What:		/sys/class/fpga_manager/<fpga>/load
+Date:		December 2017
+KernelVersion:	4.16
+Contact:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+
+Description:	Program a bitstream firmware into the FPGA.
+
+		Writing the name of a firmware file into this "load"
+		file will trigger the programming of the FPGA using
+		that firmware.
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 188ffefa3cc3..1c7ca77c96c2 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -351,12 +351,40 @@ static ssize_t state_show(struct device *dev,
 	return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
+static ssize_t load_store(struct device *dev,
+			  struct device_attribute *attr, const char *buf,
+			  size_t count)
+{
+	struct fpga_manager *mgr = to_fpga_manager(dev);
+	char *name;
+	int ret;
+
+	if (count > 0 && buf[count - 1] == '\n')
+		count--;
+
+	name = kstrndup(buf, count, GFP_KERNEL);
+	if (!name)
+		return -ENOSPC;
+
+	ret = fpga_mgr_firmware_load(mgr, NULL, name);
+	if (ret < 0) {
+		kfree(name);
+		return ret;
+	}
+
+	kfree(name);
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(state);
+static DEVICE_ATTR_WO(load);
 
 static struct attribute *fpga_mgr_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_state.attr,
+	&dev_attr_load.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
-- 
2.13.6
