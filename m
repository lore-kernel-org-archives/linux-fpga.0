Return-Path: <moritz.fischer.private@gmail.com>
Date: Tue, 4 Aug 2020 09:41:33 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
Message-ID: <20200804164133.GA1499313@epycbox.lan>
References: <20200804162003.19402-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804162003.19402-1-trix@redhat.com>
To: trix@redhat.com
Cc: hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Tom,

On Tue, Aug 04, 2020 at 09:20:03AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> I take care of fpga kernel and userspace for Red Hat and would
> like help out more with the mainline kernel.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce2737b1feb5..6fdb01776413 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6805,6 +6805,7 @@ F:	drivers/net/ethernet/nvidia/*
>  
>  FPGA DFL DRIVERS
>  M:	Wu Hao <hao.wu@intel.com>
> +R:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/fpga/dfl.rst
> @@ -6813,6 +6814,7 @@ F:	include/uapi/linux/fpga-dfl.h
>  
>  FPGA MANAGER FRAMEWORK
>  M:	Moritz Fischer <mdf@kernel.org>
> +R:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
>  W:	http://www.rocketboards.org
> -- 
> 2.18.1
> 
Acked-by: Moritz Fischer <mdf@kernel.org>

I can take the patch, can I get an Acked-by from Hao?

Thanks!

Moritz
