Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19C382379;
	Thu, 23 Jul 2026 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784780956; cv=none; b=oST7SMZjBmMv997x5h43mCIEEe36u7E0dCWqz7aGaIJ86H7CGDeKfPp/lBprQ8ntauB0Lnqw/xCYqMj2LoYV5crTFfbgDRnkKOsr0ZCaiVbaBnQSVDZpGGy8Q4yMpiF0Aqe+maMdeBjbSi5nc9NoKYB1qB0dLxqJpFVGrsKqQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784780956; c=relaxed/simple;
	bh=ZatVT0U1yCXOrhRsxoQTAwBUf9NEIaFUpxntGK4qsWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4zfoqOLH2k4RDLVHo19IXtXkslSe0ZvKCHFnDMvZiMcsi+w44YioCQv4AQfBJFUpyEX6E+HuJXK4AglwIU9TAEugaAbiT2MCtzcobLxl1L/YgSsjby8P9Cyj/PXJph9LxzJoTWRUETpkX7iJoA/JmwupvscC/3QxmerWt2YRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvWx4uW7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvWx4uW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784780941; x=1816316941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZatVT0U1yCXOrhRsxoQTAwBUf9NEIaFUpxntGK4qsWs=;
  b=VvWx4uW7bVHnUCfe+dhaupDcfiIBUCeq7pUzdYkwDBW6/LQtCY3ffB7X
   sPaF74VzFxUSGX4lwu6VCuhsg2Z4vAylr+IU4SunDHqQtptvqBO7Fd+E/
   i6x+OxdMvLG0RHxW8R2sFMF1F4oBdoH/mQ+xcabAvlprTv2+gDTGUxLop
   jjfxIfYNKODTF9i8bjVSZpK2xCc0k0gSQ9ix1dux4spCn7ytUxGAt1lcH
   rEhk6aOFrY7eqGxssNE0Jmq6I+wE/CBMW11TR2+t10n0ky2mA5fG9JdGJ
   EJeFvlM5mryu2QB3Kv/G/hZ6sttvKj+cIKZiXfzeDxt9rX8Submn9+q/s
   g==;
X-CSE-ConnectionGUID: 5yC7ifMHQRy1PAJof8VcmQ==
X-CSE-MsgGUID: pmKzcs9wS6q7cfB7WISmSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84404258"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="84404258"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 21:28:56 -0700
X-CSE-ConnectionGUID: w5mTDfR1RLqLcJ2VHZtE1w==
X-CSE-MsgGUID: EV1QK4HtQcifRv9c/3V1Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="262616913"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 22 Jul 2026 21:28:54 -0700
Date: Thu, 23 Jul 2026 12:28:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-fpga@vger.kernel.org, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] fpga: m10bmc-sec: add image_load sysfs for
 N3000/D5005
Message-ID: <amGYhCKpesGH/yLB@yilunxu-OptiPlex-7050>
References: <20260715073854.26117-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715073854.26117-1-ionut.nechita@windriver.com>

On Wed, Jul 15, 2026 at 10:38:53AM +0300, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> The mainline Intel MAX10 BMC secure-update driver can stage and flash a
> new image through the firmware-upload ABI, but it has no way to trigger a
> reload of an image that is already resident in FLASH or EEPROM. OPAE

The concern is, what's the impact to the system and the bmc driver.

And this is the FPGA re-programing, I don't want specific FPGA
re-programing interfaces per device. Let's figure out a meaningful
set of interfaces and a graceful flow for FPGA re-programing.
