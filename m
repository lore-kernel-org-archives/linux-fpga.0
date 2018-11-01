Return-Path: <SRS0=RBas=NM=denx.de=agust@kernel.org>
Return-Path: <SRS0=RBas=NM=denx.de=agust@kernel.org>
Date: Thu, 1 Nov 2018 19:33:36 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fpga: xilinx-spi: Use unique FPGA manager names
Message-ID: <20181101193336.766566fc@crub>
In-Reply-To: <CANk1AXR470s6XyfjR8=1SdiNAFsVj0oNA1-STVCu6_zY-kLf3A@mail.gmail.com>
References: <20181029144222.26927-1-agust@denx.de>
	<20181029164857.GA2453@archbook>
	<20181030121913.3f5f8458@crub>
	<CANk1AXR470s6XyfjR8=1SdiNAFsVj0oNA1-STVCu6_zY-kLf3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, 1 Nov 2018 13:21:00 -0500
Alan Tull atull@kernel.org wrote:

>On Tue, Oct 30, 2018 at 6:19 AM Anatolij Gustschin <agust@denx.de> wrote:
>>
>> Hi Moritz,
>>
>> On Mon, 29 Oct 2018 09:48:57 -0700
>> Moritz Fischer mdf@kernel.org wrote:
>> ...  
>> >Sounds like a udev problem that can be solved by looking at the
>> >parent device?  
>>
>> Yes, but there are still all kinds of small embedded systems
>> without udev/systemd support.  
>
>What do you see if you look at the following for your fpga manager
>(may be other than fpga0)?
>
>/sys/class/fpga_manager/fpga0/device
>
>or
>
> /sys/class/fpga_manager/fpga0/of_node

of_node isn't there, it is a non-dt platform.

# ls -l /sys/class/fpga_manager/fpga0/device
lrwxrwxrwx 1 root root 0 Nov  1 19:26 /sys/class/fpga_manager/fpga0/device -> ../../../spi1.0
 
# ls -l /sys/class/fpga_manager/fpga0/device/
total 0
lrwxrwxrwx 1 root root    0 Nov  1 16:48 driver -> ../../../../../../../../../../../../bus/spi/drivers/altera-ps-spi
-rw-r--r-- 1 root root 4096 Nov  1 19:26 driver_override
drwxr-xr-x 3 root root    0 Nov  1 16:48 fpga_manager
-r--r--r-- 1 root root 4096 Nov  1 19:26 modalias
drwxr-xr-x 2 root root    0 Nov  1 19:26 power
drwxr-xr-x 2 root root    0 Nov  1 19:26 statistics
lrwxrwxrwx 1 root root    0 Nov  1 16:48 subsystem -> ../../../../../../../../../../../../bus/spi
-rw-r--r-- 1 root root 4096 Nov  1 16:48 uevent

Thanks,

Anatolij
