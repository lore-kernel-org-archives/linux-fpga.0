Return-Path: <SRS0=UOBO=M6=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=UOBO=M6=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v4 09/18] of: overlay: validate overlay properties
 #address-cells and #size-cells
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-10-git-send-email-frowand.list@gmail.com>
 <20181018181338.GD15557@bogus>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <b6c378d0-19db-5426-7c3a-dbbc5907c37c@gmail.com>
Date: Thu, 18 Oct 2018 12:13:04 -0700
MIME-Version: 1.0
In-Reply-To: <20181018181338.GD15557@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/18/18 11:13, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 07:37:29PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> If overlay properties #address-cells or #size-cells are already in
>> the live devicetree for any given node, then the values in the
>> overlay must match the values in the live tree.
>>
>> If the properties are already in the live tree then there is no
>> need to create a changeset entry to add them since they must
>> have the same value.  This reduces the memory used by the
>> changeset and eliminates a possible memory leak.  This is
>> verified by 12 fewer warnings during the devicetree unittest,
>> as the possible memory leak warnings about #address-cells and
> 
> Still missing the rest...
> 
> And what about my other comments too?

Apologies, paper bag.  Will fix all.

-Frank

> 
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>> Changes since v3:
>>   - for errors of an overlay changing the value of #size-cells or
>>     #address-cells, return -EINVAL so that overlay apply will fail
>>   - for errors of an overlay changing the value of #size-cells or
>>     #address-cells, make the message more direct.
>>     Old message:
>>       OF: overlay: ERROR: overlay and/or live tree #size-cells invalid in node /soc/base_fpga_region
>>     New message:
>>       OF: overlay: ERROR: changing value of /soc/base_fpga_region/#size-cells not allowed
>>
>>  drivers/of/overlay.c | 42 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
