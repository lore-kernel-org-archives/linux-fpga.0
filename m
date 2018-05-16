Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 09/14] Documentation: fpga: move fpga overview to driver-api
Date: Wed, 16 May 2018 18:50:02 -0500
Message-Id: <20180516235007.3951-10-atull@kernel.org>
In-Reply-To: <20180516235007.3951-1-atull@kernel.org>
References: <20180516235007.3951-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Start of moving Documentation/fpga/*.txt to driver-api, including:
 - Add new directory driver-api/fpga
 - Add new file driver-api/fpga/index.rst
 - Add driver-api/fpga to driver-api/index.rst
 - Move Documentation/fpga/overview.txt to driver-api/fpga/intro.rst
 - Formatting and rewrites so that intro.rst will build cleanly
   and form a good introduction to the rest of the docs to be added.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 Documentation/driver-api/fpga/index.rst | 10 ++++++
 Documentation/driver-api/fpga/intro.rst | 54 +++++++++++++++++++++++++++++++++
 Documentation/driver-api/index.rst      |  1 +
 Documentation/fpga/overview.txt         | 23 --------------
 4 files changed, 65 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/driver-api/fpga/index.rst
 create mode 100644 Documentation/driver-api/fpga/intro.rst
 delete mode 100644 Documentation/fpga/overview.txt

diff --git a/Documentation/driver-api/fpga/index.rst b/Documentation/driver-api/fpga/index.rst
new file mode 100644
index 0000000..71e568a
--- /dev/null
+++ b/Documentation/driver-api/fpga/index.rst
@@ -0,0 +1,10 @@
+==============
+FPGA Subsystem
+==============
+
+:Author: Alan Tull
+
+.. toctree::
+   :maxdepth: 2
+
+   intro
diff --git a/Documentation/driver-api/fpga/intro.rst b/Documentation/driver-api/fpga/intro.rst
new file mode 100644
index 0000000..51cd81d
--- /dev/null
+++ b/Documentation/driver-api/fpga/intro.rst
@@ -0,0 +1,54 @@
+Introduction
+============
+
+The FPGA subsystem supports reprogramming FPGAs dynamically under
+Linux.  Some of the core intentions of the FPGA subsystems are:
+
+* The FPGA subsystem is vendor agnostic.
+
+* The FPGA subsystem separates upper layers (userspace interfaces and
+  enumeration) from lower layers that know how to program a specific
+  FPGA.
+
+* Code should not be shared between upper and lower layers.  This
+  should go without saying.  If that seems necessary, there's probably
+  framework functionality that that can be added that will benefit
+  other users.  Write the linux-fpga mailing list and maintainers and
+  seek out a solution that expands the framework for broad reuse.
+
+* Generally, when adding code, think of the future.  Plan for re-use.
+
+The framework in the kernel is divided into:
+
+FPGA Manager
+------------
+
+If you are adding a new FPGA or a new method of programming a FPGA,
+this is the subsystem for you.  Low level FPGA manager drivers contain
+the knowledge of how to program a specific device.  This subsystem
+includes the framework in fpga-mgr.c and the low level drivers that
+are registered with it.
+
+FPGA Bridge
+-----------
+
+FPGA Bridges prevent spurious signals from going out of a FPGA or a
+region of a FPGA during programming.  They are disabled before
+programming begins and re-enabled afterwards.  An FPGA bridge may be
+actual hard hardware that gates a bus to a cpu or a soft ("freeze")
+bridge in FPGA fabric that surrounds a partial reconfiguration region
+of an FPGA.  This subsystem includes fpga-bridge.c and the low level
+drivers that are registered with it.
+
+FPGA Region
+-----------
+
+If you are adding a new interface to the FPGA framework, add it on top
+of a FPGA region to allow the most reuse of your interface.
+
+The FPGA Region framework (fpga-region.c) associates managers and
+bridges as reconfigurable regions.  A region may refer to the whole
+FPGA in full reconfiguration or to a partial reconfiguration region.
+
+The Device Tree FPGA Region support (of-fpga-region.c) handles
+reprogramming FPGAs when device tree overlays are applied.
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 7b12b6b..6d9f2f9 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -52,6 +52,7 @@ available subsections can be seen below.
    dmaengine/index
    slimbus
    soundwire/index
+   fpga/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/fpga/overview.txt b/Documentation/fpga/overview.txt
deleted file mode 100644
index 0f1236e..0000000
--- a/Documentation/fpga/overview.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Linux kernel FPGA support
-
-Alan Tull 2017
-
-The main point of this project has been to separate the out the upper layers
-that know when to reprogram a FPGA from the lower layers that know how to
-reprogram a specific FPGA device.  The intention is to make this manufacturer
-agnostic, understanding that of course the FPGA images are very device specific
-themselves.
-
-The framework in the kernel includes:
-* low level FPGA manager drivers that know how to program a specific device
-* the fpga-mgr framework they are registered with
-* low level FPGA bridge drivers for hard/soft bridges which are intended to
-  be disable during FPGA programming
-* the fpga-bridge framework they are registered with
-* the fpga-region framework which associates and controls managers and bridges
-  as reconfigurable regions
-* the of-fpga-region support for reprogramming FPGAs when device tree overlays
-  are applied.
-
-I would encourage you the user to add code that creates FPGA regions rather
-that trying to control managers and bridges separately.
-- 
2.7.4
