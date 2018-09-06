Return-Path: <SRS0=nxl3=LU=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=nxl3=LU=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 6 Sep 2018 11:23:59 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] dt-bindings: fpga: fix freeze controller compatible in
 region doc
Message-ID: <20180906182359.GB20419@archbook>
References: <20180906180152.3620-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906180152.3620-1-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <mdf@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

looks like it's just the examples, right? So not sure someone
would be affected by that, yet?

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

Acked-by: Moritz Fischer <mdf@kernel.org>

Cheers,

Moritz
