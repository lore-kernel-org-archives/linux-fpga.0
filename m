MIME-Version: 1.0
Date: Sat, 19 Jan 2019 16:40:48 -0800
References: <20190116020100.4813-1-atull@kernel.org>
In-Reply-To: <20190116020100.4813-1-atull@kernel.org>
Message-ID: <CAJYdmeMfH-2aY09_rA0JavL4=WoRy+jWe+ZwgGgefDq-CbpCaA@mail.gmail.com>
Subject: Re: [PATCH v3] fpga: altera_freeze_bridge: remove restriction to socfpga
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Content-Type: text/plain; charset="UTF-8"
To: Alan Tull <atull@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jan 15, 2019 at 6:01 PM Alan Tull <atull@kernel.org> wrote:
>
> The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> since it can be used on other platforms such as Stratix10.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: add depends on HAS_IOMEM
> v3: put both dependencies on one line
> ---
>  drivers/fpga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0bb7b5c..c20445b 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
>
>  config ALTERA_FREEZE_BRIDGE
>         tristate "Altera FPGA Freeze Bridge"
> -       depends on ARCH_SOCFPGA && FPGA_BRIDGE
> +       depends on FPGA_BRIDGE && HAS_IOMEM
>         help
>           Say Y to enable drivers for Altera FPGA Freeze bridges.  A
>           freeze bridge is a bridge that exists in the FPGA fabric to
> --
> 2.7.4
>

Thanks,
Moritz
