Date: Fri, 17 Jul 2020 19:19:55 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA Manager changes for 5.9-rc1
Message-ID: <20200718021954.GA7272@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: moritzf@google.com, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.9

for you to fetch changes up to eacfbf589c904bf8362cbd2d6cac123b0230e272:

  fpga: dfl: pci: add device id for Intel FPGA PAC N3000 (2020-07-12 19:00:37 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.9-rc1

Here is the (slightly larger than usual) patch set for the 5.9-rc1 merge
window.

DFL:
- Xu's changes add support for AFU interrupt handling and puts them to
  use for error handling.
- Xu's other change also adds another device-id for the Intel FPGA PAC N3000.
- John's change converts from using get_user_pages() to
  pin_user_pages().
- Gustavo's patch cleans up some of the allocation by using
  struct_size().

Xilinx:
- Luca's changes clean up the xilinx-spi and xilinx-slave-serial drivers
  and updates the comments and dt-bindings to reflect the fact it also
  supports 7 series devices.

Core:
- Tom cleaned up the fpga-bridge / fpga-mgr core by removing some
  dead-stores.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      fpga: dfl: Use struct_size() in kzalloc()

John Hubbard (1):
      fpga: dfl: afu: convert get_user_pages() --> pin_user_pages()

Luca Ceresoli (5):
      dt-bindings: fpga: xilinx-slave-serial: valid for the 7 Series too
      fpga manager: xilinx-spi: valid for the 7 Series too
      fpga manager: xilinx-spi: remove unneeded, mistyped variables
      dt-bindings: fpga: xilinx-slave-serial: add optional INIT_B GPIO
      fpga manager: xilinx-spi: check INIT_B pin during write_init

Tom Rix (2):
      fpga: Fix dead store fpga-mgr.c
      fpga: Fix dead store in fpga-bridge.c

Xu Yilun (8):
      fpga: dfl: parse interrupt info for feature devices on enumeration
      fpga: dfl: pci: add irq info for feature devices enumeration
      fpga: dfl: introduce interrupt trigger setting API
      fpga: dfl: afu: add interrupt support for port error reporting
      fpga: dfl: fme: add interrupt support for global error reporting
      fpga: dfl: afu: add AFU interrupt support
      Documentation: fpga: dfl: add descriptions for interrupt related interfaces.
      fpga: dfl: pci: add device id for Intel FPGA PAC N3000

 .../bindings/fpga/xilinx-slave-serial.txt          |  16 +-
 Documentation/fpga/dfl.rst                         |  19 ++
 drivers/fpga/dfl-afu-dma-region.c                  |  19 +-
 drivers/fpga/dfl-afu-error.c                       |  17 ++
 drivers/fpga/dfl-afu-main.c                        |  32 +++
 drivers/fpga/dfl-fme-error.c                       |  18 ++
 drivers/fpga/dfl-fme-main.c                        |   6 +
 drivers/fpga/dfl-pci.c                             |  78 ++++-
 drivers/fpga/dfl.c                                 | 313 ++++++++++++++++++++-
 drivers/fpga/dfl.h                                 |  63 ++++-
 drivers/fpga/fpga-bridge.c                         |   6 +-
 drivers/fpga/fpga-mgr.c                            |   4 +-
 drivers/fpga/xilinx-spi.c                          |  61 +++-
 include/uapi/linux/fpga-dfl.h                      |  82 ++++++
 14 files changed, 687 insertions(+), 47 deletions(-)
