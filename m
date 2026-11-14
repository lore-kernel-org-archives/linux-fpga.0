Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669839;
	b=MqXhvEXH9IX1GlbYyH947ixwxjLlAJREzReB9byM5HA0JmdlXoUdPQsx5JQeJq5O2eyH
	 ESqXuskdX2vnEtsjYZqadRIofRPfX4HkyVXIvWLwElWrswY7YHTmIjptn3Vqcrl5Cfkxe
	 O7vtKI9v1UPs/1FkTdTJBrF/tji2J/d6+LMNEaVQHcUrK1z3SJ7CLp+7h3vDeNorgeCUh
	 7YDRyAetEPFxASzyAkLhz4bR4o08+/uihq3kki+bR27IiWK6UW9q7TsMEMboUopvOdxrT
	 p2SDwdwc5gDu5skPzZ6Oxmz6VlKv8zC32RHgUfDcVgv+0tUqO+cRRE5ixumBE1FW/yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669839;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0HmbXb327GJzFT5MXU0MRRM3XV64FYP4EU8RuoGrtuQ=;
	b=EYVq2XZnjQSKnsohgNzU5eA6lm1dTMjrb9vf1q2Fj9hYPQEOFXlUm9RKWp1fll9bS6/w
	 xaLNWYbymq+vdTyzheTROmwxjzBXaokQ0IUdKIwWBmeJyw7guKM6mJpKPtOIlOprzaIUK
	 dwbXVKOwwhM2BnQwnK3rdDgz06XcgSE1s4q870FHKoQvJff2rVXvPUQ2XrwqyX+YXEFHZ
	 U80FyBlGA4MOHpARZTLn61daJKnquShJdHQTr/upbVWnPKyp4k/MskdHdI9fBII7LVepK
	 HeXUWoMwzoPyOO0qwot2S5Chz0Lh6yt3UsdjTsxhhGakmXkhUqvtyJr70DCY9diUpOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VDXcumEv;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A67606A334;
	Sat, 14 Nov 2026 15:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5A67606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VDXcumEv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794669839; x=1826205839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=511xuNfl0NVDcMvVwuYTw6PJvE9bfC2iaNFme+P5uvo=;
  b=VDXcumEv+CqAR1I03MffOtPsJ6W3wVXlBHNcvr34uDG7cmKgHHH63d8E
   oL5qcyq8tvxC0+M6Ph9nrmXdkRDywaxZXjB7/COQNk4Y1AhmDy/5GtDf/
   lVKeqw8YTacWTh5svT7do/RQsElIZr11DFOC11s3AfvcyiiZQKIhpN5cn
   kgYEUmqZ763sfxq6cfJ9z8nZ+A+J1BDbFve74ytAyEhlya3oWgNMS29nR
   QSuwI+b1vsffn9fG64IEU46rzb9KYQHyeKHzkd/3roGiAhzVETItxL0v4
   vMKncmnM6NIsKH05tAJWUJi77VNgPsGlemSyzmxTTkeMfOWO6j0lOO81M
   A==;
X-CSE-ConnectionGUID: EKifLBA7TL+HdYmVL5aMAQ==
X-CSE-MsgGUID: /o6oO5aNRKSjMAHH6+MPZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3497042"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3497042"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 07:23:58 -0800
X-CSE-ConnectionGUID: oD5+JMaFTmieNNINNg1E+Q==
X-CSE-MsgGUID: z23+rWEeS/a5nwxVe21+4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="9239784"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa005.fm.intel.com with ESMTP; 14 Nov 2026 07:23:56 -0800
Date: Sat, 14 Nov 2026 23:15:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: tze.yee.ng@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	Matthew Gerlach <mgerlach@opensource.altera.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH v4] fpga: altera-freeze-bridge: clear all illegal request
 bits
Message-ID: <avh7E5ueMvcp9zE+@yilunxu-OptiPlex-7050>
References: <72504835fca6acc0c6bbed589f5917c8e60ffc74.1794453791.git.tze.yee.ng@altera.com>
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72504835fca6acc0c6bbed589f5917c8e60ffc74.1794453791.git.tze.yee.ng@altera.com>

On Thu, Nov 12, 2026 at 11:43:30AM +0800, tze.yee.ng@altera.com wrote:
> From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> 
> A Partial Reconfiguration Region Controller can be connected to one or
> more Freeze Bridge. Each Freeze Bridge has an illegal_request bit
> represented in the freeze_illegal_request register. Bit i is the bridge on
> freeze interface i. Unlike the status and control registers, which act on
> all bridges collectively, this register reports each bridge individually.
> 
> Writing a literal 1 clears only bit 0 and leaves the illegal request
> latched for every other bridge. Write back the value just read instead, so
> the set-to-clear applies to whichever Freeze Bridge reported the request.
> 
> Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
> Cc: stable@vger.kernel.org # v4.10+
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next, thanks.

> ---
> Changes in v4:
> - Restore the narrative opening sentences from v2; the earlier rewrite read
>   too much like a dense hardware spec (Xu Yilun).
> 
> Changes in v3:
> - Reword the commit message in imperative mood (Xu Yilun).
> - Describe the freeze_illegal_request register layout: one write-1-to-clear
>   bit per Freeze Bridge via the Conduit Merger, versus the collective
>   status/ctrl registers (Xu Yilun).
> 
> Changes in v2:
> - Add "Cc: stable@vger.kernel.org # v4.10+" into the signoff area so the
>   stable-kernel rule is satisfied (reported by kernel test robot).
> - Remove Chiau Ee's signoff as he is no longer working on this patch.
> 
> Link v3:
> https://lore.kernel.org/all/13856736bdb808b64826aab337d9919abeb3ea5c.1791253862.git.tze.yee.ng@altera.com/
> ---
>  drivers/fpga/altera-freeze-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
> index 30d03ba14481..cc0c320538da 100644
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
