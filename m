Return-Path: <SRS0=gGtO=NS=ellerman.id.au=mpe@kernel.org>
Return-Path: <SRS0=gGtO=NS=ellerman.id.au=mpe@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
In-Reply-To: <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com> <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com> <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
Date: Wed, 07 Nov 2018 23:09:14 +1100
Message-ID: <87sh0dqec5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
To: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Frank Rowand <frowand.list@gmail.com> writes:

> Hi Michael, Ben, Paul,
>
> Do you know if anyone has tried this series on PowerPC?

I have. No obvious breakage.

My test does a loop of adding and removing multiple CPUs multiple times,
and in the past that has uncovered refcounting bugs. So I don't think
we're leaking any with this series applied.

I used the tracepoint patch to keep an eye on the refcounts :)

  https://patchwork.ozlabs.org/patch/751602/


I'm happy for this series to go into linux-next where it should get some
more testing.

cheers
