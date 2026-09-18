Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E35514777;
	Fri, 18 Sep 2026 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753164; cv=none; b=U1950XIkHzaOTaM0DS8nNdk+hc3wIBJfABPYcl60bMAvkraVE6z4LuekM/xStlp+OvIBBBcJ/XIWQpErKKUMW4NnW1OoMNn9HGsv8jy+2apKVFTTWrPD6kyCCujJXVs+byUNlOdTcBSekbDsCvwqvrX/HIamNpf6zeFstr/Mi8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753164; c=relaxed/simple;
	bh=ADbjXrTc3VqMtOrXdkd1llXCmbrgHQP/sgMQWIrJ9HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnEieGRMtpxLCf+vE9AC99uNkWtoPVxXLP8Zf0TM4WcNQr48f43D3nlxGtCaPdeC/Xnx99QaGOD7L5cfnPiKHFxNVnpeRUgFIMB6Zqi2EAg4X/XBd73iPXjRUmDZr9XccCTA+pK79DbURSGoehpyubF9VSl1evIrF5Shvql9LQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UESUd0os; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UESUd0os"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789753162; x=1821289162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ADbjXrTc3VqMtOrXdkd1llXCmbrgHQP/sgMQWIrJ9HA=;
  b=UESUd0oswQPKv3vcRggRNNk+FpUe6BI64yDI+lvge+OgUp7L++GYBOLY
   t8oR6H2ubiD3zjJUHrC+8EmtyNVibBg8giw4mHprnbn8JwAOkxxNBd5oA
   +Xx0jBTdrUgX/hZhtRe64Ia1D+zWweV/m4kEGbFb18FpxFfou/ZjD8gEJ
   unWFaUMi9MKirtM5jGv9NEFqPvTTIeJjJ5NLRYuw1riqLPpYIMrso2G8K
   C/1bOOTXh533lMDnJJMxE5ZQeNjcWr8B/s5Grewvwma/HfpOhLLf8Mt+X
   5Cr5wWYqFVVAMkN0xOghhLw/x7Tb9hBxgqTPo56EtTezyrGSZ8QkvWbg9
   A==;
X-CSE-ConnectionGUID: OpdGP7cLTsWAXCVq596dUA==
X-CSE-MsgGUID: AaQLH8x3S2qp0osj3ad6Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90143449"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90143449"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 10:39:20 -0700
X-CSE-ConnectionGUID: AbAAxrodSaSjTipO4Pe7+Q==
X-CSE-MsgGUID: LHgaXWzfSsWc1yJpphSZMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="268237165"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa009.fm.intel.com with ESMTP; 18 Sep 2026 10:39:18 -0700
Date: Sat, 19 Sep 2026 01:38:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Alan Tull <atull@kernel.org>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: Fix of_fpga_mgr_get() reference in fpga_mgr_lock()
 docs
Message-ID: <aq13LIFPzbtEVxtR@yilunxu-OptiPlex-7050>
References: <20260912100937.86316-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912100937.86316-1-kmehltretter@gmail.com>

On Sat, Sep 12, 2026 at 12:09:37PM +0200, Karl Mehltretter wrote:
> The fpga_mgr_lock() comment lists of_fpga_mgr_put() as a source of a
> manager pointer. The helper which obtains that pointer is
> of_fpga_mgr_get(). Correct the reference.
> 
> Fixes: ebf877a51ad7 ("fpga: mgr: separate getting/locking FPGA manager")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next
