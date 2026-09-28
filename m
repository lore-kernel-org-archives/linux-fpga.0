Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198C49A3DF;
	Mon, 28 Sep 2026 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591259; cv=none; b=mWR1mfZ0qAZLkdf6HtsxJjJ6XlY57/vx6f68BoOein4M3ILmrovGZUrYAB8cGysT/qmo/tM+Y4ZU60Qsw1xcDU0JPBNVXRjE6h4CNbMqd8OB77SvJkSzRxxYhKVwiR59jBEcv/nm9ItU8m5EW6jR3UWQrjYp37YLvclb4Nbt/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591259; c=relaxed/simple;
	bh=4GgBiDeM9ttxkZ2Jswvw/Rvy/TFh+4kQtgB/Dp8kUw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfx72o6yIWFCY12eVbjPss7UdnFZlYI9YYyq1iPyTNnU+EIegvXVzE08y/GT2ZSdMN8IrMkAWUSoKS18koDOhmknbYQ95SSk3zmEq7T6FmjiqJHbTBgJGVDn7XF8kWrnbPZgzcW7BNOv/FAyPgKQ3n5YQp8W479BiOkTg9gaBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUAISSU3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUAISSU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790591257; x=1822127257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4GgBiDeM9ttxkZ2Jswvw/Rvy/TFh+4kQtgB/Dp8kUw4=;
  b=KUAISSU3ZKtImZigF+ZQpThgAtV8Go5Do6hHY+7pC2kL1Icc730Hu4iS
   JD+iSHVtKhDHN88DzG/x2PQxJiGDt64ZObnv0S+kJU5VKVhVMChLL+0IK
   B0lttEWexjxGs4J4bF1//bzgBv0zjO+wxdWN+922KaaM0ttNW/YQChmKw
   tBBl0ZFvbbe6OjNKaI7mq/fnLWthrPLjQPh0IUos8xGxrJ6h7iF2regm0
   hJpITIT4Q8rj3zzdzDsSWtO4/31CcCmp6e1HOKnhVLn4egWgmJsi45tnI
   rCI9vF09Ym4BxcG7yyPdIfGuIP3UlNnd+FmthxBPSSsU27XCI6fBGy8yQ
   A==;
X-CSE-ConnectionGUID: 6fJCiVNVRqiQIOARSZ+7Ug==
X-CSE-MsgGUID: cAkpQPAfRlWbmR/s7V4iRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="78850921"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="78850921"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:27:36 -0700
X-CSE-ConnectionGUID: gklnNkmITqKvFslsk2rbyg==
X-CSE-MsgGUID: FuYREMpwSoKjQ0ZdnCbkXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="283093315"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa005.fm.intel.com with ESMTP; 28 Sep 2026 03:27:33 -0700
Date: Mon, 28 Sep 2026 18:25:46 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: tze.yee.ng@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Matthew Gerlach <mgerlach@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH v2] fpga: bridge: incorrect set to clear
 freeze_illegal_request register
Message-ID: <arpAqkvuFSB6+EAn@yilunxu-OptiPlex-7050>
References: <2fe34c2dec61150a39d21e067521b0acc031247c.1789956938.git.tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe34c2dec61150a39d21e067521b0acc031247c.1789956938.git.tze.yee.ng@altera.com>

On Sun, Sep 20, 2026 at 07:23:51PM -0700, tze.yee.ng@altera.com wrote:
> From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> 
> A Partial Region Controller can be connected to one or more
> Freeze Bridge. Each Freeze Bridge has an illegal_request
> bit represented in the freeze_illegal_request register.

Why only this register reveals details about multiple bridges, while
other registers always operate on all of them? And how can we understand
which bridges are actually in use.

> Thus, instead of just set to clear the illegal_request bit
> for first Freeze Bridge, we need to ensure the set to clear

Imperative mood.

> action is applied to which ever Freeze Bridge that has
> occurrence of illegal request.
> 
> Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
> Cc: stable@vger.kernel.org # v4.10+
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Taking over this patch from Tanmay.
> 
> Changes in v2:
> - Add "Cc: stable@vger.kernel.org # v4.10+" into the signoff area so the
>   stable-kernel rule is satisfied (reported by kernel test robot).
> - Remove Chiau Ee's signoff as he is no longer working on this patch.
> 
> Link v1: 
> https://lore.kernel.org/all/20250311151601.12264-1-tanmay.kathpalia@altera.com/
> ---
>  drivers/fpga/altera-freeze-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
> index c24c976117c8..2591dcc53d83 100644
> --- a/drivers/fpga/altera-freeze-bridge.c
> +++ b/drivers/fpga/altera-freeze-bridge.c
> @@ -51,7 +51,7 @@ static int altera_freeze_br_req_ack(struct altera_freeze_br_data *priv,
>  		if (illegal) {
>  			dev_err(dev, "illegal request detected 0x%x", illegal);
>  
> -			writel(1, csr_illegal_req_addr);
> +			writel(illegal, csr_illegal_req_addr);
>  
>  			illegal = readl(csr_illegal_req_addr);
>  			if (illegal)
> -- 
> 2.43.7
> 
> 
