Return-Path: <SRS0=eEcE=NQ=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=eEcE=NQ=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
Date: Mon, 5 Nov 2018 13:55:10 -0800
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Michael, Ben, Paul,

Do you know if anyone has tried this series on PowerPC?

Thanks,

-Frank


On 11/5/18 11:24 AM, Rob Herring wrote:
> On Mon, Nov 5, 2018 at 9:26 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Add checks to (1) overlay apply process and (2) memory freeing
>> triggered by overlay release.  The checks are intended to detect
>> possible memory leaks and invalid overlays.
>>
>> The checks revealed bugs in existing code.  Fixed the bugs.
>>
>> While fixing bugs, noted other issues, which are fixed in
>> separate patches.
>>
>> *****  Powerpc folks: I was not able to test the patches that
>> *****  directly impact Powerpc systems that use dynamic
>> *****  devicetree.  Please review that code carefully and
>> *****  test.  The specific patches are: 03/16, 04/16, 07/16
> 
> I'm waiting for this to happen. Send me a pull req when it does or
> when you give up waiting for a response.
> 
> Rob
> 
