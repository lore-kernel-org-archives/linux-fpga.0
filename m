Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/2] fpga: add attribute groups
Date: Tue, 22 Aug 2017 10:53:53 -0500
Message-Id: <20170822155355.3896-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Anatolij Gustschin <agust@denx.de>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Make it easy to add device attribute groups when registering an FPGA
manager, bridge, or region.  This way, the sysfs attributes are added
in device_add instead of afterwards which can lead to race
conditions [1].

Patch 1: add groups to the structs that are used when a manager, bridge,
or region is registered.

Patch 2: changes to altera cvp FPGA manager to use this method of
registering.

I've tested this method on platform devices.  Patch 2 builds but is
untested.

This patchset is dependent on my "non-dt support" patchset currently
under review.

[1] http://www.kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/

Alan Tull (2):
  fpga: add attribute groups
  fpga: altera-cvp: register attribute groups using ops

 drivers/fpga/altera-cvp.c        | 39 +++++++++++++++++++--------------------
 drivers/fpga/fpga-bridge.c       |  1 +
 drivers/fpga/fpga-mgr.c          |  1 +
 drivers/fpga/fpga-region.c       |  1 +
 include/linux/fpga/fpga-bridge.h |  2 ++
 include/linux/fpga/fpga-mgr.h    |  2 ++
 include/linux/fpga/fpga-region.h |  2 ++
 7 files changed, 28 insertions(+), 20 deletions(-)

-- 
2.7.4
