Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2393B27DB;
	Wed,  9 Sep 2026 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937012; cv=none; b=Ni1tRGtW/DyLiejoEfra4wAYI7RtG5Akdbo4T6CoEh7jKwzl4S+htWisTX9VwS4XgaD8pnoCufk3nPeYH8b/c5Pl8sa+m6LOJ9HLRGL4GtWQo2PNBUMtiUDvOKB5JV9thfjXyIUFlAd4ie1qMHBprMvaghgPSP8HFR2x19E+GMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937012; c=relaxed/simple;
	bh=Yc5xclrqSmERpgC5f27PtXqO+XkTKGqa9fZR4rbq/mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kejB2McnEp68InCX/qEgo0/+m9Y0DOjKyejoOkyTpmbN5vL12FAWrtzzOLiLD0eSeOV3qZ8dx2ksiDjEOyIxLd4EL+LnVJPd6WBZRx4h4MooWiK1aqP+PJd2x883OgzA4pGsqFI0P9IopOR/MVYUvbJF8MLqZ6m8B4QavicsxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJ/aZOJK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJ/aZOJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788937009; x=1820473009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yc5xclrqSmERpgC5f27PtXqO+XkTKGqa9fZR4rbq/mM=;
  b=lJ/aZOJKWG4uMIL3/zufJxaye+ET7KMA1UOBGi+q1gLj5+RMQJafegsi
   oJ+lbYNuYr7Hqj4tLyp7D/TEgmnvDdaqLIcTpgVyzCMjpyEVFU7EpklyO
   7Tz+4G7p43povXqoG8+iRo+4jqotA/q64VxdiAg5CX+0Wp9G5aqi7ieHH
   XVL8D+futajIVtyFBnHzWn0CnX5OwGbygL11KfkSAyTLHZMjX9SM0RBRJ
   YBUzCVlEF3LSOxB6jiSnrQBblfaUZr8vZrtqzcA22xyfqIRIgh2qeYcws
   7RwbpXBCzZJjBGz7t8wgRGom8e4WdOIwNLx4qIFDKhxbRmhv9WqqLGoFX
   w==;
X-CSE-ConnectionGUID: s4Ui5Vd9S4OCx3cI3GBcEA==
X-CSE-MsgGUID: k//7Km7VSsWuwnKqtQcuIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89276129"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89276129"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 23:56:46 -0700
X-CSE-ConnectionGUID: ai4jzfNoRj2xXBd/DiwtsA==
X-CSE-MsgGUID: RxkyeNY4S2q/DVZ0TcdT9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="270739671"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 08 Sep 2026 23:56:45 -0700
Date: Wed, 9 Sep 2026 14:56:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: fix typo in s10_ops_write() comment
Message-ID: <aqEDLPv1M4wD0JH+@yilunxu-OptiPlex-7050>
References: <20260907044344.3130-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907044344.3130-1-hemanth.selam@gmail.com>

On Mon, Sep 07, 2026 at 10:13:44AM +0530, Hemanth Selam wrote:
> The comment reads "reuse it to send more data or free if if all data has
> been sent".  The first "if" is not a repetition, it should be "it", to
> match the "reuse it" earlier in the same sentence.
> 
> v1 deleted the second "if" instead, which left the sentence without an
> object.  Xu Yilun pointed out the correct reading.

These change history should not belong to the changelog. Put them under
--- so they won't appear when applied.

> 
> Only touches a comment, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/fpga/stratix10-soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index b8ec2e6f615f..5aed560050c2 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -286,7 +286,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  
>  	/*
>  	 * Loop waiting for buffers to be returned.  When a buffer is returned,
> -	 * reuse it to send more data or free if if all data has been sent.
> +	 * reuse it to send more data or free it if all data has been sent.
>  	 */
>  	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
>  		reinit_completion(&priv->status_return_completion);
> 
