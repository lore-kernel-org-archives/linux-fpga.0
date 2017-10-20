Return-Path: <SRS0=EcyG=BT=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=EcyG=BT=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:13346 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdJTHXq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 20 Oct 2017 03:23:46 -0400
From: majiuyue <majiuyue@huawei.com>
Subject: RE: [PATCH v5 13/18] fpga: region: add register/unregister functions
Date: Fri, 20 Oct 2017 07:23:31 +0000
Message-ID: <1F870B2EBF7EE147840708BE00416263C61FD3@dggemi508-mbs.china.huawei.com>
References: <20171017212031.3770-1-atull@kernel.org>
 <20171017212031.3770-14-atull@kernel.org>
In-Reply-To: <20171017212031.3770-14-atull@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

Hi Alan, 

I have a little confused on the fpga_region_register() interface.

> -static int of_fpga_region_probe(struct platform_device *pdev)
> +int fpga_region_register(struct device *dev, struct fpga_region 
> +*region)
>  {
>...
>	device_initialize(&region->dev);
>  	region->dev.class = fpga_region_class;
>  	region->dev.parent = dev;
> -	region->dev.of_node = np;
> +	region->dev.of_node = dev->of_node;
>  	region->dev.id = id;
>  	dev_set_drvdata(dev, region);

For the device tree version, it is clear that each fpga region will have one of_node,
and the fpga_region is registered to it with the **dev->driver_data** point to the fpga_region struct.

But for non- device tree version (e.g. pcie-attached fpga in x86),
I cannot just call "fpga_region_register(&pdev->dev, region[i])" multiple times if I want to register
multiple regions. Because the register interface use "pdev->dev.driver_data" to store reference to fpga_region.

So, I have to separate it to 2 steps:

 - create one sub-device(maybe platform_dev?) for each region,
 - and register fpga_region to these sub-devices instead of the pci_dev.

Is there any way to omit these extra sub-devices?


Thank you.

Jiuyue Ma
 
