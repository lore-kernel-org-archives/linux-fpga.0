Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D4369D55;
	Mon, 28 Sep 2026 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597785; cv=none; b=uE1B3h6ltUgkZ2NFzqV7i9TZUNQ/33DLmJ4gPk6Amgao7EQU32rFQqJrGgkUQaqxzKDUogVsPP+06QQAWm/iRDcwpfYJy05dPF91HIj19GxMYnc80NrEqkeV100+Jxv4+j0+BYz46/GsQ1iKVr9dFX6Qjzj8taFvnO4hJ+5h7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597785; c=relaxed/simple;
	bh=CIvwWP0bqGSZZNJmUwJ0WPPvV/yKpz6EAM44HziEB8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ6PGrbQr3ZMMu8XFGwmYlQkxLn2kofRcm+N8u2XQt02C4KGFd+juCg+lqLgZjhwji+7jxlM2VOqiIuoKulU1326fai9g1w/Y3yc63ORuHEQjHw1UuTkw5m8DVrlIkdWVSKQS94IgExUrTKxrqzNR/urTISSgR7a2jLt2J7wEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiAtJvLv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiAtJvLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790597783; x=1822133783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CIvwWP0bqGSZZNJmUwJ0WPPvV/yKpz6EAM44HziEB8o=;
  b=QiAtJvLv20sLBpDD4COR2SA48r6c9lZhrcol4yzlFmxFvuVW7IZASR4f
   DQF+8wfS6OYy8oYB1yFlDP1Wy4Q2nguPbm9J8yrG5Y3FIXdXv6hZVyhVy
   uOTF6NqXZo0UXAH9yugyBgmWYyOcqtJQawan5At0SkgftLOxwUE6MbtZn
   brEHYLt8+HeByqIfSWcfNQr/vIaOi0tO3bV7WMBTTKMBdtOjy+JTxHz56
   6XKezxsUHmPYRkj0ll1MBeLf8adVurHma5iE+iHTVI/lkQui/38vsE0Mf
   CTEFjrrbNfV9cWg2FJNF5AoiB7257iD0MmzJ0U9VGWfkb02gFJbnPtAid
   Q==;
X-CSE-ConnectionGUID: E2RW7qVbQzySfEF3HdOkxQ==
X-CSE-MsgGUID: vDZ6TvIHQTan4TEJKXmOnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90423086"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90423086"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:16:20 -0700
X-CSE-ConnectionGUID: 7QbPy/wqSx695brhaS3o1Q==
X-CSE-MsgGUID: 29ARU6MVSDmxoeH3JEAAeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="273177537"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2026 05:16:19 -0700
Date: Mon, 28 Sep 2026 20:14:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fpga: stratix10-soc: floor config_complete_timeout_us
Message-ID: <arpaJ7z+hOAASQMk@yilunxu-OptiPlex-7050>
References: <cover.1790090287.git.adrian.ho.yin.ng@altera.com>
 <c2dce10175d54bd39fe3a9dd1a0ab783a62095f3.1790090287.git.adrian.ho.yin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2dce10175d54bd39fe3a9dd1a0ab783a62095f3.1790090287.git.adrian.ho.yin.ng@altera.com>

On Wed, Sep 23, 2026 at 12:02:43AM +0800, Adrian Ng Ho Yin wrote:
> Keep info->config_complete_timeout_us configurable. of-fpga-region
> leaves it at 0 when the DT property is absent, and usecs_to_jiffies(0)
> makes the wait return immediately. Reconfiguration also takes ~600ms in
> practice, so enforce S10_RECONFIG_TIMEOUT as a minimum floor while still
> honouring any larger caller-supplied value. Note this prevents a DT
> property from lowering the timeout below that floor.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
> ---
>  drivers/fpga/stratix10-soc.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index c16ed571630b..83590e6b405f 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -7,6 +7,7 @@
>  #include <linux/completion.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/firmware/intel/stratix10-svc-client.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> @@ -360,7 +361,15 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>  	unsigned long timeout;
>  	int ret;
>  
> -	timeout = usecs_to_jiffies(info->config_complete_timeout_us);
> +	/*
> +	 * Keep config_complete_timeout_us configurable. of-fpga-region leaves
> +	 * it at 0 when the DT property is absent, and usecs_to_jiffies(0)
> +	 * makes the wait return immediately. Reconfiguration also takes
> +	 * ~600ms in practice, so enforce S10_RECONFIG_TIMEOUT as a minimum
> +	 * floor while still honouring any larger caller-supplied value.
> +	 */
> +	timeout = max(usecs_to_jiffies(info->config_complete_timeout_us),
> +		      S10_RECONFIG_TIMEOUT);

Basically I think config_complete_timeout_us is used in a wrong way. You
can refer to other vendor fpga driver for reference.

>  
>  	do {
>  		reinit_completion(&priv->status_return_completion);
> -- 
> 2.49.GIT
> 
> 
