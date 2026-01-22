Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8435326D57;
	Thu, 22 Jan 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077317; cv=none; b=TZk4cbmJXoJ0aZ4hhFGqbtu1BDUJymc5m8yebP3Hju6Cwbv/24KnOa2uuagaTLUrKu8lmr1nEDSYUPcbI9KtRtAswTHQ7+zo5476Q/2Yh5bHZnVi9HWk+sEyaQVhuuoaWyy8biMS9z5qDyN7EneZ2GRnRt9xFJr6cRnIZCIwtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077317; c=relaxed/simple;
	bh=KKdwSdQ+XAZaHSZGhdzFBpf8CKlRdzMJaONsRFg9qb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsVj5wKLARMrwwM74dqVDYzYTKw2YrYaYnOA3HdnlMS158vcVYyhA9q10wlVL6fqWXgq2wxeaGUPIsZvlWjVyXiikYgtF2Qok2q6V6tWS5GWS8GZnDLs06sYNnKd/3XmKJyNR3yx4mJuruUexamQhB0m0g+nWCIYqo0TNjSx4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKE1gb4F; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKE1gb4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769077315; x=1800613315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KKdwSdQ+XAZaHSZGhdzFBpf8CKlRdzMJaONsRFg9qb4=;
  b=XKE1gb4FJ22XDq2u+SEf6GZLHicrU+pQF3vRKN2cVh1J3xknfCuHC2tv
   rZ+Yh+EJ+lkcQfCIElpFhE2dbV/RSEPIxY9DcKoOA5nweseIbduJKTo0X
   nuMhQkjLWiFZb9F3LZJCliwI9WAX3ThAIeSlLISrvZFAEmVCzqT562e7X
   nbyiOpGzjn9ozyZ1KWmgZgCvSsjRYS8OUekfq0xF97l2vgEvPz8iHhRne
   Ezu6YaZ3rOb7/39h7+BvQ565eHGHWcq0zVliwtmYRH+KkeYBTB8MdOagf
   W/ojymaS7f9VbR5AGMqQQkASWG8/8oCpsNSYK2XNsb7aY4IKSbaSGL5vy
   w==;
X-CSE-ConnectionGUID: dnq0n59AQouHOrtaiK7Ukw==
X-CSE-MsgGUID: 7zKbR6dXTl6SDazl2RxUcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="87893700"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="87893700"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 02:21:54 -0800
X-CSE-ConnectionGUID: YrYbv5yUSg6qf0TEnfE7tQ==
X-CSE-MsgGUID: 9qSbXSuNQSy030IO3dP8KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="205824250"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 22 Jan 2026 02:21:54 -0800
Date: Thu, 22 Jan 2026 18:03:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: mdf@kernel.org, yilun.xu@intel.com, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: bridge: Use sysfs_emit() instead of sprintf()
Message-ID: <aXH2D06eZ5DRTVi0@yilunxu-OptiPlex-7050>
References: <20260117043626.2188219-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117043626.2188219-1-dinguyen@kernel.org>

On Fri, Jan 16, 2026 at 10:36:26PM -0600, Dinh Nguyen wrote:
> According to Documentation/filesystems/sysfs.rst, show() functions
> should use sysfs_emit() when formatting the value to be returned to user

The doc says "New implementations ... should only use ...". The existing
code is OK, the patch is also OK, but sorry I expect we don't churn code
just for doing it. We could also append these trivial changes along with
patchsets that make real improvements.

Thanks,
Yilun
