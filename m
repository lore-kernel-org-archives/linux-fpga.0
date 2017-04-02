Return-Path: <moritz.fischer.private@gmail.com>
Date: Sun, 2 Apr 2017 07:41:46 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 01/16] docs: fpga: add a document for Intel FPGA driver
 overview
Message-ID: <20170402144146.GA30775@tyrael.amer.corp.natinst.com>
References: <1490875696-15145-1-git-send-email-hao.wu@intel.com>
 <1490875696-15145-2-git-send-email-hao.wu@intel.com>
 <alpine.DEB.2.20.1703310907270.2072@mgerlach-VirtualBox>
 <CANk1AXTPM+9Xdahw2sy4kSJ-Dket3Z5eS83AvW4agwSvvoFSjQ@mail.gmail.com>
 <20170401111619.GB4804@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170401111619.GB4804@hao-dev>
To: Wu Hao <hao.wu@intel.com>
Cc: Alan Tull <atull@kernel.org>, matthew.gerlach@linux.intel.com, Moritz Fischer <moritz.fischer@ettus.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, luwei.kang@intel.com, yi.z.zhang@intel.com, Enno Luebbers <enno.luebbers@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Sat, Apr 01, 2017 at 07:16:19PM +0800, Wu Hao wrote:
> On Fri, Mar 31, 2017 at 01:38:06PM -0500, Alan Tull wrote:
> > On Fri, Mar 31, 2017 at 1:24 PM,  <matthew.gerlach@linux.intel.com> wrote:
> > >
> > >
> > > On Thu, 30 Mar 2017, Wu Hao wrote:
> > >
> > >
> > > Hi Wu Hao,
> > >
> > > Great documentation. I'm looking forward to diving into the rest of the
> > > patches. Please see my comments inline.
> > >
> > > Matthew Gerlach
> > >
> > >
> > >> Add a document for Intel FPGA driver overview.
> > >>
> > >> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > >> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > >> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > >> ---
> > >> Documentation/fpga/intel-fpga.txt | 259
> > >> ++++++++++++++++++++++++++++++++++++++
> > >> 1 file changed, 259 insertions(+)
> > >> create mode 100644 Documentation/fpga/intel-fpga.txt
> > >>
> > >> diff --git a/Documentation/fpga/intel-fpga.txt
> > >> b/Documentation/fpga/intel-fpga.txt
> > >> new file mode 100644
> > >> index 0000000..9396cea
> > >> --- /dev/null
> > >> +++ b/Documentation/fpga/intel-fpga.txt
> > >> @@ -0,0 +1,259 @@
> > >>
> > >> +===============================================================================
> > >> +                    Intel FPGA driver Overview
> > >>
> > >> +-------------------------------------------------------------------------------
> > >> +                Enno Luebbers <enno.luebbers@intel.com>
> > >> +                Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > >> +                Wu Hao <hao.wu@intel.com>
> > >> +
> > >> +The Intel FPGA driver provides interfaces for userspace applications to
> > >> +configure, enumerate, open, and access FPGA accelerators on platforms
> > >> equipped
> > >> +with Intel(R) FPGA solutions and enables system level management
> > >> functions such
> > >> +as FPGA reconfiguration, power management, and virtualization.
> > >> +
> > >
> > >
> > > From a Linux kernel perspective, I'm not sure this is the best name for
> > > this code.  The name gives me the impression that it is a driver for all
> > > Intel FPGAs, but not all Intel FPGAs are connected to the processor over a
> > > PCIe bus.  The processor could be directely connected like the Arria10
> > > SOCFPGA.  Such a processor could certainly benefit from this accelerator
> > > usage model.  In an extreme case, couldn't a processor in the FPGA,
> > > running Linux, also benefit from this accelerator model?  Is this code a
> > > "FPGA Accelerator Framework"?
> > >
> > >> +HW Architecture
> > >> +===============
> > >> +From the OS's point of view, the FPGA hardware appears as a regular PCIe
> > >> device.
> > >> +The FPGA device memory is organized using a predefined data structure
> > >> (Device
> > >> +Feature List). Features supported by the particular FPGA device are
> > >> exposed
> > >> +through these data structures, as illustrated below:
> > >> +
> > >> +  +-------------------------------+  +-------------+
> > >> +  |              PF               |  |     VF      |
> > >> +  +-------------------------------+  +-------------+
> > >> +      ^            ^         ^              ^
> > >> +      |            |         |              |
> > >> ++-----|------------|---------|--------------|-------+
> > >> +|     |            |         |              |       |
> > >> +|  +-----+     +-------+ +-------+      +-------+   |
> > >> +|  | FME |     | Port0 | | Port1 |      | Port2 |   |
> > >> +|  +-----+     +-------+ +-------+      +-------+   |
> > >> +|                  ^         ^              ^       |
> > >> +|                  |         |              |       |
> > >> +|              +-------+ +------+       +-------+   |
> > >> +|              |  AFU  | |  AFU |       |  AFU  |   |
> > >> +|              +-------+ +------+       +-------+   |
> > >> +|                                                   |
> > >> +|                 FPGA PCIe Device                  |
> > >> ++---------------------------------------------------+
> > >> +
> > >> +The driver supports PCIe SR-IOV to create virtual functions (VFs) which
> > >> can be
> > >> +used to assign individual accelerators to virtual machines .
> > >
> > >
> > > Does this HW Architecture require an Intel FPGA?  Couldn't any vendors FPGA
> > > be used as long as it presented itself the PCIe bus the same and contained
> > > an appropriate Device Feature List?

