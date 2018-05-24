Return-Path: <SRS0=5V+a=IL=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=5V+a=IL=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 24 May 2018 10:09:08 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 08/14] fpga: region: kernel-doc fixes
Message-ID: <20180524170908.GE4051@archbook>
References: <20180516235007.3951-1-atull@kernel.org>
 <20180516235007.3951-9-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516235007.3951-9-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, May 16, 2018 at 06:50:01PM -0500, Alan Tull wrote:
> Fix formatting and some cleanup for the kernel-doc documentation in
> fpga-region.c
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/fpga-region.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 0878f62..112fa3a 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -81,13 +81,16 @@ static void fpga_region_put(struct fpga_region *region)
>  
>  /**
>   * fpga_region_program_fpga - program FPGA
> + *
>   * @region: FPGA region
> + *
>   * Program an FPGA using fpga image info (region->info).
>   * If the region has a get_bridges function, the exclusive reference for the
>   * bridges will be held if programming succeeds.  This is intended to prevent
>   * reprogramming the region until the caller considers it safe to do so.
>   * The caller will need to call fpga_bridges_put() before attempting to
>   * reprogram the region.
> + *
>   * Return 0 for success or negative error code.
>   */
>  int fpga_region_program_fpga(struct fpga_region *region)
> @@ -216,7 +219,7 @@ void fpga_region_free(struct fpga_region *region)
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_free);
>  
> -/*
> +/**
>   * fpga_region_register - register a FPGA region
>   * @region: FPGA region created by fpga_region_create
>   * Return: 0 or -errno
> @@ -228,7 +231,7 @@ int fpga_region_register(struct fpga_region *region)
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_register);
>  
> -/*
> +/**
>   * fpga_region_unregister - unregister a FPGA region
>   * @region: FPGA region
>   */
> -- 
> 2.7.4
> 

Thanks,
Moritz
