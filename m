Date: Sun, 1 Mar 2020 08:24:24 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: dfl: pci: fix return value of
 cci_pci_sriov_configure
Message-ID: <20200301162422.GF7593@epycbox.lan>
References: <1582610838-7019-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582610838-7019-1-git-send-email-yilun.xu@intel.com>
To: Xu Yilun <yilun.xu@intel.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Feb 25, 2020 at 02:07:18PM +0800, Xu Yilun wrote:
> pci_driver.sriov_configure should return negative value on error and
> number of enabled VFs on success. But now the driver returns 0 on
> success. The sriov configure still works but will cause a warning
> message:
> 
>   XX VFs requested; only 0 enabled
> 
> This patch changes the return value accordingly.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 89ca292..5387550 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -248,11 +248,13 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>  			return ret;
>  
>  		ret = pci_enable_sriov(pcidev, num_vfs);
> -		if (ret)
> +		if (ret) {
>  			dfl_fpga_cdev_config_ports_pf(cdev);
> +			return ret;
> +		}
>  	}
>  
> -	return ret;
> +	return num_vfs;
>  }
>  
>  static void cci_pci_remove(struct pci_dev *pcidev)
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks
