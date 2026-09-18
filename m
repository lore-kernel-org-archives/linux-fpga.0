Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4B51A14E;
	Fri, 18 Sep 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750468; cv=none; b=lHDSW1Fha2WUro9WWVRIi4shKZZmSy3slK/8Ncra8y3qDqRPBrtdd53SY6ULkIMIC6NCutbymj4IYpPnR7kyXY0awVVlbJni4erBJVUOt23AIy4t8idJ9iQuA728LCWjGudJeGmqEA0wAmeaXtkol1tYPtMI2vety/iNZse+3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750468; c=relaxed/simple;
	bh=cWUhj1t4YFcDJmEafWwQCuh+uNznZca9sFnEEB3midg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5/YEIrEXGR5mk6rUjFM2lk0XSJY71zhPHmSX49LYEva8zpNp+QBjWF3yhSIp5SQaoxoJPwyRmFgrq3y0/TRDbfn20ySJDWtMLxSq/xoJjfRtwCr3P5PfrXy89mpz040cqnvZ7QpV/tLAPBa4vaD82xD5BKhPjUne8gKguRYEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmP3oZpz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmP3oZpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789750466; x=1821286466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWUhj1t4YFcDJmEafWwQCuh+uNznZca9sFnEEB3midg=;
  b=UmP3oZpzAJiq4MztJrC6jQ8tq9wQi1KAjy/qfQcx4+wkrd9hXm72ZgDy
   1+cgzFsay9BmHm52R2atY9Tc14KkLcrldKHDjEcrYo9+QhPUZapSeshEh
   1PnWdc3+v44b9O4RxS6FV4dsg9XCDnB30RzD21XtMjGPnvefB6gqhrEVS
   um4W7Ce27dkdcwh7VJ4221StCf/8xGqTDj58+ZG/oWIs2aGupCR85yTdT
   KtCY0JFZrPVDuUX4mjbHan7oS/oeCR21m27MITHIu7kFj6i6CBNO6Fzml
   bSpr3n9pSrs/mVi3SUxf/qsUe/fLHRHdxbJByxC7fKsIBAYPsdnG2RkY3
   Q==;
X-CSE-ConnectionGUID: a2CircBFTGqrKTr/S5HI5A==
X-CSE-MsgGUID: sab2LQXUQqCzhQslDp2RjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90286300"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90286300"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 09:54:25 -0700
X-CSE-ConnectionGUID: fEdpXOQ/SC6Tiv1F769f8A==
X-CSE-MsgGUID: 9kkH8+YgTpCGWsa6574fRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2937247"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 09:54:23 -0700
Date: Sat, 19 Sep 2026 00:53:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: altera-cvp: Retry teardown and reset CVP state
 on failure
Message-ID: <aq1som4bim3EiTO5@yilunxu-OptiPlex-7050>
References: <20260915062734.42964-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915062734.42964-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

> +static void altera_cvp_disable_cvp_mode(struct altera_cvp_conf *conf)
> +{
> +	u32 val;
> +
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
> +	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
> +	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
> +}

Use the helper for existing code, or there are still duplications.
Split a preparatory patch for this.
