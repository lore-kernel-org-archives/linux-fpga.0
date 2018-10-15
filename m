Return-Path: <SRS0=63Yb=M3=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=63Yb=M3=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v3 13/18] of: overlay: check prevents multiple fragments
 touching same property
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
 <b6ee53f7e02cc3ea52713ae82402e97d7050cb3e.camel@perches.com>
 <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
 <16f48648393366d91e43cd66b3d0a346b1ed29ab.camel@perches.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <e045d69a-7896-3ff1-8472-2f51c2468d7f@gmail.com>
Date: Sun, 14 Oct 2018 20:21:01 -0700
MIME-Version: 1.0
In-Reply-To: <16f48648393366d91e43cd66b3d0a346b1ed29ab.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/14/18 18:55, Joe Perches wrote:
> On Sun, 2018-10-14 at 18:52 -0700, Frank Rowand wrote:
>> On 10/14/18 18:06, Joe Perches wrote:
>>> On Sun, 2018-10-14 at 17:24 -0700, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Add test case of two fragments updating the same property.  After
>>>> adding the test case, the system hangs at end of boot, after
>>>> after slub stack dumps from kfree() in crypto modprobe code.
> []
>>> I think this is worse performance than before.
>>>
>>> This now walks all entries when before it would
>>> return -EINVAL directly when it found a match.
>>
>> Yes, it is worse performance, but that is OK.
>>
>> This is a check that is done when a devicetree overlay is applied.
>> If an error occurs then that means that the overlay was incorrectly
>> specified.  The file drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
>> in this patch provides an example of how a bad overlay can be created.
>>
>> Once an error was detected, the check could return immediately, or it
>> could continue to give a complete list of detected errors.  I chose to
>> give the complete list of detected errors.
> 
> Swell.  Please describe that in the commit message.

If a version 4 of the series is created I will update the commit
message.  As a stand alone item I do not think it is worth a
new version.

-Frank
