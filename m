Return-Path: <SRS0=c8Cb=MH=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=c8Cb=MH=gmail.com=robherring2@kernel.org>
Date: Tue, 25 Sep 2018 16:09:00 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: fpga: fix freeze controller compatible in
 region doc
Message-ID: <20180925210900.GA30292@bogus>
References: <20180906180152.3620-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906180152.3620-1-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <mdf@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Sep 06, 2018 at 01:01:52PM -0500, Alan Tull wrote:
> Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
> regarding the freeze controller bridge, secifically:
> 
>  compatible = "altr,freeze-bridge";
> 
> The compatibility string should be "altr,freeze-bridge-controller"
> as set forth in altera-freeze-bridge.txt.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Reported-by: Dalon Westergreen <dalon.westergreen@intel.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied.

Rob
