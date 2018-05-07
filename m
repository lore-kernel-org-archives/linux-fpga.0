Return-Path: <SRS0=Nv/z=H2=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=Nv/z=H2=gmail.com=robherring2@kernel.org>
Date: Mon, 7 May 2018 11:10:46 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv4 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager
 binding
Message-ID: <20180507161045.GA24624@rob-hp-laptop>
References: <1525443697-31009-1-git-send-email-richard.gong@linux.intel.com>
 <1525443697-31009-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525443697-31009-5-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

On Fri, May 04, 2018 at 09:21:34AM -0500, richard.gong@linux.intel.com wrote:
> From: Alan Tull <atull@kernel.org>
> 
> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v2: this patch is added in patch set version 2
> v3: change to put fpga_mgr node under firmware/svc node
> v4: s/fpga-mgr@0/fpga-mgr/ to remove unit_address
>     Add Richard's signed-off-by
> ---
>  .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt

Reviewed-by: Rob Herring <robh@kernel.org>
