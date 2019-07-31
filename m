Date: Tue, 30 Jul 2019 23:26:25 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] Please pull FPGA Manager changes for 5.4
Message-ID: <20190731062622.GA4414@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, broonie@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.4

for you to fetch changes up to 2949dc443116a66fd1a92d9ef107be16cdd197cd:

  dt-bindings: fpga: Consolidate bridge properties (2019-07-24 14:19:15 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.4-rc1

Here is the first set of changes for the 5.4-rc1 merge window.

They're all more or less cleanup patches:

- Carlos' patch addresses a checkpatch warning
- My first patch changes the return type of a function to align it with
  the fact that nothing checks the return value and it uncoditionally
  returned 0 anyways
- My second patch somehow fell through the cracks before and cleans up
  the FPGA bridge bindings by consolidating them instead of repeating
  the same paragraph over and over again.

All of these patches have been in the last few linux-next releases
without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Carlos A Petry (1):
      fpga: altera-cvp: Fix function definition argument

Moritz Fischer (2):
      fpga: altera-pr-ip: Make alt_pr_unregister function void
      dt-bindings: fpga: Consolidate bridge properties

 .../devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt   |  5 +----
 .../devicetree/bindings/fpga/altera-freeze-bridge.txt       |  5 +----
 .../devicetree/bindings/fpga/altera-hps2fpga-bridge.txt     |  5 +----
 Documentation/devicetree/bindings/fpga/fpga-bridge.txt      | 13 +++++++++++++
 .../devicetree/bindings/fpga/xilinx-pr-decoupler.txt        |  8 ++------
 drivers/fpga/altera-cvp.c                                   |  3 ++-
 drivers/fpga/altera-pr-ip-core-plat.c                       |  4 +++-
 drivers/fpga/altera-pr-ip-core.c                            |  4 +---
 include/linux/fpga/altera-pr-ip-core.h                      |  2 +-
 9 files changed, 25 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt
