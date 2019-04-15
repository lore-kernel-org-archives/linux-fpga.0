Return-Path: <SRS0=yxNN=SR=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=yxNN=SR=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:34027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOL4C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 15 Apr 2019 07:56:02 -0400
Subject: Re: Device Description for FPGA Components on x86 system
References: <1629227.alSmCsHHUc@pcbe13614> <6563205.xRkLC0driV@pcbe13614>
 <dae0b7ba500cc03fab23956eac85ca79@sw-optimization.com>
 <31100498.IIhqzTXyFT@pcbe13614>
 <CANk1AXSQCFGE94R8ZxVSF2Gp+diCHJhFJPSVSx+iEyWp2URcpw@mail.gmail.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <08e60e79-8ae3-06ac-779e-d4d99e0ed846@metux.net>
Date: Mon, 15 Apr 2019 13:55:49 +0200
MIME-Version: 1.0
In-Reply-To: <CANk1AXSQCFGE94R8ZxVSF2Gp+diCHJhFJPSVSx+iEyWp2URcpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>, Federico Vaga <federico.vaga@cern.ch>
Cc: Eric Schwarz <eas@sw-optimization.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-x86_64@vger.kernel.org, linux-fpga-owner@vger.kernel.org

On 10.04.19 16:21, Alan Tull wrote:

> I wish I could point you to a complete solution, but there is a lot of> work to be done in this area.  Most of what is in the kernel is a low>
level in-kernel API [4].  As you correctly state, the hardest part of>
this is doing the enumerating if you are on x86 and aren't using>
devicetree.
ACK. I believe, introducing oftree the right way to go. I've got that
on my 2do list, too, but yet too busy w/ other things. So, if you'd
like to work on that, I'd highly appreciate that.

I'd like to also use oftree overlays for some platform drivers that
essentially just initialize/wire up generic drivers to perform some
board specific function (eg. drivers/platform/x86/pcengines-apuv2.c).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
