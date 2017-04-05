Return-Path: <SRS0=IzCg=3N=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=IzCg=3N=intel.com=hao.wu@kernel.org>
Date: Wed, 5 Apr 2017 20:57:01 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 04/16] fpga: intel: pcie: parse feature list and create
 platform device for features.
Message-ID: <20170405125701.GB3039@hao-dev>
References: <1490875696-15145-1-git-send-email-hao.wu@intel.com>
 <1490875696-15145-5-git-send-email-hao.wu@intel.com>
 <20170404024455.GB8866@tyrael.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170404024455.GB8866@tyrael.amer.corp.natinst.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: atull@kernel.org, moritz.fischer@ettus.com, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, luwei.kang@intel.com, yi.z.zhang@intel.com, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Apr 03, 2017 at 07:44:55PM -0700, Moritz Fischer wrote:
> Xiao,
> 
> few nits inline, I'll need to come back to this once I went over the
> rest of the patchset ;-)

Sure, Thanks for your comments and review. :)

> 
> On Thu, Mar 30, 2017 at 08:08:04PM +0800, Wu Hao wrote:
> > From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > 
> > Device Featuer List structure creates a link list of feature headers
> > within the MMIO space to provide an extensiable way of adding features.
> > 
> > The Intel FPGA PCIe driver walks through the feature headers to enumerate
> > feature devices, FPGA Management Engine (FME) and FPGA Port for Accelerated
> > Function Unit (AFU), and their private sub features. For feature devices,
> > it creates the platform devices and linked the private sub features into
> > their platform data.
> > 
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> > Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ---
> >  drivers/fpga/intel/Makefile      |   2 +-
> >  drivers/fpga/intel/feature-dev.c | 139 +++++++
> >  drivers/fpga/intel/feature-dev.h | 342 ++++++++++++++++
> >  drivers/fpga/intel/pcie.c        | 841 ++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 1321 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/fpga/intel/feature-dev.c
> >  create mode 100644 drivers/fpga/intel/feature-dev.h
> > 
> > diff --git a/drivers/fpga/intel/Makefile b/drivers/fpga/intel/Makefile
> > index 61fd8ea..c029940 100644
> > --- a/drivers/fpga/intel/Makefile
> > +++ b/drivers/fpga/intel/Makefile
> > @@ -1,3 +1,3 @@
> >  obj-$(CONFIG_INTEL_FPGA_PCI) += intel-fpga-pci.o
> >  
> > -intel-fpga-pci-objs := pcie.o
> > +intel-fpga-pci-objs := pcie.o feature-dev.o
> > diff --git a/drivers/fpga/intel/feature-dev.c b/drivers/fpga/intel/feature-dev.c
> > new file mode 100644
> > index 0000000..6952566
> > --- /dev/null
> > +++ b/drivers/fpga/intel/feature-dev.c
> > @@ -0,0 +1,139 @@
> > +/*
> > + * Intel FPGA Feature Device Driver
> > + *
> > + * Copyright (C) 2017 Intel Corporation, Inc.
> > + *
> > + * Authors:
> > + *   Kang Luwei <luwei.kang@intel.com>
> > + *   Zhang Yi <yi.z.zhang@intel.com>
> > + *   Wu Hao <hao.wu@intel.com>
> > + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > + *
> > + * This work is licensed under a dual BSD/GPLv2 license. When using or
> > + * redistributing this file, you may do so under either license. See the
> > + * LICENSE.BSD file under this directory for the BSD license and see
> > + * the COPYING file in the top-level directory for the GPLv2 license.
> > + */
> > +
> > +#include "feature-dev.h"
> > +
> > +void feature_platform_data_add(struct feature_platform_data *pdata,
> > +			       int index, const char *name,
> > +			       int resource_index, void __iomem *ioaddr)
> > +{
> > +	WARN_ON(index >= pdata->num);
> > +
> > +	pdata->features[index].name = name;
> > +	pdata->features[index].resource_index = resource_index;
> > +	pdata->features[index].ioaddr = ioaddr;
> > +}
> > +
> > +int feature_platform_data_size(int num)
> 
> static inline? num can be const

Sure. will fix this.

> 
> > +{
> > +	return sizeof(struct feature_platform_data) +
> > +		num * sizeof(struct feature);
> > +}
> > +
> > +struct feature_platform_data *
> > +feature_platform_data_alloc_and_init(struct platform_device *dev, int num)
> > +{
> > +	struct feature_platform_data *pdata;
> > +
> > +	pdata = kzalloc(feature_platform_data_size(num), GFP_KERNEL);
> > +	if (pdata) {
> > +		pdata->dev = dev;
> > +		pdata->num = num;
> > +		mutex_init(&pdata->lock);
> > +	}
> > +
> > +	return pdata;
> > +}
> > +
> > +int fme_feature_num(void)
> 
> is this used outside of this file? if not -> static

Yes, used in pcie.c

> > +{
> > +	return FME_FEATURE_ID_MAX;
> > +}
> > +
> > +int port_feature_num(void)
> 
> is this used outside of this file? if not -> static

Yes, used in pcie.c

