Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <3092191.aOBZP6MEga@pcbe13614>
References: <20180725181514.3501-1-atull@kernel.org> <3092191.aOBZP6MEga@pcbe13614>
From: Alan Tull <atull@kernel.org>
Date: Tue, 14 Aug 2018 18:57:26 -0500
Message-ID: <CANk1AXTfCsJi1bnGw41V1seGc0c5vW1ZCLdor6x_eso6Uy71Vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpga: Document when fpga_blah_free functions should
 be used
Content-Type: text/plain; charset="UTF-8"
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Moritz Fischer <mdf@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jul 26, 2018 at 2:26 AM, Federico Vaga <federico.vaga@cern.ch> wrote:
> Hi Alan,
>
> have you considered the possibility of having something like devm_fpga_[mgr|
> bridge|region]_[create|free]() ? Like this, it will be obvious that 'struct
> fpga_mgr' will be released automatically without reading any comment (but the
> comment is still good), and you use devm_*_free() only to handle error
> conditions.

Hi Federico,

Sorry for the late reply.  I was waiting until I had this all
implemented.  As you've seen, I've posted the devm_fpga_mgr_create
implementation [1].  I found I didn't need devm_*_free() for the error
conditions, the managed device code handled cleanup nicely without it.

Just to be clear, I'm dropping this patch in favor of devm support instead.

Thanks again for your suggestions.

Alan

[1] https://lkml.org/lkml/2018/8/14/954

>
> On Wednesday, July 25, 2018 8:15:13 PM CEST Alan Tull wrote:
>> Clarify when fpga_(mgr|bridge|region)_free functions should be used.
>> The class's dev_release will handle cleanup when the device is released
>> so once the mgr/brige/region has been successfully registered, it
>> would be a bug to call fpga_(mgr|bridge|region)_free.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
>> Suggested-by: Federico Vaga <federico.vaga@cern.ch>
>> ---
>>  drivers/fpga/fpga-bridge.c | 10 +++++++++-
>>  drivers/fpga/fpga-mgr.c    | 10 +++++++++-
>>  drivers/fpga/fpga-region.c | 10 +++++++++-
>>  3 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index 24b8f98..528d2149 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -379,7 +379,11 @@ EXPORT_SYMBOL_GPL(fpga_bridge_create);
>>
>>  /**
>>   * fpga_bridge_free - free a fpga bridge and its id
>> - * @bridge:  FPGA bridge struct created by fpga_bridge_create
>> + * @bridge:  FPGA bridge struct created by fpga_bridge_create()
>> + *
>> + * Free a FPGA bridge.  This function should only be called for
>> + * freeing a bridge that has not been registered yet (such as in error
>> + * paths in a probe function).
>>   */
>>  void fpga_bridge_free(struct fpga_bridge *bridge)
>>  {
>> @@ -414,6 +418,10 @@ EXPORT_SYMBOL_GPL(fpga_bridge_register);
>>  /**
>>   * fpga_bridge_unregister - unregister and free a fpga bridge
>>   * @bridge:  FPGA bridge struct created by fpga_bridge_create
>> + *
>> + * Unregister the bridge device.  The class's dev_release will handle
>> + * freeing the bridge struct when the device is released so don't
>> + * call fpga_bridge_free() after calling fpga_bridge_unregister().
>>   */
>>  void fpga_bridge_unregister(struct fpga_bridge *bridge)
>>  {
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index a41b07e..9632cbd 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -619,7 +619,11 @@ EXPORT_SYMBOL_GPL(fpga_mgr_create);
>>
>>  /**
>>   * fpga_mgr_free - deallocate a FPGA manager
>> - * @mgr:     fpga manager struct created by fpga_mgr_create
>> + * @mgr:     fpga manager struct created by fpga_mgr_create()
>> + *
>> + * Free a FPGA manager struct.  This function should only be called
>> + * for freeing a manager that has not been registered yet (such as in
>> + * error paths in a probe function).
>>   */
>>  void fpga_mgr_free(struct fpga_manager *mgr)
>>  {
>> @@ -663,6 +667,10 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register);
>>  /**
>>   * fpga_mgr_unregister - unregister and free a FPGA manager
>>   * @mgr:     fpga manager struct
>> + *
>> + * Unregister the manager device.  The class's dev_release will handle
>> + * freeing the manager struct when the device is released so don't
>> + * call fpga_mgr_free() after calling fpga_mgr_unregister().
>>   */
>>  void fpga_mgr_unregister(struct fpga_manager *mgr)
>>  {
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index 0d65220..7335fa9 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -231,7 +231,11 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
>>
>>  /**
>>   * fpga_region_free - free a struct fpga_region
>> - * @region: FPGA region created by fpga_region_create
>> + * @region:  FPGA region created by fpga_region_create()
>> + *
>> + * Free a FPGA region struct.  This function should only be called for
>> + * freeing a region that has not been registered yet (such as in error
>> + * paths in a probe function).
>>   */
>>  void fpga_region_free(struct fpga_region *region)
>>  {
>> @@ -255,6 +259,10 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
>>  /**
>>   * fpga_region_unregister - unregister and free a FPGA region
>>   * @region: FPGA region
>> + *
>> + * Unregister the region device.  The class's dev_release will handle
>> + * freeing the region so don't call fpga_region_free() after calling
>> + * fpga_region_unregister().
>>   */
>>  void fpga_region_unregister(struct fpga_region *region)
>>  {
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
