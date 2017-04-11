Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170402144146.GA30775@tyrael.amer.corp.natinst.com>
References: <1490875696-15145-1-git-send-email-hao.wu@intel.com>
 <1490875696-15145-2-git-send-email-hao.wu@intel.com> <alpine.DEB.2.20.1703310907270.2072@mgerlach-VirtualBox>
 <CANk1AXTPM+9Xdahw2sy4kSJ-Dket3Z5eS83AvW4agwSvvoFSjQ@mail.gmail.com>
 <20170401111619.GB4804@hao-dev> <20170402144146.GA30775@tyrael.amer.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 11 Apr 2017 13:02:08 -0500
Message-ID: <CANk1AXQNidgYbRpO+3Ap32_DXog9M2BxdW+MK0vM8yZAi=jzhg@mail.gmail.com>
Subject: Re: [PATCH 01/16] docs: fpga: add a document for Intel FPGA driver overview
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>, matthew.gerlach@linux.intel.com, Moritz Fischer <moritz.fischer@ettus.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Sun, Apr 2, 2017 at 9:41 AM, Moritz Fischer <mdf@kernel.org> wrote:
> On Sat, Apr 01, 2017 at 07:16:19PM +0800, Wu Hao wrote:
>> On Fri, Mar 31, 2017 at 01:38:06PM -0500, Alan Tull wrote:
>> > On Fri, Mar 31, 2017 at 1:24 PM,  <matthew.gerlach@linux.intel.com> wrote:
>> > >
>> > >
>> > > On Thu, 30 Mar 2017, Wu Hao wrote:
>> > >
>> > >
>> > > Hi Wu Hao,
>> > >
>> > > Great documentation. I'm looking forward to diving into the rest of the
>> > > patches. Please see my comments inline.
>> > >
>> > > Matthew Gerlach
>> > >
>> > >
>> > >> Add a document for Intel FPGA driver overview.
>> > >>
>> > >> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
>> > >> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>> > >> Signed-off-by: Wu Hao <hao.wu@intel.com>
>> > >> ---
>> > >> Documentation/fpga/intel-fpga.txt | 259
>> > >> ++++++++++++++++++++++++++++++++++++++
>> > >> 1 file changed, 259 insertions(+)
>> > >> create mode 100644 Documentation/fpga/intel-fpga.txt
>> > >>
>> > >> diff --git a/Documentation/fpga/intel-fpga.txt
>> > >> b/Documentation/fpga/intel-fpga.txt
>> > >> new file mode 100644
>> > >> index 0000000..9396cea
>> > >> --- /dev/null
>> > >> +++ b/Documentation/fpga/intel-fpga.txt
>> > >> @@ -0,0 +1,259 @@
>> > >>
>> > >> +===============================================================================
>> > >> +                    Intel FPGA driver Overview
>> > >>
>> > >> +-------------------------------------------------------------------------------
>> > >> +                Enno Luebbers <enno.luebbers@intel.com>
>> > >> +                Xiao Guangrong <guangrong.xiao@linux.intel.com>
>> > >> +                Wu Hao <hao.wu@intel.com>
>> > >> +
>> > >> +The Intel FPGA driver provides interfaces for userspace applications to
>> > >> +configure, enumerate, open, and access FPGA accelerators on platforms
>> > >> equipped
>> > >> +with Intel(R) FPGA solutions and enables system level management
>> > >> functions such
>> > >> +as FPGA reconfiguration, power management, and virtualization.
>> > >> +
>> > >
>> > >
>> > > From a Linux kernel perspective, I'm not sure this is the best name for
>> > > this code.  The name gives me the impression that it is a driver for all
>> > > Intel FPGAs, but not all Intel FPGAs are connected to the processor over a
>> > > PCIe bus.  The processor could be directely connected like the Arria10
>> > > SOCFPGA.  Such a processor could certainly benefit from this accelerator
>> > > usage model.  In an extreme case, couldn't a processor in the FPGA,
>> > > running Linux, also benefit from this accelerator model?  Is this code a
>> > > "FPGA Accelerator Framework"?
>> > >
>> > >> +HW Architecture
>> > >> +===============
>> > >> +From the OS's point of view, the FPGA hardware appears as a regular PCIe
>> > >> device.
>> > >> +The FPGA device memory is organized using a predefined data structure
>> > >> (Device
>> > >> +Feature List). Features supported by the particular FPGA device are
>> > >> exposed
>> > >> +through these data structures, as illustrated below:
>> > >> +
>> > >> +  +-------------------------------+  +-------------+
>> > >> +  |              PF               |  |     VF      |
>> > >> +  +-------------------------------+  +-------------+
>> > >> +      ^            ^         ^              ^
>> > >> +      |            |         |              |
>> > >> ++-----|------------|---------|--------------|-------+
>> > >> +|     |            |         |              |       |
>> > >> +|  +-----+     +-------+ +-------+      +-------+   |
>> > >> +|  | FME |     | Port0 | | Port1 |      | Port2 |   |
>> > >> +|  +-----+     +-------+ +-------+      +-------+   |
>> > >> +|                  ^         ^              ^       |
>> > >> +|                  |         |              |       |
>> > >> +|              +-------+ +------+       +-------+   |
>> > >> +|              |  AFU  | |  AFU |       |  AFU  |   |
>> > >> +|              +-------+ +------+       +-------+   |
>> > >> +|                                                   |
>> > >> +|                 FPGA PCIe Device                  |
>> > >> ++---------------------------------------------------+
>> > >> +
>> > >> +The driver supports PCIe SR-IOV to create virtual functions (VFs) which
>> > >> can be
>> > >> +used to assign individual accelerators to virtual machines .
>> > >
>> > >
>> > > Does this HW Architecture require an Intel FPGA?  Couldn't any vendors FPGA
>> > > be used as long as it presented itself the PCIe bus the same and contained
>> > > an appropriate Device Feature List?
>
> I think this is a good (and important) point. Especially when sysfs
> entries & ioctls constituting ABI depend on it.

Please cc linux-api@vger.kernel.org on your next version of this as
linux/Documentation/process/adding-syscalls.rst specifies for new system calls.

Alan
