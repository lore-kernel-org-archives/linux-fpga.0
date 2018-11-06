Return-Path: <SRS0=D2yy=NR=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=D2yy=NR=ettus.com=moritz.fischer@kernel.org>
Date: Tue, 6 Nov 2018 11:07:47 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv10 4/8] dt-bindings: fpga: add Stratix10 SoC FPGA manager
 binding
Message-ID: <20181106190747.GA5690@archbook>
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
 <1541523172-5171-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541523172-5171-5-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, corbet@lwn.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, todd.riffel@intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

Hi Richard,

On Tue, Nov 06, 2018 at 10:52:48AM -0600, richard.gong@linux.intel.com wrote:
> From: Alan Tull <atull@kernel.org>
> 
> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: this patch is added in patch set version 2
> v3: change to put fpga_mgr node under firmware/svc node
> v4: s/fpga-mgr@0/fpga-mgr/ to remove unit_address
>     add Richard's signed-off-by
> v5: add Reviewed-by Rob Herring
> v6: no change
> v7: no change
> v8: no change
> v9: no change
> v10: no change
> ---
>  .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> new file mode 100644
> index 0000000..6e03f79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> @@ -0,0 +1,17 @@
> +Intel Stratix10 SoC FPGA Manager
> +
> +Required properties:
> +The fpga_mgr node has the following mandatory property, must be located under
> +firmware/svc node.
> +
> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
> +
> +Example:
> +
> +	firmware {
> +		svc {
> +			fpga_mgr: fpga-mgr {
> +				compatible = "intel,stratix10-soc-fpga-mgr";
> +			};
> +		};
> +	};
> -- 
> 2.7.4
> 
Thanks,
Moritz
