Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661766;
	b=0J9pKAVgCSwA0s9CgxFrFFUTu8PXgWbXJ11plRVMMKhivOSWm+gcUlyfvilO+JRcGDc2
	 iQ8q2MUNZSr1adrqmZNk/7aUcyCNVulbocmyRyX6mJYbz3iVJUiyE9ln4mCYtV94RjrNN
	 om8aUj2Y66Ab94JujdZkL+pCRNdoNGUImxHUKodqlHGYST59n3y+5sGgBXwO80hlIKPbN
	 eFV6OukNbHx+8aodobnfsc0CrH/rFUOB4ko3DdXWMIUMc43uaHvL4msnxtFPPuPEVguXP
	 tBmzxxiwNwXUWWagkaaiR87qj5A9GUuD9aFMxWVx1QGmPyBHlw5RpUQP+0+F94xcX7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661766;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3ZTzQECzP8zCA4zZIUOYcMmNhdFsxwT6/XtJiNtrnio=;
	b=vy5FmxX4w1W1BZsghG6SYr3dAWpuhjO13SnwGCku+SNIIyc5/Oe3rO3LJ5+uqi4iMLEr
	 wdbMpbioyedLvUeW4cTRfQ/ymWVe0HlFw4YMP0Ue0eAnYdRMdmQcoGxLKyX+bFEbtPHga
	 cyHRN4zIe6v8HCte5jp0i3zx12rBtoCr1ChzjDjriT0alUdTbIEvCOkHggOs7th5lSlIg
	 SppZo6FZX06hP+OQFoCo6jIBoCZHBB2J4eXux50pSbp+VfiLsRXrvpV4OyGHclM+RIydY
	 okZSaL/qSdkc2K4/ZL/Z4Q7VACXEkEOD4OEJfJBegwkAwCHupTCXYHGKChP+88XV0gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVGwYf1e;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD3606E0CE;
	Sat, 14 Nov 2026 13:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CFD3606E0CE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVGwYf1e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794661765; x=1826197765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3LrEAWD2vso0+yzov29pKHt2uGcBzvsMBwzmMMJMss8=;
  b=cVGwYf1eQ3SbkOsXKnm9vZwk30XqMO82lJ5uLZjPbwLzgZ0dheOBGsyT
   u9rQoN0HU7pJHuLtvdn8k5eekJ8IuiXyJlaI6l+rKyfM8k648/Z5Y4eYQ
   RY5ofKVcxTN9B58Z8fwnDX5e4V8s9EQRk4cBGmCxVzkctSLytiBt0aJIL
   AfvKUeIRC9NTXnxfh60sQWAiETdSbxWwKYdRpwc/7zqVZoTQM8idbKKHy
   U9kLhXJxgpRVOlUS2fFUM7TZ1ZqylCds3SFbQ8RX95Y3BBbDMpzfrkQnv
   AuJO1/89hz9EX45ykFkoMcUcm13GR//FGnd/wF+EXaANDnepo1tAuYZGy
   Q==;
X-CSE-ConnectionGUID: IkFvKW0yT6ypIZWsUjzAmg==
X-CSE-MsgGUID: f6XjP5iQRuCZphamSVQJAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3488611"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3488611"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 05:09:24 -0800
X-CSE-ConnectionGUID: vx3GMDnIRuiBOgprM3V5lA==
X-CSE-MsgGUID: vf8gb478SwiF8fB8umKoTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="9685598"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa010.fm.intel.com with ESMTP; 14 Nov 2026 05:09:23 -0800
Date: Sat, 14 Nov 2026 21:00:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Aravind Thokala <aravind.thokala@amd.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: add shutdown() handler
Message-ID: <avhbivs3HDdvzrtB@yilunxu-OptiPlex-7050>
References: <20261110-pr_decoupler_shutdown_handler-v1-1-b833dfe9d380@amd.com>
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-pr_decoupler_shutdown_handler-v1-1-b833dfe9d380@amd.com>

On Tue, Nov 10, 2026 at 12:46:35PM +0530, Aravind Thokala wrote:
> Add a .shutdown() handler to decouple the Reconfigurable Partition
> from the static logic on reboot, shutdown, and kexec.

I'm not sure what problem are you going to solve by gating the PR region
from static region regardless. Please specify.

Before I get enough information, I generally think that's not the right
way to solve problems. You need to gracefully handle the specific logic
inside the PR region which actually impact kexec, so that they work in
expected ways, rather than abruptly cutting down the HW connection
regardless.

> 
> The handler writes CTRL_CMD_DECOUPLE to the control register. On the
> PR Decoupler, this turns decoupling on, which stops signal changes
> passing through the bridge. On the DFX AXI Shutdown Manager, it
> requests that the IP stop passing AXI transactions through.
> 
> Signed-off-by: Aravind Thokala <aravind.thokala@amd.com>
> ---
>  drivers/fpga/xilinx-pr-decoupler.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 1405ddbe88f1..75b59edbf440 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -137,6 +137,13 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void xlnx_pr_decoupler_shutdown(struct platform_device *pdev)
> +{
> +	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
> +
> +	xlnx_pr_decoupler_enable_set(bridge, false);
> +}
> +
>  static void xlnx_pr_decoupler_remove(struct platform_device *pdev)
>  {
>  	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
> @@ -147,6 +154,7 @@ static void xlnx_pr_decoupler_remove(struct platform_device *pdev)
>  static struct platform_driver xlnx_pr_decoupler_driver = {
>  	.probe = xlnx_pr_decoupler_probe,
>  	.remove = xlnx_pr_decoupler_remove,
> +	.shutdown = xlnx_pr_decoupler_shutdown,
>  	.driver = {
>  		.name = "xlnx_pr_decoupler",
>  		.of_match_table = xlnx_pr_decoupler_of_match,
> 
> ---
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
> change-id: 20261110-pr_decoupler_shutdown_handler-bf2596f6d1de
> 
> Best regards,
> --  
> Aravind Thokala <aravind.thokala@amd.com>
> 
> 
