Return-Path: <SRS0=c7M9=FX=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=c7M9=FX=gmail.com=robherring2@kernel.org>
Date: Thu, 1 Mar 2018 16:41:01 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: fpga: Consolidate bridge properties
Message-ID: <20180301224101.ob4bdmh7nne5zgvf@rob-hp-laptop>
References: <20180221173306.17265-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221173306.17265-1-mdf@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, atull@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Feb 21, 2018 at 09:33:06AM -0800, Moritz Fischer wrote:
> Consolidate bridge properties in a single file, instead of duplicating
> the same optional property over and over again.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt |  5 +----
>  .../devicetree/bindings/fpga/altera-freeze-bridge.txt     |  5 +----
>  .../devicetree/bindings/fpga/altera-hps2fpga-bridge.txt   |  5 +----
>  Documentation/devicetree/bindings/fpga/fpga-bridge.txt    | 15 +++++++++++++++
>  .../devicetree/bindings/fpga/xilinx-pr-decoupler.txt      |  8 ++------
>  5 files changed, 20 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt

Reviewed-by: Rob Herring <robh@kernel.org>
