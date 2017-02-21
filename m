Return-Path: <SRS0=xDgO=2C=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=xDgO=2C=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <b6b24137-3168-26da-04c9-1e73caee0041@xilinx.com>
References: <1487624123-13579-1-git-send-email-mdf@kernel.org>
 <1487624123-13579-3-git-send-email-mdf@kernel.org> <b6b24137-3168-26da-04c9-1e73caee0041@xilinx.com>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Tue, 21 Feb 2017 10:36:33 -0600
Message-ID: <CANk1AXRa5_xwG3-sFN3H6n_OgjRnW3+pC-+qoNQaNoxOkxZawA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fpga: region: Add fpga-region property 'encrypted-fpga-config'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Michal Simek <michal.simek@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Feb 21, 2017 at 7:55 AM, Michal Simek <michal.simek@xilinx.com> wro=
te:
> On 20.2.2017 21:55, mdf@kernel.org wrote:
>> From: Moritz Fischer <mdf@kernel.org>
>>
>> Add fpga-region property to allow passing the fact that the bitstream is
>> encrypted to the fpga-region and ultimately to the low-level driver.
>>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> Cc: Alan Tull <atull@kernel.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-fpga@vger.kernel.org
>> ---
>>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>>  drivers/fpga/fpga-region.c                             | 8 ++++++--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Do=
cumentation/devicetree/bindings/fpga/fpga-region.txt
>> index 3b32ba1..81bf3ad 100644
>> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> @@ -186,6 +186,7 @@ Optional properties:
>>       otherwise full reconfiguration is done.
>>  - external-fpga-config : boolean, set if the FPGA has already been conf=
igured
>>       prior to OS boot up.
>> +- encrypted-fpga-config : boolean, set if the bitstream is encrypted
>>  - region-unfreeze-timeout-us : The maximum time in microseconds to wait=
 for
>>       bridges to successfully become enabled after the region has been
>>       programmed.
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index 3222fdb..2fe2a52 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -337,8 +337,9 @@ static int child_regions_with_firmware(struct device=
_node *overlay)
>>   * The overlay must add either firmware-name or external-fpga-config pr=
operty
>>   * to the FPGA Region.
>>   *
>> - *   firmware-name        : program the FPGA
>> - *   external-fpga-config : FPGA is already programmed
>> + *   firmware-name         : program the FPGA
>> + *   external-fpga-config  : FPGA is already programmed
>> + *   encrypted-fpga-config : FPGA bitstream is encrypted
>>   *
>>   * The overlay can add other FPGA regions, but child FPGA regions canno=
t have a
>>   * firmware-name property since those regions don't exist yet.
>> @@ -373,6 +374,9 @@ static int fpga_region_notify_pre_apply(struct fpga_=
region *region,
>>       if (of_property_read_bool(nd->overlay, "external-fpga-config"))
>>               info->flags |=3D FPGA_MGR_EXTERNAL_CONFIG;
>>
>> +     if (of_property_read_bool(nd->overlay, "encrypted-fpga-config"))
>> +             info->flags |=3D FPGA_MGR_ENCRYPTED_BITSTREAM;
>> +
>>       of_property_read_string(nd->overlay, "firmware-name", &firmware_na=
me);
>>
>>       of_property_read_u32(nd->overlay, "region-unfreeze-timeout-us",
>>
>
> Acked-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Alan Tull <atull@kernel.org>

>
> Thanks,
> Michal
>
