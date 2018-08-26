Return-Path: <SRS0=3isQ=LJ=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=3isQ=LJ=intel.com=hao.wu@kernel.org>
Date: Mon, 27 Aug 2018 07:18:23 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH] fpga: dfl: fme-mgr: fix spelling mistake "Invaild" ->
 "Invalid"
Message-ID: <20180826231823.GA7561@hao-dev>
References: <20180826221355.12661-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180826221355.12661-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Sun, Aug 26, 2018 at 11:13:55PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err message.

This patch is duplicated. This issue is covered by your previous patch.

https://marc.info/?l=linux-fpga&m=153202583007071&w=2

Thanks
Hao

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/fpga/dfl-fme-mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b5ef405b6d88..9f045d058cfd 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
>  		}
>  
>  		if (count < 4) {
> -			dev_err(dev, "Invaild PR bitstream size\n");
> +			dev_err(dev, "Invalid PR bitstream size\n");
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.17.1
