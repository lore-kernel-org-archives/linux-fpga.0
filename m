Return-Path: <moritz.fischer.private@gmail.com>
Date: Tue, 23 Apr 2019 17:21:55 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: stratix10-soc: fix use-after-free on s10_init()
Message-ID: <20190424002155.GA15154@archbook>
References: <1556062325-26141-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556062325-26141-1-git-send-email-wen.yang99@zte.com.cn>
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Wen,

On Wed, Apr 24, 2019 at 07:32:05AM +0800, Wen Yang wrote:
> The refcount of fw_np has already been decreased by of_find_matching_node()
> so it shouldn't be used anymore.
> This patch adds an of_node_get() before of_find_matching_node() to avoid
> the use-after-free problem.
> 
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: linux-fpga@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/stratix10-soc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 13851b3..215d337 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -507,12 +507,16 @@ static int __init s10_init(void)
>  	if (!fw_np)
>  		return -ENODEV;
>  
> +	of_node_get(fw_np);
>  	np = of_find_matching_node(fw_np, s10_of_match);
> -	if (!np)
> +	if (!np) {
> +		of_node_put(fw_np);
>  		return -ENODEV;
> +	}
>  
>  	of_node_put(np);
>  	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
> +	of_node_put(fw_np);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.9.5
> 

Thanks,
Moritz
