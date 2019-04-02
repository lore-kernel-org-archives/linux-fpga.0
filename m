Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20190402123123.915-1-nava.manne@xilinx.com> <20190402123123.915-4-nava.manne@xilinx.com>
In-Reply-To: <20190402123123.915-4-nava.manne@xilinx.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 2 Apr 2019 13:27:23 -0500
Message-ID: <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Content-Type: text/plain; charset="UTF-8"
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michal.simek@xilinx.com>, Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Apr 2, 2019 at 7:32 AM Nava kishore Manne <nava.manne@xilinx.com> wrote:

Hi Nava,

Looks good.

>
> This patch adds FPGA Manager support for the Xilinx
> ZynqMP chip.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
> Changes for v4:
>                 -Updated the Fpga Mgr registrations call's
>                  to 5.0
>                 -Removed dma_set_mask_and_coherent() As the FW
>                  supports only 32-bit address operations.
>
> Changes for v3:
>                 -Created patches on top of 5.0-rc5.
>                  No functional changes.
>
> Changes for v2:
>                 -Fixed some minor coding issues as suggested by
>                  Moritz
>
> Changes for v1:
>                 -None.
>
> Changes for RFC-V2:
>                 -Updated the Fpga Mgr registrations call's
>                  to 4.18

Thanks,
Alan
