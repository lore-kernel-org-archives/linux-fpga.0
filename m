Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3A2DB7BE;
	Mon,  4 May 2026 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894924; cv=none; b=edkv8Z95/a+uOIfHhCV0pdKtkd49RhEjKrdjpOjp5hehOW+Of+xzSmVwCnTzNb0f9/+CCY5hfmWxAH7iQ0AWb7+8jjge3f6SdXvvykl8NP5R7ZWlcMOr0Ra7ODAhzgbMPMYtHv9vs1HPJjBlGX0/KDaJhFs2qoPR8kT7v4kxGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894924; c=relaxed/simple;
	bh=qvUHI/Jk7Wsh27+QYlR/yeU+sPK3Rc0MiyiH2vd7ixI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nghqTsy9MImqk4qr/7SW91hucfRoEQeD6dYEfdg1mIlNJYM28nw3wd5qvnQRL+mF89ldX9a8st1yOsslwMA2dIRYfvzH9Pev4qtXGkQC8FhsDZQo8BzoVGH0v8PUgqWsSM4TrQKW2DhMkPlGPAcDBm29P8v7w4UqgwIYFiczVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dv1aWkL+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dv1aWkL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777894923; x=1809430923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qvUHI/Jk7Wsh27+QYlR/yeU+sPK3Rc0MiyiH2vd7ixI=;
  b=Dv1aWkL+D+5CpjjOr4zJJ9mvrGQpTT4bu2DGXF9xdWcnRB5bcOBzbtgP
   Y9MLDSl0LZ551O+tfWzd7yiOZr4qqrkijIS+tuof4L9LwKDUkvHHrWS5t
   D7s6CiqpJTcyO4ExWEG4Wz08R9TOWnKlT/lYZwGs6w8rxPk3pTxvPa91b
   S3THVBazBW59i9QpgAWQco1nmxNrv6D8s7lapRZRCZb/oHziabWDvriQN
   Ln/+6o1y5a/y/Rw+iIWr9wXmCs5s5HonxGJCuRpGLQa1kZoOGmHOdv3c3
   AQkSQl+MJlyBMuWOmapiWUbBUK8mfCSegRAq3cQxad8CUmW5LgS4fewrn
   Q==;
X-CSE-ConnectionGUID: kwPboVQHROWOl0kiDT9bZw==
X-CSE-MsgGUID: ojvSGE7cQZ67cHA8Mz2oog==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78799444"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78799444"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:42:03 -0700
X-CSE-ConnectionGUID: UT9/K/HOTzO9pCin0KW4CQ==
X-CSE-MsgGUID: yg58v6N7TmOc+ld9Y045bw==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 04 May 2026 04:42:00 -0700
Date: Mon, 4 May 2026 19:19:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Phil Pemberton <philpem@philpem.me.uk>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tom Rix <trix@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] fpga: ts73xx-fpga: add OF match table for device
 tree probing
Message-ID: <afiAsAUkNdVkXwFO@yilunxu-OptiPlex-7050>
References: <20260409122016.3940462-1-philpem@philpem.me.uk>
 <20260409122016.3940462-3-philpem@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409122016.3940462-3-philpem@philpem.me.uk>

On Thu, Apr 09, 2026 at 01:20:16PM +0100, Phil Pemberton wrote:
> The ts73xx-fpga driver currently only matches by platform device name,
> which prevents it from being probed when the device is described in a
> device tree. Add an of_device_id table so the driver can match against
> the "technologic,ts7300-fpga" compatible string.
> 
> The TS-7350 and TS-7390 use different FPGAs with a different programming
> interface, so while the driver is named "ts73xx-fpga", it doesn't apply
> to them.
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied this series to for-next.
