Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942636AB4B;
	Mon, 18 May 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116881; cv=none; b=QyMVRobKW5i8lzlyCssTfl4KwKqEAcaI7dC16X1KkK5Utk/9Fgm5gzVuziTinifGX5rIX+ytdU1YZCyhsmfK5nDUMnWDy7/TTZayBIzhkACpdXfXrVkjntHYDI/R/ziD/I6XFdfmKmWcDreuEgrAojcj0miShy8VQy7PXIAbXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116881; c=relaxed/simple;
	bh=8zWDm+opgBq6BjgLaRAyrLMgyeZMttMSkAcnS7rVJr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzPT+3Kwq3gfDB61HeoKPRzYtZ/vM9CShwvhqEV7mER0fQ7zqjfcVYMqaaLxIsFwe2YznKzh5DUpmyLg+RG8sK/Ga7wMmuEtwmLkaHUgg2lZrodPo0Ox1L2tOzb1ECcr1Y7AWX8Y0MspjOSL1pU6K9h60qdEKhkH8uKdWqcGpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGn9HzbM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGn9HzbM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779116881; x=1810652881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8zWDm+opgBq6BjgLaRAyrLMgyeZMttMSkAcnS7rVJr4=;
  b=gGn9HzbMeDVHhn2oeExGcZtw74zf+hPfBpwesni+KPoWF6OD6t7xTnYB
   zWYKDqRlcWyRcRsgyIJiCcA6XYHLFP7qVa+/ZdAiNwdyjIC3ZmKcbC0Hd
   oyRM4/vNj7O9gTQ6NwK3OtQ0+JWnTDmh0bIxSF/7xsvcui9OYexPTkA8Q
   knFhAMR1CfRutwFmkqGXXMZynvc62SSD64u0aRn8bdnKzJZiP5DEOl2MZ
   yeXqSSR3PpxocadBhf+lEVv+KEVzhPtydCPUSJdqhrLsN2b9KJ9kMMrmW
   +JCXTsV2Rgi8KnluqcxZoekYRuPUktGfb6hjejpkoKar1zVxiYXEFGgp4
   w==;
X-CSE-ConnectionGUID: /5yYeNedQtqP6iRJJQjkoQ==
X-CSE-MsgGUID: 07yoBVUkR6yUAKVcpTgspw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80142152"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="80142152"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 08:08:00 -0700
X-CSE-ConnectionGUID: uL+9skloTOSX5wzNvIPbUw==
X-CSE-MsgGUID: pUhrUb+ARbiXLdoWp35L2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="238456516"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 18 May 2026 08:07:57 -0700
Date: Mon, 18 May 2026 22:44:27 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 3/3] fpga: microchip-spi: fix zero header_size OOB
 read in mpf_ops_parse_header()
Message-ID: <agslyzwn9aeBVUwj@yilunxu-OptiPlex-7050>
References: <20260512130710.933089-1-sebasjosue84@gmail.com>
 <20260512130710.933089-4-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512130710.933089-4-sebasjosue84@gmail.com>

On Tue, May 12, 2026 at 07:07:10AM -0600, Sebastian Alba Vives wrote:
> mpf_ops_parse_header() reads header_size from the bitstream at
> MPF_HEADER_SIZE_OFFSET (24). When header_size is zero, the expression
> *(buf + header_size - 1) reads one byte before the buffer start.
> 
> Since initial_header_size is set to 71 in mpf_ops, the fpga-mgr core
> guarantees the buffer is always large enough to reach MPF_HEADER_SIZE_OFFSET.

"WARNING: Prefer a maximum 75 chars per line", again use checkpatch.
