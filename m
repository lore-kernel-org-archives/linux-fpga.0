Return-Path: <marex@denx.de>
Return-Path: <marex@denx.de>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as co-maintainer to fpga mgr
 framework.
References: <1479764942-14321-1-git-send-email-mdf@kernel.org>
 <1479764942-14321-2-git-send-email-mdf@kernel.org>
From: Marek Vasut <marex@denx.de>
Message-ID: <b737d78e-34d5-3fb8-6ccd-34e8a10a0276@denx.de>
Date: Mon, 21 Nov 2016 23:09:11 +0100
MIME-Version: 1.0
In-Reply-To: <1479764942-14321-2-git-send-email-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Moritz Fischer <moritz.fischer@ettus.com>, linux-kernel@vger.kernel.org
Cc: mbrugger@suse.com, jgunthorpe@obsidianresearch.com, mike.looijmans@topic.nl, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@opensource.altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 11/21/2016 10:49 PM, Moritz Fischer wrote:
> Add myself as co-maintainer to fpga mgr framework.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Alan Tull <atull@opensource.altera.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org

Acked-by: Marek Vasut <marex@denx.de>

> ---
> Hi all,
> 
> Lately we've fallen behind a bit on reviewing patches lately.
> 
> 'Behind the scenes', Alan has worked on getting a git tree setup
> for us on kernel.org and I've worked on getting the mailing list setup.
> The mailing list is up and running (see patch [1/2]) of this series.
> 
> Greg said he'd be happy to take pull requests from now on, so I hope
> once we have figured out the exact workflow things will be much smoother
> getting your patches merged into the fpga mgr framework.
> 
> Feel free to comment / speak up if you're not cool with this change.
> 
> Thanks,
> 
> Moritz
> 
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 19527a0..1856594 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5004,7 +5004,7 @@ K:	fmc_d.*register
>  
>  FPGA MANAGER FRAMEWORK
>  M:	Alan Tull <atull@opensource.altera.com>
> -R:	Moritz Fischer <moritz.fischer@ettus.com>
> +M:	Moritz Fischer <moritz.fischer@ettus.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
>  F:	drivers/fpga/
> 


-- 
Best regards,
Marek Vasut
