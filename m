Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:36005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfBLOch (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 Feb 2019 09:32:37 -0500
Subject: Re: [PATCH] fpga: expand minor range when registering chrdev region
References: <20190212062451.1354-1-cgxu519@gmx.com>
 <CAAtXAHck6a2LbWGb9Fu7+HP9Uz8oAhTOs9636AqD7P9SOSGi3A@mail.gmail.com>
From: cgxu519 <cgxu519@gmx.com>
Message-ID: <3a1c6ac6-ecfe-f21c-ef4c-0af8ab8536eb@gmx.com>
Date: Tue, 12 Feb 2019 22:32:14 +0800
MIME-Version: 1.0
In-Reply-To: <CAAtXAHck6a2LbWGb9Fu7+HP9Uz8oAhTOs9636AqD7P9SOSGi3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org

On 2/12/19 6:54 PM, Moritz Fischer wrote:
> Hi Chengguang,
>
> On Mon, Feb 11, 2019 at 10:25 PM Chengguang Xu <cgxu519@gmx.com> wrote:
>> Actually, total amount of available minor number
>> for a single major is MINORMARK + 1. So expand
> Typo. MINORMASK?

Yeah, it's a typo, should be MINORMASK.

>
>> minor range when registering chrdev region
> How does that manifest?

The output of /proc/devices only shows major so
I'm not sure is there an easy way to do that except
hacking the code to show minor range with major.

Thanks
