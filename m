Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH] Documentation: fpga: cleanup
Date: Tue, 29 May 2018 12:55:59 -0500
Message-Id: <20180529175600.3672-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

This patch fixes the minor spelling/typos/etc that Randy Dunlap
pointed out in his review.

This patch applies cleanly on char-misc-next; kernel-doc builds
with no warnings for fpga docs.

Thanks,
Alan

Alan Tull (1):
  Documentation: fpga: cleanup

 Documentation/driver-api/fpga/fpga-mgr.rst    | 12 ++++++------
 Documentation/driver-api/fpga/fpga-region.rst | 12 ++++++------
 Documentation/driver-api/fpga/intro.rst       | 14 +++++++-------
 3 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.7.4
