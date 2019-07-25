Date: Thu, 25 Jul 2019 10:22:33 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv3 0/3] fpga: altera-cvp: Add Stratix10 Support
Message-ID: <20190725172231.GA9274@archbox>
References: <1564067808-21173-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564067808-21173-1-git-send-email-thor.thayer@linux.intel.com>
To: thor.thayer@linux.intel.com
Cc: mdf@kernel.org, richard.gong@linux.intel.com, agust@denx.de, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Thor,

On Thu, Jul 25, 2019 at 10:16:45AM -0500, thor.thayer@linux.intel.com wrote:
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
> Thor Thayer (3):
>   fpga: altera-cvp: Discover Vendor Specific offset
>   fpga: altera-cvp: Preparation for V2 parts.
>   fpga: altera-cvp: Add Stratix10 (V2) Support
> 
>  drivers/fpga/altera-cvp.c | 348 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 277 insertions(+), 71 deletions(-)
> 
> -- 
> 2.7.4
> 

this doesn't apply since I applied Carlos' patch 998c1de56dac7
("fpga: altera-cvp: Fix function definition argument") yesterday to

git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git

'for-next' branch.

Would you mind resending it on top of that and drop the extra dev_dbg()
for the offset in Patch [1/3]?

Sorry about that. Things are moving around a bit, but hopefully settle
down soon :)

- Moritz
