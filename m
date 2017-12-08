Return-Path: <SRS0=YrFZ=DE=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=YrFZ=DE=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:51205 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753863AbdLHN5T (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 8 Dec 2017 08:57:19 -0500
Date: Fri, 8 Dec 2017 14:57:17 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: RFC: FT232H based FPGA configuration adapter drivers
Message-ID: <20171208145717.67b23e48@crub>
In-Reply-To: <CAMuHMdUAXv_s8Lw1qwORew8RydKRKhFq7tMccU7jCa63_Otp0w@mail.gmail.com>
References: <20171207153150.6f33f2e7@crub>
        <CAMuHMdUAXv_s8Lw1qwORew8RydKRKhFq7tMccU7jCa63_Otp0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fpga@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>

Hi Geert,

On Fri, 8 Dec 2017 10:27:46 +0100
Geert Uytterhoeven geert@linux-m68k.org wrote:

[...]
>A quick Google shows the FT232H chip in MPSSE mode can also support i2c.
>I guess your design can be extended for that, too, using another VID/PID
>pair?

Yes, this should be doable.

Thanks,

Anatolij
