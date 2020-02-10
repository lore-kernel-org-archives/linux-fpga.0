Return-Path: <will@kernel.org>
Return-Path: <will@kernel.org>
Date: Mon, 10 Feb 2020 16:34:01 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200210163400.GA21900@willie-the-truck>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581306469-22629-3-git-send-email-hao.wu@intel.com>
To: Wu Hao <hao.wu@intel.com>
Cc: mdf@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com, Luwei Kang <luwei.kang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi,

On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> This patch adds support for performance reporting private feature
> for FPGA Management Engine (FME). Now it supports several different
> performance counters, including 'basic', 'cache', 'fabric', 'vtd'
> and 'vtd_sip'. It allows user to use standard linux tools to access
> these performance counters.

I had a quick look at this, and it mostly looks alright to me. Just a few
high-level comments/questions:

  - I would still prefer for the PMU drivers to live under drivers/perf/

  - You should probably give the PMU a better name than "fme%d", for example
    "intel_fpga_dfl_fme%d".

  - CPU0 can be hotplugged off on non-x86 systems. How do you cope with
    that?

  - readq() will emit 2x32-bit reads on some architectures. What happens
    in this case?

Will
