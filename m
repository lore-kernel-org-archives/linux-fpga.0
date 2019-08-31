Date: Sat, 31 Aug 2019 13:45:30 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] Please pull FPGA Manager changes for 5.4
Message-ID: <20190831204528.GA23936@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit 2949dc443116a66fd1a92d9ef107be16cdd197cd:

  dt-bindings: fpga: Consolidate bridge properties (2019-07-24 14:19:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-cvp-for-5.4

for you to fetch changes up to e58915179f3f4a839ea3b9aeae1c1e13e98e33b1:

  fpga: altera-cvp: Add Stratix10 (V2) Support (2019-08-24 11:38:29 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.4-rc1

Here is the second set of changes for the 5.4 merge window.

This patchset adds support for the v2 revision of Intel (Altera)'s CVP
parts including the Stratix 10.

All of this patches have been reviewed and been in the last few
linux-next releases without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Thor Thayer (3):
      fpga: altera-cvp: Discover Vendor Specific offset
      fpga: altera-cvp: Preparation for V2 parts.
      fpga: altera-cvp: Add Stratix10 (V2) Support

 drivers/fpga/Kconfig      |   6 +-
 drivers/fpga/altera-cvp.c | 339 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 271 insertions(+), 74 deletions(-)
