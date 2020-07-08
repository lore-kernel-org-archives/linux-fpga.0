Return-Path: <SRS0=DSnZ=AT=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=DSnZ=AT=linux.intel.com=richard.gong@kernel.org>
Subject: Re: [PATCH] fpga: stratix10-soc: make FPGA task un-interruptible
References: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
 <3e45e4a4-f002-ecf8-110f-bf7d646a5dbe@kernel.org>
From: Richard Gong <richard.gong@linux.intel.com>
Message-ID: <5be15818-9170-b2a5-e92b-bbe6b1fcba21@linux.intel.com>
Date: Wed, 8 Jul 2020 13:30:12 -0500
MIME-Version: 1.0
In-Reply-To: <3e45e4a4-f002-ecf8-110f-bf7d646a5dbe@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dinh Nguyen <dinguyen@kernel.org>, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

Hi Dinh,


On 7/8/20 12:08 PM, Dinh Nguyen wrote:
> Hi
> 
> On 7/7/20 11:14 AM, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
>> reconfiguration process stops and the user can't perform a new FPGA
>> reconfiguration properly.
>>
>> Set FPGA complete task to be not interruptible so that the user can
>> properly perform FPGA reconfiguration after CTRL+C event.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   drivers/fpga/stratix10-soc.c | 23 +++--------------------
>>   1 file changed, 3 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>> index 44b7c56..657a70c 100644
>> --- a/drivers/fpga/stratix10-soc.c
>> +++ b/drivers/fpga/stratix10-soc.c
>> @@ -196,17 +196,13 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>>   	if (ret < 0)
>>   		goto init_done;
>>   
>> -	ret = wait_for_completion_interruptible_timeout(
>> +	ret = wait_for_completion_timeout(
>>   		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>>   	if (!ret) {
>>   		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>>   		ret = -ETIMEDOUT;
>>   		goto init_done;
>>   	}
>> -	if (ret < 0) {
>> -		dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
>> -		goto init_done;
>> -	}
>>   
>>   	ret = 0;
>>   	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
>> @@ -318,7 +314,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>>   		 */
>>   		wait_status = 1; /* not timed out */
>>   		if (!priv->status)
>> -			wait_status = wait_for_completion_interruptible_timeout(
>> +			wait_status = wait_for_completion_timeout(
>>   				&priv->status_return_completion,
>>   				S10_BUFFER_TIMEOUT);
>>   
>> @@ -340,13 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>>   			ret = -ETIMEDOUT;
>>   			break;
>>   		}
>> -		if (wait_status < 0) {
>> -			ret = wait_status;
>> -			dev_err(dev,
>> -				"error (%d) waiting for svc layer buffers\n",
>> -				ret);
>> -			break;
>> -		}
>>   	}
>>   
>>   	if (!s10_free_buffers(mgr))
>> @@ -372,7 +361,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>>   		if (ret < 0)
>>   			break;
>>   
>> -		ret = wait_for_completion_interruptible_timeout(
>> +		ret = wait_for_completion_timeout(
>>   			&priv->status_return_completion, timeout);
>>   		if (!ret) {
>>   			dev_err(dev,
>> @@ -380,12 +369,6 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>>   			ret = -ETIMEDOUT;
>>   			break;
>>   		}
>> -		if (ret < 0) {
>> -			dev_err(dev,
>> -				"error (%d) waiting for RECONFIG_COMPLETED\n",
>> -				ret);
>> -			break;
>> -
>>   		/* Not error or timeout, so ret is # of jiffies until timeout */
>>   		timeout = ret;
>>   		ret = 0;
>>
> 
> Do you need the same change in drivers/fpga/socfpga.c? 
It is not required.
Also, you did not
> include Moritz Fisher on this. He's the maintainer.
> 
I did include Moritz Fisher <mdf@kernel.org> in the submission, is 
something change recently?


Regards,
Richard
> Dinh
> 
