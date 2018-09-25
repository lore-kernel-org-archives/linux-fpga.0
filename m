Return-Path: <SRS0=c8Cb=MH=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=c8Cb=MH=gmail.com=robherring2@kernel.org>
Date: Tue, 25 Sep 2018 15:17:20 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v2 2/3] dt-bindings: fpga: Add bindings for ZynqMP
 fpga driver
Message-ID: <20180925201720.GA32354@bogus>
References: <20180905072448.12488-1-nava.manne@xilinx.com>
 <20180905072448.12488-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905072448.12488-3-nava.manne@xilinx.com>
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: mark.rutland@arm.com, michal.simek@xilinx.com, atull@kernel.org, mdf@kernel.org, jollys@xilinx.com, sboyd@kernel.org, rajanv@xilinx.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Sep 05, 2018 at 12:54:47PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.

Sorry, but I wasn't thinking that you already have a node defined under 
/firmware. There's no reason to have this pcap node as a child of it. 
The existing node can instantiate multiple providers including this and 
reset provider.

>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt        | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
