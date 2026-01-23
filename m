Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B444522D9E9
	for <linux-fpga@vger.kernel.org>; Fri, 23 Jan 2026 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184276; cv=none; b=pPHUXrqNAMVoNosj+tCwONHui+1XDpWPFPV53LmHcf1fwl5KjSnzvaFwKCT/5D51ZlcaxFCnAEB7R3R3C/XYUZJsQAcKTbZ7PfZ613EJAumnECvpleGUooQH4BOW2xBWyFuehx1BBPL4/63cYzd4cuVOkjxqNScklLZGHfpEqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184276; c=relaxed/simple;
	bh=Kn8ur+QEoHMnn6zkEHyevxQsGNkBFdZ7FsAWPd9T+fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxizHUex2sX3YscsQAteHewoy0U7cXsy+Q/Diz1a2z/2v1lVMg0caExpm2cY8AWaNvKFs2Nop7jrtCIe2IW4goAZBgMSc5yTyIwGOCURpzO622t+y+g3I1JkMYApcZaqK03zbjmLGsMVCzrOliujoVt5JDxZUAdh2nbyR9lwrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KVdabue5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KVdabue5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D88C4CEF1;
	Fri, 23 Jan 2026 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769184276;
	bh=Kn8ur+QEoHMnn6zkEHyevxQsGNkBFdZ7FsAWPd9T+fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVdabue5VEZjQrteC77QgWDsr+c7E6UFz0Zgo9XsVlPb5VRVe3AmBciPn9p2ZT7KD
	 U/6phPDwhn0ElxtXS2AcCNQKf9oHcsBoqUGSNU+zsoST8xUgOQYe1sqwYZI+yBX9Wp
	 HiBKt3GMlw7nDsw/tYv+Ml5nUpejiF40vNxHgpGY=
Date: Fri, 23 Jan 2026 17:04:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.20-rc1
Message-ID: <2026012324-chump-frequent-9b4c@gregkh>
References: <aXHt+hVR6uIy/xww@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXHt+hVR6uIy/xww@yilunxu-OptiPlex-7050>

On Thu, Jan 22, 2026 at 05:29:30PM +0800, Xu Yilun wrote:
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
> 
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-v6.20-rc1
> 

Pulled and pushed out, thanks!

greg k-h
