Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <d8f9c064-3db1-6753-7b6d-dd6401274f03@xilinx.com>
References: <1487118690-21166-1-git-send-email-mdf@kernel.org> <d8f9c064-3db1-6753-7b6d-dd6401274f03@xilinx.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 15 Feb 2017 10:30:52 -0600
Message-ID: <CANk1AXQL0+tfBnGPuMJ+o_YDjMMngFLeXJPRzNO_LRwr1sMZXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpga: Add flag to indicate bitstream needs decrypting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Michal Simek <michal.simek@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Feb 15, 2017 at 9:03 AM, Michal Simek <michal.simek@xilinx.com> wro=
te:
> On 15.2.2017 01:31, mdf@kernel.org wrote:
>> From: Moritz Fischer <moritz.fischer@ettus.com>
>>
>> Add a flag that is passed to the write_init() callback, indicating
>> that the bitstream is encrypted.
>>
>> The low-level driver will deal with the flag, or return an error,
>> if encrypted bitstreams are not supported.
>>
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> Cc: Alan Tull <atull@kernel.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-fpga@vger.kernel.org
>> ---
>>  include/linux/fpga/fpga-mgr.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr=
.h
>> index 57beb5d..1355d8a 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -70,6 +70,7 @@ enum fpga_mgr_states {
>>   */
>>  #define FPGA_MGR_PARTIAL_RECONFIG    BIT(0)
>>  #define FPGA_MGR_EXTERNAL_CONFIG     BIT(1)
>> +#define FPGA_MGR_DECRYPT_BITSTREAM   BIT(2)
>>
>>  /**
>>   * struct fpga_image_info - information specific to a FPGA image
>>
>
> Isn't it better to state that bitstream is encrypted
> instead of saying that bitstream requires decryption?

Such as FPGA_MGR_ENCRYPTED_BITSTREAM  ?

Also please consider adding a DT property such that the FPGA region
code will set this flag similar to how the DTO sets up other FPGA
image info.

Alan

>
> Your second patch is saying add support for encrypted bitstreams.
>
> M
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
