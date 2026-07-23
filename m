Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48F35957;
	Thu, 23 Jul 2026 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778184; cv=none; b=SqYY9hFytijPxaUtt5P80Z83mcuuRwsdoITCNSoXUXeEvyv4rxvotTJhSUmqdEHurNsEeoAjCryVhhltqWFNWqS1AcqtcjWuDVPCytuEmEf2YhUFZ8hCbrsS6hcwhfw7UUIbOwmkDZLF0Hbz2YIuAGrpR8eqpmhK6xx3kwKFwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778184; c=relaxed/simple;
	bh=00/2rT1UkilxLFvvuR0TIA2N4HP+MTk+D09t7HRq7JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlWQa8hLZw/fFs7NZwypFWVrbfqqZ14ybhD7ZI4cXIr+r5HBo2DrdEHGb6gItFVDwzRXuq6X/DblXu+/RyqtLJS2glQfCW84xMRhPVHEATwMzzM4Si9S5AKWuZWx6if9ib7AuY7Nm+xFT8KOXuoTSjqsFAs4Mw96C8TLTyeDm7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTeuRu1/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTeuRu1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784778183; x=1816314183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=00/2rT1UkilxLFvvuR0TIA2N4HP+MTk+D09t7HRq7JU=;
  b=GTeuRu1/1XpLVdpmVr8A7lFoKUas6UADjvAWTGPR2RQY3J10ZqUbutBO
   OJbxzgXeij2Jx12BvMFioO/wHAnXc7kKuGcXSbJI+OUNWoel6xTN3u0rc
   +dCyyW3+uxNhfcxUnc6ptSyPExWO4XGAbmM2d0sMntQ/WTYe837Ls9VpJ
   XuZ7Shw0eOdC4jZE0m4dpM8aKtQ0rnDY6cgq1lJxpqFSwZmDSKUZAWDM/
   xTzz4LyEJ9TUrGvAkogj9qx3vWTngRC1OudLZyW5ZxpmIbFI2MGhn97pB
   IZZxjh9x598Lkc2Js41vNx4WBat7KT0N26rpYDhmoPUsEUdEjsaL7z/O7
   g==;
X-CSE-ConnectionGUID: bx+Rj3ErQk+BgOwW5IB1fA==
X-CSE-MsgGUID: yJGCxmyQTTSh8VNhy30wag==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89247841"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="89247841"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 20:43:02 -0700
X-CSE-ConnectionGUID: tkVC2qnHRBi2LENw64fm/A==
X-CSE-MsgGUID: JuK9IgnzRaie7AejDUG3aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="253924564"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 22 Jul 2026 20:43:00 -0700
Date: Thu, 23 Jul 2026 11:42:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: yilun.xu@intel.com, mdf@kernel.org, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daisuke Matsuda <matsuda@preferred.jp>
Subject: Re: [PATCH 2/2] fpga: altera-cvp: Propagate PCI config access errors
Message-ID: <amGNwqOFs3oLXhWt@yilunxu-OptiPlex-7050>
References: <20260701092633.5146-1-dskmtsd@gmail.com>
 <20260701092633.5146-2-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701092633.5146-2-dskmtsd@gmail.com>

On Wed, Jul 01, 2026 at 09:26:33AM +0000, Daisuke Matsuda wrote:
> From: Daisuke Matsuda <matsuda@preferred.jp>
> 
> The CvP control path accesses the VSEC registers through PCI config space,
> but several reads and writes ignore the return value. If a config read
> fails, the driver can make decisions from an undefined register value and
> continue programming with bogus status or control bits.

Searching from the kernel, most pci_read/write_config_dword() don't
check return values. Could you help me understand why they don't but
this driver has the specific need?

Thanks,
Yilun
