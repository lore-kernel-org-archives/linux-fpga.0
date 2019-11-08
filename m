Date: Fri, 8 Nov 2019 08:19:32 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA changes for 5.5
Message-ID: <20191108161808.GA398122@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org, hao.wu@intel.com, moritzf@google.com
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-dfl-for-5.5

for you to fetch changes up to fddc9fcbe69a502d84adf0bad5e2c6c80823838c:

  fpga: dfl: fme: add power management support (2019-10-16 19:18:27 -0700)

----------------------------------------------------------------
Here is the first set of FPGA changes for 5.5

The first patch from Stephen is a trivial cleanup patch.

The following three patches add hwmon support to DFL FPGAs.

All of this patches have been reviewed and been in the last couple
of linux-next releases without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Stephen Boyd (1):
      fpga: Remove dev_err() usage after platform_get_irq()

Wu Hao (2):
      fpga: dfl: fme: add thermal management support
      fpga: dfl: fme: add power management support

Xu Yilun (1):
      Documentation: fpga: dfl: add descriptions for thermal/power management interfaces

 Documentation/ABI/testing/sysfs-platform-dfl-fme | 132 ++++++++
 Documentation/fpga/dfl.rst                       |  10 +
 drivers/fpga/Kconfig                             |   2 +-
 drivers/fpga/dfl-fme-main.c                      | 385 +++++++++++++++++++++++
 drivers/fpga/zynq-fpga.c                         |   4 +-
 5 files changed, 529 insertions(+), 4 deletions(-)
