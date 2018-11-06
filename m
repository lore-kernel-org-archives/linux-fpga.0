Return-Path: <SRS0=qTBN=NR=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=qTBN=NR=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv10 0/8] Add Intel Stratix10 FPGA manager and service layer 
Date: Tue,  6 Nov 2018 10:52:44 -0600
Message-Id: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, todd.riffel@intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

This is the 10th submission of Intel Stratix10 service layer and FPGA
manager driver patches. In this submission I have moved Stratix10 service
layer driver .c file to drivers/firmware and header files to
include/linux/firmware/intel. I have added Stratix10 service layer
document to other firmware interface.

Stratix10 service layer patches have been reviewed internally by Alan Tull
and other colleagues at Intel.

Some features of the Intel Stratix10 SoC require a level of privilege
higher than the kernel is granted. Such secure features include
FPGA programming, remote status update, read and write the secure
registers. In terms of the ARMv8 architecture, the kernel runs at Exception
Level 1 (EL1), access to the features requires Exception Level 3 (EL3).

The Intel Stratix10 service layer provides kernel APIs for drivers to
request access to the secure features. The requests are queued and
processed one by one. ARM’s SMCCC is used to pass the execution of the
requests on to a secure monitor (EL3).

Later the Intel Stratix10 service layer driver will be extended to provide
services for QSPI, Crypto and warm reset.

v2: add patches for FPGA manager, FPGA manager binding, dts and defconfig
    remove intel-service subdirectory and intel-service.h, move intel-smc.h
    and intel-service.c to driver/misc subdirectory.
    remove global variables.
    change service layer driver be 'default n'.
    correct SPDX markers.
    add timeout for do..while() loop.
    add kernel-doc for the functions and structs, correct multiline
    comments.
    replace kfifo_in and kfifo_out with kfifo_in_spinlocked and
    kfifo_out_spinlocked.
    rename struct intel_svc_data (at client header) to
    intel_svc_client_msg.
    rename struct intel_svc_private_mem to intel_svc_data.
    other corrections/changes from Intel internal code reviews.
v3: change all exported functions with "intel_svc_" as the prefix.
    increase timeout values for claiming back submitted buffer(s).
    rename struct intel_command_reconfig_payload to
    struct intel_svc_command_reconfig_payload.
    add pr_err() to provide the error return value.
    change to put fpga_mgr node under firmware/svc node.
    change to FPGA manager to align the update of service client APIs, and
    the update of fpga_mgr device node.
    Other corrections/changes.
v4: s/intel/stratix10/ on some variables, structs, functions, and file
    names intel-service.c -> stratix10-svc.c
    intel-smc.h -> stratix10-smc.h
    intel-service-client.h -> stratix10-svc-client.h.
    remove non-kernel-doc formatting.
    s/fpga-mgr@0/fpga-mgr/ to remove unit_address at fpga_mgr node.
    add Rob's Reviewed-by.
    add Richard's signed-off-by.
v5: add a new API statix10_svc_done() which is called by service client
    when client request is completed or error occurs during request
    process. Which allows service layer to free its resources.
    remove dummy client from service layer client header and service layer
    source file.
    add Rob's Reviewed-by.
    add a new file stratix10-svc.rst and add that to driver-api/index.rst.
    kernel-doc fixes.
v6: replace kthread_create_on_cpu() with kthread_create_on_node().
    extend stratix_svc_send() to support service client which doesn't use
    memory allocated by service layer.
    add S10_RECONFIG_TIMEOUT.
    rename s/S10_BUF_TIMEOUT/S10_BUFFER_TIMEOUT/.
    fix service layer and FPGA manager Klocwork errors.
v7: add remote status update client support.
    s/pr_debug/dev_dbg, s/dev_info/dev_dbg.
    add unlock buffer if s10_svc_send_msg() fails.
    add release channel if fpga_mgr_create() fails.
    handle invalid pointer at svc if the client passed an invalid name.
v8: move stratix10-smc.h to include/linux from driver/misc.
    revert version 7 error code & smc function ID value changes at
    stratix10-smc.h.
    add a goto and common error handling at the end of fpga driver's.
    probe function.
v9: remove a patch on defconfig for enable service layer and FPGA manager.
    resolve a issue found at git-bisect test.
    remove kernel-doc markups that aren't being built.
v10:move stratix10-smc.h and stratix10-svc-client.h to
    include/linux/firmware/intel.
    move stratix10-svc.c to drivers/firmware.
    s/STRATIX10_SERVICE/INTEL_STRATIX10_SERVICE, fix a Klocwork error at
    service layer driver.
    s/stratix10_svc_command_reconfig_payload/
    stratix10_svc_command_config_type.
    add stratix10 service layer document to other firmware interface.
    update path for the included header in Stratix10 FPGA manager driver.

Alan Tull (3):
  dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
  arm64: dts: stratix10: add fpga manager and region
  fpga: add intel stratix10 soc fpga manager driver

Richard Gong (5):
  dt-bindings, firmware: add Intel Stratix10 service layer binding
  arm64: dts: stratix10: add stratix10 service driver binding to base
    dtsi
  firmware: add Intel Stratix10 service layer driver
  Documentation: driver-api: add stratix10 service layer
  firmware: add remote status update client support

 .../bindings/firmware/intel,stratix10-svc.txt      |   57 ++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |   17 +
 .../driver-api/firmware/other_interfaces.rst       |   30 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   33 +
 drivers/firmware/Kconfig                           |   12 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/stratix10-svc.c                   | 1044 ++++++++++++++++++++
 drivers/fpga/Kconfig                               |    6 +
 drivers/fpga/Makefile                              |    1 +
 drivers/fpga/stratix10-soc.c                       |  535 ++++++++++
 include/linux/firmware/intel/stratix10-smc.h       |  312 ++++++
 .../linux/firmware/intel/stratix10-svc-client.h    |  217 ++++
 12 files changed, 2265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
 create mode 100644 drivers/firmware/stratix10-svc.c
 create mode 100644 drivers/fpga/stratix10-soc.c
 create mode 100644 include/linux/firmware/intel/stratix10-smc.h
 create mode 100644 include/linux/firmware/intel/stratix10-svc-client.h

-- 
2.7.4
