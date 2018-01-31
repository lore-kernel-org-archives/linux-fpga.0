Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511764948-20972-13-git-send-email-hao.wu@intel.com>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com> <1511764948-20972-13-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 31 Jan 2018 09:31:59 -0600
Message-ID: <CANk1AXT4OiH=Wj3o5AjsS7DiUitudMetVu860Qz1RjodDfM18g@mail.gmail.com>
Subject: Re: [PATCH v3 12/21] fpga: dfl: fme: add FPGA_GET_API_VERSION/CHECK_EXTENSION
 ioctls support
Content-Type: text/plain; charset="UTF-8"
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

One fix again, otherwise please add my ack to subsequent versions.

> FPGA_GET_API_VERSION and FPGA_CHECK_EXTENSION ioctls are common ones which
> need to be supported by all feature devices drivers including FME and AFU.
> Userspace application can use these ioctl interfaces to get the API info
> and check if specific extension is supported or not in current driver.
>
> This patch implements above 2 ioctls in FPGA Management Engine (FME)
> driver.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> new file mode 100644
> index 0000000..b46d124
> --- /dev/null
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -0,0 +1,50 @@
> +/*
> + * Header File for FPGA DFL User API
> + *
> + * Copyright (C) 2017 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Kang Luwei <luwei.kang@intel.com>
> + *   Zhang Yi <yi.z.zhang@intel.com>
> + *   Wu Hao <hao.wu@intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL version 2.

Please remove above line.  My understanding is that we are supposed to
not combine SPDX with other license statements.

> + * SPDX-License-Identifier: GPL-2.0
> + */

// SPDX-License-Identifier: GPL-2.0

As first line of file.

Thanks,
Alan
