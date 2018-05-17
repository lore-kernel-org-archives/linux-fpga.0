Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180517070407.GA13919@kroah.com>
References: <20180516235007.3951-1-atull@kernel.org> <20180517070407.GA13919@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 17 May 2018 09:08:11 -0500
Message-ID: <CANk1AXS2jqG_RT5tL=b_+n8+FzZnWEUHoJh2qgjWJJ4hEv2vMw@mail.gmail.com>
Subject: Re: [PATCH 00/14] fpga api changes and kernel-doc fixup
Content-Type: text/plain; charset="UTF-8"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, May 17, 2018 at 2:04 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, May 16, 2018 at 06:49:53PM -0500, Alan Tull wrote:
>> I'm posting these all together because they are interdependent.
>>
>> Patches 1-4 are a repost of v4 of the FPGA api change.
>>
>> Patch 5 is a repost of adding SPDX to my fpga code
>>
>> Patch 6-12 update the fpga kernel-doc documentation and move
>> existing .txt fpga documentation to driver-api ReST documents.
>>
>> Patch 13 is a minor documentation fix
>>
>> Patch 14 updates MAINTAINERS for the new driver-api/fpga directory
>
> Are these just for review, or do you feel they are good enough for me to
> queue up for 4.18-rc1 now?

I think the first five are good to go, but that's your call.

Patches 1-4 are the API reworked following your suggestions.

Patch 5 (SPDX) = I haven't heard any feedback on, but I think it's good.

So I think patches 1-5 are good (if you agree).  The rest are new to
the mailing list and haven't been reviewed/acked by anybody else yet.

I generally avoid posting reviewed/unreviewed patches together, sorry.
I just didn't want to open the possibility of patches being applied
out of order and the issues that can cause.

Alan

>
> thanks,
>
> greg k-h
