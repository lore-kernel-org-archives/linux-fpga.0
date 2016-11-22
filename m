Return-Path: <atull@opensource.altera.com>
Return-Path: <atull@opensource.altera.com>
Date: Mon, 21 Nov 2016 20:29:15 -0600
From: atull <atull@opensource.altera.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as co-maintainer to fpga
 mgr framework.
In-Reply-To: <1479764942-14321-2-git-send-email-mdf@kernel.org>
Message-ID: <alpine.DEB.2.20.1611212021050.3633@atull-VirtualBox2>
References: <1479764942-14321-1-git-send-email-mdf@kernel.org> <1479764942-14321-2-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: linux-kernel@vger.kernel.org, marex@denx.de, mbrugger@suse.com, jgunthorpe@obsidianresearch.com, mike.looijmans@topic.nl, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, "Moritz Fischer  <mdf@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>," <linux-fpga@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, 21 Nov 2016, Moritz Fischer wrote:

> Add myself as co-maintainer to fpga mgr framework.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Alan Tull <atull@opensource.altera.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org
> ---
> Hi all,
> 
> Lately we've fallen behind a bit on reviewing patches lately.

Hi Moritz,

drivers/fpga has been in the upstream kernel a year now.  Most of that
time, traffic has been very slow.  Recently we had more traffic while
I was travelling and moving to a new office, both cases leaving me
with bad network connectivity.  Things will probably return to normal.
I appreciate your passion and all your effort reviewing stuff.  I
don't see a need for two maintainers at this point.

Alan

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
> -- 
> 2.7.4
> 
> 
