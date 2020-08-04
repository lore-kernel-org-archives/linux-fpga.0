Return-Path: <SRS0=ZE+O=BO=redhat.com=trix@kernel.org>
Return-Path: <SRS0=ZE+O=BO=redhat.com=trix@kernel.org>
From: trix@redhat.com
Subject: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
Date: Tue,  4 Aug 2020 09:20:03 -0700
Message-Id: <20200804162003.19402-1-trix@redhat.com>
Content-Type: text/plain; charset=US-ASCII
To: hao.wu@intel.com, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Tom Rix <trix@redhat.com>

I take care of fpga kernel and userspace for Red Hat and would
like help out more with the mainline kernel.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce2737b1feb5..6fdb01776413 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6805,6 +6805,7 @@ F:	drivers/net/ethernet/nvidia/*
 
 FPGA DFL DRIVERS
 M:	Wu Hao <hao.wu@intel.com>
+R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/fpga/dfl.rst
@@ -6813,6 +6814,7 @@ F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
+R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 W:	http://www.rocketboards.org
-- 
2.18.1
