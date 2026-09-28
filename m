Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11794B95CF;
	Mon, 28 Sep 2026 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596874; cv=none; b=aevg8TvAi10F73nnkwmWeyyfwOkOdspBYcvBmVwmYvrsArnVPPyy2WVz8/pjZ+MiS3RZfoOk6i4ZGGwMv8ZNZQARWojWPrjWdWMnQv+Jaw57wRXsQuPz74d1jC3BDluJMiznysqaNxkwB+aCW0AA9MADhjMmJJtsvE1o7Zis2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596874; c=relaxed/simple;
	bh=xMP3M3WgJm5VnltIoTZFc+aP1Rh9+ekdn2gQcbYIpsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neGnswQJbBH77AYPteRZECfgUkSU1e4YR3m6Ux9hLXjO2p/zvxeXRRiEb6PVvvpHKYWjQfSV9waeiB3JR/g64urYeTRVSkMT126hPmdo+IZTuDCWEP2PdWtQcSpHd3QoV951KDLUfV/NputejZWnl8Q7uHHLBC8mfOXe70ea5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iq2kg31U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iq2kg31U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790596872; x=1822132872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xMP3M3WgJm5VnltIoTZFc+aP1Rh9+ekdn2gQcbYIpsM=;
  b=Iq2kg31UsXW0sZX0GoVghgUCfikJKZ+zTFI+H/YrKZDCaX1D/+3RURd1
   vTKcDxzrToGBAGZkdcNIeJsgFbasYXTFmllRMMEef0mYpaqm4lHPwiNak
   gdp/GSEB5fntr7bX8J65fiE/Rhz0b0W6m7efwU0uIPJpkVAVbI8rI25sR
   yJp7SORZl+7dV027eSRqIk6FE4oZ4qlkXaLcpI58gE8xZ9C7ZnoXVlZoo
   FgJacNbhV+CeDqKvF8ZXFUpjfXWr12HcBM3j3tdlqgHebdqqr64gWk1t0
   wbWYp8YL97zZP+Fmi+TlWMaGQUu0tMyzpJkKv11TnLD+dJ53whTM/3YgS
   g==;
X-CSE-ConnectionGUID: vcZewq7uQvKj9vX+jrAFqw==
X-CSE-MsgGUID: dY/TdANSQ8OC9HjD3rmKZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="116822477"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="116822477"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:01:12 -0700
X-CSE-ConnectionGUID: m7CIGqNKRvWLwid7ZbdATA==
X-CSE-MsgGUID: VJNtekeVTw+4jbpjRxiWBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274258697"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa010.fm.intel.com with ESMTP; 28 Sep 2026 05:01:10 -0700
Date: Mon, 28 Sep 2026 19:59:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] fpga: stratix10-soc: prefer ERROR over BUFFER_DONE
Message-ID: <arpWmvYkDRBIqpif@yilunxu-OptiPlex-7050>
References: <cover.1790090287.git.adrian.ho.yin.ng@altera.com>
 <77007ef350addaec2d9a9e3bfe90f4c303281893.1790090287.git.adrian.ho.yin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77007ef350addaec2d9a9e3bfe90f4c303281893.1790090287.git.adrian.ho.yin.ng@altera.com>

On Wed, Sep 23, 2026 at 12:02:42AM +0800, Adrian Ng Ho Yin wrote:
> Check SVC_STATUS_ERROR before BUFFER_DONE so a combined
> BUFFER_DONE | ERROR callback aborts instead of being treated as success.
> Clear priv->status at the start of write_init so stale bits cannot leak
> into the next reconfiguration.

There is also a COMPLETED | ERROR combination, does it need the same
handling?

> 
> Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
> ---
>  drivers/fpga/stratix10-soc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 3ba0ffa1d9e0..c16ed571630b 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -183,6 +183,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	uint i;
>  	int ret;
>  
> +	/* Drop stale status bits left by a previous aborted write. */
> +	priv->status = 0;
> +
>  	ctype.flags = 0;
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_dbg(dev, "Requesting partial reconfiguration.\n");
> @@ -319,6 +322,13 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  		wait_status = wait_for_completion_timeout(
>  			&priv->status_return_completion, S10_BUFFER_TIMEOUT);
>  
> +		/* ERROR must win over BUFFER_DONE when both are set. */
> +		if (test_and_clear_bit(SVC_STATUS_ERROR, &priv->status)) {
> +			dev_err(dev, "ERROR - giving up - SVC_STATUS_ERROR\n");
> +			ret = -EFAULT;
> +			break;
> +		}
> +
>  		if (test_and_clear_bit(SVC_STATUS_BUFFER_DONE, &priv->status) ||
>  		    test_and_clear_bit(SVC_STATUS_BUFFER_SUBMITTED,
>  				       &priv->status)) {
> @@ -326,12 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  			continue;
>  		}
>  
> -		if (test_and_clear_bit(SVC_STATUS_ERROR, &priv->status)) {
> -			dev_err(dev, "ERROR - giving up - SVC_STATUS_ERROR\n");
> -			ret = -EFAULT;
> -			break;
> -		}
> -

I think these command handlings in this series are much of the same
style:

 - init a completion
 - send command
 - wait_for_completion_timeout
 - check error status
 - check successful status
 - stratix10_svc_done

Now they are really a mess, hardly reviewable. Is it possible we make a
helper to regulate them?

>  		if (!wait_status) {
>  			dev_err(dev, "timeout waiting for svc layer buffers\n");
>  			ret = -ETIMEDOUT;
> -- 
> 2.49.GIT
> 
> 
