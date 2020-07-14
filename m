Return-Path: <SRS0=/d1T=AZ=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=/d1T=AZ=intel.com=yilun.xu@kernel.org>
Date: Tue, 14 Jul 2020 14:01:08 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Message-ID: <20200714060108.GA27430@yilunxu-OptiPlex-7050>
References: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
 <4efe6ee9-4e88-5b31-01a2-414f752a3d2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4efe6ee9-4e88-5b31-01a2-414f752a3d2e@redhat.com>
To: Tom Rix <trix@redhat.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Russ Weight <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Jul 13, 2020 at 07:36:26AM -0700, Tom Rix wrote:
> 
> > @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
> >  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
> >  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
> >  #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> > +#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30
> 
> My point about consistency.� These are all intel� and all should have their pf parts removed.
> 
>  #define PCIE_DEVICE_ID_INTEL_INT_5_X	0xBCBD
>  #define PCIE_DEVICE_ID_INTEL_INT_6_X	0xBCC0
>  #define PCIE_DEVICE_ID_INTEL_DSC_1_X	0x09C4
> 
> Let's revisit this for the d5005.

I agree that we should be consistent on the naming. I think we could
reconsider the naming of previous cards and submit a new patch for them.

> 
> trix
> 
