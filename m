Date: Sun, 12 Jul 2020 19:02:24 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Message-ID: <20200713020223.GA62228@epycbox.lan>
References: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
To: Xu Yilun <yilun.xu@intel.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Russ Weight <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Jul 13, 2020 at 09:47:46AM +0800, Xu Yilun wrote:
> Add PCIe Device ID for Intel FPGA PAC N3000.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/dfl-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 73b5153..e220bec 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
>  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
>  #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> +#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30
>  /* VF Device */
>  #define PCIE_DEVICE_ID_VF_INT_5_X	0xBCBF
>  #define PCIE_DEVICE_ID_VF_INT_6_X	0xBCC1
> @@ -76,6 +77,7 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_INT_6_X),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_DSC_1_X),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_DSC_1_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000),},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks!
