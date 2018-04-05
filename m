Return-Path: <SRS0=SzW4=G2=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=SzW4=G2=gmail.com=robherring2@kernel.org>
Date: Thu, 5 Apr 2018 08:16:53 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv3 1/7] dt-bindings, firmware: add Intel Stratix10 service
 layer binding
Message-ID: <20180405131653.2rso2ta74w663pdx@rob-hp-laptop>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
 <1522182014-7338-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522182014-7338-2-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Mar 27, 2018 at 03:20:08PM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a device tree binding for the Intel Stratix10 service layer driver
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: Change to put service layer driver node under the firmware node
>     Change compatible to "intel, stratix10-svc"
> v3: No change
> ---
>  .../bindings/firmware/intel,stratix10-svc.txt      | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

Please add acks/reviewed-by's when posting new versions.

Rob
