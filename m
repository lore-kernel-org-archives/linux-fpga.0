Return-Path: <SRS0=fjBz=BW=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=fjBz=BW=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932338AbdJWP75 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 23 Oct 2017 11:59:57 -0400
Received: from mail-ua0-f175.google.com (mail-ua0-f175.google.com [209.85.217.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F8A21908
        for <linux-fpga@vger.kernel.org>; Mon, 23 Oct 2017 15:59:57 +0000 (UTC)
Received: by mail-ua0-f175.google.com with SMTP id u32so13275828uau.0
        for <linux-fpga@vger.kernel.org>; Mon, 23 Oct 2017 08:59:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171022094306.GA24055@tyrael.ni.corp.natinst.com>
References: <20171017212031.3770-1-atull@kernel.org> <20171017212031.3770-14-atull@kernel.org>
 <1F870B2EBF7EE147840708BE00416263C61FD3@dggemi508-mbs.china.huawei.com> <20171022094306.GA24055@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 23 Oct 2017 10:59:15 -0500
Message-ID: <CANk1AXRbPbtBquO+0ndoT9QzuPXTuq4a5Su8bEeVp_XN9QFPMw@mail.gmail.com>
Subject: Re: [PATCH v5 13/18] fpga: region: add register/unregister functions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>
Cc: majiuyue <majiuyue@huawei.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

On Sun, Oct 22, 2017 at 4:43 AM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Jiuyue,

> Hi Jiuyue,
>
> On Fri, Oct 20, 2017 at 07:23:31AM +0000, majiuyue wrote:
>> Hi Alan,
>>
>> I have a little confused on the fpga_region_register() interface.
>>
>> > -static int of_fpga_region_probe(struct platform_device *pdev)
>> > +int fpga_region_register(struct device *dev, struct fpga_region
>> > +*region)
>> >  {
>> >...
>> >     device_initialize(&region->dev);
>> >     region->dev.class = fpga_region_class;
>> >     region->dev.parent = dev;
>> > -   region->dev.of_node = np;
>> > +   region->dev.of_node = dev->of_node;
>> >     region->dev.id = id;
>> >     dev_set_drvdata(dev, region);

Thanks for catching this.  This dev_set_drvdata is only needed for the
platform_get_drvdata that's in of_fpga_region_remove.   So the
dev_set_drvdta should be taken from fpga_region_register and moved to
of_fpga_region_probe.

How does that sound?

Alan

>>
>> For the device tree version, it is clear that each fpga region will have one of_node,
>> and the fpga_region is registered to it with the **dev->driver_data** point to the fpga_region struct.
>>
>> But for non- device tree version (e.g. pcie-attached fpga in x86),
>> I cannot just call "fpga_region_register(&pdev->dev, region[i])" multiple times if I want to register
>> multiple regions. Because the register interface use "pdev->dev.driver_data" to store reference to fpga_region.
>>
>> So, I have to separate it to 2 steps:
>>
>>  - create one sub-device(maybe platform_dev?) for each region,
>
> This step doesn't seem to crazy to me, because most likely you wanna be
> able to have region specific behavior on a per subdevice basis?
>
> One big issue is that we don't have a whole lot of PCIe
> hardware to look. If you have a project that requires this, sharing some
> code (snippets) might allow for better architecture and ultimately make your job
> easier ;-)
>
>>  - and register fpga_region to these sub-devices instead of the pci_dev.
>>
>> Is there any way to omit these extra sub-devices?
>
> We can probably work around this, again, a specific usecase would help.
>>
>>
>> Thank you.
>>
>> Jiuyue Ma
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks,
> Moritz
