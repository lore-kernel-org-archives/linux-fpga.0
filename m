Return-Path: <SRS0=gAzV=AY=redhat.com=trix@kernel.org>
Return-Path: <SRS0=gAzV=AY=redhat.com=trix@kernel.org>
Subject: Re: [PATCH v2] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
References: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <4efe6ee9-4e88-5b31-01a2-414f752a3d2e@redhat.com>
Date: Mon, 13 Jul 2020 07:36:26 -0700
MIME-Version: 1.0
In-Reply-To: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Russ Weight <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>


> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
>  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
>  #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> +#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30

My point about consistency.  These are all intel  and all should have their pf parts removed.

 #define PCIE_DEVICE_ID_INTEL_INT_5_X	0xBCBD
 #define PCIE_DEVICE_ID_INTEL_INT_6_X	0xBCC0
 #define PCIE_DEVICE_ID_INTEL_DSC_1_X	0x09C4

Let's revisit this for the d5005.

trix
