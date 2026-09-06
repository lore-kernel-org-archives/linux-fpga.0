Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA721CA03;
	Sun,  6 Sep 2026 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709298; cv=none; b=WQXkIcg6vh1f3dI8Uh4jkSWTeg/vKoREIM/U8j9UhlhqNu64MKYtK04ndIPOhBFga6AmK9MnpXyKKpD7j2Z9Kwl0yw1QmvMOoVYnpX8GMt/jYTymHmrPpteIj+R2Abe733SLFiKVzg73VerEeoviUXtpPdGCQ69mVJVKXdttQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709298; c=relaxed/simple;
	bh=cJwXGpezGuktasyLX67ghytsMF5jbSeh8SXFTrfB3Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUN47jVcilHAVhxWrWTmXE61rOlFC/sBVr9eR3+CCQJ7Zv+3sDukD7Js6Pcplq3IbbuZQribc/my3XtZIHHheAFbBt9V7KL4O7nC+ByM2JlJ9vpWmr+J9UhK+CxyVSTjDK0mubCwZB6QeQ9+dUoMxdJ53PsfGfx6KHR1fRvqO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+i1+6L1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+i1+6L1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788709296; x=1820245296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cJwXGpezGuktasyLX67ghytsMF5jbSeh8SXFTrfB3Gc=;
  b=M+i1+6L1jsG0gwyPJoGRGxDgo7iMoD8bfC/84ao3k/L4wBAXWiXBRs0F
   7DZmdho2kFLD7PdRuPFVuv45EgmJ57oO9VouLoqHvBjatX4nfrzpmVinh
   EfeTYGW00NiyGkVBWSYwG+GpBbspCmBBKIXyvZj47kLr2fChTxCUM10PF
   V7xq1WkeNrNUDoRA9xadGD05AnobVr1ghDkB4CZrhoFttdQXLngUI2L5g
   QsuebyxxlCbSgMQwDoiZqSlWyOVyTlYln7mX2cWChkSQewg3Yt+IpxdeA
   B02Lk+ILwDsb6gYnNWIDXTsgbsaa04Bo0EX2nm4su/33JBLvqzhcGnnfV
   w==;
X-CSE-ConnectionGUID: CeADNT1aSoyb4z8r/t/dOQ==
X-CSE-MsgGUID: pE87na6uSjycL+8Hmp8YwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="111907154"
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="111907154"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 08:41:35 -0700
X-CSE-ConnectionGUID: ErJtXON2TmSOojpeA6YL/Q==
X-CSE-MsgGUID: pUzdu9oHTRy+XvZDeTGtHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="266814093"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa010.fm.intel.com with ESMTP; 06 Sep 2026 08:41:32 -0700
Date: Sun, 6 Sep 2026 23:41:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: fix repeated word 'if' in comment
Message-ID: <ap2Jq537MhIpI5OW@yilunxu-OptiPlex-7050>
References: <20260904112153.35820-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904112153.35820-1-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 04:51:52PM +0530, Hemanth Selam wrote:
> Drop the second 'if', reported by checkpatch.pl as a possible repeated
> word.  Only touches a comment, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/fpga/stratix10-soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index b8ec2e6f615f..c08d60e3c85f 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -286,7 +286,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  
>  	/*
>  	 * Loop waiting for buffers to be returned.  When a buffer is returned,
> -	 * reuse it to send more data or free if if all data has been sent.
> +	 * reuse it to send more data or free if all data has been sent.

The actual fix should probably be "free it if ...“, right?

>  	 */
>  	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
>  		reinit_completion(&priv->status_return_completion);
> -- 
> 2.48.1
> 
> 
