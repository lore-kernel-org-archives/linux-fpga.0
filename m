Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181029160814.5530-1-agust@denx.de>
In-Reply-To: <20181029160814.5530-1-agust@denx.de>
From: Alan Tull <atull@kernel.org>
Date: Thu, 1 Nov 2018 15:00:23 -0500
Message-ID: <CANk1AXRpsHx=PW19r75EQqmaJLCEegTKFs8StAVtZ-naGLYmbQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera-cvp: fix 'bad IO access' on x86_64
Content-Type: text/plain; charset="UTF-8"
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Oct 29, 2018 at 11:08 AM Anatolij Gustschin <agust@denx.de> wrote:

Hi Anatolij,

>
> If mapping the CvP BAR fails, we still can configure the FPGA via
> PCI config space access. In this case the iomap pointer is NULL.
> On x86_64, passing NULL address to pci_iounmap() generates
> "Bad IO access at port 0x0" output with stack call trace. Fix it.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>

Thanks for fixing this!

Alan


> ---
>  drivers/fpga/altera-cvp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 610a1558e0ed..144fa2a4d4cc 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -477,7 +477,8 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>         return 0;
>
>  err_unmap:
> -       pci_iounmap(pdev, conf->map);
> +       if (conf->map)
> +               pci_iounmap(pdev, conf->map);
>         pci_release_region(pdev, CVP_BAR);
>  err_disable:
>         cmd &= ~PCI_COMMAND_MEMORY;
> @@ -493,7 +494,8 @@ static void altera_cvp_remove(struct pci_dev *pdev)
>
>         driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
>         fpga_mgr_unregister(mgr);
> -       pci_iounmap(pdev, conf->map);
> +       if (conf->map)
> +               pci_iounmap(pdev, conf->map);
>         pci_release_region(pdev, CVP_BAR);
>         pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>         cmd &= ~PCI_COMMAND_MEMORY;
> --
> 2.17.1
>
