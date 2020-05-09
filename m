Date: Sat, 9 May 2020 11:13:57 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA Manager changes for 5.8
Message-ID: <20200509181355.GA3828@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: moritzf@google.com, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.8

for you to fetch changes up to a2b9d4eadb7727772698d06e4cbeb1a1e2538675:

  fpga: dfl: afu: support debug access to memory-mapped afu regions (2020-04-29 20:37:12 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.8

Here's the first set of changes for the 5.8-rc1 merge window.

Dominic's change adds support for accessing AFU regions with gdb.
Gustavo's change is a cleanup patch regarding variable lenght arrays.
Richard's changes update dt-bindings and add support for stratix and agilex.
Sergiu's changes update spi transfers with the new delay field.
Xu's change addresses an issue with a wrong return value.
Shubhrajyoti's change makes the Zynq FPGA driver return -EPROBE_DEFER on
check of devm_clk_get failure.
Xu's change for DFL enables multiple opens.

All of these patches have been reviewed, have appropriate Acked-by's and
have been in the last few linux-next releases without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Dominic Chen (1):
      fpga: dfl: afu: support debug access to memory-mapped afu regions

Gustavo A. R. Silva (1):
      fpga: dfl.h: Replace zero-length array with flexible-array member

Richard Gong (5):
      dt-bindings: fpga: add compatible value to Stratix10 SoC FPGA manager binding
      arm64: dts: agilex: correct FPGA manager driver's compatible value
      fpga: stratix10-soc: add compatible property value for intel agilex
      dt-bindings, firmware: add compatible value Intel Stratix10 service layer binding
      arm64: dts: agilex: correct service layer driver's compatible value

Sergiu Cuciurean (2):
      fpga: ice40-spi: Use new structure for SPI transfer delays
      fpga: machxo2-spi: Use new structure for SPI transfer delays

Xu Yilun (1):
      fpga: dfl: support multiple opens on feature device node.

 .../bindings/firmware/intel,stratix10-svc.txt      |  2 +-
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |  3 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |  4 +--
 drivers/fpga/dfl-afu-main.c                        | 35 +++++++++++++-------
 drivers/fpga/dfl-fme-main.c                        | 19 +++++++----
 drivers/fpga/dfl.c                                 | 15 +++++++--
 drivers/fpga/dfl.h                                 | 37 ++++++++++++++++------
 drivers/fpga/ice40-spi.c                           | 10 ++++--
 drivers/fpga/machxo2-spi.c                         | 12 ++++---
 drivers/fpga/stratix10-soc.c                       |  3 +-
 10 files changed, 100 insertions(+), 40 deletions(-)
