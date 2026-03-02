Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95972FD1AA;
	Mon,  2 Mar 2026 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772423953; cv=none; b=oJOWvPCn9+p804qQoyOJCE6dRsD9L4XfEpnTqb2XyUIwsr3s4uGM9wnDi08zMmMpi/n50Vg+kRhcEfTe7JGwhAHz4wtzsiCsqXLHsrBjOoBhZwHbBy/lOlqixgBrnEGR9DZQ3R0x26cSfxCWMjOD6ItCzLXvCeGiOi8dkzER8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772423953; c=relaxed/simple;
	bh=C/7cOB3JkNIYXX+n+xVu2rS0S5kAwFznPEmvLBMrpBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzaaZl+KVY6DKQ+j/ilUuVUKYfW5fIOLQ/QMy0SPB3CRMhS28B6tjpvAhQTfwXmN7xyA3YOsfuutSo9hcr8fdDqalKBGcECD/jwq7INakTHWKqdMabk5x39/wK+Flv3myv36V68uPUrVhBQRdTJXNDoxfZ0FLNPdvin7Bg1SmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TduVE0id; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TduVE0id"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772423952; x=1803959952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C/7cOB3JkNIYXX+n+xVu2rS0S5kAwFznPEmvLBMrpBE=;
  b=TduVE0idZQzP/tHS/JZw0EMWekBh+rm+OCIVV3afz8gzypKJWuCoMci1
   Ohx+5OSH34qpoOLlzEDcfk9s6tekbCIVaLnJvXieUQOui/vnMNHm07wKc
   bmUJT12J7bGZgji9hWgfHU/l5neb+IwA3/bh3TtgjpXRXmCV7+hYAR1YY
   jZDNRUv8K/dxK8AxR9HnbkPOhdTFVimfYkUDMDqb15c+G8BAj4Q1la+wA
   KThXvjIkXtlXVgQ8Q0jcX4clCOyStbI+Jf4j0U2VspKoQ5Ln+4NmSIrbj
   lQk9X6HpcWd8NzqFifjN7iYkF6Jw8PaqRSzoSM1I90djNmJ0PomG/13+X
   g==;
X-CSE-ConnectionGUID: 7muqj1VQSBe3IVr7z1kzog==
X-CSE-MsgGUID: znSgrUfVR+egiRVWltfYgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84517519"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84517519"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 19:59:12 -0800
X-CSE-ConnectionGUID: IwS2MQkHSMCdwVrxTFKmEg==
X-CSE-MsgGUID: QZhxgA5wR6yUsBMrES50hg==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 01 Mar 2026 19:59:09 -0800
Date: Mon, 2 Mar 2026 11:39:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: mdf@kernel.org, yilun.xu@intel.com, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: bridge: Use sysfs_emit() instead of sprintf()
Message-ID: <aaUGbWGo/DuzvE69@yilunxu-OptiPlex-7050>
References: <20260117043626.2188219-1-dinguyen@kernel.org>
 <aXH2D06eZ5DRTVi0@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXH2D06eZ5DRTVi0@yilunxu-OptiPlex-7050>

On Thu, Jan 22, 2026 at 06:03:59PM +0800, Xu Yilun wrote:
> On Fri, Jan 16, 2026 at 10:36:26PM -0600, Dinh Nguyen wrote:
> > According to Documentation/filesystems/sysfs.rst, show() functions
> > should use sysfs_emit() when formatting the value to be returned to user
> 
> The doc says "New implementations ... should only use ...". The existing
> code is OK, the patch is also OK, but sorry I expect we don't churn code
> just for doing it. We could also append these trivial changes along with
> patchsets that make real improvements.

I'm sorry. I changed my mind and would like to apply this patch. This
change solves the inconsistent usage of sprintf() & sysfs_emit() in the
same file.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> 
> Thanks,
> Yilun
> 
