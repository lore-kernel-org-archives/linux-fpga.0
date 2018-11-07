Return-Path: <SRS0=NL9p=NS=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=NL9p=NS=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v6 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <1541431515-25197-5-git-send-email-frowand.list@gmail.com>
 <87muqlqdog.fsf@concordia.ellerman.id.au>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <ea4d4314-a7e8-f4cd-f9e0-15fedcd3510f@gmail.com>
Date: Wed, 7 Nov 2018 06:58:56 -0800
MIME-Version: 1.0
In-Reply-To: <87muqlqdog.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 11/7/18 4:23 AM, Michael Ellerman wrote:
> frowand.list@gmail.com writes:
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
> 
> It would be clearer if you said 'The previous commit "of: overlay ..."

Will fix.


>> added a missing of_node_get() to __of_attach_node_sysfs().  This
>> results in a refcount imbalance for nodes attached with
>> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
>> to __of_attach_node_sysfs() is:
>>
>>    dlpar_attach_node()
>>       of_attach_node()
>>          __of_attach_node_sysfs()
>>
>> Tested-by: Alan Tull <atull@kernel.org>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> ***** UNTESTED.  I need people with the affected PowerPC systems
>> *****            (systems that dynamically allocate and deallocate
>> *****            devicetree nodes) to test this patch.
> 
> This looks OK to me in light of the previous patch.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> It also means dlpar_detach_node() is again behaving as described in the
> comment to of_detach_node().
> 
> It would be good to make mention of:
> 
>   Fixes: 68baf692c435 ("powerpc/pseries: Fix of_node_put() underflow during DLPAR remove")
> 
> Which removed an of_node_put() in the exact same place for different
> reasons.

OK.

-Frank

> 
> cheers
> 
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index 7625546caefd..17958043e7f7 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -270,6 +270,8 @@ int dlpar_detach_node(struct device_node *dn)
>>  	if (rc)
>>  		return rc;
>>  
>> +	of_node_put(dn);
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> Frank Rowand <frank.rowand@sony.com>
> 
