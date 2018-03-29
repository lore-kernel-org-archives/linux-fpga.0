Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1522182014-7338-5-git-send-email-richard.gong@linux.intel.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com> <1522182014-7338-5-git-send-email-richard.gong@linux.intel.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 29 Mar 2018 16:12:30 -0500
Message-ID: <CANk1AXTYZTdMHMPkz1+0zZ2f2FJ-rjJVUbtjjKW06ac1J5VAVQ@mail.gmail.com>
Subject: Re: [PATCHv3 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
Content-Type: text/plain; charset="UTF-8"
To: Richard Gong <richard.gong@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <mdf@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org, Yves Vandervennet <yves.vandervennet@linux.intel.com>, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Mar 27, 2018 at 3:20 PM,  <richard.gong@linux.intel.com> wrote:
> From: Alan Tull <atull@kernel.org>
>
> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: this patch is added in patch set version 2
> v3: change to put fpga_mgr node under firmware/svc node
> ---
>  .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> new file mode 100644
> index 0000000..be7cd96
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
> +       firmware {
> +               svc {
> +                       fpga_mgr: fpga-mgr@0 {

Shouldn't have the index.  Should be:

                            fpga_mgr: fpga-mgr {

Alan

> +                               compatible = "intel,stratix10-soc-fpga-mgr";
> +                       };
> +               };
> +       };
> --
> 2.7.4
>
