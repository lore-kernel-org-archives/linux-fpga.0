Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 3 Jul 2019 19:59:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/15] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190703175926.GA14649@kroah.com>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-6-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628004951.6202-6-mdf@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jun 27, 2019 at 05:49:41PM -0700, Moritz Fischer wrote:
> From: Wu Hao <hao.wu@intel.com>
> 
> This patch adds virtualization support description for DFL based
> FPGA devices (based on PCIe SRIOV), and introductions to new
> interfaces added by new dfl private feature drivers.
> 
> [mdf@kernel.org: Fixed up to make it work with new reStructuredText docs]
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  Documentation/fpga/dfl.rst | 100 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)

This doesn't apply to my tree, where is this file created?

thanks,

greg k-h
