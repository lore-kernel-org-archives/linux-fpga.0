Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180329213940.GB29604@tyrael.ni.corp.natinst.com>
References: <20180329153658.11614-1-mdf@kernel.org> <20180329153658.11614-5-mdf@kernel.org>
 <20180329170618.GE8501@kroah.com> <CANk1AXSDDe_PKsx+9CEAN0ZFdb+efqJPWxLfVM2t9xPAQFNctQ@mail.gmail.com>
 <20180329213940.GB29604@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Fri, 30 Mar 2018 10:27:22 -0500
Message-ID: <CANk1AXTPpJWUCrSEU4w25o-Ef9mqLnzVLhgDhmnyP6b-Hv_wHA@mail.gmail.com>
Subject: Re: [PATCH 4/6] fpga: region: change fpga_region_register to have one param
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Mar 29, 2018 at 4:39 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Thu, Mar 29, 2018 at 03:42:51PM -0500, Alan Tull wrote:
>> On Thu, Mar 29, 2018 at 12:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> Hi Greg,
>>
>> >> -int fpga_region_register(struct device *dev, struct fpga_region *region)
>> >> +int fpga_region_register(struct fpga_region *region)
>> >>  {
>> >> +     struct device *dev = region->parent;
>> >>       int id, ret = 0;
>> >>
>> >> +     if (!dev) {
>> >> +             pr_err("Attempt to register fpga region without parent\n");
>> >> +             return -EINVAL;
>> >> +     }
>> >
>> > Are you sure you don't want a virtual device?  That is what will happen
>> > if you do not have a parent, right?  Or do you always want to have
>> > "real" devices?
>>
>> I don't want to restrict this to "real" devices, so yes, I'll be
>> removing this check.
>>
>> >> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>> >> index b6520318ab9c..423c87e3e29a 100644
>> >> --- a/include/linux/fpga/fpga-region.h
>> >> +++ b/include/linux/fpga/fpga-region.h
>> >> @@ -8,6 +8,7 @@
>> >>  /**
>> >>   * struct fpga_region - FPGA Region structure
>> >>   * @dev: FPGA Region device
>> >> + * @parent: parent device
>> >>   * @mutex: enforces exclusive reference to region
>> >>   * @bridge_list: list of FPGA bridges specified in region
>> >>   * @mgr: FPGA manager
>> >> @@ -18,6 +19,7 @@
>> >>   */
>> >>  struct fpga_region {
>> >>       struct device dev;
>> >> +     struct device *parent;
>> >
>> > Why doesn't your dev parent pointer point to this, why do you need to
>> > have a separate pointer?  That feels really wrong.  Pass in the parent
>> > pointer when you create the struct device, otherwise it will be
>> > registered incorrectly anyway.  Then you always have the correct
>> > pointer, no need to keep a "spare" copy.
>>
>> I'll add a fpga_mgr_create function and let it set the parent.  No
>> need to save it.
>
> I think we had discussed this in the first round of the patchset.

Yup! :)

> How about fpga_mgr_alloc(...) and fpga_mgr_register(...) as suggested
> back then?

I'm cool with either name.  The alloc/create function will be doing
more than alloc.  It's going to fill in some struct members, allocate
an id #, and init the dev.  There's precedent for similar functions
named either way, even 'alloc' functions that do plenty of
initialization.

Alan

>
> Thanks for the review,
>
> Moritz
