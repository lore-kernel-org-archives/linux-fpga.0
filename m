Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76998316917;
	Fri, 19 Dec 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157953; cv=none; b=WvQ9kDvcdaIqRUt56QOYvg4PVNE3HM9X7QfEEZ/hoVOuARpfNhk2jPFsYVQrf7NXcFX6iMEBQbv/DCzxpBqBFC+u0wy7E9rwzXy9cKPRttQU8cpV4rTbX+cABUIjfxqkUuaP8WwgfbiG0PLTBGztnN+tHdfLkcz5Mi9vWCfwMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157953; c=relaxed/simple;
	bh=jTam/avc+Nm85UtJLHBO0ExRzdYHUY29ok9dc7c+1F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq2Awd+LugTseVMaxPUoThnzNOArW4KCsaZaC8sC19GAulJE68XW11YjFsi0yRRo40leIZ8OohPtx8qCasGlPP49U/zVTEvGa3BWjlYc70759ZHXiE+xrOyPPiQiIx7dpAgi3WcknmJU0YyO+vaLoh84wEp8QGfVJEpkXIGwtAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzVYc5y2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzVYc5y2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766157951; x=1797693951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jTam/avc+Nm85UtJLHBO0ExRzdYHUY29ok9dc7c+1F4=;
  b=FzVYc5y2m+FBo3/VjVQNVI4+xQS+t/uAGKdD9LOOcBM2pDVhG6k52JsK
   qUa8zQ9jaWnjXkZTrKHiRu6Z1PwruxbWq1UOLcsYZAV8fgEwV3rZQP1Hy
   6Wan7xz0QanZJBDSzOgEN1YJWrrHfdonUAtVXz9l7PSO87rZcsfodXGIJ
   IHWEeMrGBXJvCX9RNChhXWTn9p/aXO3Jbrw7OuTBnQAAetj70iKZRbzgh
   gtDicdyx/R2bdGB4K/svNaiuQCXMvZmMfz5ZZw9GsH168LlLBnOMSnDnQ
   XQRUNy39GTNqBLnv/yEgGRsKUWLk6V9DDrALqvjHPUeXDdVPn+qcBTIFp
   w==;
X-CSE-ConnectionGUID: s/QaD7RDT9Oj89wJnnzVhQ==
X-CSE-MsgGUID: pnZtSdU4TOWoXxWundLXIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68052133"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68052133"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 07:25:51 -0800
X-CSE-ConnectionGUID: oPrMGbKDQLCkVO23GzsP/g==
X-CSE-MsgGUID: zS5UO/Q2SJWBGT2FALM8pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198032785"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 19 Dec 2025 07:25:49 -0800
Date: Fri, 19 Dec 2025 23:09:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: adrianhoyin.ng@altera.com
Cc: dinguyen@kernel.org, mdf@kernel.org, yilun.xu@intel.com,
	trix@redhat.com, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fpga: stratix10-soc: Add persistent SMMU-aware DMA
 handling for Agilex5
Message-ID: <aUVqrU1D+UpfqDlL@yilunxu-OptiPlex-7050>
References: <20251217055632.1776206-1-adrianhoyin.ng@altera.com>
 <20251217055632.1776206-3-adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217055632.1776206-3-adrianhoyin.ng@altera.com>

On Wed, Dec 17, 2025 at 01:56:32PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> Agilex5 platforms require SMMU translation for FPGA configuration
> buffers, but the Stratix10 FPGA manager previously assumed direct
> physical addressing, causing reconfiguration failures when SMMU was
> enabled.
> 
> This patch adds SMMU-aware DMA mapping and unmapping of service-layer
> buffers and introduces a dma_addr field to track mapped addresses.
> Buffers are also allocated once at probe() instead of per transfer,
> reducing IOMMU overhead and avoiding timeout issues on Agilex5.

The original code allocates the buffer at fpga_manager_ops.write_init(),
a.k.a before re-programming start, not on every write transfer. I don't
understand why there is timeout issue in this phase. I.e. I'm not
convinced the move of buffer allocation brings benefit.

[...]

> @@ -259,6 +256,10 @@ static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
>  
>  	svc_buf = priv->svc_bufs[i].buf;
>  	memcpy(svc_buf, buf, xfer_sz);
> +	if (priv->is_smmu_enabled)
> +		priv->svc_bufs[i].dma_addr = dma_map_single(dev, svc_buf,
> +							    SVC_BUF_SIZE,
> +							    DMA_TO_DEVICE);

I'm even more confused now, why the dma mapping here? In patch #1 you've
already mapped the buffer when allocating, you mapped it a second time
here. Moreover the mapped dma_addr is not used anywhere, why?

Thanks,
Yilun
