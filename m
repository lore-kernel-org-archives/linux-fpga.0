Return-Path: <SRS0=/7mc=EU=linux.intel.com=matthew.gerlach@kernel.org>
Return-Path: <SRS0=/7mc=EU=linux.intel.com=matthew.gerlach@kernel.org>
Date: Thu, 25 Jan 2018 08:15:02 -0800 (PST)
From: matthew.gerlach@linux.intel.com
Subject: Re: [PATCH] fpga: fpga-region: comment on fpga_region_program_fpga
 locking
In-Reply-To: <20180125153922.3119-1-atull@kernel.org>
Message-ID: <alpine.DEB.2.20.1801250813290.3365@mgerlach-VirtualBox>
References: <20180125153922.3119-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>



On Thu, 25 Jan 2018, Alan Tull wrote:

Hi Alan,

I seem to remember issue coming up a couple of times.
I think this comment will be very helpful.

Matthew Gerlach

> Add a comment to the header of fpga_region_program_fpga()
> regarding locking of the bridges.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> drivers/fpga/fpga-region.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index edab2a2..cb0603e 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -95,6 +95,11 @@ static void fpga_region_put(struct fpga_region *region)
>  * fpga_region_program_fpga - program FPGA
>  * @region: FPGA region
>  * Program an FPGA using fpga image info (region->info).
> + * If the region has a get_bridges function, the exclusive reference for the
> + * bridges will be held if programming succeeds.  This is intended to prevent
> + * reprogramming the region until the caller considers it safe to do so.
> + * The caller will need to call fpga_bridges_put() before attempting to
> + * reprogram the region.
>  * Return 0 for success or negative error code.
>  */
> int fpga_region_program_fpga(struct fpga_region *region)
> -- 
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
