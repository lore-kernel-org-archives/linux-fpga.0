Return-Path: <SRS0=UOBO=M6=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=UOBO=M6=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
 <20181018170931.GC15557@bogus>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <780fb659-29e8-1ef4-4f62-97dacf36f6c8@gmail.com>
Date: Thu, 18 Oct 2018 12:09:45 -0700
MIME-Version: 1.0
In-Reply-To: <20181018170931.GC15557@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/18/18 10:09, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 07:37:24PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
>> added a missing of_node_get() to __of_attach_node_sysfs().  This
>> results in a refcount imbalance for nodes attached with
>> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
>> to __of_attach_node_sysfs() is:
>>
>>    dlpar_attach_node()
>>       of_attach_node()
>>          __of_attach_node_sysfs()
> 
> IIRC, there's a long standing item in the todo (Grant's) to convert the 
> open coded dlpar code. Maybe you want to do that first?

I'd like to avoid extra delays to getting the current (with necesary
fixes) series accepted because the series is rather intrusive and
could have conflicts with other patches.

I'm also worried that I don't have access to any of the systems that
use the dynamic overlay code, and I don't have any way to test the
changes.

Can we encourage the users of this code to convert the open coded
dlpar code?


>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> ***** UNTESTED.  I need people with the affected PowerPC systems
>> *****            (systems that dynamically allocate and deallocate
>> *****            devicetree nodes) to test this patch.
> 
> Can't we write a test case that does the same thing?

I could write a simplistic test case, but I'm concerned that
simplistic is not anywhere near sufficient.  And my test case
would reflect the same assumptions I already have when I
wrote this patch.


>>
>>  arch/powerpc/platforms/pseries/dlpar.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index a0b20c03f078..e3010b14aea5 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
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
>>
> 
