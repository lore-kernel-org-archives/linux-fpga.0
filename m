Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAtXAHep-WaJyTWL1KmLGtjCvrYLmL=Cv4cfS_qjjfP2UuGbpw@mail.gmail.com>
References: <1492697401-11211-1-git-send-email-atull@kernel.org>
 <1492697401-11211-9-git-send-email-atull@kernel.org> <CAAtXAHep-WaJyTWL1KmLGtjCvrYLmL=Cv4cfS_qjjfP2UuGbpw@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 8 May 2017 16:03:28 -0500
Message-ID: <CANk1AXSb39sz_8MGNn9C3tJ7pr0PVTiXw_9wFhP=wpW2YTeBUw@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] fpga: region: check for child regions before
 allocing image info
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, May 5, 2017 at 3:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Thu, Apr 20, 2017 at 7:09 AM, Alan Tull <atull@kernel.org> wrote:
>> During a device tree overlay pre-apply notification, the check
>> for child FPGA regions can happen slightly earlier.  This saves
>> us from allocating the FPGA image info that just gets thrown
>> away.
>>
>> This is a baby step in refactoring the FPGA region code to
>> separate out common FPGA region code from FPGA region
>> Device Tree overlay support.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks!

Alan
