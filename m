Return-Path: <SRS0=i/2R=NX=denx.de=agust@kernel.org>
Return-Path: <SRS0=i/2R=NX=denx.de=agust@kernel.org>
Date: Tue, 13 Nov 2018 00:08:23 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] fpga: altera-cvp: Insert SPDX-License-Identifier
Message-ID: <20181113000823.04df5a7a@crub>
In-Reply-To: <20181108011312.29587-2-capetry.dev@gmail.com>
References: <20181108011312.29587-1-capetry.dev@gmail.com>
	<20181108011312.29587-2-capetry.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: capetry.dev@gmail.com
Cc: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed,  7 Nov 2018 23:13:11 -0200
capetry.dev@gmail.com capetry.dev@gmail.com wrote:
...
>diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>index 610a1558e..45b7c8c0b 100644
>--- a/drivers/fpga/altera-cvp.c
>+++ b/drivers/fpga/altera-cvp.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0

when SPDX identifier is in place, shouldn't the GPL boilerplate below
be removed?

Anatolij
