Return-Path: <SRS0=FdzR=2C=xilinx.com=michal.simek@kernel.org>
Return-Path: <SRS0=FdzR=2C=xilinx.com=michal.simek@kernel.org>
Subject: Re: [PATCH v2 1/3] fpga: Add flag to indicate bitstream needs
 decrypting
References: <1487624123-13579-1-git-send-email-mdf@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <928f959d-fc36-ba5d-95ba-990dd1927489@xilinx.com>
Date: Tue, 21 Feb 2017 14:55:08 +0100
MIME-Version: 1.0
In-Reply-To: <1487624123-13579-1-git-send-email-mdf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: mdf@kernel.org, linux-fpga@vger.kernel.org
Cc: Alan Tull <atull@kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 20.2.2017 21:55, mdf@kernel.org wrote:
> From: Moritz Fischer <mdf@kernel.org>
> 
> Add a flag that is passed to the write_init() callback, indicating
> that the bitstream is encrypted.
> 
> The low-level driver will deal with the flag, or return an error,
> if encrypted bitstreams are not supported.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org
> ---
> 
> Changes from v1:
> - Renamed flag from FPGA_MGR_DECRYPT_BITSTREAM->FPGA_MGR_ENCRYPTED_BITSTREAM
> 
> ---
>  include/linux/fpga/fpga-mgr.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 57beb5d..e2ef94f 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -70,6 +70,7 @@ enum fpga_mgr_states {
>   */
>  #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>  #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
> +#define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
>  
>  /**
>   * struct fpga_image_info - information specific to a FPGA image
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
