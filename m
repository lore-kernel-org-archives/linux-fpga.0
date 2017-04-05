Return-Path: <SRS0=6hqy=3N=linux.intel.com=matthew.gerlach@kernel.org>
Return-Path: <SRS0=6hqy=3N=linux.intel.com=matthew.gerlach@kernel.org>
Date: Wed, 5 Apr 2017 15:25:24 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
Subject: Re: [PATCH] fpga fr br: fix warning for unexpected version number
In-Reply-To: <CAAtXAHdZwyV2Wx3ZvK37i85zY8cc-rWcA=e74KCmFvgByg+k1Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704051521090.2392@mgerlach-VirtualBox>
References: <1491419155-17440-1-git-send-email-matthew.gerlach@linux.intel.com> <CAAtXAHdZwyV2Wx3ZvK37i85zY8cc-rWcA=e74KCmFvgByg+k1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>



On Wed, 5 Apr 2017, Moritz Fischer wrote:

> Hi Matthew,
>

Hi Moritz,


> On Wed, Apr 5, 2017 at 12:05 PM,  <matthew.gerlach@linux.intel.com> wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> The value in the version register of the altera freeze bridge
>> controller changed from the beta value of 2 to the
>> value of 0xad000003 in the official release of the IP.
>> This patch supports the old and new version numbers
>> without printing an warning.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  drivers/fpga/altera-freeze-bridge.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
>> index 8dcd9fb..bdfd5eb 100644
>> --- a/drivers/fpga/altera-freeze-bridge.c
>> +++ b/drivers/fpga/altera-freeze-bridge.c
>> @@ -28,6 +28,7 @@
>>  #define FREEZE_CSR_REG_VERSION                 12
>>
>>  #define FREEZE_CSR_SUPPORTED_VERSION           2
>> +#define FREEZE_CSR_OFFICIAL_VERSION            0xad000003
>>
>>  #define FREEZE_CSR_STATUS_FREEZE_REQ_DONE      BIT(0)
>>  #define FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE    BIT(1)
>> @@ -241,10 +242,12 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
>>                 priv->enable = 1;
>>
>>         revision = readl(priv->base_addr + FREEZE_CSR_REG_VERSION);
>> -       if (revision != FREEZE_CSR_SUPPORTED_VERSION)
>> +       if ((revision != FREEZE_CSR_SUPPORTED_VERSION) &&
>> +           (revision != FREEZE_CSR_OFFICIAL_VERSION))
>>                 dev_warn(dev,
>> -                        "%s Freeze Controller unexpected revision %d != %d\n",
>> -                        __func__, revision, FREEZE_CSR_SUPPORTED_VERSION);
>> +                        "%s unexpected revision 0x%x != 0x%x != 0x%x\n",
>> +                        __func__, revision, FREEZE_CSR_SUPPORTED_VERSION,
>> +                        FREEZE_CSR_OFFICIAL_VERSION);
>
> Maybe you actually wanna bail out if you read a random other value
> instead of what you
> expect instead of printing a warning.

I thought about making it an error if the version didn't match, but it was 
a dev_warn() before and that allowed folks to use the "old" driver with 
the new IP version.

>>
>>         return fpga_bridge_register(dev, FREEZE_BRIDGE_NAME,
>>                                     &altera_freeze_br_br_ops, priv);
>> --
>> 2.7.4
>>
>
> Cheers,
>
> Moritz
>
