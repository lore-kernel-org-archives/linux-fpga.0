Return-Path: <SRS0=vJnv=K2=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=vJnv=K2=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from smtp2.macqel.be ([109.135.2.61]:53381 "EHLO smtp2.macqel.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbeHKRmW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Aug 2018 13:42:22 -0400
Date: Sat, 11 Aug 2018 17:01:43 +0200
From: Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA
        programming
Message-ID: <20180811150143.GA1940@frolo.macqel>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-fpga@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

On Mon, Dec 04, 2017 at 01:43:15PM +0000, Thomas Petazzoni wrote:
> The current FPGA subsystem only allows programming the FPGA bitstream
> through Device Tree overlays. This assumes that the devices inside the
> FPGA are described through a Device Tree.
> 
> However, some platforms have their FPGA connected to the main CPU over
> PCIe and the devices in the FPGA are therefore dynamically
> discoverable using the normal PCIe enumeration mechanisms. There is
> therefore no Device Tree overlay describing the devices in the
> FPGA. Furthermore, on my platform (an old SH7786), there is no Device
> Tree at all, as there is no support for Device Tree for this SoC.
> 
> Adding a userspace interface to trigger the programming of the FPGA
> has already been requested in the past (see [1]) showing that there is
> a need for such a feature.
> 
> This commit therefore introduces a very simple interface, in the form
> of a "load" sysfs file. Writing the name of the firmware file to
> program into the FPGA to this "load" file triggers the programming
> process.

Thank you for your patch.  I have used it succesfully to program and
reprogram with different bit files an 'invisible' FPGA which is actually
a piece of hardware bridging a Sub LVDS CMOS sensor output to a CSI
MIPI-2 input.

If this patch is not suitable in the general case it could at least be
made available for development context.

Attached is a small patch on top of yours that fixes a minor annoyance
when using 'echo' without the '-n' option.

Philippe
-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles

--k+w/mQv8wyuph6w0
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-FIX-fpga-add-simple-userspace-interface-to-trigger-F.patch"

From 284a904c4f8bf3978735d234c7ee2bacfd10edaf Mon Sep 17 00:00:00 2001
From: Philippe De Muyter <phdm@macqel.be>
Date: Fri, 10 Aug 2018 09:35:41 +0200
Subject: [PATCH] FIX "fpga: add simple userspace interface to trigger FPGA
 programming"

When fpga-mgr load_store strips the received string to remove the
terminating '\n', it should still return the whole count, not the
stripped one.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>
---
 drivers/fpga/fpga-mgr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 751a447..61492787 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -404,11 +404,15 @@ static ssize_t load_store(struct device *dev,
 	struct fpga_manager *mgr = to_fpga_manager(dev);
 	char *name;
 	int ret;
+	size_t stripped_count = count;
 
 	if (count > 0 && buf[count - 1] == '\n')
-		count--;
+		stripped_count--;
 
-	name = kstrndup(buf, count, GFP_KERNEL);
+	if (!stripped_count)
+		return count;
+
+	name = kstrndup(buf, stripped_count, GFP_KERNEL);
 	if (!name)
 		return -ENOSPC;
 
-- 
2.7.4


--k+w/mQv8wyuph6w0--
