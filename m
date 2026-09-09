Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425846EC98;
	Wed,  9 Sep 2026 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940933; cv=none; b=dDGJVxYq2JlAlC9PTdmOskkNi9pauT/d1bnu/vbE/0257RTlj5CftIKFWgjPJkTE3F8HLfPb159OQLz2vR3BOg3pT2o4Y1jYlr1QouLuPXCeXqO77ekwUwj/pS758jLLYL5eisDGKbBuNNyQ8QqoISRrdtHHN7r6pXAV6LiS1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940933; c=relaxed/simple;
	bh=p8cdWX8YIdJZfnqWOC41ZnvOaypzciVKNBO8Fz7KurU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPR2R1bGhUjF3miPKoFBt7joLCUpnBR6ghAje5cs5GnZiAmmn5ihFCYr0YnYSEoKdKs76n8No5VhbujGij4+JfBm6MkeCcjEoGWPw6niUp03KY/YIuTfKFVvkVW2rfBpifn1UnL2nvWL1YEYDb/db/3D1mI4MRqYe0E0YeIMnm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTRArj1Y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTRArj1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788940932; x=1820476932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=p8cdWX8YIdJZfnqWOC41ZnvOaypzciVKNBO8Fz7KurU=;
  b=nTRArj1YgiFpt1g+4StQOfGDlUimfB0038I4YaeK1sq0/ekCRIzodtPZ
   QhIdgFvGCibuwtXi/ugh3sCn5Aq7wWUSwLVEl7LlJXgLaLs9dmfuMuZZI
   xPvkVnrO7zPD34js6pcC3t3QN3F/aq1VZPLeOAFlKEpLHzv5nX6HHSQ0N
   Wxv/rUi+h9uRat8bmd33Bv544FBU/Xx15FOk+v4AW3ik+RUyyEoYlIHT1
   tjmTZWc7vx9PFTWlOWmuN4PruCNvxK2PsV9bMzr93Vy8ca3nGF78YvYYO
   CqQ/+yz/pji4YZ8qI5mi/JbUUFw8D2V3sunwiKAt4caaeGX4QsHyMESsD
   w==;
X-CSE-ConnectionGUID: K1/gWo4vRn6o+X6C4GfPrQ==
X-CSE-MsgGUID: vHTb12cHRnWkj13mogppSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106726383"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106726383"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:02:11 -0700
X-CSE-ConnectionGUID: jYFAMtyfSpCP2kqRzn3v7A==
X-CSE-MsgGUID: 0N2g8gOCS3u09AsvFEfElg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301118983"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2026 01:02:09 -0700
Date: Wed, 9 Sep 2026 16:02:09 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] fpga: dfl: Drop #include for <linux/mod_devicetable.h>
Message-ID: <aqESgYZRJCbN9IV/@yilunxu-OptiPlex-7050>
References: <799c3ffa64d758ffb74f84da492d978a517ff1ba.1787407491.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <799c3ffa64d758ffb74f84da492d978a517ff1ba.1787407491.git.ukleinek@kernel.org>

On Sat, Aug 22, 2026 at 04:05:35PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> None of the c files that #include drivers/fpga/dfl.h (either directly or
> via drivers/fpga/dfl-afu.h) actually need <linux/mod_devicetable.h>.
> 
> There is drivers/fpga/dfl-pci.c using pci_device_id, which is provided
> by <linux/pci.h> and drivers/fpga/dfl.c using dfl_device_id which is
> already provided by <linux/dfl.h>. No other structs traditionally
> defined in <linux/mod_devicetable.h> are used by these drivers.
> 
> So the #include can just be dropped.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next. Thanks.

> ---
>  drivers/fpga/dfl.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 9549f63b00eb..9a65617bb870 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -23,7 +23,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> -#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
> 
> base-commit: 903c1cf6dff9964e71eda98a39e2e5d442050472
> -- 
> 2.55.0.11.g153666a7d9bb
> 
> 
