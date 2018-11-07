Return-Path: <SRS0=NL9p=NS=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=NL9p=NS=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
 <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
 <87sh0dqec5.fsf@concordia.ellerman.id.au>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <8d2d4bcb-1349-7bfb-7007-151cb9f19c1b@gmail.com>
Date: Wed, 7 Nov 2018 06:59:53 -0800
MIME-Version: 1.0
In-Reply-To: <87sh0dqec5.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 11/7/18 4:09 AM, Michael Ellerman wrote:
> Frank Rowand <frowand.list@gmail.com> writes:
> 
>> Hi Michael, Ben, Paul,
>>
>> Do you know if anyone has tried this series on PowerPC?
> 
> I have. No obvious breakage.
> 
> My test does a loop of adding and removing multiple CPUs multiple times,
> and in the past that has uncovered refcounting bugs. So I don't think
> we're leaking any with this series applied.
> 
> I used the tracepoint patch to keep an eye on the refcounts :)
> 
>   https://patchwork.ozlabs.org/patch/751602/
> 
> 
> I'm happy for this series to go into linux-next where it should get some
> more testing.
> 
> cheers
> 

Thanks for the reviews and testing.

-Frank
