Return-Path: <SRS0=83J2=VN=linux.intel.com=thor.thayer@kernel.org>
Return-Path: <SRS0=83J2=VN=linux.intel.com=thor.thayer@kernel.org>
From: thor.thayer@linux.intel.com
Subject: [PATCHv2 0/3] fpga: altera-cvp: Add Stratix10 Support
Date: Tue, 16 Jul 2019 17:48:04 -0500
Message-Id: <1563317287-18834-1-git-send-email-thor.thayer@linux.intel.com>
To: mdf@kernel.org, richard.gong@linux.intel.com, agust@denx.de
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Thor Thayer <thor.thayer@linux.intel.com>

Newer versions (V2) of Altera/Intel FPGAs CvP have different PCI
Vendor Specific Capability offsets than the older (V1) Altera/FPGAs.

Most of the CvP registers and their bitfields remain the same
between both the older parts and the newer parts.

This patchset implements changes to discover the Vendor Specific
Capability offset and then add Stratix10 CvP support.

V2 Changes:
  Remove inline designator from abstraction functions.
  Reverse Christmas Tree format for local variables
  Remove redundant mask from credit calculation
  Add commment for the delay(1) function in wait_for_credit()

Thor Thayer (3):
  fpga: altera-cvp: Discover Vendor Specific offset
  fpga: altera-cvp: Preparation for V2 parts.
  fpga: altera-cvp: Add Stratix10 (V2) Support

 drivers/fpga/altera-cvp.c | 326 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 255 insertions(+), 71 deletions(-)

-- 
2.7.4
