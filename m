Return-Path: <SRS0=Vgs8=45=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=Vgs8=45=gmail.com=robherring2@kernel.org>
Date: Thu, 12 Mar 2020 15:39:11 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] arch: nios2: remove 'resetvalue' property
Message-ID: <20200312203911.GA32682@bogus>
References: <20200306115450.3352-1-alexandru.ardelean@analog.com>
 <20200306115450.3352-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306115450.3352-2-alexandru.ardelean@analog.com>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nios2-dev@lists.rocketboards.org, ley.foon.tan@intel.com, robh+dt@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, 6 Mar 2020 13:54:50 +0200, Alexandru Ardelean wrote:
> The 'altr,pio-1.0' driver does not handle the 'resetvalue', so remove it.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 -
>  arch/nios2/boot/dts/10m50_devboard.dts                 | 2 --
>  2 files changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
