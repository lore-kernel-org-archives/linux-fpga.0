Return-Path: <SRS0=h1EM=HX=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=h1EM=HX=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv4 0/7] Add Intel Stratix10 FPGA manager and service layer
Date: Fri,  4 May 2018 09:21:30 -0500
Message-Id: <1525443697-31009-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@linux.intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

This is the 4th submission of Intel stratix10 service layer patches. Intel
Stratix10 FPGA manager, which is 1st Stratix10 service layer client, is
included in this submission.

Stratix10 service layer patches have been reviewed internally by Alan Tull
and other colleagues at Intel.

Some features of the Intel Stratix10 SoC require a level of privilege
higher than the kernel is granted. Such secure features include
FPGA programming. In terms of the ARMv8 architecture, the kernel runs
at Exception Level 1 (EL1), access to the features requires
Exception Level 3 (EL3).

The Intel Stratix10 service layer provides an in kernel API for drivers to
request access to the secure features. The requests are queued and
processed one by one. ARM’s SMCCC is used to pass the execution of the
requests on to a secure monitor (EL3).

Later the Intel Stratix10 service layer driver will be extended to provide
services for QSPI, Crypto and warm reset.

v2: add patches for FPGA manager, FPGA manager binding, dts and defconfig
    remove intel-service subdirectory and intel-service.h, move intel-smc.h
    and intel-service.c to driver/misc subdirectory
    remove global variables
    change service layer driver be 'default n'
    correct SPDX markers
    add timeout for do..while() loop
    add kernel-doc for the functions and structs, correct multiline comments
    replace kfifo_in/kfifo_out with kfifo_in_spinlocked/kfifo_out_spinlocked
    rename struct intel_svc_data (at client header) to intel_svc_client_msg
    rename struct intel_svc_private_mem to intel_svc_data
    other corrections/changes from Intel internal code reviews
v3: change all exported functions with "intel_svc_" as the prefix
    increase timeout values for claiming back submitted buffer(s)
    rename struct intel_command_reconfig_payload to
    struct intel_svc_command_reconfig_payload
    add pr_err() to provide the error return value
    change to put fpga_mgr node under firmware/svc node
    change to FPGA manager to align the update of service client APIs, and the
    update of fpga_mgr device node
    Other corrections/changes
v4: s/intel/stratix10/ on some variables, structs, functions, and file names
    intel-service.c -> stratix10-svc.c
    intel-smc.h -> stratix10-smc.h
    intel-service-client.h -> stratix10-svc-client.h
    remove non-kernel-doc formatting
    s/fpga-mgr@0/fpga-mgr/ to remove unit_address at fpga_mgr node
    add Rob's Reviewed-by
    add Richard's signed-off-by

Alan Tull (3):
  dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
  arm64: dts: stratix10: add fpga manager and region
  fpga: add intel stratix10 soc fpga manager driver

Richard Gong (4):
  dt-bindings, firmware: add Intel Stratix10 service layer binding
  arm64: dts: stratix10: add stratix10 service driver binding to base
    dtsi
  driver, misc: add Intel Stratix10 service layer driver
  defconfig: enable fpga and service layer

 .../bindings/firmware/intel,stratix10-svc.txt      |  57 ++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |  17 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  33 +
 arch/arm64/configs/defconfig                       |   6 +
 drivers/fpga/Kconfig                               |   6 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/stratix10-soc.c                       | 534 ++++++++++++
 drivers/misc/Kconfig                               |  12 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/stratix10-smc.h                       | 203 +++++
 drivers/misc/stratix10-svc.c                       | 945 +++++++++++++++++++++
 include/linux/stratix10-svc-client.h               | 190 +++++
 12 files changed, 2005 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
 create mode 100644 drivers/fpga/stratix10-soc.c
 create mode 100644 drivers/misc/stratix10-smc.h
 create mode 100644 drivers/misc/stratix10-svc.c
 create mode 100644 include/linux/stratix10-svc-client.h

-- 
2.7.4
