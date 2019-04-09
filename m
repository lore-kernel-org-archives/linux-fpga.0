Return-Path: <moritz.fischer.private@gmail.com>
Date: Tue, 9 Apr 2019 08:54:59 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
Message-ID: <20190409155459.GA7617@archbook>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-2-nava.manne@xilinx.com>
 <20190408171456.GA4293@archbook>
 <9ab8f7fb-0936-3635-60fe-164402780429@xilinx.com>
 <BYAPR02MB471005801CE9F16523516611C22D0@BYAPR02MB4710.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR02MB471005801CE9F16523516611C22D0@BYAPR02MB4710.namprd02.prod.outlook.com>
To: Nava kishore Manne <navam@xilinx.com>
Cc: Michal Simek <michals@xilinx.com>, Moritz Fischer <mdf@kernel.org>, "atull@kernel.org" <atull@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Nava,

On Tue, Apr 09, 2019 at 08:54:34AM +0000, Nava kishore Manne wrote:
> Hi Moritz,
> 
> Thanks for the quick response.
> Please find my response inline
> 
> > -----Original Message-----
> > From: Michal Simek [mailto:michal.simek@xilinx.com]
> > Sent: Tuesday, April 9, 2019 12:04 PM
> > To: Moritz Fischer <mdf@kernel.org>; Nava kishore Manne
> > <navam@xilinx.com>
> > Cc: atull@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; Michal
> > Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; linux-fpga@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > chinnikishore369@gmail.com
> > Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
> > 
> > On 08. 04. 19 19:14, Moritz Fischer wrote:
> > > Hi Nava,
> > >
> > > On Tue, Apr 02, 2019 at 06:01:21PM +0530, Nava kishore Manne wrote:
> > >> This Patch Adds fpga API's to support the Bitstream loading by using
> > >> firmware interface.
> > >>
> > >> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > >> ---
> > >> Changes for v4:
> > >> 		-None.
> > >>
> > >> Chnages for v3:
> > >> 		-Created patches on top of 5.0-rc5.
> > >> 		 No functional changes.
> > >>
> > >> Changes for v2:
> > >> 		-Added Firmware FPGA Manager flags As suggested by
> > >> 		 Moritz.
> > >>
> > >> Changes for v1:
> > >> 		-None.
> > >>
> > >> Changes for RFC-V2:
> > >> 		-New Patch
> > >>
> > >>  drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
> > >>  include/linux/firmware/xlnx-zynqmp.h | 10 ++++++
> > >>  2 files changed, 56 insertions(+)
> > >>
> > >> diff --git a/drivers/firmware/xilinx/zynqmp.c
> > >> b/drivers/firmware/xilinx/zynqmp.c
> > >> index 98f936125643..7159a90abc44 100644
> > >> --- a/drivers/firmware/xilinx/zynqmp.c
> > >> +++ b/drivers/firmware/xilinx/zynqmp.c
> > >> @@ -537,6 +537,50 @@ static int zynqmp_pm_reset_get_status(const enum
> > zynqmp_pm_reset reset,
> > >>  	return ret;
> > >>  }
> > >>
> > >> +/*
> > >> + * zynqmp_pm_fpga_load - Perform the fpga load
> > >> + * @address:	Address to write to
> > >> + * @size:	pl bitstream size
> > >> + * @flags:
> > >> + *	BIT(0) - Bit-stream type.
> > >> + *		 0 - Full Bitstream.
> > >> + *		 1 - Partial Bitstream.

Don't you wanna call out the defines instead here that you defined in
include/linux/firmware/xlnx-zynqmp.h?

> > >> + *
> > >> + * This function provides access to pmufw. To transfer
> > >> + * the required bitstream into PL.
> > >> + *
> > >> + * Return: Returns status, either success or error+reason  */ static
> > >> +int zynqmp_pm_fpga_load(const u64 address, const u32 size,
> > >> +			       const u32 flags)
> > >> +{
> > >> +	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
> > >> +				   upper_32_bits(address), size, flags, NULL); }
> > >> +
> > >> +/**
> > >> + * zynqmp_pm_fpga_get_status - Read value from PCAP status register
> > >> + * @value: Value to read
> > >> + *
> > >> + * This function provides access to the xilfpga library to get
> > >
> > > xilfpga? Is that PMU firmware you're talking about?
> 
> Xilfpga is a library and it’s a part of PMUFW BSP.
> It will follow the below flow to configure the PL from Linux environment.
> Linux -Fpga Manager framework <--> Linux-Firmware Driver <- -smc call-->ATF <--IPI call--> PMUFW<--> Xilfpga library.

Fair enough. Was wondering if we could simplify/clarify the comment, but
also don't have a good suggestion :)
> 
> > >
> > >> + * the PCAP status
> > >> + *
> > >> + * Return: Returns status, either success or error+reason  */ static
> > >> +int zynqmp_pm_fpga_get_status(u32 *value) {
> > >> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> > >> +	int ret;
> > >> +
> > >> +	if (!value)
> > >> +		return -EINVAL;
> > >> +
> > >> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0,
> > ret_payload);
> > >> +	*value = ret_payload[1];
> > >> +
> > >> +	return ret;
> > >> +}
> > >> +
> > >>  /**
> > >>   * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
> > >>   *			       master has initialized its own power management
> > >> @@ -640,6 +684,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
> > >>  	.request_node = zynqmp_pm_request_node,
> > >>  	.release_node = zynqmp_pm_release_node,
> > >>  	.set_requirement = zynqmp_pm_set_requirement,
> > >> +	.fpga_load = zynqmp_pm_fpga_load,
> > >> +	.fpga_get_status = zynqmp_pm_fpga_get_status,
> > >>  };
> > >>
> > >>  /**
> > >> diff --git a/include/linux/firmware/xlnx-zynqmp.h
> > >> b/include/linux/firmware/xlnx-zynqmp.h
> > >> index 642dab10f65d..4df226b6ab0f 100644
> > >> --- a/include/linux/firmware/xlnx-zynqmp.h
> > >> +++ b/include/linux/firmware/xlnx-zynqmp.h
> > >> @@ -48,6 +48,12 @@
> > >>  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
> > >>  #define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
> > >>
> > >> +/*
> > >> + * Firmware FPGA Manager flags
> > >> + * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration  */
> > >> +#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
> > >> +
> > >>  enum pm_api_id {
> > >>  	PM_GET_API_VERSION = 1,
> > >>  	PM_REQUEST_NODE = 13,
> > >> @@ -56,6 +62,8 @@ enum pm_api_id {
> > >>  	PM_RESET_ASSERT = 17,
> > >>  	PM_RESET_GET_STATUS,
> > >>  	PM_PM_INIT_FINALIZE = 21,
> > >> +	PM_FPGA_LOAD = 22,
> > >> +	PM_FPGA_GET_STATUS,
> > >
> > > Any reason you can't do 'PM_FPGA_GET_STATUS = 23' here? Trying to
> > > understand your reasoning. Are you planning to move them around?
> > 
> > It is 23 by design. In xilinx repo there was only the first value which is
> > recommended practice. But upstreaming is not done in the same order that's
> > why if there is a gap you need to assign values there.
> > Even that 22 can be removed in this case but it is just nit.
> > 
>  As Michal said here Assigning value of 22 is not needed. Will fix this issue in the next version.

Ok, I didn't check the Xilinx repos :) Makes sense, though.

With nits above addressed:
Reviewed-by: Moritz Fischer <mdf@kernel.org>

Thanks,
Moritz
