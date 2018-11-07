Return-Path: <SRS0=NL9p=NS=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=NL9p=NS=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v6 07/18] of: dynamic: change type of
 of_{at,de}tach_node() to void
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <1541431515-25197-8-git-send-email-frowand.list@gmail.com>
 <87tvktqedf.fsf@concordia.ellerman.id.au>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <6bc78502-7587-eb9c-237f-d3f031979d42@gmail.com>
Date: Wed, 7 Nov 2018 06:55:14 -0800
MIME-Version: 1.0
In-Reply-To: <87tvktqedf.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 11/7/18 4:08 AM, Michael Ellerman wrote:
> frowand.list@gmail.com writes:
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> of_attach_node() and of_detach_node() always return zero, so
>> their return value is meaningless.
> 
> But should they always return zero?
> 
> At least __of_attach_node_sysfs() can fail in several ways.

Sigh.  And of_reconfig_notify() can fail.  And at one point in the
history the return value of of_reconfig_notify() was returned by
of_attach_node() if of_reconfig_notify() failed.


> And there's also this in __of_detach_node() which should probably be
> returning an error:
> 
> 	if (WARN_ON(of_node_check_flag(np, OF_DETACHED)))
>         	return;
> 
> 
> Seems to me we should instead be fixing these to propagate errors,
> rather than hiding them?

The history of how of_attach_node() stopped propagating errors is
a bit more complex than I want to dig into at the moment.  So I'll
drop this patch from the series and add investigating this onto
my todo list.  I suspect that the result of investigating will be
that error return values should not be ignored in of_attach_node()
and of_detach_node(), but should instead be propagated to the
callers, as you suggest.

-Frank

> 
> cheers
> 
