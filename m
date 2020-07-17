Return-Path: <SRS0=PeW4=A4=redhat.com=trix@kernel.org>
Return-Path: <SRS0=PeW4=A4=redhat.com=trix@kernel.org>
Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
 <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <237c776b-8746-421d-26ad-eea7242a9172@redhat.com>
Date: Fri, 17 Jul 2020 06:32:26 -0700
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>


On 7/16/20 8:48 PM, Wu, Hao wrote:
>> Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
>>
>> Generally i think this is a good approach.
>>
>> However I do have concern.
>>
>> The feature_id in dfl is magic number, similar to pci id but without a vendor
>> id.
>>
>> Is it possible to add something like a vendor id so different vendors would
>> not have to be so careful to use a unique id ?
> Hi Tom,
>
> Thanks for the comments.
>
> Here is only one field defined in spec, that is feature id to distinguish one
> feature with another one. There is no vendor id here I think, and several
> cards are using this for now and seems not possible to change DFH format
> for these products. : (

There looks like some unused bits in the first word, how about

#define DFH_EOL            BIT_ULL(40)        /* End of list */

+define DFH_VENDOR    GENMAKE_ULL(49,41) /* Vendor ID */

#define DFH_TYPE        GENMASK_ULL(63, 60)    /* Feature type */

And Intel gets id 0.

>
> I fully understand the concern is the feature id management, and potential
> conflicts there from different vendors. One possible method to resolve this
> is managing the ids in a public place (web? Or just the driver header file for
> feature id definition), all vendors can request some feature ids, and other
> people can see which feature ids have been used so that they can avoid
> using conflict ones with other people.

The conflict will come in development when two vendors use the same unpublished feature id.

Also keeping the truth of id's in the kernel source isn't that great because the public kernel always lags development repositories.

>
> And in the later version DFH, this feature id will be replaced with GUID
> I think, so it can resolve the conflict problems from different vendors?
> But now, we still need to handle the existing ones. : )

This is why I proposed needing to generalize the matching.

>
> Thanks
> Hao
>
>> This touches some of the matching function of the bus ops.  Could there be a
>> way for bus ops to be used so that there could be multiple matching
>> function.  Maybe the one in 0002 as a default so users could override it ?
>>
>> The use case I am worrying about is an OEM.  The OEM uses an unclaimed
>> feature_id and supplies their own platform device device driver to match the
>> feature_id.  But some later version of the kernel claims this feature_id and
>> the OEM's driver no longer works and since the value comes from pci config
>> space it is difficult to change.
>>
>> So looking for something like
>>
>> register_feature_matcher((*bus_match)(struct device *dev, struct
>> device_driver *drv))
>>
>> static int dfl_bus_match_default(struct device *dev, struct device_driver *drv)
>> {
>>     struct dfl_device *dfl_dev = to_dfl_dev(dev);
>>     struct dfl_driver *dfl_drv = to_dfl_drv(drv);
>>     const struct dfl_device_id *id_entry = dfl_drv->id_table;
>>
>>     while (id_entry->feature_id) {
>>         if (dfl_match_one_device(id_entry, dfl_dev)) {
>>             dfl_dev->id_entry = id_entry;
>>             return 1;
>>         }
>>         id_entry++;
>>     }
>>
>>     return 0;
>> }
>>
>> register_feature_matcher(&dfl_bus_match_default)
>>
>> static int dfl_bus_match(struct device *dev, struct device_driver *drv)
>> {
>>
>>     struct dfl_device *dfl_dev = to_dfl_dev(dev);
>>     struct dfl_driver *dfl_drv = to_dfl_drv(drv);
>>     const struct dfl_device_id *id_entry = dfl_drv->id_table;
>>
>>     while (id_entry->feature_id) {
>>
>>         matcher = Loop over matchers()
>>
>>         if (matcher(dev, drv)) {
>>             dfl_dev->id_entry = id_entry;
>>             return 1;
>>         }
>>         id_entry++;
>>     }
>>
>>     return 0;
>> }
>>
>> Or maybe use some of the unused bits in the dfl header to add a second
>> vendor-like id and change existing matcher to look feature_id and
>> vendor_like_id.
>>
>> Tom
>>
>>
>>
>> On 7/14/20 10:38 PM, Xu Yilun wrote:
>>> This patchset makes it possible to develop independent driver modules
>>> for DFL private features. It also helps to leverage existing kernel
>>> drivers to enable some IP blocks in DFL.
>>>
>>> Xu Yilun (2):
>>>   fpga: dfl: map feature mmio resources in their own feature drivers
>>>   fpga: dfl: create a dfl bus type to support DFL devices
>>>
>>>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>>>  drivers/fpga/dfl-pci.c                  |  21 +-
>>>  drivers/fpga/dfl.c                      | 435 +++++++++++++++++++++++++++-----
>>>  drivers/fpga/dfl.h                      |  91 ++++++-
>>>  4 files changed, 492 insertions(+), 70 deletions(-)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>>>
