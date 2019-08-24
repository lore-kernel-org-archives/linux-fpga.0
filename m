Return-Path: <SRS0=lx+0=WU=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=lx+0=WU=ettus.com=moritz.fischer@kernel.org>
Date: Sat, 24 Aug 2019 11:41:46 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [RESEND PATCHv4 0/3] fpga: altera-cvp: Add Stratix10 Support
Message-ID: <20190824184146.GA12399@archbox>
References: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
To: thor.thayer@linux.intel.com
Cc: mdf@kernel.org, richard.gong@intel.com, agust@denx.de, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Thor,

On Mon, Aug 19, 2019 at 03:48:05PM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Newer versions (V2) of Altera/Intel FPGAs CvP have different PCI
> Vendor Specific Capability offsets than the older (V1) Altera/FPGAs.
> 
> Most of the CvP registers and their bitfields remain the same
> between both the older parts and the newer parts.
> 
> This patchset implements changes to discover the Vendor Specific
> Capability offset and then add Stratix10 CvP support.
> 
> V2 Changes:
>   Remove inline designator from abstraction functions.
>   Reverse Christmas Tree format for local variables
>   Remove redundant mask from credit calculation
>   Add commment for the delay(1) function in wait_for_credit()
> 
> V3 Changes
>   Return int instead of void for abstraction functions
>   Check the return code from read in altera_cvp_chk_error()
>   Move reset of current_credit_byte to clear_state().
>   Check return codes of read/writes in added functions.
> 
> V4 Changes
>   Rename delta_credit to space
>   Simplify wait for credit do-while loop.
>   Change from udelay() to usleep_range()
>   Use min() to find length to send
>   Remove NULL initialization from private structure
>   Use #define for Version1 offsets
>   Change current_credit_byte to u32 sent_packets.
>   Changes to Kconfig title and description to support Stratix10.
> 
> Thor Thayer (3):
>   fpga: altera-cvp: Discover Vendor Specific offset
>   fpga: altera-cvp: Preparation for V2 parts.
>   fpga: altera-cvp: Add Stratix10 (V2) Support
> 
>  drivers/fpga/Kconfig      |   6 +-
>  drivers/fpga/altera-cvp.c | 339 ++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 271 insertions(+), 74 deletions(-)
> 
> -- 
> 2.7.4
> 

Applied to for-next. If all goes well I'll send it out with next PR.

- Moritz