> > +{
> > +	return PORT_FEATURE_ID_MAX;
> > +}
> > +
> > +int fpga_port_id(struct platform_device *pdev)
> > +{
> > +	struct feature_port_header *port_hdr;
> > +	struct feature_port_capability capability;
> > +
> > +	port_hdr = get_feature_ioaddr_by_index(&pdev->dev,
> > +					       PORT_FEATURE_ID_HEADER);
> > +	WARN_ON(!port_hdr);
> > +
> > +	capability.csr = readq(&port_hdr->capability);
> > +	return capability.port_number;
> > +}
> > +EXPORT_SYMBOL_GPL(fpga_port_id);
> > +
> > +/*
> > + * Enable Port by clear the port soft reset bit, which is set by default.
> > + * The User AFU is unable to respond to any MMIO access while in reset.
> > + * __fpga_port_enable function should only be used after __fpga_port_disable
> > + * function.
> > + */
> > +void __fpga_port_enable(struct platform_device *pdev)
> > +{
> > +	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +	struct feature_port_header *port_hdr;
> > +	struct feature_port_control control;
> > +
> > +	WARN_ON(!pdata->disable_count);
> > +
> > +	if (--pdata->disable_count != 0)
> > +		return;
> > +
> > +	port_hdr = get_feature_ioaddr_by_index(&pdev->dev,
> > +					       PORT_FEATURE_ID_HEADER);
> > +	WARN_ON(!port_hdr);
> > +
> > +	control.csr = readq(&port_hdr->control);
> > +	control.port_sftrst = 0x0;
> > +	writeq(control.csr, &port_hdr->control);
> > +}
> > +EXPORT_SYMBOL_GPL(__fpga_port_enable);
> > +
> > +#define RST_POLL_INVL 10 /* us */
> > +#define RST_POLL_TIMEOUT 1000 /* us */
> > +
> > +int __fpga_port_disable(struct platform_device *pdev)
> > +{
> > +	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +	struct feature_port_header *port_hdr;
> > +	struct feature_port_control control;
> > +
> > +	if (pdata->disable_count++ != 0)
> > +		return 0;
> > +
> > +	port_hdr = get_feature_ioaddr_by_index(&pdev->dev,
> > +					       PORT_FEATURE_ID_HEADER);
> > +	WARN_ON(!port_hdr);
> > +
> > +	/* Set port soft reset */
> > +	control.csr = readq(&port_hdr->control);
> > +	control.port_sftrst = 0x1;
> > +	writeq(control.csr, &port_hdr->control);
> > +
> > +	/*
> > +	 * HW sets ack bit to 1 when all outstanding requests have been drained
> > +	 * on this port and minimum soft reset pulse width has elapsed.
> > +	 * Driver polls port_soft_reset_ack to determine if reset done by HW.
> > +	 */
> > +	control.port_sftrst_ack = 1;
> > +
> > +	if (fpga_wait_register_field(port_sftrst_ack, control,
> > +		&port_hdr->control, RST_POLL_TIMEOUT, RST_POLL_INVL)) {
> > +		dev_err(&pdev->dev, "timeout, fail to reset device\n");
> > +		return -ETIMEDOUT;
> > +	}
> 
> see iopoll comment above.

Yes, will fix this.

> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(__fpga_port_disable);
> > diff --git a/drivers/fpga/intel/feature-dev.h b/drivers/fpga/intel/feature-dev.h
> > new file mode 100644
> > index 0000000..a1e6e7d
> > --- /dev/null
> > +++ b/drivers/fpga/intel/feature-dev.h
> > @@ -0,0 +1,342 @@
> > +/*
> > + * Intel FPGA Feature Device Driver Header File
> > + *
> > + * Copyright (C) 2017 Intel Corporation, Inc.
> > + *
> > + * Authors:
> > + *   Kang Luwei <luwei.kang@intel.com>
> > + *   Zhang Yi <yi.z.zhang@intel.com>
> > + *   Wu Hao <hao.wu@intel.com>
> > + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > + *
> > + * This work is licensed under a dual BSD/GPLv2 license. When using or
> > + * redistributing this file, you may do so under either license. See the
> > + * LICENSE.BSD file under this directory for the BSD license and see
> > + * the COPYING file in the top-level directory for the GPLv2 license.
> > + */
> > +
> > +#ifndef __INTEL_FPGA_FEATURE_H
> > +#define __INTEL_FPGA_FEATURE_H
> > +
> > +#include <linux/fs.h>
> > +#include <linux/pci.h>
> > +#include <linux/uuid.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>
> > +
> > +/* maximum supported number of ports */
> > +#define MAX_FPGA_PORT_NUM 4
> > +/* plus one for fme device */
> > +#define MAX_FEATURE_DEV_NUM	(MAX_FPGA_PORT_NUM + 1)
> > +
> > +#define FME_FEATURE_HEADER          "fme_hdr"
> > +#define FME_FEATURE_THERMAL_MGMT    "fme_thermal"
> > +#define FME_FEATURE_POWER_MGMT      "fme_power"
> > +#define FME_FEATURE_GLOBAL_PERF     "fme_gperf"
> > +#define FME_FEATURE_GLOBAL_ERR      "fme_error"
> > +#define FME_FEATURE_PR_MGMT         "fme_pr"
> > +
> > +#define PORT_FEATURE_HEADER         "port_hdr"
> > +#define PORT_FEATURE_UAFU           "port_uafu"
> > +#define PORT_FEATURE_ERR            "port_err"
> > +#define PORT_FEATURE_UMSG           "port_umsg"
> > +#define PORT_FEATURE_PR             "port_pr"
> > +#define PORT_FEATURE_STP            "port_stp"
> > +
> > +/* All headers and structures must be byte-packed to match the spec. */
> > +#pragma pack(1)
> 
> I recall there being some controversy about this, can't remember which
> way people ended up deciding :)

It seems __packed is better?

