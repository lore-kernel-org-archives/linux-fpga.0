Return-Path: <SRS0=GmHG=BP=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=GmHG=BP=intel.com=yilun.xu@kernel.org>
Date: Wed, 5 Aug 2020 16:35:04 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
  feature
Message-ID: <20200805083504.GA20262@yilunxu-OptiPlex-7050>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-5-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB38196B703EA0772783466AA9854A0@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB38196B703EA0772783466AA9854A0@DM6PR11MB3819.namprd11.prod.outlook.com>
To: "Wu, Hao" <hao.wu@intel.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "trix@redhat.com" <trix@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, "Weight, Russell H" <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Thanks for your quick response, I'm OK with most changes. Some comments
inline.

On Tue, Aug 04, 2020 at 08:56:12PM +0800, Wu, Hao wrote:
> > Subject: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private feature
> 
> > +#define NIOS_INIT0x1000
> > +#define NIOS_INIT_DONEBIT(0)
> > +#define NIOS_INIT_STARTBIT(1)
> > +/* Mode for PKVL A, link 0, the same below */
> > +#define REQ_FEC_MODE_A0_MSKGENMASK(9, 8)
> > +#define REQ_FEC_MODE_A1_MSKGENMASK(11, 10)
> > +#define REQ_FEC_MODE_A2_MSKGENMASK(13, 12)
> > +#define REQ_FEC_MODE_A3_MSKGENMASK(15, 14)
> > +#define REQ_FEC_MODE_B0_MSKGENMASK(17, 16)
> > +#define REQ_FEC_MODE_B1_MSKGENMASK(19, 18)
> > +#define REQ_FEC_MODE_B2_MSKGENMASK(21, 20)
> > +#define REQ_FEC_MODE_B3_MSKGENMASK(23, 22)
> > +#define REQ_FEC_MODE_NO0x0
> > +#define REQ_FEC_MODE_KR0x1
> > +#define REQ_FEC_MODE_RS0x2
> 
> What does REQ mean?

It's the abbreviation of REQUEST, on spec these fields names
REQUEST_FEC_MODE_X_X

> > +/* ns is the abbreviation of nios_spi */
> > +static int ns_bus_poll_stat_timeout(void __iomem *base, u64 *v)
> 
> Why adding "bus" here? I just see it's polling on register bits, right?
> It's a little confusing on ns_bus.

It is the polling for regmap read/write, the regmap is also called
regbus, so I name ns_bus here.

I could change the name, do you think there is confusing also for 
ns_bus_reg_read & ns_bus_reg_write?

Thanks,
Yilun.
