Date: Mon, 30 Mar 2020 20:55:02 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA Manager (late) fixes for 5.7
Message-ID: <20200331035459.GA3472@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: moritzf@google.com, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ fpga-fixes-for-5.7

for you to fetch changes up to 3c2760b78f90db874401d97e3c17829e2e36f400:

  fpga: dfl: pci: fix return value of cci_pci_sriov_configure (2020-03-30 20:45:30 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.7-rc1

Here are two (late) fixes for 5.7-rc1 merge window.

Xu's change addresses an issue with a wrong return value.

Shubhrajyoti's change makes the Zynq FPGA driver return -EPROBE_DEFER on

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Shubhrajyoti Datta (1):
      fpga: zynq: Remove clk_get error message for probe defer

Xu Yilun (1):
      fpga: dfl: pci: fix return value of cci_pci_sriov_configure

 drivers/fpga/dfl-pci.c   | 6 ++++--
 drivers/fpga/zynq-fpga.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)
