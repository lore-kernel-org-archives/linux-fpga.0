Return-Path: <SRS0=k5de=R7=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=k5de=R7=gmail.com=robherring2@kernel.org>
Date: Thu, 28 Mar 2019 12:00:28 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190328170028.GA10815@bogus>
References: <20190326143129.2608-1-nava.manne@xilinx.com>
 <20190326143129.2608-7-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326143129.2608-7-nava.manne@xilinx.com>
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

On Tue, 26 Mar 2019 20:01:29 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v5:
> 		-Moved pcap node as a child to firwmare
> 		 node as suggested by Rob.
> Changes for v4:
> 		-Modified binding description as suggested by Moritz Fischer.
> Changes for v3:
> 		-Removed PCAP as a child node to the FW and Created
> 		 an independent node since PCAP driver is a consumer
> 		 not a provider.
> 
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
