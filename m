Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 22 Jan 2020 15:10:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RESEND Patch v6 2/2] fpga: dfl: fme: add performance reporting
 support
Message-ID: <20200122141026.GA10399@kroah.com>
References: <1579230628-22243-1-git-send-email-hao.wu@intel.com>
 <1579230628-22243-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579230628-22243-3-git-send-email-hao.wu@intel.com>
To: Wu Hao <hao.wu@intel.com>
Cc: will@kernel.org, mdf@kernel.org, mark.rutland@arm.com, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, atull@kernel.org, Luwei Kang <luwei.kang@intel.com>, Xu Yilun <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Jan 17, 2020 at 11:10:28AM +0800, Wu Hao wrote:
> +static const struct attribute_group fme_perf_fabric_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_fabric_events_attrs,
> +	.is_visible = fme_perf_fabric_events_visible,
> +};
> +

I don't see any Documentation/ABI/ entries for all of these new files.
Please properly document them so we know how to review this.

thanks,

greg k-h
