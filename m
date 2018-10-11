Return-Path: <SRS0=ciJd=MX=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=ciJd=MX=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH 05.1/16] of:overlay: missing name, phandle, linux,phandle
 in new nodes
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
 <1539151495-8110-1-git-send-email-frowand.list@gmail.com>
 <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
 <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
 <e32a99a2-1db5-80e6-5022-83cd8fd07180@gmail.com>
 <bcbba4ca-0656-aa27-c058-064fb7175d38@gmail.com>
 <CANk1AXSRifmwu1FQRY_hsuqDESEzcMET_hpLNZOeW4QLrUwsdw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <3f36468b-676a-558d-4180-7129d2bf2c6c@gmail.com>
Date: Thu, 11 Oct 2018 16:38:26 -0700
MIME-Version: 1.0
In-Reply-To: <CANk1AXSRifmwu1FQRY_hsuqDESEzcMET_hpLNZOeW4QLrUwsdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/11/18 12:33, Alan Tull wrote:
> On Thu, Oct 11, 2018 at 12:39 AM Frank Rowand <frowand.list@gmail.com> wrote:
> 
> [resend of my messed up rejected email of a minute ago, sorry]
> 
>>
>> On 10/10/18 14:03, Frank Rowand wrote:

< snip >

> I understand you're quite busy with all this, but I'm wondering
> whether it might be worth it go ahead and make the properties be
> kernel objects also at this point.  That would be an improvement for
> the case of overlay properties added to non-overlay nodes, so the
> lifespan of the overlay property memory can be coupled with the
> properties kobj's instead of the node kobj's.
> 
> Alan
> 

That is one of the approaches that I am thinking about to handle
the potential memory leaks from those properties.

I'd like to make these changes in a step wise fashion, to let each
major change get some exposure and use before moving on to the
next step.  Making properties into kernel objects would impact
a lot of code.

So not in this series.  But thanks for thinking about it.

-Frank
