Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E23F0752;
	Fri, 26 Jun 2026 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493917; cv=none; b=ItZs1SHgOPbqLkKbpmv8WYruwoTL7zcUR3tjnfCklT4+uS+Ugo1m7fWB0fE9Vw/8/n97OHJ96Qa1kNdoi+ZF9g3xGeJvhk5WxJOqnQbu2jWkteZG/7kU1qIVTWMmRxnSG+UfVKActa7cLaD30OF7nYzwiRTovPDvL1Ds0Xp3Emw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493917; c=relaxed/simple;
	bh=kcv0owXXRmlG/SehdIuyDT+80oh8JbG7zukqvSYHjdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDtF7EQ1LhSkdUY90PbFjDg80A4fswzTNraAERYdAIJ0/lKmmsEKJnRA/Bs6p0L0UZmtx66KM1rvWHE35KMKBm1CiCwzYUYLlY3iV94SpcjMTW0f5zonOyhWJu5G934NpozAUmDuflT/shwlfFuVOwgSrRcn+3ZmGpsvEnwLSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBmAJqUv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBmAJqUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782493916; x=1814029916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kcv0owXXRmlG/SehdIuyDT+80oh8JbG7zukqvSYHjdQ=;
  b=gBmAJqUv5tssz/BXFRE3diH1em61COMjo1iQCQTvJW+I2iX7Wba5feR4
   j9PFhNWqC1HDShmOKaoQU1hqS3V2VBgWxw/r5wiT8xMJnJlOqMLZOX2Ou
   JB0Z/ocJoq0GXnxKJmFi9p0B1X5pOEA9QwyQedU6ZGUr9H7u6hMJHOuIs
   HTf0vljHK8FCjpQEJgXGsqAZFJ+UNxzoHTLaPsjO97ybgLsxnTmPcPbn7
   zN728n5nuAS7KqrvqlzdgR6kj3jSNfNifsXJwQtG1nLLuY7WlSxzKtg1J
   HtFiXJJQAISzmqnWIMYT1HBgdSqPGv/aeWRdNhQubKXshtOTbkFseVAQ5
   A==;
X-CSE-ConnectionGUID: d6o6nn1LRiGjy3GA8JpKHg==
X-CSE-MsgGUID: zV2pVgbxTROGYGlpIp0uiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="87190665"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="87190665"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 10:11:55 -0700
X-CSE-ConnectionGUID: waRAHOCqSf+zoyaRaJwy6w==
X-CSE-MsgGUID: w7cY3p9oSFSRNfWxls684A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="281463285"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 26 Jun 2026 10:11:53 -0700
Date: Sat, 27 Jun 2026 01:11:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: tze.yee.ng@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Richard Gong <richard.gong@intel.com>, Alan Tull <atull@kernel.org>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	tien.sung.ang@altera.com
Subject: Re: [PATCH v3] fpga: stratix10-soc: Fix SVC mailbox handling during
 reconfiguration
Message-ID: <aj6y2CLYpdaQOGd4@yilunxu-OptiPlex-7050>
References: <0119f69b467e2b90240ebaa3aee3120f621ddee3.1782295811.git.tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0119f69b467e2b90240ebaa3aee3120f621ddee3.1782295811.git.tze.yee.ng@altera.com>

> @@ -195,20 +195,20 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
>  			       &ctype, sizeof(ctype));
>  	if (ret < 0)
> -		goto init_done;
> +		goto init_error;
>  
>  	ret = wait_for_completion_timeout(
>  		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>  	if (!ret) {
>  		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>  		ret = -ETIMEDOUT;
> -		goto init_done;
> +		goto init_error;
>  	}
>  
>  	ret = 0;

Why re-initialize ret here?

>  	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
>  		ret = -ETIMEDOUT;
> -		goto init_done;
> +		goto init_error;
>  	}
>  
>  	/* Allocate buffers from the service layer's pool. */
> @@ -216,16 +216,19 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
>  		if (IS_ERR(kbuf)) {
>  			s10_free_buffers(mgr);
> -			ret = PTR_ERR(kbuf);
> -			goto init_done;
> +			ret = -ENOMEM;

Why change the ret?

> +			goto init_error;
>  		}
>  
>  		priv->svc_bufs[i].buf = kbuf;
>  		priv->svc_bufs[i].lock = 0;
>  	}
>  
> -init_done:
> +	goto init_done;

Happy path? why not just return 0; And you don't need init_done at all.

> +
> +init_error:
>  	stratix10_svc_done(priv->chan);
> +init_done:
>  	return ret;
>  }
