Date: Mon, 20 Jan 2020 17:22:50 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA changes for 5.6
Message-ID: <20200121012248.GA3890@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org, moritzf@google.com
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-for-5.6

for you to fetch changes up to 28910cee898c2a43fcdd8c26e1378ae8084a93a0:

  fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer (2020-01-10 12:51:56 -0800)

----------------------------------------------------------------
Here is the first set of FPGA changes for 5.6

The first two patches are minor cleanups to the DFL drivers,
that remove unused warnings.

The third patch removes a redundant error message to the ts73xx driver.

The last patch removes a confusing print in case a call to devm_clk_get
returns -EPROBE_DEFER.

All patches have been reviewed on the mailing list and have been in the
last couple of linux-next releases without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Ding Xiang (1):
      fpga: remove redundant dev_err message

Shubhrajyoti Datta (1):
      fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer

yu kuai (2):
      fpga: dfl: fme: remove set but not used variable 'fme'
      fpga: dfl: afu: remove set but not used variable 'afu'

 drivers/fpga/dfl-afu-main.c        | 2 --
 drivers/fpga/dfl-fme-main.c        | 2 --
 drivers/fpga/ts73xx-fpga.c         | 4 +---
 drivers/fpga/xilinx-pr-decoupler.c | 3 ++-
 4 files changed, 3 insertions(+), 8 deletions(-)
