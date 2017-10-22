Return-Path: <SRS0=Flcq=BV=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=Flcq=BV=ettus.com=moritz.fischer@kernel.org>
Date: Sun, 22 Oct 2017 02:43:06 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v5 13/18] fpga: region: add register/unregister functions
Message-ID: <20171022094306.GA24055@tyrael.ni.corp.natinst.com>
References: <20171017212031.3770-1-atull@kernel.org>
 <20171017212031.3770-14-atull@kernel.org>
 <1F870B2EBF7EE147840708BE00416263C61FD3@dggemi508-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1F870B2EBF7EE147840708BE00416263C61FD3@dggemi508-mbs.china.huawei.com>
To: majiuyue <majiuyue@huawei.com>
Cc: Alan Tull <atull@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Jiuyue,

On Fri, Oct 20, 2017 at 07:23:31AM +0000, majiuyue wrote:
> Hi Alan, 
> 
> I have a little confused on the fpga_region_register() interface.
> 
> > -static int of_fpga_region_probe(struct platform_device *pdev)
> > +int fpga_region_register(struct device *dev, struct fpga_region 
> > +*region)
> >  {
> >...
> >	device_initialize(&region->dev);
> >  	region->dev.class = fpga_region_class;
> >  	region->dev.parent = dev;
> > -	region->dev.of_node = np;
> > +	region->dev.of_node = dev->of_node;
> >  	region->dev.id = id;
> >  	dev_set_drvdata(dev, region);
> 
> For the device tree version, it is clear that each fpga region will have one of_node,
> and the fpga_region is registered to it with the **dev->driver_data** point to the fpga_region struct.
> 
> But for non- device tree version (e.g. pcie-attached fpga in x86),
> I cannot just call "fpga_region_register(&pdev->dev, region[i])" multiple times if I want to register
> multiple regions. Because the register interface use "pdev->dev.driver_data" to store reference to fpga_region.
> 
> So, I have to separate it to 2 steps:
> 
>  - create one sub-device(maybe platform_dev?) for each region,

This step doesn't seem to crazy to me, because most likely you wanna be
able to have region specific behavior on a per subdevice basis?

One big issue is that we don't have a whole lot of PCIe
hardware to look. If you have a project that requires this, sharing some
code (snippets) might allow for better architecture and ultimately make your job
easier ;-)

>  - and register fpga_region to these sub-devices instead of the pci_dev.
> 
> Is there any way to omit these extra sub-devices?

We can probably work around this, again, a specific usecase would help.
> 
> 
> Thank you.
> 
> Jiuyue Ma
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Moritz
