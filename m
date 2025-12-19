Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC7358D09;
	Fri, 19 Dec 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159870; cv=none; b=QL9tI/mq2ZmU6JXW07pjTLzsxH5qGqOSPPp0zokOe8swIe7FoH+wCMLbzpbqQrb4x9L8j1nHdxsqrzdeo1oaYWRSw9Rapy5am1L339tNj1atY/qjlZ5fSwhYcCtHKM7sISHwdJDE8WpG36dZJBhRL4O/R31j0czPUxzwxiNTkxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159870; c=relaxed/simple;
	bh=PF+3yQXq6TFHtpKZSSBPd0CPxfcvbtetdCzRQ45jw+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G02ne4oAyXS1FhmIk6y5UTilw6xciuPrwKWhE/4XDxFW8aZWmSiHCuE8f2twdp3ousL4EEBNGfxVdwc+t6k/JFL0fVZpzt75fSXIgP8zu4eHkfYRnizAn6Zr8hrz4gxgYxnJGuTeLRlHisGR34/xeKUFQ1wgsh8ygFUTyD1J2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoAkuZpn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoAkuZpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766159867; x=1797695867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PF+3yQXq6TFHtpKZSSBPd0CPxfcvbtetdCzRQ45jw+M=;
  b=RoAkuZpn8KSQBdIoosGCsZasvyFWupjh1qEVAtTzErMlDlT8Ie4/SCCM
   kSJrq1Mt2KKZIr5h6c6CxLSo7z8ptcdNezQWariJb/zy9FArzZAovSaA3
   xwQXyiDLi3l96o2LE6d96Hi1ns5jeK0gxLii0CnLL16GznRzEnQJrVHRq
   u/7rS0rnb8hPI+jbq1AaoG8x+NHUHIzFaq/iOcynsgf0jfr/6ygvAI9tu
   FzJ9VfWvzlFIJk+zikvd2T4Jn0AOAuoNiVnTlj3IrMkYHgrYXPtsGKDtr
   aBKLmLxAplO1DROJH7t+QBKwtAxJwuN2o3hBjyz1STgUorr5JjtDVUPcE
   Q==;
X-CSE-ConnectionGUID: NehaOxUURU6fFeL8h76pDw==
X-CSE-MsgGUID: Xg78m7jUR6C0fn2Wljdorg==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71966786"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="71966786"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 07:57:45 -0800
X-CSE-ConnectionGUID: 5xjztXwVQzO2siur9fKjqw==
X-CSE-MsgGUID: kXLkYjnlT0iCP9y/8Aj97A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="199718740"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 19 Dec 2025 07:57:42 -0800
Date: Fri, 19 Dec 2025 23:41:26 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] fpga: dfl: use subsys_initcall to allow built-in drivers
 to be added
Message-ID: <aUVyJkOxMrC/OEtr@yilunxu-OptiPlex-7050>
References: <20251215-dfl_subsys-v1-1-21807bad6b10@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-dfl_subsys-v1-1-21807bad6b10@igalia.com>

On Mon, Dec 15, 2025 at 04:05:50PM -0300, Thadeu Lima de Souza Cascardo wrote:
> The dfl code adds a bus. If it is built-in and there is a built-in driver
> as well, the dfl module_init may be called after the driver module_init,
> leading to a failure to register the driver as the bus has not been added
> yet.
> 
> Use subsys_initcall, which guarantees it will be called before the drivers
> init code.
> 
> Without the fix, we see failures like this:
> 
> [    0.479475] Driver 'intel-m10-bmc' was unable to register with bus_type 'dfl' because the bus was not initialized.
> 
> Fixes: 9ba3a0aa09fe ("fpga: dfl: create a dfl bus type to support DFL devices")

I will add:

 Cc: stable@vger.kernel.org

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next, thanks.