I think this is a good (and important) point. Especially when sysfs
entries & ioctls constituting ABI depend on it.

> > >
> > >> +
> > >> +FME (FPGA Management Engine)
> > >> +============================
> > >> +The FPGA Management Enging performs power and thermal management, error
Enging->Engine
> > >> +reporting, reconfiguration, performance reporting, and other
> > >> infrastructure
> > >> +functions. Each FPGA has one FME, which is always accessed through the
> > >> physical
> > >> +function (PF).
> > >> +
> > >> +User-space applications can acquire exclusive access to the FME using
> > >> open(),
> > >> +and release it using close().
> > >> +
> > >> +The following functions are exposed through ioctls:
> > >> +
> > >> +       Get driver API version (FPGA_GET_API_VERSION)
> > >> +       Check for extensions (FPGA_CHECK_EXTENSION)
> > >> +       Assign port to PF (FPGA_FME_PORT_ASSIGN)
> > >> +       Release port from PF (FPGA_FME_PORT_RELEASE)
> > >> +       Program bitstream (FPGA_FME_PORT_PR)
> > >> +
> > >> +More functions are exposed through sysfs
> > >> +(/sys/class/fpga/fpga.n/intel-fpga-fme.n/):
> > >> +
> > >> +       Read bitstream ID (bitstream_id)
> > >> +       Read bitstream metadata (bitstream_metadata)
> > >> +       Read number of ports (ports_num)
> > >> +       Read socket ID (socket_id)
> > >> +       Read performance counters (perf/)
> > >> +       Power management (power_mgmt/)
> > >> +       Thermal management (thermal_mgmt/)
> > >> +       Error reporting (errors/)
> > >> +
> > >> +PORT
> > >> +====
> > >> +A port represents the interface between the static FPGA fabric (the "blue
> > >> +bitstream") and a partially reconfigurable region containing an AFU (the
> > >> "green
> > 
> > Is this an fpga bridge but with added features?
> 
> Yes, I think so. As you see the fme_pr function in patch 11, related port needs
> to be disabled firstly before fpga_mgr_buf_load for given accelerator.

Can we just extend the bridge to have the additional features, please?

> > >> +bitstream"). It controls the communication from SW to the accelerator and
> > >> +exposes features such as reset and debug.
> > >> +
> > >> +A PCIe device may have several ports and each port can be released from
> > >> PF by
> > >> +FPGA_FME_PORT_RELEASE ioctl on FME, and exposed through a VF via PCIe
> > >> sriov
> > >> +sysfs interface.
> > >> +
> > >> +AFU
> > >> +===
> > >> +An AFU is attached to a port and exposes a 256k MMIO region to be used
> > >> for
> > >> +accelerator-specific control registers.
> > >> +
> > >> +User-space applications can acquire exclusive access to an AFU attached
> > >> to a
> > >> +port by using open() on the port device node, and release it using
> > >> close().
> > >> +
> > >> +The following functions are exposed through ioctls:
> > >> +
> > >> +       Get driver API version (FPGA_GET_API_VERSION)
> > >> +       Check for extensions (FPGA_CHECK_EXTENSION)
> > >> +       Get port info (FPGA_PORT_GET_INFO)
> > >> +       Get MMIO region info (FPGA_PORT_GET_REGION_INFO)
> > >> +       Map DMA buffer (FPGA_PORT_DMA_MAP)
> > >> +       Unmap DMA buffer (FPGA_PORT_DMA_UNMAP)
> > >> +       Reset AFU (FPGA_PORT_RESET)
> > >> +       Enable UMsg (FPGA_PORT_UMSG_ENABLE)
> > >> +       Disable UMsg (FPGA_PORT_UMSG_DISABLE)
> > >> +       Set UMsg mode (FPGA_PORT_UMSG_SET_MODE)
> > >> +       Set UMsg base address (FPGA_PORT_UMSG_SET_BASE_ADDR)
> > >> +
> > >> +User-space applications can also mmap() accelerator MMIO regions.
> > >> +
> > >> +More functions are exposed through sysfs:
> > >> +(/sys/class/fpga/fpga.n/intel-fpga-port.m/):
> > >> +
> > >> +       Read Accelerator GUID (afu_id)
> > >> +       Error reporting (errors/)
> > >> +
> > >> +Partial Reconfiguration
> > >> +=======================
> > >> +As mentioned above, accelerators can be reconfigured through partial
> > >> +reconfiguration of a green bitstream file (GBS). The green bitstream must
> > >> have
> > >> +been generated for the exact blue bitstream and targeted reconfigurable
> > >> region
> > >> +(port) of the FPGA; otherwise, the reconfiguration operation will fail
> > >> and
> > >> +possibly cause system instability. This compatibility can be checked by
> > >> +comparing the interface ID noted in the GBS header against the interface
> > >> ID
> > >> +exposed by the FME through sysfs (see above). This check is usually done
> > >> by
> > >> +user-space before calling the reconfiguration IOCTL.
> > >> +
> > >> +FPGA virtualization
> > >> +===================
> > >> +To enable accessing an accelerator from applications running in a VM, the
> > >> +respective AFU's port needs to be assigned to a VF using the following
> > >> steps:
> > >> +
> > >> + a) The PF owns all AFU ports by default. Any port that needs to be
> > >> reassigned
> > >> + to a VF must be released from PF firstly through the
> > >> FPGA_FME_PORT_RELEASE
> > >> + ioctl on the FME device.
> > >> +
> > >> + b) Once N ports are released from PF, then user can use below command to
> > >> + enable SRIOV and VFs. Each VF owns only one Port with AFU.
> > >> +
> > >> + echo N > $PCI_DEVICE_PATH/sriov_numvfs
> > >> +
> > >> + c) Pass through the VFs to VMs
> > >> +
> > >> + d) The AFU under VF is accessiable from applications in VM (using the
> > >> same
> > >> + driver inside the VF).
> > >> +
> > >> +Note the an FME can't be assigned to a VF, thus PR and other management
> > >> +functions are only available via the PF.
> > >> +
> > >> +
> > >> +Driver organization
> > >> +===================
> > >> +
> > >> +  +------------------+  +---------+   |             +---------+
> > >> +  | +-------+        |  |         |   |             |         |
> > >> +  | | FPGA  |  FME   |  |   AFU   |   |             |   AFU   |
> > >> +  | |Manager| Module |  |  Module |   |             |  Module |
> > >> +  | +-------+        |  |         |   |             |         |
> > >> +  +------------------+  +---------+   |             +---------+
> > >> +        +-----------------------+     |      +-----------------------+
> > >> +        | FPGA Container Device |     |      | FPGA Container Device |
> > >> +        +-----------------------+     |      +-----------------------+
> > >> +          +------------------+        |         +------------------+
> > >> +          | FPGA PCIE Module |        | Virtual | FPGA PCIE Module |
> > >> +          +------------------+   Host | Machine +------------------+
> > >> + ------------------------------------ | ------------------------------
> > >> +           +---------------+          |          +---------------+
> > >> +           | PCI PF Device |          |          | PCI VF Device |
> > >> +           +---------------+          |          +---------------+
> > >> +
> > >> +The FPGA devices appear as regular PCIe devices; thus, the FPGA PCIe
> > >> device
> > >> +driver is always loaded first once a FPGA PCIE PF or VF device is
> > >> detected. This
> > >> +driver plays an infrastructural role in the driver architecuture.  It:
> > >> +
> > >> +       a) creates FPGA container device as parent of the feature devices.
> > >> +       b) walks through the Device Feature List, which is implemented in
> > >> PCIE
> > >> +          device BAR memory, to discover feature devices and their sub
> > >> features
> > >> +          and create platform device for them under the container device.
> > >
> > >
> > > I really like the idea of creating platform devices for the sub features. It
> > > is in line with other FPGA use cases.  Platform devices are at the heart of
> > > device trees used by processors directly connected FPGAs and processors
> > > inside FPGAs.
> > >
> > >> +       c) supports SRIOV.
> > >> +       d) introduces the feature device infrastructure, which abstracts
> > >> +          operations for sub features and exposes common functions to
> > >> feature
> > >> +          device drivers.
> > >> +
> > >> +The FPGA Management Engine (FME) driver is a platform driver which is
> > >> loaded
> > >> +automatically after FME platform device creation from the PCIE driver. It
> > >> +provides the key features for FPGA management, including:
> > >> +
> > >> +       a) Power and thermal management, error reporting, performance
> > >> reporting
> > >> +          and other infrastructure functions. Users can access these
> > >> functions
> > >> +          via sysfs interfaces exposed by FME driver.
> > >> +       b) Paritial Reconfiguration. The FME driver registers a FPGA
> > >> Manager
> > >> +          during PR sub feature initialization; once it receives an
> > >> +          FPGA_FME_PORT_PR ioctl from user, it invokes the common
> > >> interface
> > >> +          function from FPGA Manager to complete the partial
> > >> reconfiguration of
> > >> +          the bitstream to the given port.
> > >> +       c) Port management for virtualization. The FME driver introduces
> > >> two
> > >> +          ioctls, FPGA_FME_PORT_RELEASE (releases given port from PF) and
> > >> +          FPGA_FME_PORT_ASSIGN (assigns the port back to PF). Once the
> > >> port is
> > >> +          released from the PF, it can be assigned to the VF through the
> > >> SRIOV
> > >> +          interfaces provided by PCIE driver. (Refer to "FPGA
> > >> virtualization"
> > >> +          for more details).
> > >> +
> > >> +Similar to the the FME driver, the FPGA Accelerated Function Unit (AFU)
> > >> driver
> > >> +is probed once the AFU platform device is created. The main function of
> > >> this
> > >> +module is to provide an interface for userspace applications to access
> > >> the
> > >> +individual accelerators, including basic reset control on port, AFU MMIO
> > >> region
> > >> +export, dma buffer mapping service, UMsg notification, and remote debug
> > >> +functions (see above).
> > >> +
> > >> +
> > >> +Device enumeration
> > >> +==================
> > >> +This section introduces how applications enumerate the fpga device from
> > >> +the sysfs hierarchy under /sys/class/fpga.
> > >> +
> > >> +In the example below, two Intel(R) FPGA devices are installed in the
> > >> host. Each
> > >> +fpga device has one FME and two ports (AFUs).
> > >> +
> > >> +For each FPGA device, a device director is created under
> > >> /sys/class/fpga/:
> > >> +
> > >> +       /sys/class/fpga/fpga.0
> > >> +       /sys/class/fpga/fpga.1
> > >> +
> > >> +The Intel(R) FPGA device driver exposes "intel-fpga-dev" as the FPGA's
> > >> name.
> > >> +Application can retrieve name information via the sysfs interface:
> > >> +
> > >> +       /sys/class/fpga/fpga.0/name
> > >> +
> > >> +Each node has one FME and two ports (AFUs) as child devices:
> > >> +
> > >> +       /sys/class/fpga/fpga.0/intel-fpga-fme.0
> > >> +       /sys/class/fpga/fpga.0/intel-fpga-port.0
> > >> +       /sys/class/fpga/fpga.0/intel-fpga-port.1
> > >> +
> > >> +       /sys/class/fpga/fpga.1/intel-fpga-fme.1
> > >> +       /sys/class/fpga/fpga.1/intel-fpga-port.2
> > >> +       /sys/class/fpga/fpga.1/intel-fpga-port.3
> > >> +
> > >> +In general, the FME/AFU sysfs interfaces are named as follows:
> > >> +
> > >> +       /sys/class/fpga/<fpga.n>/<intel-fpga-fme.n>/
> > >> +       /sys/class/fpga/<fpga.n>/<intel-fpga-port.m>/
> > >> +
> > >> +with 'n' consecutively numbering all FMEs and 'm' consecutively numbering
> > >> all
> > >> +ports.
> > >> +
> > >> +The device nodes used for ioctl() or mmap() can be referenced through:
> > >> +
> > >> +       /sys/class/fpga/<fpga.n>/<intel-fpga-port.n>/dev
> > >> +       /sys/class/fpga/<fpga.n>/<intel-fpga-fme.n>/dev
> > >> +
> > >> +
> > >> +Open discussions
> > >> +================
> > >> +The current FME driver does not provide user space access to the FME MMIO
> > >> +region, but exposes access through sysfs and ioctls. It also provides an
> > >> FPGA
> > >> +manger interface for partial reconfiguration (PR), but does not make use
> > >> of
> > >> +fpga-regions. User PR requests via the FPGA_FME_PORT_PR ioctl are handled
> > >> inside
> > >> +the FME, and fpga-region depends on device tree which is not used at all.
> > >> There
> > >> +are patches from Alan Tull to separate the device tree specific code and
> > >
> > >
> > > I am currently trying to use those patches in a different driver.  They've
> > > compiled cleanly in my out of tree pcie module driver against the 3.10
> > > kernel.
> > > I need to actually write the code to create and register the region, but
> > > Alan's platform driver code should be a good guide for me.  Just need to
> > > find the time.
> > >
> > >> +introduce a sysfs interface for PR. We plan to add fpga-regions support
> > >> in the
> > >> +driver once the related patches get merged. Then the FME driver should
> > >> create
> > >> +one fpga-region for each Port/AFU.
> > >
> > >
> > > Does the FME driver create the fpga-region, or is each region described as
> > > an entry in the Device Feature List and therefore created by the code that
> > > enumerates the Device Feature List?
> > >
> > >> --
> > >> 2.7.4
> > >>
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> > >> the body of a message to majordomo@vger.kernel.org
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >>
> > >

Cheers,
Moritz
