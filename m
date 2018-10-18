Return-Path: <SRS0=H3ux=M6=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=H3ux=M6=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41564 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeJSBL1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 18 Oct 2018 21:11:27 -0400
Date: Thu, 18 Oct 2018 12:09:31 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Message-ID: <20181018170931.GC15557@bogus>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: frowand.list@gmail.com
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org

On Mon, Oct 15, 2018 at 07:37:24PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
> added a missing of_node_get() to __of_attach_node_sysfs().  This
> results in a refcount imbalance for nodes attached with
> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
> to __of_attach_node_sysfs() is:
> 
>    dlpar_attach_node()
>       of_attach_node()
>          __of_attach_node_sysfs()

IIRC, there's a long standing item in the todo (Grant's) to convert the 
open coded dlpar code. Maybe you want to do that first?

> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> ***** UNTESTED.  I need people with the affected PowerPC systems
> *****            (systems that dynamically allocate and deallocate
> *****            devicetree nodes) to test this patch.

Can't we write a test case that does the same thing?

> 
>  arch/powerpc/platforms/pseries/dlpar.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index a0b20c03f078..e3010b14aea5 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
>  	if (rc)
>  		return rc;
>  
> +	of_node_put(dn);
> +
>  	return 0;
>  }
>  
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
