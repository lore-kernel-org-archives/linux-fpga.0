Date: Tue, 3 Sep 2019 20:00:22 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: [GIT PULL] FPGA DFL Changes for 5.4 (late, sorry)
Message-ID: <20190904030020.GA5534@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: gregkh@linuxfoundation.org
Cc: moritzf@google.com, hao.wu@intel.com, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

not sure I got this one right. It's a bit complicated, since there's
some dependencies on stuff already in char-misc-next as well as the
dev_groups_all_drivers.

Let me know if I messed up.

Thanks,
Moritz

The following changes since commit 99097a214b0c15f7595ac8f2788662f3941c1992:

  Merge 5.3-rc7 into char-misc-next (2019-09-02 19:30:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-dfl-for-5.4

for you to fetch changes up to 77a0ef488de9ac6054204c5bf61cf2095fff25d8:

  Documentation: fpga: dfl: add descriptions for virtualization and new interfaces. (2019-09-03 19:35:42 -0700)

----------------------------------------------------------------
FPGA DFL Changes for 5.4

This pull-request contains the FPGA DFL changes for 5.4

- The first three patches are cleanup patches making use of dev_groups and
  making the init callback optional.
- One patch adds userclock sysfs entries that are DFL specific
- One patch exposes AFU port disable/enable functions
- One patch adds error reporting
- One patch adds AFU SignalTap support
- One patch adds FME global error reporting
- The final patch is a documentation patch that decribes the
  virtualization interfaces

This patchset requires the 'dev_groups_all_drivers' tag from drivers
core for the dev_groups refactoring as well as the DFL changes already
in char-misc-next.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Dmitry Torokhov (1):
      driver core: add dev_groups to all drivers

Moritz Fischer (2):
      Merge tag 'dev_groups_all_drivers' into fpga-dfl-for-5.4
      Merge branch 'char-misc-next' of git://git.kernel.org/.../gregkh/char-misc into fpga-dfl-for-5.4

Thor Thayer (3):
      fpga: altera-cvp: Discover Vendor Specific offset
      fpga: altera-cvp: Preparation for V2 parts.
      fpga: altera-cvp: Add Stratix10 (V2) Support

Wu Hao (9):
      fpga: dfl: make init callback optional
      fpga: dfl: fme: convert platform_driver to use dev_groups
      fpga: dfl: afu: convert platform_driver to use dev_groups
      fpga: dfl: afu: add userclock sysfs interfaces.
      fpga: dfl: afu: expose __afu_port_enable/disable function.
      fpga: dfl: afu: add error reporting support.
      fpga: dfl: afu: add STP (SignalTap) support
      fpga: dfl: fme: add global error reporting support
      Documentation: fpga: dfl: add descriptions for virtualization and new interfaces.

 Documentation/ABI/testing/sysfs-platform-dfl-fme  |  62 ++++
 Documentation/ABI/testing/sysfs-platform-dfl-port |  53 ++++
 Documentation/fpga/dfl.rst                        | 105 +++++++
 drivers/base/dd.c                                 |  14 +
 drivers/fpga/Kconfig                              |   6 +-
 drivers/fpga/Makefile                             |   3 +-
 drivers/fpga/altera-cvp.c                         | 339 +++++++++++++++-----
 drivers/fpga/dfl-afu-error.c                      | 230 ++++++++++++++
 drivers/fpga/dfl-afu-main.c                       | 230 +++++++++++---
 drivers/fpga/dfl-afu.h                            |   9 +
 drivers/fpga/dfl-fme-error.c                      | 359 ++++++++++++++++++++++
 drivers/fpga/dfl-fme-main.c                       |  42 +--
 drivers/fpga/dfl-fme.h                            |   3 +
 drivers/fpga/dfl.c                                |  10 +-
 drivers/fpga/dfl.h                                |   9 +
 include/linux/device.h                            |   3 +
 16 files changed, 1329 insertions(+), 148 deletions(-)
 create mode 100644 drivers/fpga/dfl-afu-error.c
 create mode 100644 drivers/fpga/dfl-fme-error.c
