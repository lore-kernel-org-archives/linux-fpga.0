Return-Path: <SRS0=ctjt=SL=xilinx.com=michals@kernel.org>
Return-Path: <SRS0=ctjt=SL=xilinx.com=michals@kernel.org>
Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-2-nava.manne@xilinx.com> <20190408171456.GA4293@archbook>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <9ab8f7fb-0936-3635-60fe-164402780429@xilinx.com>
Date: Tue, 9 Apr 2019 08:33:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190408171456.GA4293@archbook>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Moritz Fischer <mdf@kernel.org>, Nava kishore Manne <nava.manne@xilinx.com>
Cc: atull@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

On 08. 04. 19 19:14, Moritz Fischer wrote:
> Hi Nava,
> 
> On Tue, Apr 02, 2019 at 06:01:21PM +0530, Nava kishore Manne wrote:
>> This Patch Adds fpga API's to support the Bitstream loading
>> by using firmware interface.
>>
>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>> ---
>> Changes for v4:
>> 		-None.
>>
>> Chnages for v3:
>> 		-Created patches on top of 5.0-rc5.
>> 		 No functional changes.
>>
>> Changes for v2:
>> 		-Added Firmware FPGA Manager flags As suggested by
>> 		 Moritz.
>>
>> Changes for v1:
>> 		-None.
>>
>> Changes for RFC-V2:
>> 		-New Patch
>>
>>  drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
>>  include/linux/firmware/xlnx-zynqmp.h | 10 ++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
>> index 98f936125643..7159a90abc44 100644
>> --- a/drivers/firmware/xilinx/zynqmp.c
>> +++ b/drivers/firmware/xilinx/zynqmp.c
>> @@ -537,6 +537,50 @@ static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
>>  	return ret;
>>  }
>>  
>> +/*
>> + * zynqmp_pm_fpga_load - Perform the fpga load
>> + * @address:	Address to write to
>> + * @size:	pl bitstream size
>> + * @flags:
>> + *	BIT(0) - Bit-stream type.
>> + *		 0 - Full Bitstream.
>> + *		 1 - Partial Bitstream.
>> + *
>> + * This function provides access to pmufw. To transfer
>> + * the required bitstream into PL.
>> + *
>> + * Return: Returns status, either success or error+reason
>> + */
>> +static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
>> +			       const u32 flags)
>> +{
>> +	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
>> +				   upper_32_bits(address), size, flags, NULL);
>> +}
>> +
>> +/**
>> + * zynqmp_pm_fpga_get_status - Read value from PCAP status register
>> + * @value: Value to read
>> + *
>> + * This function provides access to the xilfpga library to get
> 
> xilfpga? Is that PMU firmware you're talking about?
> 
>> + * the PCAP status
>> + *
>> + * Return: Returns status, either success or error+reason
>> + */
>> +static int zynqmp_pm_fpga_get_status(u32 *value)
>> +{
>> +	u32 ret_payload[PAYLOAD_ARG_CNT];
>> +	int ret;
>> +
>> +	if (!value)
>> +		return -EINVAL;
>> +
>> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
>> +	*value = ret_payload[1];
>> +
>> +	return ret;
>> +}
>> +
>>  /**
>>   * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
>>   *			       master has initialized its own power management
>> @@ -640,6 +684,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
>>  	.request_node = zynqmp_pm_request_node,
>>  	.release_node = zynqmp_pm_release_node,
>>  	.set_requirement = zynqmp_pm_set_requirement,
>> +	.fpga_load = zynqmp_pm_fpga_load,
>> +	.fpga_get_status = zynqmp_pm_fpga_get_status,
>>  };
>>  
>>  /**
>> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
>> index 642dab10f65d..4df226b6ab0f 100644
>> --- a/include/linux/firmware/xlnx-zynqmp.h
>> +++ b/include/linux/firmware/xlnx-zynqmp.h
>> @@ -48,6 +48,12 @@
>>  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
>>  #define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
>>  
>> +/*
>> + * Firmware FPGA Manager flags
>> + * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
>> + */
>> +#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
>> +
>>  enum pm_api_id {
>>  	PM_GET_API_VERSION = 1,
>>  	PM_REQUEST_NODE = 13,
>> @@ -56,6 +62,8 @@ enum pm_api_id {
>>  	PM_RESET_ASSERT = 17,
>>  	PM_RESET_GET_STATUS,
>>  	PM_PM_INIT_FINALIZE = 21,
>> +	PM_FPGA_LOAD = 22,
>> +	PM_FPGA_GET_STATUS,
> 
> Any reason you can't do 'PM_FPGA_GET_STATUS = 23' here? Trying to
> understand your reasoning. Are you planning to move them around?

It is 23 by design. In xilinx repo there was only the first value which
is recommended practice. But upstreaming is not done in the same order
that's why if there is a gap you need to assign values there.
Even that 22 can be removed in this case but it is just nit.

Thanks,
Michal
