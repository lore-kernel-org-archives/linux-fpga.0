Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-12-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-12-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 14 Feb 2018 10:36:26 -0600
Message-ID: <CANk1AXTDC2YROkdFyhnnAn28nwrv7UHt5_saFGDn4-8VRqS7Sw@mail.gmail.com>
Subject: Re: [PATCH v4 11/24] fpga: dfl: fme: add header sub feature support
Content-Type: text/plain; charset="UTF-8"
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Looks good.

> From: Kang Luwei <luwei.kang@intel.com>
>
> The Header Register set is always present for FPGA Management Engine (FME),
> this patch implements init and uinit function for header sub feature and
> introduce several read-only sysfs interfaces for the capability and status.
>
> Sysfs interfaces:
> * /sys/class/fpga_region/<regionX>/<dfl-fme.x>/ports_num
>   Read-only. Number of ports implemented
>
> * /sys/class/fpga_region/<regionX>/<dfl-fme.x>/bitstream_id
>   Read-only. Blue Bitstream (static FPGA region) identifier number. It contains
>   the detailed version and other information of this static FPGA region.
>
> * /sys/class/fpga_region/<regionX>/<dfl-fme.x>/bitstream_metadata
>   Read-only. Blue Bitstream (static FPGA region) meta data. It contains the
>   synthesis date, seed and other information of this static FPGA region.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
