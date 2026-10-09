Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07530E828
	for <linux-fpga@vger.kernel.org>; Fri,  9 Oct 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557685; cv=none; b=fkelRwJ58g8bRJiys8wQZPlrq/zOXOzxP3+EW91WIvXpOxdm2W+fNSxdoBZ4NmLzjOsrP7bFVzVsZDfv+v05CdW69OD4eY1qvRY0RsqVHEW/cyjUUzB+an0QSkutPxhow5ue3LoSiUeVgtxYchgaApGlyRmOCt20p+ODRbA8U7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557685; c=relaxed/simple;
	bh=/gdjnoB0qE6cUi7GQ/GxNywWVdXdfYr5CJ9d1Yp2pUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwxR5ofuCRBB3p6Dbv8i/SAKjmPYySpc4+WIEWyQvBh/tp4nM5j+Vg3/XeQLEnX4Tw6ERhMxm5OpXFg80CFyjZxKSBJdpO85XdN9zkN/G3amSw9J4/uGqUM7Yzg+hx0sELUUqCtmImeSeFVrFXmxi+Pov8sKBZcx7wV/IIsKv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vx1BtvU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vx1BtvU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B6A1F000FF;
	Fri,  9 Oct 2026 14:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791557684;
	bh=cTMQfBp9pIEIKk2otQd0btEsdYH5NRtkbf1iNa2+f10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vx1BtvU9DWEp4AypPrrv4lUm+FY9l+x/pNU8Mo4ZCBaW2keVwoHY8ZkCb0ex2YyWx
	 eBb9AX51xdTSPdwOWaBqc62vaC5RJi4RG2vqKV9cxtsRYrHxzg+NSCk/BMaVxOE2+L
	 QbrSBW3D3GiYSxuqw6Nf0NG+EoRhtO57BysB0zq4=
Date: Fri, 9 Oct 2026 16:25:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 7.4-rc1
Message-ID: <2026100948-used-steerable-0ab5@gregkh>
References: <asdXxh/YnEiCb92U@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asdXxh/YnEiCb92U@yilunxu-OptiPlex-7050>

On Thu, Oct 08, 2026 at 04:43:50PM +0800, Xu Yilun wrote:
> The following changes since commit df2908090cda368b01ff43709f51890076c56157:
> 
>   Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-7.4-rc1

Pulled and pushed out, thanks.

greg k-h
