Date: Wed, 19 Apr 2017 10:16:03 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: region: add missing DT documentation for config
 complete timeout
Message-ID: <20170419171603.GA19240@tyrael.amer.corp.natinst.com>
References: <20170418134003.13830-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418134003.13830-1-tklauser@distanz.ch>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <moritz.fischer@ettus.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Tobias,

On Tue, Apr 18, 2017 at 03:40:03PM +0200, Tobias Klauser wrote:
> Commit 42d5ec954719 ("fpga: add config complete timeout") introduced the
> config complete property but didn't include the corresponding DT binding
> documentation. Add it now.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index 81bf3adba24b..6db8aeda461a 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -193,6 +193,8 @@ Optional properties:
>  - region-freeze-timeout-us : The maximum time in microseconds to wait for
>  	bridges to successfully become disabled before the region has been
>  	programmed.
> +- config-complete-timeout-us : The maximum time in microseconds time for the
> +	FPGA to go to operating mode after the region has been programmed.
>  - child nodes : devices in the FPGA after programming.
>  
>  In the example below, when an overlay is applied targeting fpga-region0,
> -- 
> 2.12.2
> 
> 

Looks good to me, Maybe Rob has got something,

Moritz
