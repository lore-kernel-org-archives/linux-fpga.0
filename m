Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180329170142.GB8501@kroah.com>
References: <20180329153658.11614-1-mdf@kernel.org> <20180329153658.11614-2-mdf@kernel.org>
 <20180329170142.GB8501@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 29 Mar 2018 15:38:43 -0500
Message-ID: <CANk1AXT_hKKgi8G1pkDrgfg425i-jLkjiC3TZ2AUee11_PSSYQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] fpga: region: don't use drvdata in common fpga code
Content-Type: text/plain; charset="UTF-8"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Mar 29, 2018 at 12:01 PM, Greg KH <gregkh@linuxfoundation.org> wrote:

Hi Greg,

> On Thu, Mar 29, 2018 at 08:36:53AM -0700, Moritz Fischer wrote:
>> From: Alan Tull <atull@kernel.org>
>>
>> Part of patchset that changes the following fpga_*_register
>> functions to not set drvdata:
>> * fpga_region_register.
>> * fpga_mgr_register
>> * fpga_bridge_register
>
> That's not what this specific patch does.  Please do not write generic
> changelog text that is identical for 3 patches that does different
> things in each one :(

Thanks for the guidance, it's always helpful.  I'll clean up.

Alan

>
> thanks,
>
> greg k-h
