Return-Path: <SRS0=l0rK=AU=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=l0rK=AU=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:2172 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIUzJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 Jul 2020 16:55:09 -0400
Subject: Re: [PATCH] fpga: stratix10-soc: make FPGA task un-interruptible
References: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
 <926c1117-1f31-5b3d-55af-4216db4f1745@redhat.com>
From: Richard Gong <richard.gong@linux.intel.com>
Message-ID: <283c922f-12a7-ccfc-2165-219fb5fe6999@linux.intel.com>
Date: Thu, 9 Jul 2020 16:10:12 -0500
MIME-Version: 1.0
In-Reply-To: <926c1117-1f31-5b3d-55af-4216db4f1745@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Tom Rix <trix@redhat.com>, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, dinguyen@kernel.org, richard.gong@intel.com

Hi Tom,

On 7/9/20 3:01 PM, Tom Rix wrote:
> Mostly fine, see inline question.
> 
> On 7/7/20 9:14 AM, richard.gong@linux.intel.com wrote:
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
> 
> This part is done in an infinite loop, is the loop still needed 
The loop is still need. FPGA manager driver need polling the completed 
status from the lower level firmware. The lower level firmware can 
return FPGA manager driver with busy, completed or error status.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
Thanks for your review!

Regards,
Richard
> 
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
>> -		}
>>   		/* Not error or timeout, so ret is # of jiffies until timeout */
>>   		timeout = ret;
>>   		ret = 0;
> 
