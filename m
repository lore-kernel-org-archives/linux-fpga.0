Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B336A030;
	Fri, 19 Dec 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159792; cv=none; b=a/+eBG1vr4fNf8+EKz5vMFp5w8aDJS9GYGxPco7c4AxRW6EPodYVSMWTYwqlgcFpaiJMvbub72BwXBZRSgPK5lhUuuQHww4iT1uWx28sOSSwahzTmNiwGFILIrMfWfSHF7XBQP4K24X3/UUvyAiMGdQoL8JBVjfHy46Ejy9z/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159792; c=relaxed/simple;
	bh=S5i8eVfDKxPB3n3/rKECDOJx5Ees4JGr6vAqgz7sOrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjl70tydCxdTX5lW1D9w+VUYeCtDYK+/NhGF10GcDOMUD8i6RKNT9mbHU2bTQ1WuP9ovWthliXQtD/L8nj9Ldx+npSHeSzUoMKjJvlChU69UAL2Sv9OCTwHrExFqSip0dSlcITIqY6Cq1MnEebWDuv8Zseg5gyJlFs3KUaMu0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avJ97rg+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avJ97rg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766159791; x=1797695791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5i8eVfDKxPB3n3/rKECDOJx5Ees4JGr6vAqgz7sOrg=;
  b=avJ97rg+ORDVAHYI6muPUFJuQFD/H+HKeeyNU98BDz8s8EyVfLnrQqTQ
   ANtFnritrrCuQhpMCa4DMDQXEp2nDuugzioMXl4pepRAIvMKRx0dHy92P
   imXXwzyAk6E1jB2LxTp2BJXVLl8llY+4/g6CBQ9d+cS74hZpmUrpbDWSY
   +Qk6BnItotBe02WJrCsp0bMVfar35G+7gLGaC/M0P8X8g1geeOz98F3SD
   0UTX3K+VZS049NppCGsWxxMGt6DorGmCWWOaW+pJmk7ZOCRnR5BxxzdFp
   T+eq5vwRlXd2wciuC44nGbrcM4llulSpjNDoTHgYWwMWnmdVlnZhlIVlm
   Q==;
X-CSE-ConnectionGUID: tr6o42A0TuuoHCZFeCpcuw==
X-CSE-MsgGUID: UXeUMi9aTiS6ySl7cpk07Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71966715"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="71966715"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 07:56:30 -0800
X-CSE-ConnectionGUID: Nc51gz8kQPqnXAS5IvwCkA==
X-CSE-MsgGUID: njNmakY3TjeY30tOsQu0sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="199718513"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 19 Dec 2025 07:56:28 -0800
Date: Fri, 19 Dec 2025 23:40:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH] fpga: xilinx: Switch Michal Simek's email to new one
Message-ID: <aUVx3PtC1Hho5RbK@yilunxu-OptiPlex-7050>
References: <49de9536c9952a3a36bb996f2fb0a1f0efb1ba6f.1765787307.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49de9536c9952a3a36bb996f2fb0a1f0efb1ba6f.1765787307.git.michal.simek@amd.com>

On Mon, Dec 15, 2025 at 09:28:29AM +0100, Michal Simek wrote:
> @xilinx.com is still working but better to switch to new amd.com after
> AMD/Xilinx acquisition.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next, thanks.
