Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BE1391;
	Sun,  1 Mar 2026 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370419; cv=none; b=CWEHBWK9oe2mKt5TSfNkX+okruYqu+hx5nX9dQOXx9zJtRvyMIOmQCaec6FMDbLqDGwwjnn8ZdvBIJ3w/lY4bvVmz0NnxmAWxLlNARkPGb1PbnS2uO3f6FJOPZrCW2Y++1FRW93Qn18NeOqXqgwKHKme9ITlZaVjzR6IDDZUt64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370419; c=relaxed/simple;
	bh=vHy26NGPRM/WjxyX+Tq8QehanyjBlS0j6raUBORnLko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qv8G4CFaNoQ8iKVv/+m/0D7EFzraPiRSiG8Kxx6ZRUfSCabmbtt6Tez6xyHC6iY1H3wNVnmLocvTsswJkG7HVvBOH3mKkqfDOrgLVLmZ7ISchbHTRTRYLffvBOE7GnbWhBuGzLHYguDXhOHcvT6XNPRM9vJOj2jYsoh2qgpFJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee4auBRu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee4auBRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE32CC116C6;
	Sun,  1 Mar 2026 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772370419;
	bh=vHy26NGPRM/WjxyX+Tq8QehanyjBlS0j6raUBORnLko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ee4auBRuikLY7/Ds/HY+esT3iorzSwdVxGUHA1GQ748/s+VmMk68OApP5VpTib2Sc
	 srHkEvgiiU5B5TCm5Mp9qBjeiraFfisAkIOvIjV5Wti3xEz+a08dGFMCbOfy15PEOp
	 M2KfyG4DD7vbyYwnMBo9pmdobHcKBlrytwDHFKJkRCS8za/GiZT8cMj6IMqzWdBoe7
	 vn4vMBfu4F4zNHl+nimsKFPIr+YH1fKu+lXQHlfdm4W/Q/n+IZva99/iPkZktulJxx
	 oRuJ8anQ+B0VT4+TGL3msL8ZF8Vdn0+zF5Qj3vrBos4Be35bO8aayEzQ4zPW4jDDYm
	 hSxlYdUjpAECA==
Message-ID: <2520266b-e2ee-4a74-8696-55adc5b9ae91@kernel.org>
Date: Sun, 1 Mar 2026 07:06:57 -0600
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] fpga: bridge: Use str_enabled_disabled helper in
 state_show
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@linux.dev>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260224161504.587562-1-thorsten.blum@linux.dev>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260224161504.587562-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On 2/24/26 10:15, Thorsten Blum wrote:
> Replace hard-coded strings with the str_enabled_disabled() helper. This
> unifies the output and helps the linker with deduplication, which can
> result in a smaller binary.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/fpga/fpga-bridge.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index ca68c38aa4a1..e8ff3e3bf2fc 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -12,6 +12,7 @@
>   #include <linux/of_platform.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> +#include <linux/string_choices.h>
>   
>   static DEFINE_IDA(fpga_bridge_ida);
>   static const struct class fpga_bridge_class;
> @@ -305,7 +306,7 @@ static ssize_t state_show(struct device *dev,
>   			return state;
>   	}
>   
> -	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(state));
>   }
>   
>   static DEVICE_ATTR_RO(name);

Would you consider including this patch[1] to this?

Dinh
[1] 
https://lore.kernel.org/linux-fpga/aXH2D06eZ5DRTVi0@yilunxu-OptiPlex-7050/
