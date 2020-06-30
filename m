Return-Path: <SRS0=eHqO=AL=redhat.com=trix@kernel.org>
Return-Path: <SRS0=eHqO=AL=redhat.com=trix@kernel.org>
From: trix@redhat.com
Subject: [RFC 0/1] fpga: dfl: RFC PCI config
Date: Tue, 30 Jun 2020 10:16:55 -0700
Message-Id: <20200630171656.20151-1-trix@redhat.com>
Content-Type: text/plain; charset=US-ASCII
To: hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc: linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Tom Rix <trix@redhat.com>

This configury shows where I would like the dfl pci cards to go
by introducing future cards as well as the current pac 10 card.

The goal is to fully configure the card in the drivers/fpga
area of the config.  Collecting configury of the fpga/ parts
as well as the subdevices scattered over the tree.

The user is not prevented from manually picking the equivlent.

Some documentation started to track the subdevices needed
that are not in the fpga dir as well as guiding the user to
identify the appropriate top level config.


Tom Rix (1):
  fpga: dfl: RFC PCI config

 Documentation/fpga/dfl.rst | 33 +++++++++++++++++++++++++++++++++
 drivers/fpga/Kconfig       | 28 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

-- 
2.18.1
