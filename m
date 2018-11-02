Return-Path: <SRS0=PIMu=NN=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=PIMu=NN=ettus.com=moritz.fischer@kernel.org>
Date: Fri, 2 Nov 2018 14:02:21 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: altera-cvp: fix 'bad IO access' on x86_64
Message-ID: <20181102210221.GA2002@archbook>
References: <20181029160814.5530-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029160814.5530-1-agust@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Anatolij,

On Mon, Oct 29, 2018 at 05:08:14PM +0100, Anatolij Gustschin wrote:
> If mapping the CvP BAR fails, we still can configure the FPGA via
> PCI config space access. In this case the iomap pointer is NULL.
> On x86_64, passing NULL address to pci_iounmap() generates
> "Bad IO access at port 0x0" output with stack call trace. Fix it.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-cvp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 610a1558e0ed..144fa2a4d4cc 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -477,7 +477,8 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	return 0;
>  
>  err_unmap:
> -	pci_iounmap(pdev, conf->map);
> +	if (conf->map)
> +		pci_iounmap(pdev, conf->map);
>  	pci_release_region(pdev, CVP_BAR);
>  err_disable:
>  	cmd &= ~PCI_COMMAND_MEMORY;
> @@ -493,7 +494,8 @@ static void altera_cvp_remove(struct pci_dev *pdev)
>  
>  	driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
>  	fpga_mgr_unregister(mgr);
> -	pci_iounmap(pdev, conf->map);
> +	if (conf->map)
> +		pci_iounmap(pdev, conf->map);
>  	pci_release_region(pdev, CVP_BAR);
>  	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>  	cmd &= ~PCI_COMMAND_MEMORY;
> -- 
> 2.17.1
> 

Thanks for the patch,

Moritz
