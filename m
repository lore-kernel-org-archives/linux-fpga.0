Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58583222565;
	Mon,  2 Mar 2026 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772423810; cv=none; b=jLH3DvW38CdDVHPEt5dg99FRdLIKEp8mtLRIDIbcqRiD9Y6F6n/tCHWJv3gwshEBj34n58qEH2tGV3MA+gliWBJJf8//YXUNzjInjJFLTM4Jwb64o6jQPGbF8MPsC0kJkIKM77NFWcx7X24X3rcVtuVGxWmSjKS5/wSvNLk/dAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772423810; c=relaxed/simple;
	bh=Dg9G/DI5WPWOJb4cQDwj64qOQeBp6/YA7ZYtiE2ELO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaH3P7fF1oCs1PcgR5nEyUOkkq5BWiHGWnctySIiGeOKofxrxbAP43bFL6HNR63OCgKQrM0zb8O/b0gh72DjJq/N4xiSZkSTCaGD2n+Wa4sY5LzMtKgjSaOmGaMVIFXHdkh2uBuCsEgQGV7vum5/RoXOmowgyrkElNgfqqrcqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQtn8I1D; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQtn8I1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772423808; x=1803959808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dg9G/DI5WPWOJb4cQDwj64qOQeBp6/YA7ZYtiE2ELO4=;
  b=AQtn8I1DJwds+XSin/EsD0szwfNjgU65ZCxtWNy8YR57ruNvUM/tcL+V
   EnDJSf7SeCDpx4oblKt6vFeqJ8BO8cf7sD0nBTb0uLjr+zO64AvArWEhE
   hUJRNSJcZL+ewmBDouDP5fcdUPKM5jXOaWB3BW3miaSyL4+YCXT8nY6Na
   JYepeH60RUYtHbm+Atl2gl9v9BXJQO3Sly35cjDzyViHM3fjqBxBl2+eE
   f5+iWirumid/fWpx3U2+dfqhJFoVoYwE7PzS7lVfvOkPaQ2hce/mrYR1Y
   etCIKO8UoaJcCtFPIMM2sLYBdYKHWZdY3JEPO8moFlU5ahxwVvNpjP3aN
   g==;
X-CSE-ConnectionGUID: 7M2cBb5ISsW6Gdq8GYGrYA==
X-CSE-MsgGUID: 9OBrIrQYRryidegFXLJ4Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84773765"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84773765"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 19:56:47 -0800
X-CSE-ConnectionGUID: +BM1a2dlQ9qRaX9GOjlYOg==
X-CSE-MsgGUID: PnRcFf91Qsqm7B28HqIAlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="244648570"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 01 Mar 2026 19:53:44 -0800
Date: Mon, 2 Mar 2026 11:34:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] fpga: bridge: Use str_enabled_disabled helper in
 state_show
Message-ID: <aaUFKEPvML07Q/CM@yilunxu-OptiPlex-7050>
References: <20260224161504.587562-1-thorsten.blum@linux.dev>
 <2520266b-e2ee-4a74-8696-55adc5b9ae91@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2520266b-e2ee-4a74-8696-55adc5b9ae91@kernel.org>

On Sun, Mar 01, 2026 at 07:06:57AM -0600, Dinh Nguyen wrote:
> Hi Thorsten,
> 
> On 2/24/26 10:15, Thorsten Blum wrote:
> > Replace hard-coded strings with the str_enabled_disabled() helper. This
> > unifies the output and helps the linker with deduplication, which can
> > result in a smaller binary.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   drivers/fpga/fpga-bridge.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> > index ca68c38aa4a1..e8ff3e3bf2fc 100644
> > --- a/drivers/fpga/fpga-bridge.c
> > +++ b/drivers/fpga/fpga-bridge.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/of_platform.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> > +#include <linux/string_choices.h>
> >   static DEFINE_IDA(fpga_bridge_ida);
> >   static const struct class fpga_bridge_class;
> > @@ -305,7 +306,7 @@ static ssize_t state_show(struct device *dev,
> >   			return state;
> >   	}
> > -	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
> > +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(state));
> >   }
> >   static DEVICE_ATTR_RO(name);
> 
> Would you consider including this patch[1] to this?

Oh... This str_enabled_disabled() is exactly the same trivial changes I
was thinking of when I wrote that comment.

> 
> Dinh
> [1]
> https://lore.kernel.org/linux-fpga/aXH2D06eZ5DRTVi0@yilunxu-OptiPlex-7050/

But hi Dinh, took another look, the state_show() in the same file is
already switched to sysfs_emit() by previous valid change. So to keep the
file consistency, it's good to change to sysfs_emit() for name_show().
Sorry for my neglection.
> 
