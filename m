Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1498441938-14046-5-git-send-email-hao.wu@intel.com>
References: <1498441938-14046-1-git-send-email-hao.wu@intel.com> <1498441938-14046-5-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 26 Jul 2017 13:33:53 -0500
Message-ID: <CANk1AXT_BaeKHMFRiWnTL0owrW0ar+Y1NDDxefwvjUFhNCEO=g@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] fpga: mgr: add region_id to fpga_image_info
Content-Type: text/plain; charset="UTF-8"
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Sun, Jun 25, 2017 at 8:52 PM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

> This patch adds region_id to fpga_image_info data structure, it
> allows driver to pass region id information to fpga-mgr via
> fpga_image_info for fpga reconfiguration function.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  include/linux/fpga/fpga-mgr.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 66d0e32..b222a57 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -95,6 +95,7 @@ struct fpga_image_info {
>         struct sg_table *sgt;
>         const char *buf;
>         size_t count;
> +       int region_id;

Please add a line to document this region_id above where all the other
struct members are documented.

Alan

>  #ifdef CONFIG_OF
>         struct device_node *overlay;
>  #endif
> --
> 1.8.3.1
>
