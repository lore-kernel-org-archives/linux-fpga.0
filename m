Return-Path: <SRS0=SG7w=6B=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=SG7w=6B=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14721 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgDQB6r (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Apr 2020 21:58:47 -0400
Date: Fri, 17 Apr 2020 09:56:05 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Message-ID: <20200417015605.GA30618@yilunxu-OptiPlex-7050>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
 <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Tom Rix <trix@redhat.com>
Cc: "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bhu@redhat.com" <bhu@redhat.com>

Hi Rix:

This patch is based on linux-next. There is an preceding patch
(3c2760b78f90 "fpga: dfl: pci: fix return value of cci_pci_sriov_configure",
Also see Fixes:) in linux-next but not merged in 5.7-rc1 yet.
This patch is to fix the lkp warning brought by the previous one.

Thanks.

On Thu, Apr 16, 2020 at 09:56:47AM -0700, Tom Rix wrote:
> Please check the scope.
> 
> On linus/master, the result of this change looks like
> 
> static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> {
> ��� struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> ��� struct dfl_fpga_cdev *cdev = drvdata->cdev;
> 
> ��� if (!num_vfs) {
> ��� ��� /*
> ��� ��� �* disable SRIOV and then put released ports back to default
> ��� ��� �* PF access mode.
> ��� ��� �*/
> ��� ��� pci_disable_sriov(pcidev);
> 
> ��� ��� dfl_fpga_cdev_config_ports_pf(cdev);
> 
> ��� } else {
> ��� ��� int ret; <--- defined here
> 
> ��� ��� /*
> ��� ��� �* before enable SRIOV, put released ports into VF access mode
> ��� ��� �* first of all.
> ��� ��� �*/
> ��� ��� ret = dfl_fpga_cdev_config_ports_vf(cdev, num_vfs);
> ��� ��� if (ret)
> ��� ��� ��� return ret;
> 
> ��� ��� ret = pci_enable_sriov(pcidev, num_vfs);
> ��� ��� if (ret)
> ��� ��� ��� dfl_fpga_cdev_config_ports_pf(cdev);
> ��� }
> 
> ��� return ret;� <---- not in scope, not defined here
> }
> 
> Tom
