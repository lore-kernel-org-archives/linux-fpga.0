Return-Path: <SRS0=4Nig=SB=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=4Nig=SB=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33183 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbfC3BJ3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Mar 2019 21:09:29 -0400
From: Ronan KERYELL <ronan@keryell.fr>
Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
        <20190325202810.GG2665@phenom.ffwll.local>
        <BYAPR02MB51608FDF39B39898FAAEBFEEBB5F0@BYAPR02MB5160.namprd02.prod.outlook.com>
        <CAKMK7uHh5KNaTO+a4ZA+vPQcPKUBwODsx+pPCWNp3sxe9TFP0Q@mail.gmail.com>
        <BYAPR02MB51603A1AD72F704112B55B90BB580@BYAPR02MB5160.namprd02.prod.outlook.com>
        <20190327141137.GK2665@phenom.ffwll.local>
        <BYAPR02MB5160162639C2EAC6B19901B7BB590@BYAPR02MB5160.namprd02.prod.outlook.com>
        <CAPM=9tyLNOXCaKGQkCCmo4tt=Dny0j984-=q8utjwv-aX-Y6BQ@mail.gmail.com>
Date: Fri, 29 Mar 2019 18:09:18 -0700
In-Reply-To: <CAPM=9tyLNOXCaKGQkCCmo4tt=Dny0j984-=q8utjwv-aX-Y6BQ@mail.gmail.com> (Dave
        Airlie's message of "Fri, 29 Mar 2019 14:56:17 +1000")
Message-ID: <871s2pw4ld.fsf@fisel.enstb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: Sonal Santan <sonals@xilinx.com>, Daniel Vetter <daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Cyril Chemparathy <cyrilc@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lizhi Hou <lizhih@xilinx.com>, Michal Simek <michals@xilinx.com>, "airlied@redhat.com" <airlied@redhat.com>, linux-fpga@vger.kernel.org, Ralph Wittig <wittig@xilinx.com>, Ronan Keryell <rkeryell@xilinx.com>

I am adding linux-fpga@vger.kernel.org, since this is why I missed this
thread in the first place...

>>>>> On Fri, 29 Mar 2019 14:56:17 +1000, Dave Airlie <airlied@gmail.com> said:

Hi Dave!

    Dave> On Thu, 28 Mar 2019 at 10:14, Sonal Santan <sonals@xilinx.com> wrote:

    >>> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch]

[...]

    >>> Note: There's no expectation for the fully optimizing compiler,
    >>> and we're totally ok if there's an optimizing proprietary
    >>> compiler and a basic open one (amd, and bunch of other
    >>> companies all have such dual stacks running on top of drm
    >>> kernel drivers). But a basic compiler that can convert basic
    >>> kernels into machine code is expected.

    >> Although the compiler is not open source the compilation flow
    >> lets users examine output from various stages. For example if you
    >> write your kernel in OpenCL/C/C++ you can view the RTL
    >> (Verilog/VHDL) output produced by first stage of compilation.
    >> Note that the compiler is really generating a custom circuit
    >> given a high level input which in the last phase gets synthesized
    >> into bitstream. Expert hardware designers can handcraft a circuit
    >> in RTL and feed it to the compiler. Our FPGA tools let you view
    >> the generated hardware design, the register map, etc. You can get
    >> more information about a compiled design by running XRT tool like
    >> xclbinutil on the generated file.

    >> In essence compiling for FPGAs is quite different than compiling
    >> for GPU/CPU/DSP.  Interestingly FPGA compilers can run anywhere
    >> from 30 mins to a few hours to compile a testcase.

    Dave> So is there any open source userspace generator for what this
    Dave> interface provides? Is the bitstream format that gets fed into
    Dave> the FPGA proprietary and is it signed?

Short answer:

- a bitstream is an opaque content similar to various firmware handled
  by Linux, EFI capsules, x86 microcode, WiFi modems, etc.

- there is no open-source generator for what the interface consume;

- I do not know if it is signed;

- it is probably similar to what Intel FPGA (not GPU) drivers provide
  already inside the Linux kernel and I guess there is no pure
  open-source way to generate their bit-stream either.


Long answer:

