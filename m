Return-Path: <SRS0=I98M=MR=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=I98M=MR=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH 15/16] of: unittest: initialize args before calling
 of_irq_parse_one()
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
 <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <d251f99e-6618-f1d2-814f-7aaffb8f499f@gmail.com>
Date: Fri, 5 Oct 2018 12:04:26 -0700
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On 10/05/18 07:53, Rob Herring wrote:
> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Callers of of_irq_parse_one() blindly use the pointer args.np
>> without checking whether of_irq_parse_one() had an error and
>> thus did not set the value of args.np.  Initialize args to
>> zero so that using the format "%pOF" to show the value of
>> args.np will show "(null)" when of_irq_parse_one() has an
>> error and does not set args.np instead of trying to
>> dereference a random value.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/unittest.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Does this need to be part of this series?

I do not know if it could be independently applied before the
rest of the series (I have not tested that).  I included it
in the series because the series has so many other changes to
unittest.c.

If you want me to break this out, I will remove it from this
series and resend it after the rest of the series has been
pulled to mainline (and rebase on the new mainline).

This patch is not fixing a known failure case - the current
test data does not trigger the problem.  The recent patch
from  Guenter that you already accepted fixes the known failure
case, so this patch is not urgent.  The same is true about the
other cases Guenter pointed out that this patch should fix.

-Frank
