Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v5 00/18] Enable upper layers using FPGA region w/o device tree
Date: Tue, 17 Oct 2017 16:20:13 -0500
Message-Id: <20171017212031.3770-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

* Change the fpga-mgr API to have one fpga_mgr_load function
  instead of three.

* Separate common FPGA region code from Device Tree support

* Expose API functions for FPGA regions

* Add API functions for bridges where DT is not used.

* clean up drivers/fpga/Kconfig

* add attribute groups when registering a fpga manager, bridge, or region.

Needed because the current FPGA layer has a couple of problems:

* We now have 3 functions for programming a FPGA, depending on whether
the image is in a sg list, a buffer, or firmware.  So upper layers
have to be written assuming where the image will be or will have to
write extra code to maintain flexibility.

* users who aren't using device tree are left to write their
own code that is essentially a rewrite of FPGA region.

v5 changes are small:
* add back in fpga_mgr_put in of_fpga_region_remove
* make __fpga_bridge_get static
* move #ifndef before #includes in headers
* Spelling fixes and other nits

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
 drivers/fpga/Kconfig               | 103 ++++----
 drivers/fpga/Makefile              |   1 +
 drivers/fpga/fpga-bridge.c         | 111 +++++++--
 drivers/fpga/fpga-mgr.c            | 121 +++++++--
 drivers/fpga/fpga-region.c         | 464 ++++------------------------------
 drivers/fpga/of-fpga-region.c      | 497 +++++++++++++++++++++++++++++++++++++
 include/linux/fpga/fpga-bridge.h   |  15 +-
 include/linux/fpga/fpga-mgr.h      |  39 ++-
 include/linux/fpga/fpga-region.h   |  40 +++
 12 files changed, 1044 insertions(+), 597 deletions(-)
 create mode 100644 Documentation/fpga/fpga-region.txt
 create mode 100644 Documentation/fpga/overview.txt
 create mode 100644 drivers/fpga/of-fpga-region.c
 create mode 100644 include/linux/fpga/fpga-region.h

-- 
2.7.4
