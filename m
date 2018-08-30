Return-Path: <SRS0=Lc3t=LN=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=Lc3t=LN=linux.intel.com=richard.gong@kernel.org>
Subject: Re: [PATCHv8 7/9] defconfig: enable fpga and service layer
References: <1535464245-11638-1-git-send-email-richard.gong@linux.intel.com>
 <1535464245-11638-8-git-send-email-richard.gong@linux.intel.com>
 <54ccf9d5-1cf4-edf6-47c6-be7cc5badb3e@kernel.org>
From: Richard Gong <richard.gong@linux.intel.com>
Message-ID: <18b2948c-07dc-dc23-6a36-04e8295705f3@linux.intel.com>
Date: Thu, 30 Aug 2018 09:05:55 -0500
MIME-Version: 1.0
In-Reply-To: <54ccf9d5-1cf4-edf6-47c6-be7cc5badb3e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dinh Nguyen <dinguyen@kernel.org>, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>



On 08/28/2018 09:11 AM, Dinh Nguyen wrote:
> 
> 
> On 08/28/2018 08:50 AM, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Enable fpga framework, Stratix 10 SoC FPGA manager and Stratix10
>> Service Layer
>>
> 
> Please update your commit header be "arm64: defconfig: enable fpga and
> service layer"

Ok, I will make update in the next submission.

> 
> 
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> ---
>> v2: this patch is added in patch set version 2
>> v3: no change
>> v4: s/CONFIG_INTEL_SERVICE/CONFIG_STRATIX10_SERVICE/
>>      add CONFIG_OF_FPGA_REGION=y
>>      s/Intel/Stratix10/ in subject line
>> v5: no change
>> v6: no change
>> v7: no change
>> v8: no change
>> ---
>>   arch/arm64/configs/defconfig | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index f67e8d5..2ad50a5 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -185,6 +185,7 @@ CONFIG_BLK_DEV_LOOP=y
>>   CONFIG_BLK_DEV_NBD=m
>>   CONFIG_VIRTIO_BLK=y
>>   CONFIG_BLK_DEV_NVME=m
>> +CONFIG_STRATIX10_SERVICE=y
> 
> Can this be a module?

No, Service layer driver need be compiled as part of kernel image.

Service layer driver provides services for service clients, it must be 
loaded & initialized before service clients (FPGA manager and remote 
status update drivers).

> 
>>   CONFIG_SRAM=y
>>   CONFIG_EEPROM_AT25=m
>>   # CONFIG_SCSI_PROC_FS is not set
>> @@ -642,6 +643,12 @@ CONFIG_PHY_TEGRA_XUSB=y
>>   CONFIG_HISI_PMU=y
>>   CONFIG_QCOM_L2_PMU=y
>>   CONFIG_QCOM_L3_PMU=y
>> +CONFIG_MESON_EFUSE=m
> 
> What does this change have to do with this patch?

My mistake, I will fix in the next submission.

> 
>> +CONFIG_FPGA=y
>> +CONFIG_FPGA_MGR_STRATIX10_SOC=y
>> +CONFIG_FPGA_REGION=y
>> +CONFIG_FPGA_BRIDGE=y
>> +CONFIG_OF_FPGA_REGION=y
> 
> Can these be modules?

CONFIG_FPGA_MGR_STRATIX10_SOC could be module, but the remaining 
components need be compiled as part of kernel image.

> 
> Dinh
> 
