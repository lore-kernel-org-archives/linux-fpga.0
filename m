Return-Path: <SRS0=yu0A=PT=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=yu0A=PT=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45470 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbfAKSmq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 11 Jan 2019 13:42:46 -0500
Received: by mail-yb1-f195.google.com with SMTP id q2so6205531ybd.12
        for <linux-fpga@vger.kernel.org>; Fri, 11 Jan 2019 10:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20190110230626.4130-1-atull@kernel.org>
In-Reply-To: <20190110230626.4130-1-atull@kernel.org>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Fri, 11 Jan 2019 10:42:34 -0800
Message-ID: <CAAtXAHeuGCz7msGnG-kPWN18h6h9z3VgbrBf0eXKvtKaEm7=mA@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera_freeze_bridge: remove restriction to socfpga
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org

Hi Alan,

On Thu, Jan 10, 2019 at 3:06 PM Alan Tull <atull@kernel.org> wrote:
>
> The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> since it can be used on other platforms such as Stratix10.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0bb7b5c..0bdbd3d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
>
>  config ALTERA_FREEZE_BRIDGE
>         tristate "Altera FPGA Freeze Bridge"
> -       depends on ARCH_SOCFPGA && FPGA_BRIDGE
> +       depends on FPGA_BRIDGE

Doesn't that need a dependency on HAS_IOMEM at least, then?
>         help
>           Say Y to enable drivers for Altera FPGA Freeze bridges.  A
>           freeze bridge is a bridge that exists in the FPGA fabric to
> --
> 2.7.4
>

Thanks,
Moritz
