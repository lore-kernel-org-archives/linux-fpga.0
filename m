Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/2] fpga fixes
Date: Wed, 27 Jun 2018 20:56:17 -0500
Message-Id: <1530150979-5693-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these two patches of fixes for FPGA.  They apply cleanly on
current linux-next.  They were reviewed on the mailing list.

Alan

Alan Tull (1):
  Documentation: fpga: cleanup

Christophe Jaillet (1):
  fpga: altera-cvp: Fix an error handling path in 'altera_cvp_probe()'

 Documentation/driver-api/fpga/fpga-mgr.rst    | 12 ++++++------
 Documentation/driver-api/fpga/fpga-region.rst | 12 ++++++------
 Documentation/driver-api/fpga/intro.rst       | 14 +++++++-------
 drivers/fpga/altera-cvp.c                     |  6 ++++--
 4 files changed, 23 insertions(+), 21 deletions(-)

-- 
2.7.4
