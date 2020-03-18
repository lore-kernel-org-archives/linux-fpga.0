Return-Path: <SRS0=8sIV=5D=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=8sIV=5D=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:45010 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgCRILn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Mar 2020 04:11:43 -0400
Date: Wed, 18 Mar 2020 16:09:30 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 2/7] fpga: dfl: pci: add irq info for feature devices
  enumeration
Message-ID: <20200318080930.GA2474@yilunxu-OptiPlex-7050>
References: <1584332222-26652-1-git-send-email-yilun.xu@intel.com>
 <1584332222-26652-3-git-send-email-yilun.xu@intel.com>
 <20200318063001.GA32440@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318063001.GA32440@hao-dev>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Wu Hao <hao.wu@intel.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>

On Wed, Mar 18, 2020 at 02:30:01PM +0800, Wu Hao wrote:
> On Mon, Mar 16, 2020 at 12:16:57PM +0800, Xu Yilun wrote:
> > Some DFL FPGA PCIe cards (e.g. Intel FPGA Programmable Acceleration
> > Card) support MSI-X based interrupts. This patch allows PCIe driver
> > to prepare and pass interrupt resources to DFL via enumeration API.
> > These interrupt resources could then be assigned to actual features
> > which use them.
> > 
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ----
> > v2: put irq resources init code inside cce_enumerate_feature_dev()
> >     Some minor changes for Hao's comments.
> > ---
> >  drivers/fpga/dfl-pci.c | 78 ++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 69 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index 5387550..0b1ee7d 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -39,6 +39,28 @@ static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
> >  	return pcim_iomap_table(pcidev)[bar];
> >  }
> >  
> > +static int cci_pci_alloc_irq(struct pci_dev *pcidev)
> > +{
> > +	int nvec = pci_msix_vec_count(pcidev);
> > +	int ret;
> > +
> > +	if (nvec <= 0) {
> > +		dev_dbg(&pcidev->dev, "fpga interrupt not supported\n");
> > +		return 0;
> > +	}
> > +
> > +	ret = pci_alloc_irq_vectors(pcidev, nvec, nvec, PCI_IRQ_MSIX);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return nvec;
> > +}
> > +
> > +static void cci_pci_free_irq(struct pci_dev *pcidev)
> > +{
> > +	pci_free_irq_vectors(pcidev);
> > +}
> > +
> >  /* PCI Device ID */
> >  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
> >  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
> > @@ -78,17 +100,33 @@ static void cci_remove_feature_devs(struct pci_dev *pcidev)
> >  
> >  	/* remove all children feature devices */
> >  	dfl_fpga_feature_devs_remove(drvdata->cdev);
> > +	cci_pci_free_irq(pcidev);
> > +}
> > +
> > +static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
> > +{
> > +	unsigned int i;
> > +	int *table;
> > +
> > +	table = kcalloc(nvec, sizeof(int), GFP_KERNEL);
> > +	if (table) {
> > +		for (i = 0; i < nvec; i++)
> > +			table[i] = pci_irq_vector(pcidev, i);
> > +	}
> > +
> > +	return table;
> >  }
> >  
> >  /* enumerate feature devices under pci device */
> >  static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  {
> >  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> > +	int port_num, bar, i, nvec, ret = 0;
> >  	struct dfl_fpga_enum_info *info;
> >  	struct dfl_fpga_cdev *cdev;
> >  	resource_size_t start, len;
> > -	int port_num, bar, i, ret = 0;
> >  	void __iomem *base;
> > +	int *irq_table;
> >  	u32 offset;
> >  	u64 v;
> >  
> > @@ -97,11 +135,32 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  	if (!info)
> >  		return -ENOMEM;
> >  
> > +	/* add irq info for enumeration if the device support irq */
> > +	nvec = cci_pci_alloc_irq(pcidev);
> > +	if (nvec < 0) {
> > +		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
> > +		ret = nvec;
> > +		goto enum_info_free_exit;
> 
> Hm... seems that it failed directly, different with dfl framework which is still
> trying to enable feature without interrupts. should we keep it the same?

I think we don't have to keep same criteria for dfl bus driver & dfl
framework. They are different modules, and they fail with different reasons.

For DFL framework, we treat irq as add-on support. If DFL specifies
irq for a sub feature but dfl bus driver didn't provide irq table entry,
we just skip it. So dfl bus device doesn't have to support every irq
for each sub feature with irq capability.

For PCI driver, I see there are several reasons for pci_alloc_irq_vectors()
fail, some are parameters input error, some are HW error on PCI config space,
some are out of memory... I think it's better we error out for these
unexpected errors.

> 
> > +	}
> > +
> > +	if (nvec) {
> 
> This can be else or else if ?

This can be else if.

> 
> > +		irq_table = cci_pci_create_irq_table(pcidev, nvec);
> > +		if (!irq_table) {
> > +			ret = -ENOMEM;
> > +			goto error_free_irq;
> > +		}
> > +
> > +		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
> > +		kfree(irq_table);
> > +		if (ret)
> > +			goto error_free_irq;
> > +	}
> > +
> >  	/* start to find Device Feature List from Bar 0 */
> >  	base = cci_pci_ioremap_bar(pcidev, 0);
> >  	if (!base) {
> >  		ret = -ENOMEM;
> > -		goto enum_info_free_exit;
> > +		goto error_free_irq;
> >  	}
> >  
> >  	/*
> > @@ -154,7 +213,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> >  	} else {
> >  		ret = -ENODEV;
> > -		goto enum_info_free_exit;
> > +		goto error_free_irq;
> >  	}
> >  
> >  	/* start enumeration with prepared enumeration information */
> > @@ -162,11 +221,14 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  	if (IS_ERR(cdev)) {
> >  		dev_err(&pcidev->dev, "Enumeration failure\n");
> >  		ret = PTR_ERR(cdev);
> > -		goto enum_info_free_exit;
> > +		goto error_free_irq;
> >  	}
> >  
> >  	drvdata->cdev = cdev;
> >  
> > +error_free_irq:
> 
> could you please use a similar style label here as below?

Yes let me change it.

> 
> Thanks
> Hao
> 
> > +	if (ret)
> > +		cci_pci_free_irq(pcidev);
> >  enum_info_free_exit:
> >  	dfl_fpga_enum_info_free(info);
> >  
> > @@ -211,12 +273,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> >  	}
> >  
> >  	ret = cci_enumerate_feature_devs(pcidev);
> > -	if (ret) {
> > -		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> > -		goto disable_error_report_exit;
> > -	}
> > +	if (!ret)
> > +		return ret;
> >  
> > -	return ret;
> > +	dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> >  
> >  disable_error_report_exit:
> >  	pci_disable_pcie_error_reporting(pcidev);
> > -- 
> > 2.7.4
