Return-Path: <SRS0=Ip7l=76=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=Ip7l=76=gmail.com=robherring2@kernel.org>
Date: Wed, 17 Jun 2020 16:38:41 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: fpga: xilinx-slave-serial: valid for
 the 7 Series too
Message-ID: <20200617223841.GA2967136@bogus>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-fpga@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Anatolij Gustschin <agust@denx.de>, linux-kernel@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, Moritz Fischer <mdf@kernel.org>, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, 11 Jun 2020 23:11:40 +0200, Luca Ceresoli wrote:
> The Xilinx 7-series uses the same protocol, mention that.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt     | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
