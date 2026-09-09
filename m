Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444D492E4D;
	Wed,  9 Sep 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939941; cv=none; b=Z9hdVEeoDfmUlNEmxJncohfi+SlGEB1+NJwLgZ/lgGDkGAmmXoTd4WH7ieaTDt0dNq4F4qjfzyZKAZi062G4oiyAADXeN1+2mc/h41PFt8FYgWyu1m8SkklCL9JUdr4F7+kQyNBKw7UqplLqHkiVIsS8o4Z3d8QamoolN5dh7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939941; c=relaxed/simple;
	bh=BykUejFK5ljKcbR1mM3gAEgwx+ZO2lZhl5enbSQZ+Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZLsOeW+4uGCeurtDctrTvcn/tSthwQGSZFYaJT55jGXlqY5zQ4ot4chFqa4RUY+x4Jg/PlOSGcex7azrVH3ykrj1+dG+4wcA8q0WiSyqXXqHPn+KGrtZaQif+RRVsjc/8tbwLykOdsX8Gkdkdrwfn1RfcOHFrm8S/1NLyO6/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGeUMUWl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGeUMUWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788939940; x=1820475940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BykUejFK5ljKcbR1mM3gAEgwx+ZO2lZhl5enbSQZ+Rc=;
  b=RGeUMUWlnlXyJspHhN1QR63tz4fxl7/3Itsk5AfZfUFHUhBG3MBrjwP9
   1z/LqXPvJONbKRC25HZc9NNG/3i3VCq8RdS+uCN04H2kROMwLzLy4xund
   /lDP+cU8mFr8PYz+jXJG8ylVl0SnouY07+8JGSv9AKYyi3ES/T+V35Jh/
   dGSRwKDuQT/fhE1tzeFbOv5dGR8HYEkT2vRO1ZiW3p37iiipUA5xpfx5d
   HklwftCQWD7VqSdWW9BZ84IkjUY+WY7fJgtwUFZjq5tDztBYFb/GscvyP
   +kYxI2YPwctG+pxUOshCFS88/0iOEZghL97Wo1YCjJRmsG7W6nCcptX6d
   g==;
X-CSE-ConnectionGUID: YWxEbZjaSrCVkh6Kv1aYMA==
X-CSE-MsgGUID: MLp8a0VRQrOsrzfMNtPVoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="76915763"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="76915763"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 00:45:39 -0700
X-CSE-ConnectionGUID: uLeRUXlbQgK70URCcSVZug==
X-CSE-MsgGUID: uqVVDHIMQqika+qL2VWDrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="265035318"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa009.fm.intel.com with ESMTP; 09 Sep 2026 00:45:37 -0700
Date: Wed, 9 Sep 2026 15:45:37 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yang Zi <2959243019@qq.com>
Cc: yilun.xu@intel.com, trix@redhat.com, mdf@kernel.org,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: Fix NULL pointer dereference in
 dfl_fpga_feature_devs_enumerate()
Message-ID: <aqEOocAGuV6G6xee@yilunxu-OptiPlex-7050>
References: <tencent_EFA15EDE0B67CF3347A9EFD9A05E6A620D08@qq.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_EFA15EDE0B67CF3347A9EFD9A05E6A620D08@qq.com>

On Tue, Aug 25, 2026 at 05:08:42PM +0800, Yang Zi wrote:
> The build_info struct (binfo) is zeroed by devm_kzalloc(), but its
> sub_features list head is not initialized there; INIT_LIST_HEAD() is only
> called later inside parse_feature_fiu().  If parsing ends without ever
> reaching parse_feature_fiu() (for example, when every feature header in
> the list is an unsupported type), binfo->sub_features is still all-zero
> instead of a valid empty list head.
> 
> build_info_free() then runs list_for_each_entry_safe() over that list,
> which reads head->next == NULL and dereferences a NULL pointer.
> 
> KASAN report:
> 
>     BUG: KASAN: null-ptr-deref in build_info_free drivers/fpga/dfl.c:950 [inline]
>     BUG: KASAN: null-ptr-deref in dfl_fpga_feature_devs_enumerate+0x59ba/0x60d0 drivers/fpga/dfl.c:1611
>     Read of size 8 at addr 0000000000000000 by task syz.0.2/1096
> 
> Initialize binfo->sub_features right after allocating binfo so that
> build_info_free() and the other sub_features consumers always see a valid
> list head.
> 
> Signed-off-by: Yang Zi <2959243019@qq.com>
> ---
>  drivers/fpga/dfl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 4c63c7c8579b..6377304e4447 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1589,6 +1589,8 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>          goto unregister_region_exit;
>      }
>  
> +    INIT_LIST_HEAD(&binfo->sub_features);
> +

You patch format is broken, I can't apply.

>      binfo->type = DFL_ID_MAX;
>      binfo->dev = info->dev;
>      binfo->cdev = cdev;
> 
> 
> 
