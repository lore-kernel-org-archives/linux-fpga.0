Return-Path: <SRS0=i/2R=NX=denx.de=agust@kernel.org>
Return-Path: <SRS0=i/2R=NX=denx.de=agust@kernel.org>
Date: Mon, 12 Nov 2018 22:15:20 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3] fpga: mgr: altera-ps-spi: enable usage on non-dt
 platforms
Message-ID: <20181112221520.46a2a6d9@crub>
In-Reply-To: <20181101212231.9125-1-agust@denx.de>
References: <20181101212231.9125-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: atull@kernel.org
Cc: linux-fpga@vger.kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Thu,  1 Nov 2018 22:22:31 +0100
Anatolij Gustschin agust@denx.de wrote:

>Driver probing fails on non-dt platforms since of_match_device()
>always returns NULL here. Add device names and matching driver
>data to the spi_device_id table. This allows driver binding to
>dynamically added PS-SPI devices (e.g. added via spi_new_device()
>after hot-plugging).
>
>Signed-off-by: Anatolij Gustschin <agust@denx.de>
>---
>Changes in v3:
> - don't use pointers to device data struct in driver_data

Ping. Could this be queued for -next?

Thanks,
Anatolij
