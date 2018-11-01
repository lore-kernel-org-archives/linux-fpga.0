Return-Path: <SRS0=RBas=NM=denx.de=agust@kernel.org>
Return-Path: <SRS0=RBas=NM=denx.de=agust@kernel.org>
Date: Thu, 1 Nov 2018 20:23:25 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fpga: xilinx-spi: Use unique FPGA manager names
Message-ID: <20181101202325.3bf87ea3@crub>
In-Reply-To: <CANk1AXR+Kv9-vEmMS3ybMoPOUdbNZXSK1341BD1jsEWUaZRXUg@mail.gmail.com>
References: <20181029144222.26927-1-agust@denx.de>
	<20181029164857.GA2453@archbook>
	<20181030121913.3f5f8458@crub>
	<CANk1AXR470s6XyfjR8=1SdiNAFsVj0oNA1-STVCu6_zY-kLf3A@mail.gmail.com>
	<20181101193336.766566fc@crub>
	<CANk1AXR+Kv9-vEmMS3ybMoPOUdbNZXSK1341BD1jsEWUaZRXUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, 1 Nov 2018 13:46:27 -0500
Alan Tull atull@kernel.org wrote:
...
>> # ls -l /sys/class/fpga_manager/fpga0/device
>> lrwxrwxrwx 1 root root 0 Nov  1 19:26 /sys/class/fpga_manager/fpga0/device -> ../../../spi1.0  
>
>Is 'device' giving the info this patch is adding to 'name'?

One can extract this info from 'device' somehow, but it is much more
easier to get it from the name

# cat /sys/class/fpga_manager/fpga0/name 
xlnx-slave-spi spi1.0

Thanks,

Anatolij
