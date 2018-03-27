Return-Path: <SRS0=kXu+=GR=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=kXu+=GR=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbeC0VUB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Mar 2018 17:20:01 -0400
MIME-Version: 1.0
In-Reply-To: <CAAtXAHeo_CGLqUPF=QfXojX2ZM0OJJ79PvrK6pmgn190zs0dLA@mail.gmail.com>
References: <20180327195957.3878-1-atull@kernel.org> <20180327195957.3878-3-atull@kernel.org>
 <CAAtXAHeo_CGLqUPF=QfXojX2ZM0OJJ79PvrK6pmgn190zs0dLA@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 27 Mar 2018 16:19:19 -0500
Message-ID: <CANk1AXRhzq+twBJQyJL5HJ7hxpt_ZDa0GQP6qq4JKMd3siT_bA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/4] fpga: manager: don't use drvdata in common
 fpga code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Anatolij Gustschin <agust@denx.de>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Joel Holdsworth <joel@airwebreathe.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org

On Tue, Mar 27, 2018 at 3:11 PM, Moritz Fischer
<moritz.fischer@ettus.com> wrote:
> On Tue, Mar 27, 2018 at 12:59 PM, Alan Tull <atull@kernel.org> wrote:
>> Change fpga_mgr_register to not set or use drvdata.
>>
>> Change the register/unregister function parameters to take the mgr
>> struct:
>> * int fpga_mgr_register(struct fpga_manager *mgr);
>> * void fpga_mgr_unregister(struct fpga_manager *mgr);
>>
>> Change the drivers that call fpga_mgr_register to alloc the struct
>> fpga_manager (using devm_kzalloc) and partly fill it, adding name,
>> ops, parent device, and priv.
>>
>> The rationale is that setting drvdata is fine for DT based devices
>> that will have one manager, bridge, or region per platform device.
>> However PCIe based devices may have multiple FPGA mgr/bridge/regions
>> under one PCIe device.  Without these changes, the PCIe solution has
>> to create an extra device for each child mgr/bridge/region to hold
>> drvdata.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks Moritz!

Alan
