Return-Path: <SRS0=0za6=6W=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=0za6=6W=ettus.com=moritz.fischer@kernel.org>
Date: Tue, 18 Jul 2017 21:42:21 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: Convert to using %pOF instead of full_name
Message-ID: <20170719044221.GA1581@tyrael.ni.corp.natinst.com>
References: <20170718214339.7774-22-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718214339.7774-22-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Alan Tull <atull@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jul 18, 2017 at 04:43:02PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <moritz.fischer@ettus.com>
> Cc: linux-fpga@vger.kernel.org
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/fpga-region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 3b6b2f4182a1..d9ab7c75b14f 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -319,8 +319,8 @@ static int child_regions_with_firmware(struct device_node *overlay)
>  	of_node_put(child_region);
> 
>  	if (ret)
> -		pr_err("firmware-name not allowed in child FPGA region: %s",
> -		       child_region->full_name);
> +		pr_err("firmware-name not allowed in child FPGA region: %pOF",
> +		       child_region);
> 
>  	return ret;
>  }
> --
> 2.11.0
> 
