Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C73876C5;
	Thu, 26 Feb 2026 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772087621; cv=none; b=WnNG7tNA+BVPDzYjGinTtCH9ZCRTW0SuSyR6AIWMa5NSSLe/WMbNmOxpBXkmV2CS/cJ5MM0R4lcnpwrAVIKb0cK3AoCISBDoJGASwGdfSn1K8Lbt6A15lf7XIg+twp07UvLhJDz4XnMAp9hrduKN1aHyoBX7n7UwRicpE/2hBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772087621; c=relaxed/simple;
	bh=b6ro6E4AcTkYaQZZ43ck0/UhXy75tRTVBwAgEJ/59ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGQkHwnESIlA9cbJxZ1BqZWYxsqBFYy6P5Qp2/Zs6FXV374LnW1WBLqmKSfSNkN53JjK0i5ypMzj5C6mehOgDl8M8JgZOX1d8IjxWHcbVUT+eukRmQJtUJ3U3Z8HD9qviluskabg8geCu3w/wowhK2CS1Mp7zd+RXw7KPjeH6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBeIy9yy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBeIy9yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772087619; x=1803623619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=b6ro6E4AcTkYaQZZ43ck0/UhXy75tRTVBwAgEJ/59ds=;
  b=JBeIy9yylCgImbJKy+I39wgP7G0Mb+auUoJF2WKek1S47uRqIHCvZw61
   P4nuO0AYZErCuPws4UCCKcbDLY0qQSitf++F2dfI4I5mvucJNSI+7NCuc
   coyFxvirP6QwoZcJLlLShjctjnJF5yyRPqEAY0s/YjQi6cg4pxRAlaBLs
   RV92qFpfb7OYyYomERtabqY4EUnn42xEbf+70hiooSWcY8sD3i0QdITRX
   uYWAXHhHD02yY9q8dsr6Hc+g0axupsxTp9wuheZyhV7ZY6pQZzrR4FC/u
   0+sZFthtCazR39lufWmMbGNNopvQ+NUvpZvCjjt5j+hiQhbJ+o4p+H3Mg
   Q==;
X-CSE-ConnectionGUID: jMATT015Sj2hLdPBl2A2vA==
X-CSE-MsgGUID: 1h22O+waSw+piWUfj20vEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="76974528"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="76974528"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 22:33:39 -0800
X-CSE-ConnectionGUID: 4gJiFKf1RBy7t0oiRuowdQ==
X-CSE-MsgGUID: rjjTvDidSja4DIV7SOlkSw==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 25 Feb 2026 22:33:37 -0800
Date: Thu, 26 Feb 2026 14:14:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: adrianhoyin.ng@altera.com
Cc: dinguyen@kernel.org, mdf@kernel.org, yilun.xu@intel.com,
	trix@redhat.com, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ang Tien Sung <tiensung.ang@altera.com>
Subject: Re: [PATCH] firmware: stratix10-svc: support up to 4 buffer claims
 and extend timeout
Message-ID: <aZ/krGA++52zXM9u@yilunxu-OptiPlex-7050>
References: <b67ffe732654c7db86c4b5d987af92dcc12bf4f3.1770706895.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b67ffe732654c7db86c4b5d987af92dcc12bf4f3.1770706895.git.adrianhoyin.ng@altera.com>

On Tue, Feb 10, 2026 at 03:16:42PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> The service layer previously only returned up to three buffer addresses
> per transaction. Extend the logic in svc_thread_cmd_data_claim() to
> collect up to four buffer claims. A new field `kaddr4` is added to

Why previously use 3 buffers per transaction, and why now use 4, not
5, 6...  I.e., I saw some association from struct
arm_smccc_res::a1/a2/a3 so we used 3 buffers previouly (correct me if
wrong). But the 4th buffer seems pure SVC decision so please elaborate.

> struct stratix10_svc_cb_data, and the FPGA manager callback unlocks this
> fourth buffer accordingly.
> 
> Timeout values for reconfiguration and buffer transactions are also
> increased (from ~300–720ms to 5000ms), since real-world processing takes
> significantly longer (~600ms or more). The reconfiguration complete
> timeout is also replaced with S10_RECONFIG_TIMEOUT (>1s) to avoid
> premature aborts.
> 
> Additional changes:
> - Callbacks are updated to pass all claimed buffers to clients.
> - Debug logging is added to trace received status values.
> - Simplified buffer wait logic in s10_ops_write() by always using
>   wait_for_completion_timeout().

The patch includes too much independent changes which makes reviewers
hard to distinguish which line is for which purpose, please split your
patch into a series. This also gives chances for you to explain why each
change is necessary or nice to have.

> 
> These changes improve robustness of FPGA configuration on SoCFPGA
> platforms by handling larger transactions and accommodating realistic
> timing.
> 
...

> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 0a295ccf1644..4fea9458f92b 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -147,6 +147,7 @@ static void s10_receive_callback(struct stratix10_svc_client *client,
>  	u32 status;
>  	int i;
>  
> +	pr_debug("%s data %x\n", __func__, data->status);

I'd prefer you delete it when you think the patches are ready to get merged.

...

> @@ -353,7 +348,10 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>  	unsigned long timeout;
>  	int ret;
>  
> -	timeout = usecs_to_jiffies(info->config_complete_timeout_us);
> +	/* The time taken to process this is close to 600ms
> +	 * This MUST be increased over 1 second
> +	 */
> +	timeout = S10_RECONFIG_TIMEOUT;

This was a configurable option and you now hard code it, I don't see the
rationale.
