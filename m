Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [RFC 0/2] of: Add whitelist
Date: Mon, 27 Nov 2017 14:58:02 -0600
Message-Id: <1511816284-12145-1-git-send-email-atull@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Here's a proposal for a whitelist to lock down the dynamic device tree.

For an overlay to be accepted, all of its targets are required to be
on a target node whitelist.

Currently the only way I have to get on the whitelist is calling a
function to add a node.  That works for fpga regions, but I think
other uses will need a way of having adding specific nodes from the
base device tree, such as by adding a property like 'allow-overlay;'
or 'allow-overlay = "okay";' If that is acceptable, I could use some
advice on where that particular code should go.

Alan

Alan Tull (2):
  of: overlay: add whitelist
  fpga: of region: add of-fpga-region to whitelist

 drivers/fpga/of-fpga-region.c |  9 ++++++
 drivers/of/overlay.c          | 73 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h            | 12 +++++++
 3 files changed, 94 insertions(+)

-- 
2.7.4