- processors, GPU and other digital circuits are designed from a lot of
  elementary transistors, wires, capacitors, resistors... using some
  very complex (and expensive) tools from some EDA companies but at the
  end, after months of work, they come often with a "simple" public
  interface, the... instruction set! So it is rather "easy" at the end
  to generate some instructions with a compiler such as LLVM from a
  description of this ISA or some reverse engineering. Note that even if
  the ISA is public, it is very difficult to make another efficient
  processor from scratch just from this ISA, so there is often no
  concern about making this ISA public to develop the ecosystem ;

- FPGA are field-programmable gate arrays, made also from a lot of
  elementary transistors, wires, capacitors, resistors... but organized
  in billions of very low-level elementary gates, memory elements, DSP
  blocks, I/O blocks, clock generators, specific
  accelerators... directly exposed to the user and that can be
  programmed according to a configuration memory (the bitstream) that
  details how to connect each part, routing element, configuring each
  elemental piece of hardware.  So instead of just writing instructions
  like on a CPU or a GPU, you need to configure each bit of the
  architecture in such a way it does something interesting for
  you. Concretely, you write some programs in RTL languages (Verilog,
  VHDL) or higher-level (C/C++, OpenCL, SYCL...)  and you use some very
  complex (and expensive) tools from some EDA companies to generate the
  bitstream implementing an equivalent circuit with the same
  semantics. Since the architecture is so low level, there is a direct
  mapping between the configuration memory (bitstream) and the hardware
  architecture itself, so if it is public then it is easy to duplicate
  the FPGA itself and to start a new FPGA company. That is unfortunately
  something the existing FPGA companies do not want... ;-)

To summarize:

- on a CPU & GPU, the vendor used the expensive EDA tools once already
  for you and provide the simpler ISA interface;

- on an FPGA, you have access to a pile of low-level hardware and it is
  up to you to use the lengthy process of building your own computing
  architecture using the heavy expensive very subtle EDA tools that will
  run for hours or days to generate some good-enough placement for your
  pleasure.

There is some public documentation on-line:
https://www.xilinx.com/products/silicon-devices/fpga/virtex-ultrascale-plus.html#documentation

To have an idea of the elementary architecture:
https://www.xilinx.com/support/documentation/user_guides/ug574-ultrascale-clb.pdf
https://www.xilinx.com/support/documentation/user_guides/ug579-ultrascale-dsp.pdf
https://www.xilinx.com/support/documentation/user_guides/ug573-ultrascale-memory-resources.pdf

Even on the configuration and the file format, but without any detailed semantics:
https://www.xilinx.com/support/documentation/user_guides/ug570-ultrascale-configuration.pdf


The Xilinx compiler xocc taking for example some LLVM IR and generating
some bitstream is not open-source and will probably never be for the
reasons above... :-(

Xilinx is open-sourcing all what can reasonably be open-sourced:

- the user-level and system run-time, including the OpenCL runtime:
  https://github.com/Xilinx/XRT to handle the bitstreams generated by
  some close-source tools

- the kernel device drivers which are already in
  https://github.com/Xilinx/XRT but we want to upstream into the Linux
  kernel to make life easier (this is the matter of this e-mail thread);

- to generate some real code in the most (modern and) open-source way,
  there is an open-source framework to compile some SYCL C++ including
  some Xilinx FPGA-specific extensions down to SPIR LLVM IR using
  Clang/LLVM and to feed the close-source xocc tool with it
  https://github.com/triSYCL/triSYCL

  You can see starting from
  https://github.com/triSYCL/triSYCL/blob/master/tests/Makefile#L322 how
  to start from C++ code, generate some SPIR LLVM IR and to feed xocc
  and build a fat binary that will use the XRT runtime.

  Some documentation in
  https://github.com/triSYCL/triSYCL/blob/master/doc/architecture.rst

  There are other more official ways to generate bitstream (they are
  called products instead of research projects like triSYCL :-) ).

  We are also working on an other open-source SYCL compiler with Intel
  to have a better common implementation
  https://github.com/intel/llvm/wiki and to upstream this into Clang/LLVM.

So for Xilinx FPGA, you can see the LLVM IR as the equivalent of PTX for
nVidia. But xocc is close-source for some more fundamental reasons: it
would expose all the details of the FPGA. I guess this is exactly the
same for Xilinx FPGA.

Note that probably most of the tool chains used to generate the
low-level firmware for the various CPU (microcode), GPU, etc. are
also close-source.

See you,
-- 
Ronan KERYELL, Xilinx Research Labs / San José, California.
