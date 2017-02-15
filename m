Return-Path: <SRS0=r/QU=Z4=xilinx.com=michal.simek@kernel.org>
Return-Path: <SRS0=r/QU=Z4=xilinx.com=michal.simek@kernel.org>
Subject: Re: [PATCH 1/2] fpga: Add flag to indicate bitstream needs decrypting
References: <1487118690-21166-1-git-send-email-mdf@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <d8f9c064-3db1-6753-7b6d-dd6401274f03@xilinx.com>
Date: Wed, 15 Feb 2017 16:03:41 +0100
MIME-Version: 1.0
In-Reply-To: <1487118690-21166-1-git-send-email-mdf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: mdf@kernel.org, linux-fpga@vger.kernel.org
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Alan Tull <atull@kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 15.2.2017 01:31, mdf@kernel.org wrote:
> From: Moritz Fischer <moritz.fischer@ettus.com>
> 
> Add a flag that is passed to the write_init() callback, indicating
> that the bitstream is encrypted.
> 
> The low-level driver will deal with the flag, or return an error,
> if encrypted bitstreams are not supported.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org
> ---
>  include/linux/fpga/fpga-mgr.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 57beb5d..1355d8a 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -70,6 +70,7 @@ enum fpga_mgr_states {
>   */
>  #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>  #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
> +#define FPGA_MGR_DECRYPT_BITSTREAM	BIT(2)
>  
>  /**
>   * struct fpga_image_info - information specific to a FPGA image
> 

Isn't it better to state that bitstream is encrypted
instead of saying that bitstream requires decryption?

Your second patch is saying add support for encrypted bitstreams.

M