> > +
> > +/* common header for all features */
> > +struct feature_header {
> > +	union {
> > +		u64 csr;
> > +		struct {
> > +			u16 id:12;
> > +			u8  revision:4;
> > +			u32 next_header_offset:24; /* offset to next header */
> > +			u32 rsvdz:20;
> > +			u8  type:4;		   /* feature type */
> > +#define FEATURE_TYPE_AFU		0x1
> > +#define FEATURE_TYPE_PRIVATE		0x3
> > +		};
> > +	};
> > +};
> > +
> > +/* common header for non-private features */
> > +struct feature_afu_header {
> > +	uuid_le guid;
> > +	union {
> > +		u64 csr;
> > +		struct {
> > +			u64 next_afu:24;	/* pointer to next afu header */
> > +			u64 rsvdz:40;
> > +		};
> > +	};
> > +};
> > +
> > +/* FME Header Register Set */
> > +/* FME Capability Register */
> > +struct feature_fme_capability {
> > +	union {
> > +		u64 csr;
> > +		struct {
> > +			u8  fabric_verid;	/* Fabric version ID */
> > +			u8  socket_id:1;	/* Socket id */
> > +			u8  rsvdz1:3;
> > +			u8  pcie0_link_avl:1;	/* PCIe0 link availability */
> > +			u8  pcie1_link_avl:1;	/* PCIe1 link availability */
> > +			u8  coherent_link_avl:1;/* Coherent link availability */
> > +			u8  rsvdz2:1;
> > +			u8  iommu_support:1;	/* IOMMU or VT-d supported */
> > +			u8  num_ports:3;	/* Num of ports implemented */
> > +			u8  rsvdz3:4;
> > +			u8  addr_width_bits:6;	/* Address width supported */
> > +			u8  rsvdz4:2;
> > +			u16 cache_size:12;	/* Cache size in kb */
> > +			u8  cache_assoc:4;	/* Cache Associativity */
> > +			u16 rsvdz5:15;
> > +			u8  lock_bit:1;		/* Latched lock bit by BIOS */
> > +		};
> > +	};
> > +};
> > +
> > +/* FME Port Offset Register */
> > +struct feature_fme_port {
> > +	union {
> > +		u64 csr;
> > +		struct {
> > +			u32 port_offset:24;	/* Offset to port header */
> > +			u8  rsvdz1;
> > +			u8  port_bar:3;		/* Bar id */
> > +			u32 rsvdz2:20;
> > +			u8  afu_access_ctrl:1;	/* AFU access type: PF/VF */
> > +			u8  rsvdz3:4;
> > +			u8  port_implemented:1;	/* Port implemented or not */
> > +			u8  rsvdz4:3;
> > +		};
> > +	};
> > +};
> > +
> > +struct feature_fme_header {
> > +	struct feature_header header;
> > +	struct feature_afu_header afu_header;
> > +	u64 rsvd[2];
> > +	struct feature_fme_capability capability;
> > +	struct feature_fme_port port[MAX_FPGA_PORT_NUM];
> > +};
> > +
> > +/* FME Thermal Sub Feature Register Set */
> > +struct feature_fme_thermal {
> > +	struct feature_header header;
> > +};
> > +
> > +/* FME Power Sub Feature Register Set */
> > +struct feature_fme_power {
> > +	struct feature_header header;
> > +};
> > +
> > +/* FME Global Performance Sub Feature Register Set */
> > +struct feature_fme_gperf {
> > +	struct feature_header header;
> > +};
> > +
> > +/* FME Error Sub Feature Register Set */
> > +struct feature_fme_err {
> > +	struct feature_header header;
> > +};
> > +
> > +/* FME Partial Reconfiguration Sub Feature Register Set */
> > +struct feature_fme_pr {
> > +	struct feature_header header;
> > +};
> > +
> > +/* PORT Header Register Set */
> > +/* Port Capability Register */
> > +struct feature_port_capability {
> > +	union {
> > +		u64 csr;
> > +		struct {
> > +			u8  port_number:2;	/* Port Number 0-3 */
> > +			u8  rsvdz1:6;
> > +			u16 mmio_size;		/* User MMIO size in KB */
> > +			u8  rsvdz2;
> > +			u8  sp_intr_num:4;	/* Supported interrupts num */
> > +			u32 rsvdz3:28;
> > +		};
> > +	};
> > +};
> > +
> > +/* Port Control Register */
> > +struct feature_port_control {
> > +	union {
> > +		u64 csr;
> > +		struct {
> > +			u8  port_sftrst:1;	/* Port Soft Reset */
> > +			u8  rsvdz1:1;
> > +			u8  latency_tolerance:1;/* '1' >= 40us, '0' < 40us */
> > +			u8  rsvdz2:1;
> > +			u8  port_sftrst_ack:1;	/* HW ACK for Soft Reset */
> > +			u64 rsvdz3:59;
> > +		};
> > +	};
> > +};
> > +
> > +struct feature_port_header {
> > +	struct feature_header header;
> > +	struct feature_afu_header afu_header;
> > +	u64 rsvd[2];
> > +	struct feature_port_capability capability;
> > +	struct feature_port_control control;
> > +};
> > +
> > +/* PORT Error Sub Feature Register Set */
> > +struct feature_port_error {
> > +	struct feature_header header;
> > +};
> > +
> > +/* PORT Unordered Message Sub Feature Register Set */
> > +struct feature_port_umsg {
> > +	struct feature_header header;
> > +};
> > +
> > +/* PORT SignalTap Sub Feature Register Set */
> > +struct feature_port_stp {
> > +	struct feature_header header;
> > +};
> > +
> > +#pragma pack()
> > +
> > +struct feature {
> > +	const char *name;
> > +	int resource_index;
> > +	void __iomem *ioaddr;
> > +};
> > +
> > +struct feature_platform_data {
> > +	/* list the feature dev to cci_drvdata->port_dev_list. */
> > +	struct list_head node;
> > +	struct mutex lock;
> > +	struct platform_device *dev;
> > +	unsigned int disable_count;	/* count for port disable */
> > +
> > +	int num;			/* number of features */
> > +	struct feature features[0];
> > +};
> > +
> > +enum fme_feature_id {
> > +	FME_FEATURE_ID_HEADER = 0x0,
> > +	FME_FEATURE_ID_THERMAL_MGMT = 0x1,
> > +	FME_FEATURE_ID_POWER_MGMT = 0x2,
> > +	FME_FEATURE_ID_GLOBAL_PERF = 0x3,
> > +	FME_FEATURE_ID_GLOBAL_ERR = 0x4,
> > +	FME_FEATURE_ID_PR_MGMT = 0x5,
> > +	FME_FEATURE_ID_MAX = 0x6,
> > +};
> > +
> > +enum port_feature_id {
> > +	PORT_FEATURE_ID_HEADER = 0x0,
> > +	PORT_FEATURE_ID_ERROR = 0x1,
> > +	PORT_FEATURE_ID_UMSG = 0x2,
> > +	PORT_FEATURE_ID_PR = 0x3,
> > +	PORT_FEATURE_ID_STP = 0x4,
> > +	PORT_FEATURE_ID_UAFU = 0x5,
> > +	PORT_FEATURE_ID_MAX = 0x6,
> > +};
> > +
> > +int fme_feature_num(void);
> > +int port_feature_num(void);
> > +
> > +#define FPGA_FEATURE_DEV_FME		"intel-fpga-fme"
> > +#define FPGA_FEATURE_DEV_PORT		"intel-fpga-port"
> > +
> > +void feature_platform_data_add(struct feature_platform_data *pdata,
> > +			       int index, const char *name,
> > +			       int resource_index, void __iomem *ioaddr);
> > +int feature_platform_data_size(int num);
> > +struct feature_platform_data *
> > +feature_platform_data_alloc_and_init(struct platform_device *dev, int num);
> > +
> > +int fpga_port_id(struct platform_device *pdev);
> > +
> > +static inline int fpga_port_check_id(struct platform_device *pdev,
> > +				     void *pport_id)
> > +{
> > +	return fpga_port_id(pdev) == *(int *)pport_id;
> > +}
> > +
> > +void __fpga_port_enable(struct platform_device *pdev);
> > +int __fpga_port_disable(struct platform_device *pdev);
> > +
> > +static inline void fpga_port_enable(struct platform_device *pdev)
> > +{
> > +	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +
> > +	mutex_lock(&pdata->lock);
> > +	__fpga_port_enable(pdev);
> > +	mutex_unlock(&pdata->lock);
> > +}
> > +
> > +static inline int fpga_port_disable(struct platform_device *pdev)
> > +{
> > +	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +	int ret;
> > +
> > +	mutex_lock(&pdata->lock);
> > +	ret = __fpga_port_disable(pdev);
> > +	mutex_unlock(&pdata->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static inline int __fpga_port_reset(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +
> > +	ret = __fpga_port_disable(pdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	__fpga_port_enable(pdev);
> > +	return 0;
> > +}
> > +
> > +static inline int fpga_port_reset(struct platform_device *pdev)
> > +{
> > +	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +	int ret;
> > +
> > +	mutex_lock(&pdata->lock);
> > +	ret = __fpga_port_reset(pdev);
> > +	mutex_unlock(&pdata->lock);
> > +	return ret;
> > +}
> > +
> > +static inline void __iomem *
> > +get_feature_ioaddr_by_index(struct device *dev, int index)
> > +{
> > +	struct feature_platform_data *pdata = dev_get_platdata(dev);
> > +
> > +	return pdata->features[index].ioaddr;
> > +}
> > +
> > +/*
> > + * Wait register's _field to be changed to the given value (_expect's _field)
> > + * by polling with given interval and timeout.
> > + */
> > +#define fpga_wait_register_field(_field, _expect, _reg_addr, _timeout, _invl)\
> > +({									     \
> > +	int wait = 0;							     \
> > +	int ret = -ETIMEDOUT;						     \
> > +	typeof(_expect) value;						     \
> > +	for (; wait <= _timeout; wait += _invl) {			     \
> > +		value.csr = readq(_reg_addr);				     \
> > +		if (_expect._field == value._field) {			     \
> > +			ret = 0;					     \
> > +			break;						     \
> > +		}							     \
> > +		udelay(_invl);						     \
> > +	}								     \
> > +	ret;								     \
> > +})
> 
> can't you use iopoll and friends instead of this?

Yes, will fix this.

Thanks for the recommendation.

> 
> > +
> > +#endif
> > diff --git a/drivers/fpga/intel/pcie.c b/drivers/fpga/intel/pcie.c
> > index 132d9da..28df63e 100644
> > --- a/drivers/fpga/intel/pcie.c
> > +++ b/drivers/fpga/intel/pcie.c
> > @@ -25,10 +25,827 @@
> >  #include <linux/stddef.h>
> >  #include <linux/errno.h>
> >  #include <linux/aer.h>
> > +#include <linux/fpga/fpga-dev.h>
> > +
> > +#include "feature-dev.h"
> >  
> >  #define DRV_VERSION	"EXPERIMENTAL VERSION"
> >  #define DRV_NAME	"intel-fpga-pci"
> >  
> > +#define INTEL_FPGA_DEV	"intel-fpga-dev"
> > +
> > +static DEFINE_MUTEX(fpga_id_mutex);
> > +
> > +enum fpga_id_type {
> > +	FME_ID,		/* fme id allocation and mapping */
> > +	PORT_ID,	/* port id allocation and mapping */
> > +	FPGA_ID_MAX,
> > +};
> > +
> > +/* it is protected by fpga_id_mutex */
> > +static struct idr fpga_ids[FPGA_ID_MAX];
> > +
> > +struct cci_drvdata {
> > +	struct device *fme_dev;
> > +
> > +	struct mutex lock;
> > +	struct list_head port_dev_list;
> > +
> > +	struct list_head regions; /* global list of pci bar mapping region */
> > +};
> > +
> > +/* pci bar mapping info */
> > +struct cci_pci_region {
> > +	int bar;
> > +	void __iomem *ioaddr;	/* pointer to mapped bar region */
> > +	struct list_head node;
> > +};
> > +
> > +static void fpga_ids_init(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(fpga_ids); i++)
> > +		idr_init(fpga_ids + i);
> > +}
> > +
> > +static void fpga_ids_destroy(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(fpga_ids); i++)
> > +		idr_destroy(fpga_ids + i);
> > +}
> > +
> > +static int alloc_fpga_id(enum fpga_id_type type, struct device *dev)
> > +{
> > +	int id;
> > +
> > +	WARN_ON(type >= FPGA_ID_MAX);
> > +	mutex_lock(&fpga_id_mutex);
> > +	id = idr_alloc(fpga_ids + type, dev, 0, 0, GFP_KERNEL);
> > +	mutex_unlock(&fpga_id_mutex);
> > +	return id;
> > +}
> > +
> > +static void free_fpga_id(enum fpga_id_type type, int id)
> > +{
> > +	WARN_ON(type >= FPGA_ID_MAX);
> > +	mutex_lock(&fpga_id_mutex);
> > +	idr_remove(fpga_ids + type, id);
> > +	mutex_unlock(&fpga_id_mutex);
> > +}
> > +
> > +static void cci_pci_add_port_dev(struct pci_dev *pdev,
> > +				 struct platform_device *port_dev)
> > +{
> > +	struct cci_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> > +	struct feature_platform_data *pdata = dev_get_platdata(&port_dev->dev);
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	list_add(&pdata->node, &drvdata->port_dev_list);
> > +	get_device(&pdata->dev->dev);
> > +	mutex_unlock(&drvdata->lock);
> > +}
> > +
> > +static void cci_pci_remove_port_devs(struct pci_dev *pdev)
> > +{
> > +	struct cci_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> > +	struct feature_platform_data *pdata, *ptmp;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	list_for_each_entry_safe(pdata, ptmp, &drvdata->port_dev_list, node) {
> > +		struct platform_device *port_dev = pdata->dev;
> > +
> > +		/* the port should be unregistered first. */
> > +		WARN_ON(device_is_registered(&port_dev->dev));
> > +		list_del(&pdata->node);
> > +		free_fpga_id(PORT_ID, port_dev->id);
> > +		put_device(&port_dev->dev);
> > +	}
> > +	mutex_unlock(&drvdata->lock);
> > +}
> > +
> > +/* info collection during feature dev build. */
> > +struct build_feature_devs_info {
> > +	struct pci_dev *pdev;
> > +
> > +	/*
> > +	 * PCI BAR mapping info. Parsing feature list starts from
> > +	 * BAR 0 and switch to different BARs to parse Port
> > +	 */
> > +	void __iomem *ioaddr;
> > +	void __iomem *ioend;
> > +	int current_bar;
> > +
> > +	/* points to FME header where the port offset is figured out. */
> > +	void __iomem *pfme_hdr;
> > +
> > +	/* the container device for all feature devices */
> > +	struct fpga_dev *parent_dev;
> > +
> > +	/* current feature device */
> > +	struct platform_device *feature_dev;
> > +};
> > +
> > +static void cci_pci_release_regions(struct pci_dev *pdev)
> > +{
> > +	struct cci_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> > +	struct cci_pci_region *tmp, *region;
> > +
> > +	list_for_each_entry_safe(region, tmp, &drvdata->regions, node) {
> > +		list_del(&region->node);
> > +		if (region->ioaddr)
> > +			pci_iounmap(pdev, region->ioaddr);
> > +		devm_kfree(&pdev->dev, region);
> > +	}
> > +}
> > +
> > +static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pdev, int bar)
> > +{
> > +	struct cci_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> > +	struct cci_pci_region *region;
> > +
> > +	list_for_each_entry(region, &drvdata->regions, node)
> > +		if (region->bar == bar) {
> > +			dev_dbg(&pdev->dev, "BAR %d region exists\n", bar);
> > +			return region->ioaddr;
> > +		}
> > +
> > +	region = devm_kzalloc(&pdev->dev, sizeof(*region), GFP_KERNEL);
> > +	if (!region)
> > +		return NULL;
> > +
> > +	region->bar = bar;
> > +	region->ioaddr = pci_ioremap_bar(pdev, bar);
> > +	if (!region->ioaddr) {
> > +		dev_err(&pdev->dev, "can't ioremap memory from BAR %d.\n", bar);
> > +		devm_kfree(&pdev->dev, region);
> > +		return NULL;
> > +	}
> > +
> > +	list_add(&region->node, &drvdata->regions);
> > +	return region->ioaddr;
> > +}
> > +
> > +static int parse_start_from(struct build_feature_devs_info *binfo, int bar)
> > +{
> > +	binfo->ioaddr = cci_pci_ioremap_bar(binfo->pdev, bar);
> > +	if (!binfo->ioaddr)
> > +		return -ENOMEM;
> > +
> > +	binfo->current_bar = bar;
> > +	binfo->ioend = binfo->ioaddr + pci_resource_len(binfo->pdev, bar);
> > +	return 0;
> > +}
> > +
> > +static int parse_start(struct build_feature_devs_info *binfo)
> > +{
> > +	/* fpga feature list starts from BAR 0 */
> > +	return parse_start_from(binfo, 0);
> > +}
> > +
> > +/* switch the memory mapping to BAR# @bar */
> > +static int parse_switch_to(struct build_feature_devs_info *binfo, int bar)
> > +{
> > +	return parse_start_from(binfo, bar);
> > +}
> > +
> > +static struct build_feature_devs_info *
> > +build_info_alloc_and_init(struct pci_dev *pdev)
> > +{
> > +	struct build_feature_devs_info *binfo;
> > +
> > +	binfo = devm_kzalloc(&pdev->dev, sizeof(*binfo), GFP_KERNEL);
> > +	if (binfo)
> > +		binfo->pdev = pdev;
> > +
> > +	return binfo;
> > +}
> > +
> > +static enum fpga_id_type feature_dev_id_type(struct platform_device *pdev)
> > +{
> > +	if (!strcmp(pdev->name, FPGA_FEATURE_DEV_FME))
> > +		return FME_ID;
> > +
> > +	if (!strcmp(pdev->name, FPGA_FEATURE_DEV_PORT))
> > +		return PORT_ID;
> > +
> > +	WARN_ON(1);
> > +	return FPGA_ID_MAX;
> > +}
> > +
> > +/*
> > + * register current feature device, it is called when we need to switch to
> > + * another feature parsing or we have parsed all features
> > + */
> > +static int build_info_commit_dev(struct build_feature_devs_info *binfo)
> > +{
> > +	int ret;
> > +
> > +	if (!binfo->feature_dev)
> > +		return 0;
> > +
> > +	ret = platform_device_add(binfo->feature_dev);
> > +	if (!ret) {
> > +		struct cci_drvdata *drvdata;
> > +
> > +		drvdata = dev_get_drvdata(&binfo->pdev->dev);
> > +		if (feature_dev_id_type(binfo->feature_dev) == PORT_ID)
> > +			cci_pci_add_port_dev(binfo->pdev, binfo->feature_dev);
> > +		else
> > +			drvdata->fme_dev = get_device(&binfo->feature_dev->dev);
> > +
> > +		/*
> > +		 * reset it to avoid build_info_free() freeing their resource.
> > +		 *
> > +		 * The resource of successfully registered feature devices
> > +		 * will be freed by platform_device_unregister(). See the
> > +		 * comments in build_info_create_dev().
> > +		 */
> > +		binfo->feature_dev = NULL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int
> > +build_info_create_dev(struct build_feature_devs_info *binfo,
> > +		      enum fpga_id_type type, int feature_nr, const char *name)
> > +{
> > +	struct platform_device *fdev;
> > +	struct resource *res;
> > +	struct feature_platform_data *pdata;
> > +	int ret;
> > +
> > +	/* we will create a new device, commit current device first */
> > +	ret = build_info_commit_dev(binfo);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * we use -ENODEV as the initialization indicator which indicates
> > +	 * whether the id need to be reclaimed
> > +	 */
> > +	fdev = binfo->feature_dev = platform_device_alloc(name, -ENODEV);
> > +	if (!fdev)
> > +		return -ENOMEM;
> > +
> > +	fdev->id = alloc_fpga_id(type, &fdev->dev);
> > +	if (fdev->id < 0)
> > +		return fdev->id;
> > +
> > +	fdev->dev.parent = &binfo->parent_dev->dev;
> > +
> > +	/*
> > +	 * we need not care the memory which is associated with the
> we do not need to care *for* the memory ;-)
> > +	 * platform device. After call platform_device_unregister(),
> After calling ...

Will fix them. Thanks.

> > +	 * it will be automatically freed by device's
> > +	 * release() callback, platform_device_release().
> > +	 */
> > +	pdata = feature_platform_data_alloc_and_init(fdev, feature_nr);
> > +	if (!pdata)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * the count should be initialized to 0 to make sure
> > +	 *__fpga_port_enable() following __fpga_port_disable()
> > +	 * works properly for port device.
> > +	 * and it should always be 0 for fme device.
> > +	 */
> > +	WARN_ON(pdata->disable_count);
> > +
> > +	fdev->dev.platform_data = pdata;
> > +	fdev->num_resources = feature_nr;
> > +	fdev->resource = kcalloc(feature_nr, sizeof(*res), GFP_KERNEL);
> > +	if (!fdev->resource)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +static int remove_feature_dev(struct device *dev, void *data)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +
> > +	platform_device_unregister(pdev);
> > +	return 0;
> > +}
> > +
> > +static int remove_parent_dev(struct device *dev, void *data)
> > +{
> > +	/* remove platform devices attached in the parent device */
> > +	device_for_each_child(dev, NULL, remove_feature_dev);
> > +	fpga_dev_destroy(to_fpga_dev(dev));
> > +	return 0;
> > +}
> > +
> > +static void remove_all_devs(struct pci_dev *pdev)
> > +{
> > +	/* remove parent device and all its children. */
> > +	device_for_each_child(&pdev->dev, NULL, remove_parent_dev);
> > +}
> > +
> > +static void build_info_free(struct build_feature_devs_info *binfo)
> > +{
> > +	if (!IS_ERR_OR_NULL(binfo->parent_dev))
> > +		remove_all_devs(binfo->pdev);
> > +
> > +	/*
> > +	 * it is a valid id, free it. See comments in
> > +	 * build_info_create_dev()
> > +	 */
> > +	if (binfo->feature_dev && binfo->feature_dev->id >= 0)
> > +		free_fpga_id(feature_dev_id_type(binfo->feature_dev),
> > +			     binfo->feature_dev->id);
> > +
> > +	platform_device_put(binfo->feature_dev);
> > +
> > +	devm_kfree(&binfo->pdev->dev, binfo);
> > +}
> > +
> > +#define FEATURE_TYPE_AFU	0x1
> > +#define FEATURE_TYPE_PRIVATE	0x3
> > +
> > +/* FME and PORT GUID are fixed */
> > +#define FEATURE_FME_GUID "f9e17764-38f0-82fe-e346-524ae92aafbf"
> > +#define FEATURE_PORT_GUID "6b355b87-b06c-9642-eb42-8d139398b43a"
> > +
> > +static bool feature_is_fme(struct feature_afu_header *afu_hdr)
> > +{
> > +	uuid_le u;
> > +
> > +	uuid_le_to_bin(FEATURE_FME_GUID, &u);
> > +
> > +	return !uuid_le_cmp(u, afu_hdr->guid);
> > +}
> > +
> > +static bool feature_is_port(struct feature_afu_header *afu_hdr)
> > +{
> > +	uuid_le u;
> > +
> > +	uuid_le_to_bin(FEATURE_PORT_GUID, &u);
> > +
> > +	return !uuid_le_cmp(u, afu_hdr->guid);
> > +}
> > +
> > +/*
> > + * UAFU GUID is dynamic as it can be changed after FME downloads different
> > + * Green Bitstream to the port, so we treat the unknown GUIDs which are
> > + * attached on port's feature list as UAFU.
> > + */
> > +static bool feature_is_UAFU(struct build_feature_devs_info *binfo)
> > +{
> > +	if (!binfo->feature_dev ||
> > +	      feature_dev_id_type(binfo->feature_dev) != PORT_ID)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static void
> > +build_info_add_sub_feature(struct build_feature_devs_info *binfo,
> > +			   int feature_id, const char *feature_name,
> > +			   resource_size_t resource_size, void __iomem *start)
> > +{
> > +
> > +	struct platform_device *fdev = binfo->feature_dev;
> > +	struct feature_platform_data *pdata = dev_get_platdata(&fdev->dev);
> > +	struct resource *res = &fdev->resource[feature_id];
> > +
> > +	res->start = pci_resource_start(binfo->pdev, binfo->current_bar) +
> > +		start - binfo->ioaddr;
> > +	res->end = res->start + resource_size - 1;
> > +	res->flags = IORESOURCE_MEM;
> > +	res->name = feature_name;
> > +
> > +	feature_platform_data_add(pdata, feature_id,
> > +				  feature_name, feature_id, start);
> > +}
> > +
> > +struct feature_info {
> > +	const char *name;
> > +	resource_size_t resource_size;
> > +	int feature_index;
> > +};
> > +
> > +/* indexed by fme feature IDs which are defined in 'enum fme_feature_id'. */
> > +static struct feature_info fme_features[] = {
> > +	{
> > +		.name = FME_FEATURE_HEADER,
> > +		.resource_size = sizeof(struct feature_fme_header),
> > +		.feature_index = FME_FEATURE_ID_HEADER,
> > +	},
> > +	{
> > +		.name = FME_FEATURE_THERMAL_MGMT,
> > +		.resource_size = sizeof(struct feature_fme_thermal),
> > +		.feature_index = FME_FEATURE_ID_THERMAL_MGMT,
> > +	},
> > +	{
> > +		.name = FME_FEATURE_POWER_MGMT,
> > +		.resource_size = sizeof(struct feature_fme_power),
> > +		.feature_index = FME_FEATURE_ID_POWER_MGMT,
> > +	},
> > +	{
> > +		.name = FME_FEATURE_GLOBAL_PERF,
> > +		.resource_size = sizeof(struct feature_fme_gperf),
> > +		.feature_index = FME_FEATURE_ID_GLOBAL_PERF,
> > +	},
> > +	{
> > +		.name = FME_FEATURE_GLOBAL_ERR,
> > +		.resource_size = sizeof(struct feature_fme_err),
> > +		.feature_index = FME_FEATURE_ID_GLOBAL_ERR,
> > +	},
> > +	{
> > +		.name = FME_FEATURE_PR_MGMT,
> > +		.resource_size = sizeof(struct feature_fme_pr),
> > +		.feature_index = FME_FEATURE_ID_PR_MGMT,
> > +	}
> > +};
> > +
> > +/* indexed by port feature IDs which are defined in 'enum port_feature_id'. */
> > +static struct feature_info port_features[] = {
> 
> Could probably be const

The resource_size will be updated during the enumeration.
Driver reads register to know the MMIO region size for accelerator.

Thanks
Hao

> > +	{
> > +		.name = PORT_FEATURE_HEADER,
> > +		.resource_size = sizeof(struct feature_port_header),
> > +		.feature_index = PORT_FEATURE_ID_HEADER,
> > +	},
> > +	{
> > +		.name = PORT_FEATURE_ERR,
> > +		.resource_size = sizeof(struct feature_port_error),
> > +		.feature_index = PORT_FEATURE_ID_ERROR,
> > +	},
> > +	{
> > +		.name = PORT_FEATURE_UMSG,
> > +		.resource_size = sizeof(struct feature_port_umsg),
> > +		.feature_index = PORT_FEATURE_ID_UMSG,
> > +	},
> > +	{
> > +		/* This feature isn't available for now */
> > +		.name = PORT_FEATURE_PR,
> > +		.resource_size = 0,
> > +		.feature_index = PORT_FEATURE_ID_PR,
> > +	},
> > +	{
> > +		.name = PORT_FEATURE_STP,
> > +		.resource_size = sizeof(struct feature_port_stp),
> > +		.feature_index = PORT_FEATURE_ID_STP,
> > +	},
> > +	{
> > +		/*
> > +		 * For User AFU feature, its region size is not fixed, but
> > +		 * reported by register PortCapability.mmio_size. Resource
> > +		 * size of UAFU will be set while parse port device.
> > +		 */
> > +		.name = PORT_FEATURE_UAFU,
> > +		.resource_size = 0,
> > +		.feature_index = PORT_FEATURE_ID_UAFU,
> > +	},
> > +};
> > +
> > +static int
> > +create_feature_instance(struct build_feature_devs_info *binfo,
> > +			void __iomem *start, struct feature_info *finfo)
> > +{
> > +	if (binfo->ioend - start < finfo->resource_size)
> > +		return -EINVAL;
> > +
> > +	build_info_add_sub_feature(binfo, finfo->feature_index, finfo->name,
> > +				   finfo->resource_size, start);
> > +	return 0;
> > +}
> > +
> > +static int parse_feature_fme(struct build_feature_devs_info *binfo,
> > +			     void __iomem *start)
> > +{
> > +	struct cci_drvdata *drvdata = dev_get_drvdata(&binfo->pdev->dev);
> > +	int ret;
> > +
> > +	ret = build_info_create_dev(binfo, FME_ID, fme_feature_num(),
> > +					FPGA_FEATURE_DEV_FME);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (drvdata->fme_dev) {
> > +		dev_err(&binfo->pdev->dev, "Multiple FMEs are detected.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return create_feature_instance(binfo, start,
> > +				       &fme_features[FME_FEATURE_ID_HEADER]);
> > +}
> > +
> > +static int parse_feature_fme_private(struct build_feature_devs_info *binfo,
> > +				     struct feature_header *hdr)
> > +{
> > +	struct feature_header header;
> > +
> > +	header.csr = readq(hdr);
> > +
> > +	if (header.id >= ARRAY_SIZE(fme_features)) {
> > +		dev_info(&binfo->pdev->dev, "FME feature id %x is not supported yet.\n",
> > +			 header.id);
> > +		return 0;
> > +	}
> > +
> > +	return create_feature_instance(binfo, hdr, &fme_features[header.id]);
> > +}
> > +
> > +static int parse_feature_port(struct build_feature_devs_info *binfo,
> > +			     void __iomem *start)
> > +{
> > +	int ret;
> > +
> > +	ret = build_info_create_dev(binfo, PORT_ID, port_feature_num(),
> > +					FPGA_FEATURE_DEV_PORT);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return create_feature_instance(binfo, start,
> > +				       &port_features[PORT_FEATURE_ID_HEADER]);
> > +}
> > +
> > +static void enable_port_uafu(struct build_feature_devs_info *binfo,
> > +			     void __iomem *start)
> > +{
> > +	enum port_feature_id id = PORT_FEATURE_ID_UAFU;
> > +	struct feature_port_header *port_hdr;
> > +	struct feature_port_capability capability;
> > +
> > +	port_hdr = (struct feature_port_header *)start;
> > +	capability.csr = readq(&port_hdr->capability);
> > +	port_features[id].resource_size = capability.mmio_size << 10;
> > +
> > +	/*
> > +	 * To enable User AFU, driver needs to clear reset bit on related port,
> > +	 * otherwise the mmio space of this user AFU will be invalid.
> > +	 */
> > +	if (port_features[id].resource_size)
> > +		fpga_port_reset(binfo->feature_dev);
> > +}
> > +
> > +static int parse_feature_port_private(struct build_feature_devs_info *binfo,
> > +				      struct feature_header *hdr)
> > +{
> > +	struct feature_header header;
> > +	enum port_feature_id id;
> > +
> > +	header.csr = readq(hdr);
> > +	/*
> > +	 * the region of port feature id is [0x10, 0x13], + 1 to reserve 0
> > +	 * which is dedicated for port-hdr.
> > +	 */
> > +	id = (header.id & 0x000f) + 1;
> > +
> > +	if (id >= ARRAY_SIZE(port_features)) {
> > +		dev_info(&binfo->pdev->dev, "Port feature id %x is not supported yet.\n",
> > +			 header.id);
> > +		return 0;
> > +	}
> > +
> > +	return create_feature_instance(binfo, hdr, &port_features[id]);
> > +}
> > +
> > +static int parse_feature_port_uafu(struct build_feature_devs_info *binfo,
> > +				 struct feature_header *hdr)
> > +{
> > +	enum port_feature_id id = PORT_FEATURE_ID_UAFU;
> > +	int ret;
> > +
> > +	if (port_features[id].resource_size) {
> > +		ret = create_feature_instance(binfo, hdr, &port_features[id]);
> > +		port_features[id].resource_size = 0;
> > +	} else {
> > +		dev_err(&binfo->pdev->dev, "the uafu feature header is mis-configured.\n");
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int parse_feature_afus(struct build_feature_devs_info *binfo,
> > +			      struct feature_header *hdr)
> > +{
> > +	int ret;
> > +	struct feature_afu_header *afu_hdr, header;
> > +	void __iomem *start;
> > +	void __iomem *end = binfo->ioend;
> > +
> > +	start = hdr;
> > +	for (; start < end; start += header.next_afu) {
> > +		if (end - start < (sizeof(*afu_hdr) + sizeof(*hdr)))
> > +			return -EINVAL;
> > +
> > +		hdr = start;
> > +		afu_hdr = (struct feature_afu_header *) (hdr + 1);
> > +		header.csr = readq(&afu_hdr->csr);
> > +
> > +		if (feature_is_fme(afu_hdr)) {
> > +			ret = parse_feature_fme(binfo, hdr);
> > +			binfo->pfme_hdr = hdr;
> > +			if (ret)
> > +				return ret;
> > +		} else if (feature_is_port(afu_hdr)) {
> > +			ret = parse_feature_port(binfo, hdr);
> > +			enable_port_uafu(binfo, hdr);
> > +			if (ret)
> > +				return ret;
> > +		} else if (feature_is_UAFU(binfo)) {
> > +			ret = parse_feature_port_uafu(binfo, hdr);
> > +			if (ret)
> > +				return ret;
> > +		} else
> > +			dev_info(&binfo->pdev->dev, "AFU GUID %pUl is not supported yet.\n",
> > +				 afu_hdr->guid.b);
> > +
> > +		if (!header.next_afu)
> > +			break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int parse_feature_private(struct build_feature_devs_info *binfo,
> > +				 struct feature_header *hdr)
> > +{
> > +	struct feature_header header;
> > +
> > +	header.csr = readq(hdr);
> > +
> > +	if (!binfo->feature_dev) {
> > +		dev_err(&binfo->pdev->dev, "the private feature %x does not belong to any AFU.\n",
> > +			header.id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (feature_dev_id_type(binfo->feature_dev)) {
> > +	case FME_ID:
> > +		return parse_feature_fme_private(binfo, hdr);
> > +	case PORT_ID:
> > +		return parse_feature_port_private(binfo, hdr);
> > +	default:
> > +		dev_info(&binfo->pdev->dev, "private feature %x belonging to AFU %s is not supported yet.\n",
> > +			 header.id, binfo->feature_dev->name);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int parse_feature(struct build_feature_devs_info *binfo,
> > +			 struct feature_header *hdr)
> > +{
> > +	struct feature_header header;
> > +	int ret = 0;
> > +
> > +	header.csr = readq(hdr);
> > +
> > +	switch (header.type) {
> > +	case FEATURE_TYPE_AFU:
> > +		ret = parse_feature_afus(binfo, hdr);
> > +		break;
> > +	case FEATURE_TYPE_PRIVATE:
> > +		ret = parse_feature_private(binfo, hdr);
> > +		break;
> > +	default:
> > +		dev_info(&binfo->pdev->dev,
> > +			 "Feature Type %x is not supported.\n", hdr->type);
> > +	};
> > +
> > +	return ret;
> > +}
> > +
> > +static int
> > +parse_feature_list(struct build_feature_devs_info *binfo, void __iomem *start)
> > +{
> > +	struct feature_header *hdr, header;
> > +	void __iomem *end = binfo->ioend;
> > +	int ret = 0;
> > +
> > +	for (; start < end; start += header.next_header_offset) {
> > +		if (end - start < sizeof(*hdr)) {
> > +			dev_err(&binfo->pdev->dev, "The region is too small to contain a feature.\n");
> > +			ret =  -EINVAL;
> > +			break;
> > +		}
> > +
> > +		hdr = (struct feature_header *)start;
> > +		ret = parse_feature(binfo, hdr);
> > +		if (ret)
> > +			break;
> > +
> > +		header.csr = readq(hdr);
> > +		if (!header.next_header_offset)
> > +			break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int parse_ports_from_fme(struct build_feature_devs_info *binfo)
> > +{
> > +	struct feature_fme_header *fme_hdr;
> > +	struct feature_fme_port port;
> > +	int i = 0, ret = 0;
> > +
> > +	if (binfo->pfme_hdr == NULL) {
> > +		dev_dbg(&binfo->pdev->dev, "VF is detected.\n");
> > +		return ret;
> > +	}
> > +
> > +	fme_hdr = binfo->pfme_hdr;
> > +
> > +	do {
> > +		port.csr = readq(&fme_hdr->port[i]);
> > +		if (!port.port_implemented)
> > +			break;
> > +
> > +		ret = parse_switch_to(binfo, port.port_bar);
> > +		if (ret)
> > +			break;
> > +
> > +		ret = parse_feature_list(binfo,
> > +				binfo->ioaddr + port.port_offset);
> > +		if (ret)
> > +			break;
> > +	} while (++i < MAX_FPGA_PORT_NUM);
> > +
> > +	return ret;
> > +}
> > +
> > +static int create_init_drvdata(struct pci_dev *pdev)
> > +{
> > +	struct cci_drvdata *drvdata;
> > +
> > +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&drvdata->lock);
> > +	INIT_LIST_HEAD(&drvdata->port_dev_list);
> > +	INIT_LIST_HEAD(&drvdata->regions);
> > +
> > +	dev_set_drvdata(&pdev->dev, drvdata);
> > +	return 0;
> > +}
> > +
> > +static void destroy_drvdata(struct pci_dev *pdev)
> > +{
> > +	struct cci_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> > +
> > +	if (drvdata->fme_dev) {
> > +		/* fme device should be unregistered first. */
> > +		WARN_ON(device_is_registered(drvdata->fme_dev));
> > +		free_fpga_id(FME_ID, to_platform_device(drvdata->fme_dev)->id);
> > +		put_device(drvdata->fme_dev);
> > +	}
> > +
> > +	cci_pci_remove_port_devs(pdev);
> > +	cci_pci_release_regions(pdev);
> > +	dev_set_drvdata(&pdev->dev, NULL);
> > +	devm_kfree(&pdev->dev, drvdata);
> > +}
> > +
> > +static int cci_pci_create_feature_devs(struct pci_dev *pdev)
> > +{
> > +	struct build_feature_devs_info *binfo;
> > +	int ret;
> > +
> > +	binfo = build_info_alloc_and_init(pdev);
> > +	if (!binfo)
> > +		return -ENOMEM;
> > +
> > +	binfo->parent_dev = fpga_dev_create(&pdev->dev, INTEL_FPGA_DEV);
> > +	if (IS_ERR(binfo->parent_dev)) {
> > +		ret = PTR_ERR(binfo->parent_dev);
> > +		goto free_binfo_exit;
> > +	}
> > +
> > +	ret = parse_start(binfo);
> > +	if (ret)
> > +		goto free_binfo_exit;
> > +
> > +	ret = parse_feature_list(binfo, binfo->ioaddr);
> > +	if (ret)
> > +		goto free_binfo_exit;
> > +
> > +	ret = parse_ports_from_fme(binfo);
> > +	if (ret)
> > +		goto free_binfo_exit;
> > +
> > +	ret = build_info_commit_dev(binfo);
> > +	if (ret)
> > +		goto free_binfo_exit;
> > +
> > +	/*
> > +	 * everything is okay, reset ->parent_dev to stop it being
> > +	 * freed by build_info_free()
> > +	 */
> > +	binfo->parent_dev = NULL;
> > +
> > +free_binfo_exit:
> > +	build_info_free(binfo);
> > +	return ret;
> > +}
> > +
> >  /* PCI Device ID */
> >  #define PCIe_DEVICE_ID_PF_INT_5_X	0xBCBD
> >  #define PCIe_DEVICE_ID_PF_INT_6_X	0xBCC0
> > @@ -83,9 +900,18 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> >  		goto release_region_exit;
> >  	}
> >  
> > -	/* TODO: create and add the platform device per feature list */
> > +	ret = create_init_drvdata(pcidev);
> > +	if (ret)
> > +		goto release_region_exit;
> > +
> > +	ret = cci_pci_create_feature_devs(pcidev);
> > +	if (ret)
> > +		goto destroy_drvdata_exit;
> > +
> >  	return 0;
> >  
> > +destroy_drvdata_exit:
> > +	destroy_drvdata(pcidev);
> >  release_region_exit:
> >  	pci_release_regions(pcidev);
> >  disable_error_report_exit:
> > @@ -97,6 +923,8 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> >  
> >  static void cci_pci_remove(struct pci_dev *pcidev)
> >  {
> > +	remove_all_devs(pcidev);
> > +	destroy_drvdata(pcidev);
> >  	pci_release_regions(pcidev);
> >  	pci_disable_pcie_error_reporting(pcidev);
> >  	pci_disable_device(pcidev);
> > @@ -111,14 +939,23 @@ static struct pci_driver cci_pci_driver = {
> >  
> >  static int __init ccidrv_init(void)
> >  {
> > +	int ret;
> > +
> >  	pr_info("Intel(R) FPGA PCIe Driver: Version %s\n", DRV_VERSION);
> >  
> > -	return pci_register_driver(&cci_pci_driver);
> > +	fpga_ids_init();
> > +
> > +	ret = pci_register_driver(&cci_pci_driver);
> > +	if (ret)
> > +		fpga_ids_destroy();
> > +
> > +	return ret;
> >  }
> >  
> >  static void __exit ccidrv_exit(void)
> >  {
> >  	pci_unregister_driver(&cci_pci_driver);
> > +	fpga_ids_destroy();
> >  }
> >  
> >  module_init(ccidrv_init);
> > -- 
> > 2.7.4
> > 
> 
> Thanks,
> 
> Moritz
