Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
References: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Fri, 28 Jul 2017 08:28:39 -0500
Message-ID: <CANk1AXQaPwcmHG84wuYt1-mTeWDuaXtR7JbovnX6=E7hhPU=Sg@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Intel FPGA Device Drivers
Content-Type: text/plain; charset="UTF-8"
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Sun, Jun 25, 2017 at 8:51 PM, Wu Hao <hao.wu@intel.com> wrote:
> Hi All,
>
> Here is v2 patch-series adding drivers for Intel FPGA devices.
>
> The Intel FPGA driver provides interfaces for userspace applications to
> configure, enumerate, open, and access FPGA accelerators on platforms
> equipped with Intel(R) PCIe based FPGA solutions and enables system
> level management functions such as FPGA partial reconfiguration, power
> management and virtualization.
>
> This patch series only adds the basic functions for FPGA accelerators and
> partial reconfiguration. Patches for more functions, e.g power management
> and virtualization, will be submitted after this series gets reviewed.
>
> This patch series depends on Alan Tull's patch set v2 on FPGA region
> support w/o device tree (see [1]).

I've posted a branch for review convenience on the linux-fpga
kernel.org repo.  The branch contains this patchset on top of my now
old v2 FPGA region patchset.

Branch name: for-review-next-20170720-intel-fpga-driver-v2

Alan
