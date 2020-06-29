Return-Path: <SRS0=fPaD=AK=redhat.com=trix@kernel.org>
Return-Path: <SRS0=fPaD=AK=redhat.com=trix@kernel.org>
Subject: Re: [PATCH] fpga: dfl: improve configuration of dfl pci devices
References: <20200628151813.7679-1-trix@redhat.com>
 <20200629021924.GB2620@yilunxu-OptiPlex-7050>
 <DM6PR11MB38196ED29A3E0BBAD7B246C1856E0@DM6PR11MB3819.namprd11.prod.outlook.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <26b7c920-7b9f-b753-4a49-258e09b771fa@redhat.com>
Date: Mon, 29 Jun 2020 06:28:04 -0700
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38196ED29A3E0BBAD7B246C1856E0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>


On 6/28/20 8:12 PM, Wu, Hao wrote:
>> -----Original Message-----
>> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
>> On Behalf Of Xu Yilun
>> Sent: Monday, June 29, 2020 10:19 AM
>> To: trix@redhat.com
>> Cc: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Wu, Hao <hao.wu@intel.com>;
>> matthew.gerlach@linux.intel.com
>> Subject: Re: [PATCH] fpga: dfl: improve configuration of dfl pci devices
>>
>> I think maybe we don't have to select them all. It is now possible for
>> FPGA DFL boards to work without FME or AFU, providing limited
>> functionality. It is possible designers trim the bitstream for their
>> purpose, and also need a smaller driver set.
>>
> Yes, we hope that this dfl-pci could be a common module shared by
> different cards. Some device doesn't have FME, e.g. some VF device
> with AFU only, some device has FME, but no PR support, and in the
> future, it's possible to add new modules, or something replacing AFU
> or FME, so we don't have to select all here.
>
>> I think we may add "default FPGA_DFL" for FPGA_DFL_FME,
>> FPGA_DFL_FME_MGR and others to make life easier.
> It's hard to say it's easier for everybody, e.g. I am a user of N3000, but
> I have to unselect the PR modules, as they are default Yes as proposed?
> Maybe it's better to let user select what they want, unless we find
> something really common needed under DFL framework.

I get your point about n3000, but that card is not currently supported in the public. Currently there is really only pac10, the 0x9c4 device.  Once n3000 (and d5005) is out, it will have several sub devices that will also so need to be manually configured.  While a developer of the n3000 will know which subdevices are needed, someone just building the kernel will not.  So would expect there to be something like

CONFIG_FPGA_DFL_N3000

select CONFIG_DFL_PCI

select CONFIG_DFL_SUBDEV_1

..

On PF vs FP, yes only afu parts are needed.  But i doubt anyone builds a VF specific kernel. And if folks wanted to not use the fme parts they would not have to load it's module at run time.

I would like a top level config what auto selects all of the submodules needed based on the card. I think maybe that is CONFIG_FPGA_DFL_PAC10. so we will be ready for CONFIG_FPGA_DFL_N3000 and CONFIG_FPGA_DFL_D5005 and what ever comes later.

Tom

> Hao
>
