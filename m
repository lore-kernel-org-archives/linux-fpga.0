Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5582F8E88;
	Tue, 23 Jun 2026 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230949; cv=none; b=t6IpDBbfPJyX8ILGXANBTCfAeMVKcejERz58RaaUO3iWx+yqtgOjxyDW+nrO4CDBp5s2odDE+6YAhOZ7LkhcGCZHoBydIyEuttZMEkw9W5tNit9TCVh3dvvsrp8U4g1P45os85qP2rZ/aOfQVUr5cYsIOe8AeA1vnw375yAvQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230949; c=relaxed/simple;
	bh=KFsGBGAppGvBBB7tBLLIG5HqRHCMGOsun2aYWhGi+kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ro1hZvEvg/XGzM3NOJWZcPHHih+CCv5pFv2JTz05nfhUt3+fCUInVnwCwPHmrtowJ7KJ91BLKak9cV3alP/IjFd6nyZ2Os0jFuvTfiH97RTGGOkc8wtK6uSsOPz1opc5WyFb4FFXKOcnn/2QcpZ6GYx16LU2CvJO2aB5o2HektU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLnSRYy0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLnSRYy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B998A1F000E9;
	Tue, 23 Jun 2026 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782230948;
	bh=r346LIyFmXfyUppiPIVPdMktQsO248nrxPVZ/k70UTM=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=aLnSRYy0X6etluWXP6/X6aUUe9Yea3wpCDpHJiOGmyFkcBrZ3qdUwWMi8OUuHFSFN
	 fCEpb77YkGpdp8Bk+K+Pn3D1lyIuUwmEhpxAZzRSMgQaI5EK7jcXwmBKG093p461Kh
	 nwrng2T3J98AV1iE6a8FEjuSzShephocXXLjDz1KW2Tx/JVw1jYpSLruasiJCv48sF
	 5UtkzWQKKhwsNz5sG4UzeIj6ItLUFfjos+YJyLjleRos/AXfmaZDiY4WFmB0XutrdZ
	 Pen14c/jktq8+MAE/CvYA+DeZEv9JwKVGBEn5cgXK7FlqkXKoCpHL5wWAblRkLLI2z
	 TeLd9cNt2fnIQ==
Message-ID: <da50ce16-f1a8-4d2e-8abd-ee9900644752@kernel.org>
Date: Tue, 23 Jun 2026 11:09:06 -0500
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: stratix10-soc: Fix SVC mailbox handling during
 reconfiguration
To: tze.yee.ng@altera.com, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3fb9ad8196d00860f7d4aa2e0394a271f5ad0cec.1782208001.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <3fb9ad8196d00860f7d4aa2e0394a271f5ad0cec.1782208001.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/23/26 04:47, tze.yee.ng@altera.com wrote:
> From: Tien Sung Ang <tien.sung.ang@altera.com>
> 
> Fix incorrect stratix10_svc_done() usage during FPGA reconfiguration.

Do you need a Fixes tag and Cc: stable then?

> 
> Do not call stratix10_svc_done() at the end of write_init() on success, so
> the SVC session remains active through write() and write_complete(). Call
> stratix10_svc_done() on failure in write_init() and write() so the shared
> SVC mailbox is released when reconfiguration aborts, allowing coexistence
> with other SVC clients such as soc64-hwmon.
> 

