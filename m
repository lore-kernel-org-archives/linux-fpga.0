Return-Path: <SRS0=wUhn=NS=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=wUhn=NS=linux.intel.com=richard.gong@kernel.org>
Subject: Re: [PATCHv10 3/8] firmware: add Intel Stratix10 service layer driver
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
 <1541523172-5171-4-git-send-email-richard.gong@linux.intel.com>
 <595b853f-6a8c-d608-e716-95ef1c84d0b9@infradead.org>
From: Richard Gong <richard.gong@linux.intel.com>
Message-ID: <f266e76a-6222-252e-dc79-c13044602a98@linux.intel.com>
Date: Wed, 7 Nov 2018 14:47:13 -0600
MIME-Version: 1.0
In-Reply-To: <595b853f-6a8c-d608-e716-95ef1c84d0b9@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, todd.riffel@intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

Hi Randy,

On 11/6/18 11:03 AM, Randy Dunlap wrote:
> On 11/6/18 8:52 AM, richard.gong@linux.intel.com wrote:
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index 7273e50..b6813bc 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -216,6 +216,18 @@ config FW_CFG_SYSFS_CMDLINE
>>   	  WARNING: Using incorrect parameters (base address in particular)
>>   	  may crash your system.
>>   
>> +config INTEL_STRATIX10_SERVICE
>> +       tristate "Intel Stratix10 Service Layer"
>> +       depends on HAVE_ARM_SMCCC
>> +       default n
>> +       help
>> +        Intel Stratix10 service layer runs at privileged exception level,
>> +	interfaces with the service providers (FPGA manager is one of them) and
>> +	manages secure monitor call to communicate with secure monitor software
>> +	at secure monitor exception level.
>> +
>> +        Say Y here if you want Stratix10 service layer support.
> 
> from Documentation/process/coding-style.rst:
> 
> Lines under a ``config`` definition are indented with one tab,
> while help text is indented an additional two spaces.
> 
>

I will correct that in the next submission.

> thanks.
> 

Regards,
Richard
