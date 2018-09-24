Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
From: Alan Tull <atull@kernel.org>
Date: Mon, 24 Sep 2018 15:32:44 -0500
Message-ID: <CANk1AXQY14NHHoDUKNShvDQCFP-bw7ndU=W9a5G8C1d-p4tDUQ@mail.gmail.com>
Subject: Portable DT Connectors with regard to FPGAs
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Rob Herring <robh+dt@kernel.org>, Moritz Fischer <mdf@kernel.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>
List-ID: <linux-fpga@vger.kernel.org>

My interest here was in having some discussion on whether connectors
are a good match for handling FPGAs.

The relevant use model is where a user applies a DT overlay targeting
an FPGA region after the kernel has booted.  That overlay initiates
FPGA programming and then adds nodes for the new FPGA hardware. This
is discussed more completely in the FPGA manager DT binding document
[1].  The main deal here is that I'd like to be able to add nodes
in/below a FPGA region node to support devices in the FPGA (and be
able also to remove them if we are going to reconfigure the FPGA.)

Previous discussions about DT connectors focused on the types of
things likely to be on a physical connector. GPIO and SPI got named as
good examples for discussion while MMIO specifically was dismissed
[2].  That's problematic for embedded FPGAs for example since the FPGA
is on a mmio bus and hardware that is programmed into the FPGA lives
on that mmio bus similar to any embedded peripherals.  So there's a
question - are mmio busses intended to be left un-connectorizable?

Alan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/fpga/fpga-region.txt

[2] https://lkml.org/lkml/2016/7/20/560
