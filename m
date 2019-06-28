Return-Path: <SRS0=1/Hx=U3=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=1/Hx=U3=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 00/15] FPGA DFL updates
Date: Thu, 27 Jun 2019 17:49:36 -0700
Message-Id: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

can you please take the following patches. They're mostly new features
and some cleanup of the DFL internals.

They've been on the mailing list and have been reviewed.

Note: I've seen that Mauro touched Documentation/fpga/dfl.rst in linux-next
      commit c220a1fae6c5d ("docs: fpga: convert docs to ReST and rename to *.rst")
      and fixed up PATCH 05/15 to apply on top of that.

If you prefer the original series against char-misc-next let me know,
and I'll resubmit.

Thanks,

Moritz

Wu Hao (15):
  fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register address.
  fpga: dfl: fme: remove copy_to_user() in ioctl for PR
  fpga: dfl: fme: align PR buffer size per PR datawidth
  fpga: dfl: fme: support 512bit data width PR
  Documentation: fpga: dfl: add descriptions for virtualization and new
    interfaces.
  fpga: dfl: fme: add DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
  fpga: dfl: pci: enable SRIOV support.
  fpga: dfl: afu: add AFU state related sysfs interfaces
  fpga: dfl: afu: add userclock sysfs interfaces.
  fpga: dfl: add id_table for dfl private feature driver
  fpga: dfl: afu: export __port_enable/disable function.
  fpga: dfl: afu: add error reporting support.
  fpga: dfl: afu: add STP (SignalTap) support
  fpga: dfl: fme: add capability sysfs interfaces
  fpga: dfl: fme: add global error reporting support

 .../ABI/testing/sysfs-platform-dfl-fme        |  98 +++++
 .../ABI/testing/sysfs-platform-dfl-port       | 104 +++++
 Documentation/fpga/dfl.rst                    | 100 +++++
 drivers/fpga/Makefile                         |   3 +-
 drivers/fpga/dfl-afu-error.c                  | 225 ++++++++++
 drivers/fpga/dfl-afu-main.c                   | 330 ++++++++++++++-
 drivers/fpga/dfl-afu.h                        |   7 +
 drivers/fpga/dfl-fme-error.c                  | 385 ++++++++++++++++++
 drivers/fpga/dfl-fme-main.c                   | 120 +++++-
 drivers/fpga/dfl-fme-mgr.c                    | 117 +++++-
 drivers/fpga/dfl-fme-pr.c                     |  65 +--
 drivers/fpga/dfl-fme.h                        |   7 +-
 drivers/fpga/dfl-pci.c                        |  40 ++
 drivers/fpga/dfl.c                            | 169 +++++++-
 drivers/fpga/dfl.h                            |  54 ++-
 include/uapi/linux/fpga-dfl.h                 |  32 ++
 16 files changed, 1776 insertions(+), 80 deletions(-)
 create mode 100644 drivers/fpga/dfl-afu-error.c
 create mode 100644 drivers/fpga/dfl-fme-error.c

-- 
2.22.0
