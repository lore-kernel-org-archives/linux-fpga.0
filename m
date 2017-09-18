Return-Path: <SRS0=iJay=AT=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=iJay=AT=linuxfoundation.org=gregkh@kernel.org>
Date: Mon, 18 Sep 2017 12:17:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] driver core: remove DRIVER_ATTR
Message-ID: <20170918101757.GB30415@kroah.com>
References: <20170918101736.GA30415@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918101736.GA30415@kroah.com>
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


DRIVER_ATTR is no longer in use, and driver authors should be using
DRIVER_ATTR_RW() or DRIVER_ATTR_RO() or DRIVER_ATTR_WO() instead in
order to always get the permissions correct.  So remove it so that no
one can use it anymore.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-model/driver.txt | 7 ++++---
 Documentation/filesystems/sysfs.txt   | 3 ++-
 include/linux/device.h                | 2 --
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-model/driver.txt b/Documentation/driver-model/driver.txt
index 4421135826a2..d661e6f7e6a0 100644
--- a/Documentation/driver-model/driver.txt
+++ b/Documentation/driver-model/driver.txt
@@ -196,12 +196,13 @@ struct driver_attribute {
 };
 
 Device drivers can export attributes via their sysfs directories. 
-Drivers can declare attributes using a DRIVER_ATTR macro that works
-identically to the DEVICE_ATTR macro. 
+Drivers can declare attributes using a DRIVER_ATTR_RW and DRIVER_ATTR_RO
+macro that works identically to the DEVICE_ATTR_RW and DEVICE_ATTR_RO
+macros.
 
 Example:
 
-DRIVER_ATTR(debug,0644,show_debug,store_debug);
+DRIVER_ATTR_RW(debug);
 
 This is equivalent to declaring:
 
diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
index 24da7b32c489..9a3658cc399e 100644
--- a/Documentation/filesystems/sysfs.txt
+++ b/Documentation/filesystems/sysfs.txt
@@ -366,7 +366,8 @@ struct driver_attribute {
 
 Declaring:
 
-DRIVER_ATTR(_name, _mode, _show, _store)
+DRIVER_ATTR_RO(_name)
+DRIVER_ATTR_RW(_name)
 
 Creation/Removal:
 
diff --git a/include/linux/device.h b/include/linux/device.h
index c6f27207dbe8..2bc70ddda09b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -307,8 +307,6 @@ struct driver_attribute {
 			 size_t count);
 };
 
-#define DRIVER_ATTR(_name, _mode, _show, _store) \
-	struct driver_attribute driver_attr_##_name = __ATTR(_name, _mode, _show, _store)
 #define DRIVER_ATTR_RW(_name) \
 	struct driver_attribute driver_attr_##_name = __ATTR_RW(_name)
 #define DRIVER_ATTR_RO(_name) \
-- 
2.14.1
