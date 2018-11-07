Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181106203512.4509-1-agust@denx.de> <CANk1AXS_FXFV3Q1zoorHc+fEMWtQzPfbgMEm=LzP5U0Qq_CAJg@mail.gmail.com>
 <20181107005604.693d3162@crub>
In-Reply-To: <20181107005604.693d3162@crub>
From: Alan Tull <atull@kernel.org>
Date: Wed, 7 Nov 2018 09:53:05 -0600
Message-ID: <CANk1AXTXRT8fNQb18mUAi=N7DCKgRjYjbuTZiXPkpDDTMCKALA@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera-cvp: fix probing for multiple FPGAs on the bus
Content-Type: text/plain; charset="UTF-8"
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Nov 6, 2018 at 5:56 PM Anatolij Gustschin <agust@denx.de> wrote:
>
> Hi Alan,
>
> On Tue, 6 Nov 2018 15:54:17 -0600
> Alan Tull atull@kernel.org wrote:
> ...
> >> fpga_manager fpga3: Altera CvP FPGA Manager @0000:0c:00.0 registered
> >> sysfs: cannot create duplicate filename '/bus/pci/drivers/altera-cvp/chkcfg'
> >
> >Shouldn't this have been a file under /sys/class/fpga_manager/fpga0/
> >instead?  This is a control per-device not per driver.
>
> I thought /sys/class/fpga_manager/fpgaN/ interface is generic for fpga-mgr
> and low-level manager specific stuff does not belong there. At least this
> is my filling when reading Documentation/ABI/testing/sysfs-class-fpga-manager.

Yes

>
> chkcfg is a debugging option and will be rarely used while development,
> it is off by default. And when enabling it globally at debugging time,
> it won't hurt other devices I think.

OK that's good to know.

> If it were some device specific
> behaviour control, then it surely would make sense to turn it on/off
> pre-device.
>
> ...
> >> -       ret = driver_create_file(&altera_cvp_driver.driver,
> >> -                                &driver_attr_chkcfg);
> >> -       if (ret) {
> >> -               dev_err(&pdev->dev, "Can't create sysfs chkcfg file\n");
> >> -               fpga_mgr_unregister(mgr);
> >> -               goto err_unmap;
> >> +       if (!altera_cvp_cnt++) {
> >> +               ret = driver_create_file(&altera_cvp_driver.driver,
> >> +                                        &driver_attr_chkcfg);
> >
> >In the review, I didn't catch that this was adding a driver file
> >instead of a device file.
>
> I was too focused on tons of comments to the driver patches when
> mainlining this driver and didn't have hardware with multiple
> PCIe cards to test it, so this bug crept in.
>
> When adding it as a device file, it will be in the directory with
> many PCI device specific files, e.g:
> # ls /sys/bus/pci/devices/0000\:0c\:00.0/
> ari_enabled           config                    current_link_width  dma_mask_bits    enable        local_cpulist   max_link_width  numa_node  rescan    resource0  resource4     subsystem         uevent
> broken_parity_status  consistent_dma_mask_bits  d3cold_allowed      driver           fpga_manager  local_cpus      modalias        power      reset     resource1  resource4_wc  subsystem_device  vendor
> class                 current_link_speed        device              driver_override  irq           max_link_speed  msi_bus         remove     resource  resource2  revision      subsystem_vendor
>
> I don't think that it is a good place for such driver specific control file.
> If we really must implement it per-device, then it would make more sense to
> use the current path and use something like
>
>    echo "1 0000:0c:00.0" > /sys/bus/pci/drivers/altera-cvp/chkcfg
>
> for enabling the option for a particular device. For disabling:
>
>   echo "0 0000:0c:00.0" > /sys/bus/pci/drivers/altera-cvp/chkcfg
>
> But it is harder to implement. Is it worth the effort when it is
> hardly used?

I agree, yes let's keep it as is then and just fix it.

Thanks,
Alan

>
> Thanks,
> Anatolij
