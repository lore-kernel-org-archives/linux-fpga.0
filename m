Return-Path: <SRS0=Jnos=NR=denx.de=agust@kernel.org>
Return-Path: <SRS0=Jnos=NR=denx.de=agust@kernel.org>
Date: Tue, 6 Nov 2018 10:29:31 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2] fpga: mgr: add notifier for manager
 register/unregister events
Message-ID: <20181106102931.7ec6d038@crub>
In-Reply-To: <CANk1AXTTWMSsnjSgubnP6Mrt5GJ_edOL=cgix_rcrXs7t4-2CA@mail.gmail.com>
References: <20181105171457.28150-1-agust@denx.de>
	<CANk1AXTTWMSsnjSgubnP6Mrt5GJ_edOL=cgix_rcrXs7t4-2CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Mon, 5 Nov 2018 15:08:03 -0600
Alan Tull atull@kernel.org wrote:

>On Mon, Nov 5, 2018 at 11:15 AM Anatolij Gustschin <agust@denx.de> wrote:
>
>Hi Anatolij,
>
>>
>> Add API functions for registering and removing a notifier for FPGA
>> manager register/unregister events. Notify when a new FPGA manager
>> has been registered or when an existing manager is being removed.
>> This will help configuration interface drivers to get the notion
>> of low-level FPGA managers appearing or disappearing, when using
>> hotpluggable FPGA configuration devices (e.g. via USB-FPP or
>> USB-SPI adapters).  
>
>Are you going to be adding any code upstream that uses this API?

I'd like to add our fpga-cfg driver [1] in upstream which uses this API.
Here [2] is a better readable README about it.

Thanks,

Anatolij


[1] http://git.denx.de/?p=fpga-cfg.git;a=summary
[2] https://github.com/vdsao/fpga-cfg/blob/master/README.md
