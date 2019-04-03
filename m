Return-Path: <SRS0=3rsr=SF=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=3rsr=SF=linux.intel.com=richard.gong@kernel.org>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
 <20190403142022.GB5752@archbook>
From: Richard Gong <richard.gong@linux.intel.com>
Message-ID: <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
Date: Wed, 3 Apr 2019 11:43:26 -0500
MIME-Version: 1.0
In-Reply-To: <20190403142022.GB5752@archbook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Moritz Fischer <mdf@kernel.org>
Cc: atull@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Moritz,


On 4/3/19 9:20 AM, Moritz Fischer wrote:
> Hi Richard,
> 
> On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add a log for user to know FPGA configuration is successful
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   drivers/fpga/fpga-mgr.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index c386681..559e046 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
>>   	}
>>   	mgr->state = FPGA_MGR_STATE_OPERATING;
>>   
>> +	dev_info(&mgr->dev, "Successfully programming FPGA\n");
> 
> That info is available in FPGA manager's sysfs status entry, if at all
> I'd make this a dev_dbg().
> 
>  From my end I don't see how we need this really.

We got requests from the field and they want to see a log to get know if 
FPGA configuration is successfully completed. They don't want use any 
additional command to get status.

This log is useful for the user who performs FPGA configuration.

I think we need use dev_info, since dev_dbg is not enabled by fault for 
most build.

> 
> Thanks,
> Moritz
> 
