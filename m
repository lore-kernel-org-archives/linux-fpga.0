Return-Path: <moritz.fischer.private@gmail.com>
Date: Wed, 3 Apr 2019 07:20:22 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
Message-ID: <20190403142022.GB5752@archbook>
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Richard,

On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a log for user to know FPGA configuration is successful
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/fpga-mgr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index c386681..559e046 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
>  	}
>  	mgr->state = FPGA_MGR_STATE_OPERATING;
>  
> +	dev_info(&mgr->dev, "Successfully programming FPGA\n");

That info is available in FPGA manager's sysfs status entry, if at all
I'd make this a dev_dbg().

From my end I don't see how we need this really.

Thanks,
Moritz
