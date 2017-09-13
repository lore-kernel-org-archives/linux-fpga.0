Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v4 00/18]  Enable upper layers using FPGA region w/o device tree
Date: Wed, 13 Sep 2017 15:48:23 -0500
Message-Id: <20170913204841.2730-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

* Change the fpga-mgr API to have one fpga_mgr_load function
  instead of three.

* Expose API functions for FPGA region

* Separate common FPGA region code from Device Tree support

* Add API functions for bridges where DT is not used.

This is needed because the current FPGA layer has a couple of problems:

* We now have 3 functions for programming a FPGA, depending on whether
the image is in a sg list, a buffer, or firmware.  So upper layers
have to be written assuming where the image will be or will have to
write extra code to maintain flexibility.

* users who aren't using device tree are left to write their
own code that is essentially a rewrite of FPGA region.

Mostly this patch set consists of small patches that rework the
FPGA region support, followed by one big patch that moves the
device tree FPGA region support to a separate file of-fpga-region.c.

v4 adds 3 patches:
* patch 16 supports overlays that don't program the fpga, such as
  an overlay that adds the devices that are in the static region
  of the FPGA
* patch 17 that cleans up the drivers/fpga/Kconfig
* patch 18 allows adding attribute groups when registering a
  fpga manager, bridge, or region.

v4 changes:
* Squashed v3's patch 1 (documentation) and patch 3 (api change)
* Fixes in function that allocates/frees fpga image info.
* Save the device that owns the image info in the image info struct.

These patches have been pushed to the linux-fpga kernel.org repo as
branch review-next-20170913-fpga-region-v4 for reviewing
convenience.

Alan Tull (18):
  fpga: bridge: support getting bridge from device
  fpga: mgr: API change to replace fpga load functions with single
    function
  fpga: mgr: separate getting/locking FPGA manager
  fpga: region: use dev_err instead of pr_err
  fpga: region: remove unneeded of_node_get and put
  fpga: region: get mgr early on
  fpga: region: check for child regions before allocing image info
  fpga: region: fix slow warning with more than one overlay
  fpga: region: use image info as parameter for programming region
  fpga: region: separate out code that parses the overlay
  fpga: region: add fpga-region.h header
  fpga: region: rename some functions prior to moving
  fpga: region: add register/unregister functions
  fpga: region: add fpga_region_class_find
  fpga: region: move device tree support to of-fpga-region.c
  fpga: of-fpga-region: accept overlays that don't program FPGA
  fpga: clean up fpga Kconfig
  fpga: add attribute groups

 Documentation/fpga/fpga-mgr.txt    | 132 +++++-----
 Documentation/fpga/fpga-region.txt |  95 +++++++
 Documentation/fpga/overview.txt    |  23 ++
 drivers/fpga/Kconfig               | 102 ++++----
 drivers/fpga/Makefile              |   1 +
 drivers/fpga/fpga-bridge.c         | 111 +++++++--
 drivers/fpga/fpga-mgr.c            | 121 +++++++--
 drivers/fpga/fpga-region.c         | 464 ++++------------------------------
 drivers/fpga/of-fpga-region.c      | 496 +++++++++++++++++++++++++++++++++++++
 include/linux/fpga/fpga-bridge.h   |   9 +-
 include/linux/fpga/fpga-mgr.h      |  33 ++-
 include/linux/fpga/fpga-region.h   |  40 +++
 12 files changed, 1036 insertions(+), 591 deletions(-)
 create mode 100644 Documentation/fpga/fpga-region.txt
 create mode 100644 Documentation/fpga/overview.txt
 create mode 100644 drivers/fpga/of-fpga-region.c
 create mode 100644 include/linux/fpga/fpga-region.h

-- 
2.7.4
