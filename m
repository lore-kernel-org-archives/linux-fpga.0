Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v6 00/18] patches for FPGA
Date: Wed, 15 Nov 2017 14:20:10 -0600
Message-Id: <1510777228-4291-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these patches for FPGA that have been reviewed on
the mailing list.  They include some needed FPGA API changes
plus bug fixes. They apply cleanly on next-20171113.

Alan

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
 include/linux/fpga/fpga-bridge.h   |  14 +-
 include/linux/fpga/fpga-mgr.h      |  39 ++-
 include/linux/fpga/fpga-region.h   |  40 +++
 12 files changed, 1044 insertions(+), 596 deletions(-)
 create mode 100644 Documentation/fpga/fpga-region.txt
 create mode 100644 Documentation/fpga/overview.txt
 create mode 100644 drivers/fpga/of-fpga-region.c
 create mode 100644 include/linux/fpga/fpga-region.h

-- 
2.7.4
