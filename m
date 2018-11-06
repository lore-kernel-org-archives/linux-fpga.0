Return-Path: <SRS0=L03T=NR=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=L03T=NR=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46455 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbeKFTXJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Nov 2018 14:23:09 -0500
Date: Tue, 6 Nov 2018 10:58:39 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 2/3] spi: add FTDI MPSSE SPI controller driver
Message-ID: <20181106105839.1951d067@crub>
In-Reply-To: <201811061305.tmSD6nlU%fengguang.wu@intel.com>
References: <20181105161913.27538-3-agust@denx.de>
        <201811061305.tmSD6nlU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, atull@kernel.org, mdf@kernel.org

On Tue, 6 Nov 2018 13:07:13 +0800
kbuild test robot lkp@intel.com wrote:
...
>                    from drivers/spi/spi-ftdi-mpsse.c:11:
>>> arch/x86/include/uapi/asm/ptrace-abi.h:20:13: error: expected identifier before numeric constant  
>    #define CS  13
>                ^
>>> drivers/spi/spi-ftdi-mpsse.c:27:2: note: in expansion of macro 'CS'  
>     CS = BIT(3),
>     ^~

I didn't see this while my build-testing, sorry. Will fix it in next
patch version.

Thanks,
Anatolij
