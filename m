Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170324191109.GB4736@tyrael.amer.corp.natinst.com>
References: <20170313215333.3008-1-atull@kernel.org> <CANk1AXSpNoKdpvpW2ikq6y+0o6JnfBexRkMhHUG+-u7rszoLHg@mail.gmail.com>
 <20170324191109.GB4736@tyrael.amer.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 5 Apr 2017 17:44:48 -0500
Message-ID: <CANk1AXRf9O3VYyocOkBgOZWzzkCd=S3rcxZnvH2TecuwGw_1hA@mail.gmail.com>
Subject: Re: [PATCH 0/5] fpga: enhancements to support non-dt code
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <moritz.fischer.private@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 24, 2017 at 2:11 PM, Moritz Fischer
<moritz.fischer.private@gmail.com> wrote:
> On Fri, Mar 24, 2017 at 01:09:22PM -0500, Alan Tull wrote:
>> On Mon, Mar 13, 2017 at 4:53 PM, Alan Tull <atull@kernel.org> wrote:
>> > Set of patches that supports writing code that uses
>> > FPGA regions without Device Tree overlays.
>>
>> OK here's where I try to clarify my intention for this code.  And
>> beg for reviews :)
>
> It's on the todo list ;-)

Thanks!  I could post a branch on linux-fpga git if that's helpful.

Most of the patches are small.  The last patch is large as it is moving
code from fpga-region.c to a new header and new of-fpga-region.c.
I think this patchset will be useful for the current 'Intel FPGA Driver'
patchset.

Alan

>
> Cheers,
>
> Moritz
