Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511764948-20972-16-git-send-email-hao.wu@intel.com>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com> <1511764948-20972-16-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 31 Jan 2018 09:16:58 -0600
Message-ID: <CANk1AXS-ioW2svMS3QwrQCF5TiHp_nwaongC=d2Z2MfT8BEMMw@mail.gmail.com>
Subject: Re: [PATCH v3 15/21] fpga: dfl: add fpga bridge platform driver for FME
Content-Type: text/plain; charset="UTF-8"
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

One fix below.  Besides that, please add my ack.

> This patch adds fpga bridge platform driver for FPGA Management Engine.
> It implements the enable_set call back for fpga bridge.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

> diff --git a/drivers/fpga/fpga-dfl-fme-br.c b/drivers/fpga/fpga-dfl-fme-br.c
> new file mode 100644
> index 0000000..db2603b
> --- /dev/null
> +++ b/drivers/fpga/fpga-dfl-fme-br.c
> @@ -0,0 +1,87 @@
> +/*
> + * FPGA Bridge Driver for FPGA Management Engine (FME)
> + *
> + * Copyright (C) 2017 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Wu Hao <hao.wu@intel.com>
> + *   Joseph Grecco <joe.grecco@intel.com>
> + *   Enno Luebbers <enno.luebbers@intel.com>
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Henry Mitchel <henry.mitchel@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL version 2.

If we're using the SPDX, then please get rid of the above line.

> + * SPDX-License-Identifier: GPL-2.0
> + */

The SPDX line should be the first line of the file with a // (for .c
files), please see:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/process/license-rules.rst

Same thing for other files.

Alan
