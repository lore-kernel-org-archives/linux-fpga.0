Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0B3546C0;
	Thu, 23 Jul 2026 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778287; cv=none; b=u9jqNEKdOUI9GEWw4zY8Df+98JIDlldE0jVqnFNjIhhts0DVCmcXUMxjkT5xaApRlF8xii+euN5v8a2qBXqskzwW70ogoQNYC/pJw0j3rQE/oRqBg6qjyIxjVTMcRs2LzWPzcuUtCCeAB/58ng+Txa+L0Km1873QKQ50ok8db50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778287; c=relaxed/simple;
	bh=oeAMizry9CUPvQ6+LAto0AGen856F2IGVxawkLdkVmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpm+h6AdgutGLQylfL5tcFE3ZM4CZnwkg11vwBOJ8Ur/0RuYFuewg/4AiLCv/LmBljAxmxrNIq+K6DpqUkuPhf5+Bc52NWhb1E81MtKvVXIhHX4TQju503S/WXlsNjZtgRBT/w5lMRE5Ene85QvDWteRWRSBe1FbnXIj81FYAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuekZqEP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuekZqEP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784778286; x=1816314286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oeAMizry9CUPvQ6+LAto0AGen856F2IGVxawkLdkVmI=;
  b=NuekZqEPhwlggpQaIpyOyrHGxnHcERWxq/sT9tLIRvNgxpq8UuYhQXpM
   DJKBxFKNPVVkhPY6tWpf5cG4ObGRqrq1/rB6WuTMroGKGR+F7FVHsFWS/
   u6Gl4wa6+HwZjsnQqmeBsq0kzUWDPLYAlKYqS0Q88/AOzf1EJR3vAQGH1
   0r5ntvegotA7b8F1heLyyUy4aCCyESnNh2C5IOgDzJZSJs0RWNMg4qwAU
   7dACdX3O/nW2kNYVhIpr9AuH8eja7m9hPi9nimgpLt9jnWcHNDxU6b5nZ
   LS5ryJPAwWtd17cJsubLdxH2Wnm57mY1FlmibjoOhX0FT4Ada7Cy6VQah
   A==;
X-CSE-ConnectionGUID: 1VOm5eqKTXiIWSzogZZpxQ==
X-CSE-MsgGUID: FK+eMudSSAylfgjUrpsVcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96082585"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96082585"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 20:44:44 -0700
X-CSE-ConnectionGUID: XsbGTTwvTEy+pne01+QB7w==
X-CSE-MsgGUID: OXVFDtZfQq+1x+XeRz56zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="262610136"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 22 Jul 2026 20:44:43 -0700
Date: Thu, 23 Jul 2026 11:44:41 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: yilun.xu@intel.com, mdf@kernel.org, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daisuke Matsuda <matsuda@preferred.jp>
Subject: Re: [PATCH 1/2] fpga: altera-cvp: Avoid out-of-bounds read in
 trailing byte write
Message-ID: <amGOKc18X030Abt2@yilunxu-OptiPlex-7050>
References: <20260701092633.5146-1-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701092633.5146-1-dskmtsd@gmail.com>

On Wed, Jul 01, 2026 at 09:26:32AM +0000, Daisuke Matsuda wrote:
> From: Daisuke Matsuda <matsuda@preferred.jp>
> 
> The trailing byte path in altera_cvp_send_block() dereferences a u32
> pointer even when only 1-3 bytes remain in the input buffer. If the buffer
> ends at a page or scatterlist boundary, this can read past the valid image
> data and fault.
> 
> Copy the remaining bytes into a zero-initialized u32 before writing the
> final word so only valid bytes are read from the input buffer.
> 
> Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
> Signed-off-by: Daisuke Matsuda <matsuda@preferred.jp>
> ---
>  drivers/fpga/altera-cvp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 44badfd11e1b..c00292370a8e 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/sizes.h>
> +#include <linux/string.h>
>  
>  #define CVP_BAR		0	/* BAR used for data transfer in memory mode */
>  #define CVP_DUMMY_WR	244	/* dummy writes to clear CvP state machine */
> @@ -261,7 +262,7 @@ static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
>  static int altera_cvp_send_block(struct altera_cvp_conf *conf,
>  				 const u32 *data, size_t len)
>  {
> -	u32 mask, words = len / sizeof(u32);
> +	u32 word, words = len / sizeof(u32);
>  	int i, remainder;
>  
>  	for (i = 0; i < words; i++)
> @@ -270,9 +271,9 @@ static int altera_cvp_send_block(struct altera_cvp_conf *conf,
>  	/* write up to 3 trailing bytes, if any */
>  	remainder = len % sizeof(u32);
>  	if (remainder) {

move the u32 word; declaration here, others look good to me.

> -		mask = BIT(remainder * 8) - 1;
> -		if (mask)
> -			conf->write_data(conf, *data & mask);
> +		word = 0;
> +		memcpy(&word, data, remainder);
> +		conf->write_data(conf, word);
>  	}
>  
>  	return 0;
> -- 
> 2.47.3
> 
> 
